UsersController = 
	login : (req, res)->
		res.view 
			layout: 'login_layout'


module.exports = UsersController