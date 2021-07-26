let getNullableExn = (s, ~errMsg="Value not found") => {
  switch s->Js.Nullable.toOption {
  | None => Js.Exn.raiseError(errMsg)
  | Some(s) => s
  }
}

  let makeArray = a => {
    switch a {
      | None => []
      | Some(b) => b
    }
  }