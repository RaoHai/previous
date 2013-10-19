moment = require 'moment'
module.exports = (req, res, ok)->
	fmtDate = req.app.locals.fmtDate = (date, fmtstr)->
		moment(date).format(fmtstr)

	textSummary = req.app.locals.textSummary = (text) ->
		subtext = text.substr(0 ,500) + '...'
		ptext = text.split('\n').slice(0,8).join('\n')
		console.log(subtext, ptext)
		if subtext.length < ptext.length
			return subtext
		return ptext
		


	req.app.locals.category = null;
	req.app.locals.authenticated = req.session.authenticated
	ok()