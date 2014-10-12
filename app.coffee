# Setup Express.js:
express = require 'express'
path = require 'path'
mongoose = require 'mongoose'
mongoose.connect "mongodb://localhost:27017/coffee-express"
app = express()
app.use express.static  __dirname + "/public"
app.use express.bodyParser()
app.set 'view engine', 'ejs'
app.set 'views', path.join __dirname, 'views'
User = require('./models/user')(mongoose)
app.get '/', (req,res) ->
  User.register '555','ddd','df'
  res.render "index",title:'sss',content:'tttt'
  console.log "visited"


# Start server:
app.listen(3000)
console.log("Express server listening on port %d in %s mode")