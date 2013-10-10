crypto = require 'crypto'
shasum = crypto.createHash 'sha1';

UsersController = 
  login : (req, res)->
    switch req.method
      when "POST"
        Users.findOne
          username: req.param 'username' 
        .done (err, user)->
          shasum.update user.salt + req.param 'password'
          hPassword = shasum.digest 'hex'
          if hPassword == user.hPassword
            res.redirect '/'
          else
            res.redirect '/users/login'
      else
        res.view 
          layout: 'login_layout'

  create : (req, res)->
    crypto.randomBytes 10, (ex, buf)->
      randomStr = buf.toString 'hex'
      shasum.update randomStr + req.param 'password'
      hPassword = shasum.digest 'hex'
      Users.create
        username : req.param 'username'
        hPassword : hPassword
        salt : randomStr
      .done (err, user)->
        res.send user
  

module.exports = UsersController