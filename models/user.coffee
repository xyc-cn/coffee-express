module.exports = (mongoose)->
  crypto = require 'crypto'
  UserScheme = new mongoose.Schema
    email: type:String,unique:true
    account:type:String,unique:true
    password:type:String
  User = mongoose.model 'User',UserScheme

  registerCallback = (err) ->
    if err
      return console.log err
    console.log 'new account added'

  register = (email,password,account)->
    shaSum = crypto.createHash('sha256')
    shaSum.update(password);
    console.log 'register'+email
    user = new User
      email:email
      password:password
      account:account
    user.save registerCallback
    return

  return register:register, User:User
