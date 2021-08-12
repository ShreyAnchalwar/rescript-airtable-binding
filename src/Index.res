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
type 

@module("bottleneck") @new
external createBottleneck: rps => bottleneck = "default"

@send
external wrap: =>  = "wrap"

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


/*
rateLimiter.wrap(base(tableAI).select({
        view: 'Grid View',
        pageSize: 10000 
      }).eachPage(function page(records, fetchNextPage) {
                
        if (pageNumber == request.params.page) {

          let results = [];

          records.forEach(function(record) {
            
            var result = {
              id: record.get('id'),
            }

            results.push(result);
          });

          JS.log("Returning records");
          sendResultWithResponse(results, response);

        } else {
          pageNumber++;
          fetchNextPage();
        }

      }, function done(error) {
          sendResultWithResponse([], response);
      }));

    }

  }

}
*/
