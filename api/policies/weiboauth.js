var weibo = require('weibo');

var fn = weibo.oauth({
	loginPath: '/users/login',
	logoutPath: '/logout',
	blogtypeField: 'type',
	callbackPath:'/callback',
	afterLogin: function (req, res, callback) {
		console.log(req.session.oauthUser.screen_name, 'login success');
		return callback();
	},
	beforeLogout: function (req, res, callback) {
		console.log(req.session.oauthUser.screen_name, 'loging out');
		return callback();
	}
});


module.exports = fn;