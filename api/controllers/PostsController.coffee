moment = require 'moment'
fs = require 'fs'
path = require 'path'
util = require 'util'
marked = require 'marked'
marked.setOptions
  gfm: true,
  highlight: (code, lang, callback) ->
    pygmentize
    	lang: lang
    	format: 'html'
    , code, (err, result) ->
    	if err
    		return callback(err)
    	callback null, result.toString()
  tables: true,
  breaks: false,
  pedantic: false,
  sanitize: true,
  smartLists: true,
  smartypants: false,
  langPrefix: 'lang-'

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
					marked _post.text ,(err,context)->
						_post.parsedText = context
						retval.post = _post
						next(null, _post.id)
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

