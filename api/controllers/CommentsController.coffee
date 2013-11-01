
CommentsController = 
	find : (req, res) ->
		console.log req.param 'id'
		Comments.find
			postid : req.param 'id'
		.done (err, comments)->
			res.send comments

	create : (req, res)->
		user = req.session.oauthUser
		Comments.create
			username : user.screen_name
			postid : req.param 'postid'
			link : user.t_url
			avatar : user.avatar_large
			text : req.param 'text'
		.done (err, comments) ->
			res.send comments



module.exports = CommentsController;