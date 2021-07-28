@val external fetch: (string, {..}) => {..} = "fetch"

let airTableBaseId = "id"
let airTableTableName = "table"
let airTableToken = "token"

fetch(
  `https://api.airtable.com/v0/${airTableBaseId}/${airTableTableName}?maxRecords=3&view=Grid%20view`,
  {
    "headers": {"Authorization": `Bearer ${airTableToken}`},
  },
)["then"](response => response["json"]())["then"](Js.log)["catch"](Js.log)
