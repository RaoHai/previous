
CommentsController = 
	find : (req, res) ->
		console.log req.param 'id'
		Comments.find
			postid : req.param 'id'
		.done (err, comments)->
			res.send comments


module.exports = CommentsController;