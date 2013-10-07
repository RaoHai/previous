mongo       = require('mongodb').MongoClient
format      = require('util').format
exports.connect = (req, callback)->
    config = global.config
    connect_url = 'mongodb://%@:%@/%@'.fmt config.dbhost, config.dbport, config.dbname
    console.log connect_url
    mongo.connect connect_url, (err,db)->
        if err 
            throw err
        callback(db)
