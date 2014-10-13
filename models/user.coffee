module.exports = (mongoose)->
  crypto = require 'crypto'
  async = require 'async'
  UserScheme = new mongoose.Schema
    email: type:String,unique:true
    account:type:String,unique:true
    password:type:String
  User = mongoose.model 'User',UserScheme

  registerCallback = (err) ->
    if err
      return console.log err
    console.log 'new account added'

  register = (email,password,account,callback)->
    shaSum = crypto.createHash('sha256')
    shaSum.update(password);
    console.log 'register'+email
    user = new User
      email:email
      password:shaSum.digest 'hex'
      account:account
    async.waterfall([
        (cb)->
          User.findOne(account:account,(err,doc)->
              if(doc)
                callback("has register")
              else
                cb(err)
          )
      ,(err,cb)->
          user.save registerCallback(err)
          cb()
      ],()->
        callback("success")

    )
    return

  login = (account,password,callback)->
    async.waterfall([
        (cb)->
          shaSum = crypto.createHash('sha256')
          shaSum.update(password);
          User.findOne(account:account,password:shaSum.digest('hex'),(err,doc)->
            cb err,doc)
        (doc,cb)->
          cb doc
      ],(doc)->
      callback doc
    )

  update = (account,password,callback)->
    shaSum = crypto.createHash('sha256')
    shaSum.update(password);
    console.log 'update'+account
    async.waterfall([
      (cb)->
        User.update(
           {account:account},
           {$set:password:shaSum.digest 'hex'},
           {upsert:false}
          (err,doc)->
            console.log err
            cb(err,doc))
    ],(err,doc)->
       callback(err,doc))

  deleteUser = (account,callback)->
    async.waterfall([
      (cb)->
        User.remove(account:account,(err,doc)->
          cb(err,doc))

    ],(err,doc)->
      callback(err,doc))



  return register:register, User:User,login:login,update:update,deleteUser:deleteUser
