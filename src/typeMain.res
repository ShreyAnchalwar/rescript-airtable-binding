type view = {view: string}
type record = {get: string => string}
type all = {firstPage: (({"message": string}, array<record>) => unit) => unit}
type base = {select: view => all}

@module("airtable")
external airtable: {"base": (string, string) => base} = "default"

let base = airtable["base"]("appZQ4hJRTJWsowaO")
let testing = base("Testing")
let all = testing.select({view: "Grid view"})
all.firstPage((_error, records) => {
  let names = Js.Array2.map(records, record => record.get("Name"))
  Js.log(names)
})
