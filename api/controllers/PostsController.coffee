moment = require 'moment'
fs = require 'fs'
path = require 'path'
util = require 'util'
pygmentize = require 'pygmentize'
marked = require 'marked'
hljs = require 'highlight.js'


marked.setOptions({
 	highlight: (code, lang) ->
 		console.log(hljs.highlightAuto(lang, code));
 		return hljs.highlight(lang, code).value;
});



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
				featured : req.param 'featured'
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
		
		if req.files.image != undefined && req.files.image.size > 0
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
					featured : req.param 'featured'
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
				featured : req.param 'featured'
				category: req.param 'category'
				date : moment()
				text : req.param 'text'
			.done (err, post)->
				res.redirect '/posts/' + req.param 'id'

	find : (req, res)->
		if  req.param('id') == 'undefined'
			res.send 'invalid param', 404
			return
		
		retval = {}
		async.waterfall [
			(next)->
				Posts.findOne
					ident : req.param 'id'
				.done (err, _post)->
					marked( _post.text, (err, content)->
						if (err) 
							throw err;
						_post.parsedText = content
						retval.post = _post
						next(null, _post.id)
					)
					# marked _post.text , (err, context)->
					# 	console.log(err, context)
					# 	_post.parsedText = context
					# 	retval.post = _post
					# 	next(null, _post.id)
					# return undefined
			,(postid, next)->
				Comments.find
					postid : postid
				.done (err, comments)->
					retval.comments = comments
					next()
		], (err, result) ->
			res.view
				post : retval.post
				comments: retval.comments
					

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

