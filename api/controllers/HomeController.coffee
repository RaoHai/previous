async = require 'async'

HomeController = 
	index : (req, res)->
		retvals = {}
		Posts.native (err, collection)->
			async.waterfall [
				#fetching posts and page
				(next)->
					collection.find().count (err, postcount)->
						Posts.find().sort('date DESC').done (err, posts)->
							retvals.posts = posts
							retvals.postcount = postcount
							retvals.currentPage = (req.param 'page') || 0
							next()
			] , (err, result)->
				res.view 
					posts: retvals.posts
					postcount : retvals.postcount
					currentPage : retvals.currentPage
	

module.exports = HomeController;