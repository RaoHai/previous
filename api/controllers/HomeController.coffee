
HomeController = 
	index : (req, res)->
		Posts.find().done (err, posts)->
			res.view 
				posts: posts

	

module.exports = HomeController;