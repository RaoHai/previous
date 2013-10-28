async = require 'async'

HomeController = 
	index : (req, res)->
		weibo.oauth
			loginPath: '/login'
			logoutPath: '/logout'
			blogtypefield: 'type'
			afterLogin: (req, res, callback)->
				console.log 'login success' 
			beforeLogout : (req, res, callback)->
				console.log 'logout'
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