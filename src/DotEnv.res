@module("dotenv-flow")
external config: unit => unit = "config";

@val external airtableAPIKey : Js.Nullable.t<string> = "process.env.AIRTABLE_API_KEY"
@val external nodeEnv : Js.Nullable.t<string> = "process.env.NODE_ENV"
@val external port : Js.Nullable.t<int> = "process.env.PORT"