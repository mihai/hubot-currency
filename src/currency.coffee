# Description:
#   Convert between currencies at daily exchange rates
#
# Dependencies:
#   "cheerio": "~0.18.0"
#
# Commands:
#   hubot (currency|currencies) - list the supported currency codes
#   hubot supported (currency|currencies) - list the supported currency codes
#   hubot (currency|exchange) rate <currency-code> - list USD, GBP, and EUR exchange rates for <currency-code>
#   hubot (currency|exchange) <value> <currency-code> (in|to|into) <other-currency-code> - convert <value> from <currency-code> to <other-currency-code>
#
# Author:
#   mihai
#

module.exports = (robot) ->
  cheerio = require('cheerio')
  GOOGLE_CURRENCY_RESULT_DOM_ID = '#currency_converter_result'
  GOOGLE_SERVICE_ERROR = 'Something is wrong with the Google currency converter… try again later'

  getConvertedAmount = (msg, value, from, to) -> 
    q = a: value, from: from, to: to
    msg.http('https://www.google.com/finance/converter')
      .query(q)
      .get() (err, res, body) ->
        if res.statusCode isnt 200
          msg.send GOOGLE_SERVICE_ERROR
          return

        $ = cheerio.load(body)
        result = $(GOOGLE_CURRENCY_RESULT_DOM_ID).text().trim()
        if result?
          msg.send result
        else
          msg.send 'No currency conversion result for #{value} from #{from} to {#to}'

  robot.respond /(supported )?currenc(y|ies)$/i, (msg) ->
    msg.http('https://www.google.com/finance/converter')
      .get() (err, res, body) ->
        if res.statusCode isnt 200
          msg.send GOOGLE_SERVICE_ERROR
          return

        $ = cheerio.load(body)
        opts = $('select[name=from]').children()
        message = 'List of supported currencies (<code>: <currency>):\n'
        for opt in opts
          currency_code = $(opt).attr('value')
          label = $(opt).text()
          currency_label = label.substr(0, label.indexOf('(') - 1)
          message += currency_code + ': ' + currency_label + '\n'

        msg.send message

  robot.respond /(currency|exchange) rate (\S{3}) ?.*/i, (msg) ->
    currency = msg.match[2].toUpperCase()
    (getConvertedAmount(msg, 1, currency, base) unless currency is base) for base in ['USD', 'EUR', 'GBP']

  robot.respond /(currency|exchange) ([0-9]+\.?[0-9]*)\s?(\S{3})( (in)?(to)?)? (\S{3}) ?.*/i, (msg) ->
    value = msg.match[2]
    fromCurrency = msg.match[3].toUpperCase()
    toCurrency = msg.match[7].toUpperCase()
    
    getConvertedAmount(msg, value, fromCurrency, toCurrency)
