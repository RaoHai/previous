moment = require 'moment'
fs = require 'fs'
path = require 'path'
util = require 'util'
PostsController = 
	create : (req, res)->

		tmp_path = req.files.image.path
		target_path = path.join('./','assets','images','uploads',req.files.image.name) 
		image_path = path.join('images','uploads',req.files.image.name)
		readStream = fs.createReadStream(tmp_path)
		writeStream = fs.createWriteStream(target_path);
		readStream.pipe writeStream
		readStream.on 'end', ()->
	        fs.unlinkSync tmp_path
			Posts.create
				title : req.param 'title'
				ident : req.param 'ident'
				category: req.param 'category'
				date : moment()
				text : req.param 'text'
				image : image_path
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
		if req.files
			tmp_path = req.files.image.path
			target_path = path.join('./','assets','images','uploads',req.files.image.name) 
			image_path = path.join('images','uploads',req.files.image.name)
			readStream = fs.createReadStream(tmp_path)
			writeStream = fs.createWriteStream(target_path);
			readStream.pipe writeStream
			readStream.on 'end', ()->
				Posts.update
					ident : req.param 'id'
				,
					title : req.param 'title'
					ident : req.param 'ident'
					category: req.param 'category'
					image : image_path
					date : moment()
					text : req.param 'text'
				.done (err, post)->
					res.redirect '/posts/' + req.param 'id'		
		else
			Posts.update
				ident : req.param 'id'
			,
				title : req.param 'title'
				ident : req.param 'ident'
				category: req.param 'category'
				date : moment()
				text : req.param 'text'
			.done (err, post)->
				res.redirect '/posts/' + req.param 'id'

	find : (req, res)->
		Posts.findOne
			ident : req.param 'id'
		.done (err, post)->
			res.view
				post : post

	tag : (req, res)->
		res.send req.param 'id'

	category : (req, res)->
		Posts.find
			category : req.param 'id'
		.done (err, posts)->
			res.view
				category : req.param 'id'
				title : req.param 'id'
				posts : posts
	new : (req, res)->
		res.view 'posts/new' ,
			title : 'Create New Post'


module.exports = PostsController 

