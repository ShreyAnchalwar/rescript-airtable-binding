const Airtable = require('airtable')
const meow = require('meow')
const chunk = require('lodash/chunk')
const fromPairs = require('lodash/fromPairs')

module.exports = function program (...argv) {
  const cli = meow({
    argv,
    flags: {
      apiKey: {
        type: 'string',
        alias: 'k'
      },
      base: {
        type: 'string',
        alias: 'b'
      },
      table: {
        type: 'string',
        alias: 't'
      }
    }
  })
  const { input, flags } = cli

  if (!input.length) {
    cli.showHelp()
    return
  }

  const subcommand = input.shift()

  if (subcommand !== 'add') {
    console.error('command not found')
    return 1
  }

  //const fields = fromPairs(chunk(input, 2))
  const table = new Airtable({ apiKey: flags.apiKey }).base(flags.base)(flags.table)

  return new Promise((resolve, reject) => {
    table.select(fields, (err) => {
      if (err) {
        console.error(err)
        resolve(1)
        return
      }
      resolve(0)
    })
  })
}