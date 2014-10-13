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
app.get '/register', (req,res) ->
  account = req.query.account
  password = req.query.password
  email = req.query.email
  if !account||!password||!email
    res.render "index",title:'error',content:'tttt'
  else
    User.register email,password,account,(data)-> console.log data
    res.render "index",title:'register',content:'tttt'
  console.log "visited"

app.get '/login', (req,res) ->
  User.login 'dffg','ddfgd',(data)->
    console.log data
  res.render "index",title:'login',content:'tttt'
  console.log "login"

app.get '/update', (req,res) ->
  User.update 'kkg','ddfgdddffsssddd',(err,data)->
    console.log data
  res.render "index",title:'update',content:'tttt'
  console.log "update"

app.get '/delete', (req,res) ->
  User.deleteUser 'kkg',(err,data)->
    console.log data
  res.render "index",title:'delete',content:'tttt'
  console.log "delete"

# Start server:
app.listen(3000)
console.log("Express server listening on port %d in %s mode")