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
let pageNumber = 0
let retries = 0
let wait = 30
type page
type view

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

@send
external wrap: () =>  = "wrap" //what to return from the function 

@send
external fetchNextPage: unit => page ="fetchNextPage"

let rateLimiter = createBottleneck({minTime: 1050/5}) //5 requests per

let base = createAirtable({apiKey: "keyoeqsamcsg1tG6e"})->base("appZQ4hJRTJWsowaO") // Your Airtable API Key and Base ID goes here
let table = base("Testing") // Table name goes here

let getResults = table =>
  table->select({maxRecords: 5, view: "Grid view"})->firstPage     //Can select the number of rows and type of view

getResults(table)
|> Js.Promise.then_(results => {
  Js.log(results)
  if (response.status != 429 || retries == 5) {
      return;
  retries++
  } else {
    setTimeout(getResults, wait)
  }
  Js.Promise.resolve()
})
|> Js.Promise.catch(error => {
  fetchNextPage()
  Js.log(error)
  Js.Promise.resolve(result)
})
|> ignore

