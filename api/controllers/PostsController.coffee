moment = require 'moment'

PostsController = 
	create : (req, res)->
		Posts.create
			title : req.param 'title'
			ident : req.param 'ident'
			date : moment()
			text : req.param 'text'
		.done (err, post) ->
			res.send post
		
	find : (req, res)->
		res.send "hello world"

	new : (req, res)->
		res.view()


module.exports = PostsController 

