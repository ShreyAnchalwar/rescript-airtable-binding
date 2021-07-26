module Record = {
  type t
  @send @return(nullable) external get: (t, string) => option<'a> = "get"
}

module Table = {
  type t
  @send external find: (t, string) => Js.Promise.t<Record.t> = "find"
  @send external update: (t, array<'a>) => Js.Promise.t<'p> = "update"
}

module Base = {
  type t
  @send external table: (t, string) => Table.t = "table"
}

@module("airtable") external base: string => Base.t = "base"

type c = {apiKey: string}
@module("airtable") external configure: c => unit = "configure"