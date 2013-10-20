
HomeController = 
	index : (req, res)->
		Posts.native (err, collection)->
			collection.find().count (err, postcount)->
				Posts.find().sort('date DESC').done (err, posts)->
					res.view 
						posts: posts
						postcount : postcount
						currentPage : (req.param 'page') || 0

	

module.exports = HomeController;