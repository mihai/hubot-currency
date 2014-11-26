# Hubot Currency [![npm version](https://badge.fury.io/js/hubot-currency.svg)](http://badge.fury.io/js/hubot-currency)

Convert between currencies at daily exchange rates, using Google's currency
converter: https://www.google.com/finance/converter.


## Installation

Add **hubot-currency** to your `package.json` file:

```json
"dependencies": {
  ...
  "hubot-currency": "latest"
}
```

Add **hubot-currency** to your `external-scripts.json`:

```json
["hubot-currency"]
```

Run `npm install hubot-currency`


## Commands

    hubot (currency|currencies)                                                 # list the supported currency codes
    hubot supported (currency|currencies)                                       # same as above
    hubot currency rate <currency-code>                                         # list USD, GBP, and EUR exchange rates for <currency-code>
    hubot exchange rate <currency-code>                                         # same as above
    hubot currency <value> <currency-code> (in|to|into) <other-currency-code>   # convert <value> from <currency-code> to <other-currency-code>
    hubot exchange <value> <currency-code> (in|to|into) <other-currency-code>   # same as above


## Contributing

If you are interested to make `hubot-currency` better, fork this repository, check
the list of [open issues](https://github.com/mihai/hubot-currency/issues?state=open)
for some suggestions to get started, and submit a pull request.

Feel free to add yourself to the
[CONTRIBUTORS](https://github.com/mihai/hubot-currency/blob/master/CONTRIBUTORS)
list while submitting a pull request.

## License
&copy; 2014 [Mihai Cîrlănaru](http://www.mihai-cirlanaru.com)

See [LICENSE](https://github.com/mihai/hubot-currency/blob/master/LICENSE) for more details.
