/*
Bindings
*/
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

//////////////////////////////////////////////////////////////

<<<<<<< HEAD
let base = createAirtable({apiKey: "keyoeqsamcsg1tG6e"})->base("appZQ4hJRTJWsowaO") // Your AirTable API Key and Base ID goes here
let table = base("Testing") // Table name goes here
=======
let base = createAirtable({apiKey: ""})->base("") // Your Airtable API Key and Base ID goes here
let table = base("") // Table name goes here
>>>>>>> origin

let getResults = table =>
  table->select({maxRecords: 5, view: "Grid view"})->firstPage     //Can select the number of rows and type of view

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