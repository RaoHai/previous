moment = require 'moment'
config_local = require '../../config/local'
async = require 'async'

module.exports = (req, res, ok)->
	fmtDate = req.app.locals.fmtDate = (date, fmtstr)->
		moment(date).format(fmtstr)

	textSummary = req.app.locals.textSummary = (text) ->
		if !text
			return
		subtext = text.substr(0 ,500) + '...'
		ptext = text.split('\n').slice(0,8).join('\n')
		if subtext.length < ptext.length
			return subtext
		return ptext	

	cdn = req.app.locals.cdn = (url) ->
		return "http://www.previous-blog.com" + url# + '?v=' + Math.random()

	req.app.locals.env = process.env.NODE_ENV
	 
	req.app.locals.category = null;
	req.app.locals.post
	req.app.locals.authenticated = req.session.authenticated
	if req.session.oauthUser
		req.app.locals.oauthUser = req.session.oauthUser
	else 
		req.app.locals.oauthUser = false

	Posts.native (err, collection)->
		async.waterfall [
			(next)->
				collection.group ['category'], {},{"count":0}, "function (obj, prev) { prev.count++; }" , (err, result) ->
					req.app.locals.categories = result
					next()
			, (next)->
				Posts.find
					featured : 'on'
				.sort('date DESC').done (err, posts)->
					req.app.locals.features = posts
					next()
			] ,(err, result) ->
				ok()

