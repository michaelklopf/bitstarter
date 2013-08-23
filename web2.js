var express = require('express');
var fs = require('fs');
var htmlfile = "index.html";

var app = express.createServer(express.logger());

app.get('/', function(request, response) {
  //var html = fs.readFileSync(htmlfile).toString();
  var buffer = fs.readFileSync('index.html');
  //response.send('Hello World 2!');
  response.send(buffer.toString());
});

var port = process.env.PORT || 5432;
app.listen(port, function() {
  console.log("Listening on " + port);
});