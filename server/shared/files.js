
module.exports = {
        fileExtension: function(fileName) {
        var s = fileName
        var dot = s.indexOf('.')
        while (dot > 0) {
            s = s.substring(dot+1,s.length)
            var dot = s.indexOf('.')    
        }
        return s;
    }
}