express        = require("express")
http           = require("http")
path           = require("path")
rainbow        = require("rainbow")
config         = require "./config.coffee" 

module.exports = app = express()

app.configure ->
	app.set "port", config.port
	app.set "views", path.join __dirname, 'views'
	app.set "view engine","ejs"
	app.use express.favicon()

	app.use express.logger("dev")
	app.use express.bodyParser()
	app.use express.cookieParser()
	app.use express.cookieSession(secret: 'fd2afdsafdvcxzjaklfdsa')
	app.use express.methodOverride()

	app.use (req,res,next)->
    	res.locals.url = req.url
    	next()
  	app.use app.router
  	
  	console.log rainbow

	rainbow.route(app, {  
	    controllers: '/controllers/',
	    filters:'/filters/',      
	    template:'/views/'   
	  })