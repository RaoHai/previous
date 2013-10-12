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
	
	edit : (req, res)->
		postident = req.param 'id'
		Posts.findOne
			ident : postident
		.done (err, post)->
			res.view
				post : post

	update : (req, res)->
		Posts.update
			ident : req.param 'id'
		,
			title : req.param 'title'
			ident : req.param 'ident'
			date : moment()
			text : req.param 'text'
		.done (err, user)->
			res.redirect '/posts/' + req.param 'id'

	find : (req, res)->
		Posts.findOne
			ident : req.param 'id'
		.done (err, user)->
			res.send user

	new : (req, res)->
		res.view
			title : 'Create New Post'


module.exports = PostsController 

