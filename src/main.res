@module("airtable")
external airtable: {
  "base": (
    string,
    string,
  ) => {
    "select": {"view": string} => {
      "firstPage": (
        ({"message": string}, array<{"get": string => string}>) => unit
      ) => unit,
    },
  },
} = "default"

let base = airtable["Base"]("appZQ4hJRTJWsowaO")
let testing = base("Testing")
let all = testing["select"]({"view": "Grid view"})
all["firstPage"]((_error, records) => {
  let names = Js.Array2.map(records, record => record["get"]("Name"))
  Js.log(names)
})
