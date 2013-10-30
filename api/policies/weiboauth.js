var weibo = require('weibo');
weibo.init('weibo', '1926974447', 'bc09ea8c8f7f7f9e9a613a02410603ed');
var fn = weibo.oauth({
	loginPath: '/users/login',
	logoutPath: '/logout',
	blogtypeField: 'type',
	callbackPath:'/callback',
	afterLogin: function (req, res, callback) {
		console.log(req.session.oauthUser, 'login success');
		req.app.locals.weiboauthen = true;
		return callback();
	},
	beforeLogout: function (req, res, callback) {
		console.log(req.session.oauthUser.screen_name, 'loging out');
		req.app.locals.weiboauthen = false;
		return callback();
	}
});


module.exports = fn;