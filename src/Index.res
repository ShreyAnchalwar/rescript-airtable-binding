open Express

let app = expressCjs();

app->use(jsonMiddleware())
app->use(urlencodedMiddlewareWithOptions({"extended": true}))

let base = base("Test")
let nameTable = base->Base.table("Testing")
let record = nameTable->Table.find("Name")

app->get("/view", (req,res) => {
    open Airtable
    configure({
      apiKey: DotEnv.airtableAPIKey->Utils.getNullableExn(~errMsg="Missing Airtable API Key")
    })
})

// Js.log("Base")
// Js.log(base)
// Js.log("Table")
// Js.log()
