type key = {apiKey: string}
type airtable
type table
type base = string => table
type selectParam = {maxRecords: int, view: string}
type rows
type results

@module("airtable") @new
external createAirtable: key => airtable = "default"

@send
external base: (airtable, string) => base = "base"

@send
external select: (table, selectParam) => rows = "select"

@send
external firstPage: rows => Js.Promise.t<results> = "firstPage"

let base = createAirtable({apiKey: "keyoeqsamcsg1tG6e"})->base("appZQ4hJRTJWsowaO")
let table = base("Testing")

let getResults = table =>
  table->select({maxRecords: 10, view: "Grid view"})->firstPage

getResults(table)
|> Js.Promise.then_(results => {
  Js.log(results)
  Js.Promise.resolve()
})
|> Js.Promise.catch(error => {
  Js.log(error)
  Js.Promise.resolve()
})
|> ignore
