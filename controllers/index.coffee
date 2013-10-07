
exports.get = (req, res, next) ->
    # req.db.connect(req)
    _m('posts').list req, (posts)->
        res.render "index", posts : posts
    # mongo.connect 'mongodb://127.0.0.1:27017/previous', (err,db)->
    #     if err 
    #         throw err
    #     collection = db.collection 'posts'

    #     collection.find().toArray (err, result) ->
    #         console.dir result
    
