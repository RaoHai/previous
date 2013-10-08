

PostController = 
	index : (req, res)->
		res.send "Post index"

	new : (req, res)->
		res.send "Create Post"

module.exports = PostController 

