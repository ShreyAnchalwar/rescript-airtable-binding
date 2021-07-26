const airtable = require("airtable")
const base = airtable.base("")

const testing = base("Testing")

const all = testing.select({view: "Grid view"})

all.firstPage((error, records) => {
    const names = records.map(record => 
        record.get("Name")
    )

    console.log(names)
})
