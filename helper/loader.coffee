module.exports = global._m = (modelName) ->
	return require("../model/%@".fmt(modelName))