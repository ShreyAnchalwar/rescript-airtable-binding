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
type rps = {minTime: int}
type bottleneck

@module("bottleneck") @new
external createBottleneck: rps => bottleneck = "default"

@module("airtable") @new
external createAirtable: key => airtable = "default"

@send
external base: (airtable, string) => base = "base"

@send
external select: (table, selectParam) => rows = "select"

@send
external firstPage: rows => Js.Promise.t<results> = "firstPage"

//////////////////////////////////////////////////////////////

let rateLimiter = createBottleneck({minTime: 1050/5}) 

let base = createAirtable({apiKey: ""})->base("") // Your Airtable API Key and Base ID goes here
let table = base("") // Table name goes here

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
