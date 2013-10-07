

exports.list = (req, callback) ->
	_m('mongo').connect req, (db)->
		collection = db.collection('posts')

		collection.find().toArray (err, result)->
			callback(result)
