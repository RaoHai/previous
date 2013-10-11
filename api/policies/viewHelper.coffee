moment = require 'moment'
module.exports = (req, res, ok)->
	fmtDate = req.app.locals.fmtDate = (date, fmtstr)->
		moment(date).format(fmtstr)
	req.app.locals.authenticated = req.session.authenticated
	ok()