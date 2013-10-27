moment = require 'moment'
config_local = require '../../config/local'
module.exports = (req, res, ok)->
	fmtDate = req.app.locals.fmtDate = (date, fmtstr)->
		moment(date).format(fmtstr)

	textSummary = req.app.locals.textSummary = (text) ->
		subtext = text.substr(0 ,500) + '...'
		ptext = text.split('\n').slice(0,8).join('\n')
		if subtext.length < ptext.length
			return subtext
		return ptext	

	cdn = req.app.locals.cdn = (url) ->
		return url + '?v=' + Math.random()

	req.app.locals.category = null;
	req.app.locals.post
	req.app.locals.authenticated = req.session.authenticated

	Posts.find
		featured : 'on'
	.sort('date DESC').done (err, posts)->
		req.app.locals.features = posts
		ok()