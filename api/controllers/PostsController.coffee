
PostsController = 
	create : (req, res)->
		res.send "Create new Post"
		
	index : (req, res)->
		res.send "hello world"

	new : (req, res)->
		res.view()


module.exports = PostsController 

