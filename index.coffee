express        = require("express")
http           = require("http")
path           = require("path")
rainbow        = require("rainbow")
config         = require "./config.coffee" 
module.exports = app = express()

require("./helper/proto")
require("./helper/loader")

global.config  = config

app.configure ->
    app.set "port", config.port
    app.set "views", path.join __dirname, 'views'
    app.set "view engine","ejs"
    app.use express.favicon()

    app.use "/static", express.static(__dirname+"/static")

    app.use express.logger("dev")
    app.use express.bodyParser()
    app.use express.cookieParser()
    app.use express.cookieSession(secret: 'fd2afdsafdvcxzjaklfdsa')
    app.use express.methodOverride()

    app.use (req,res,next)->
        res.locals.url = req.url
        next()
    app.use app.router


rainbow.route app 