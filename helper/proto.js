var fmt = exports.fmt = function(string, args) {
    var i = 0, data, hasHadNamedArguments;
    if (args) {
      data = args[0];
    }
  
    return string.replace(/%\{(.*?)\}/g, function(match, propertyPath) {
        hasHadNamedArguments = true;
        if (!data) {
          throw new Error("Cannot use named parameters with `fmt` without a data hash. String: '" + string + "'");
        }

        var ret = valueForKey(propertyPath, data, string);
        // If a value was found, return that; otherwise return the original matched text to retain it in the string
        // for future formatting.
        if (ret !== undefined || ret !== null) { return ret; }
        return match;
      }).replace(/%@([0-9]+)?/g, function(match, index) {
      if (hasHadNamedArguments) {
        throw new Error("Invalid attempt to use both named parameters and indexed parameters. String: '" + string + "'");
      }
      index = index ? parseInt(index, 10) - 1 : i++;
      if(args[index]!==undefined) {
        return args[index];
      }
      return "";
    });
};

String.prototype.fmt = function() {
    return fmt(this, arguments);
};
