const express = require("express");
const app = express();
const cors = require("cors");
const bp = require("body-parser");
const fetch = require("node-fetch");

app.use(cors());
app.use(bp.urlencoded({ extended: false }));
app.use(bp.json());
app.use(require("morgan")("dev"));

const AIRTABLEAPI = "keyoeqsamcsg1tG6e"; 
const AIRTABLEBASEID = "appZQ4hJRTJWsowaO"; 
const AIRTABLETABLENAME = "Testing"; 

const port = process.env.PORT || 3000;

app.get("/view", (req, res) => {
 
  fetch(
    `https://api.airtable.com/v0/${AIRTABLEBASEID}/${AIRTABLETABLENAME}?maxRecords=3&view=Grid%20view`,
    {
      headers: { Authorization: `Bearer ${AIRTABLEAPI}` },
    }
  )
    .then((res) => res.json())
    .then((result) => {
      console.log(result);
      res.json(result);
    })
    .catch((err) => {
      console.log(err);
    });
});

app.post("/create", (req, res) => {
  console.log(req.body);

  var datain = req.body;

  var payload = {
    records: [
      {
        fields: datain,
      },
    ],
  };
  fetch(`https://api.airtable.com/v0/${AIRTABLEBASEID}/${AIRTABLETABLENAME}`, {
    method: "post",
    body: JSON.stringify(payload),
    headers: {
      Authorization: `Bearer ${AIRTABLEAPI}`,
      "Content-Type": "application/json",
    },
  })
    .then((res) => res.json())
    .then((result) => {
      console.log(result);
      res.json(result);
    })
    .catch((err) => {
      console.log(err);
    });
});

app.post("/update", (req, res) => {
  console.log(req.body);

  var datain = req.body;

  var payload = {
    records: [
      {
        id: datain.id,
        fields: datain.updatedata,
      },
    ],
  };

  fetch(`https://api.airtable.com/v0/${AIRTABLEBASEID}/${AIRTABLETABLENAME}`, {
    method: "patch",
    body: JSON.stringify(payload),
    headers: {
      Authorization: `Bearer ${AIRTABLEAPI}`,
      "Content-Type": "application/json",
    },
  })
    .then((res) => res.json())
    .then((result) => {
      console.log(result);
      res.json(result);
    })
    .catch((err) => {
      console.log(err);
    });
});

app.post("/delete", (req, res) => {
  console.log(req.body);

  
  fetch(
    `https://api.airtable.com/v0/${AIRTABLEBASEID}/${AIRTABLETABLENAME}/${req.body.id}`,
    {
      method: "delete",
      headers: {
        Authorization: `Bearer ${AIRTABLEAPI}`,
      },
    }
  )
    .then((res) => res.json())
    .then((result) => {
      console.log(result);
      res.json(result);
    })
    .catch((err) => {
      console.log(err);
    });
});

app.listen(port, () => {
  console.log("listening on " + port);
});