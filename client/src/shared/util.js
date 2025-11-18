var XMLHttpRequest = require('xhr2');

module.exports = {
    
    getParentLeftOffset(node) {
        let i = node;
        let left = 0;
        while (i.parentNode) {
            if (i.parentNode.offsetLeft) left += i.parentNode.offsetLeft;
            i = i.parentNode;
        }
        return left;
    },

    spacePascal(s) {
      return s.replace(/([A-Z])/g, ' $1');
    },

    getJSON(url, callback) {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', url, true);
        xhr.responseType = 'json';
        xhr.onload = function() {
          var status = xhr.status;
          if (status === 200) {
            callback(null, xhr.response);
          } else {
            callback(status, xhr.response);
          }
        };
        xhr.onerror = function() {
          alert('Can not communicate with service');
        };
        xhr.send();
    },
//(6376 sign-in, credentials, signInResult) through ProfileCDO from SignIn
// callback returns (error, data) to SignIn
    putJSON(url, data, callback) {
        var xhr = new XMLHttpRequest();
        xhr.open('POST', url, true);
        xhr.responseType = 'json';
        xhr.onload = function() {
          var status = xhr.status;
          if (status === 200) {
            callback(null, xhr.response);
          } else {
            callback(status, xhr.response);
          }
        };
        xhr.onerror = function() {
          alert('Can not communicate with service');
        };
        const localOffset = new Date().getTimezoneOffset();  //get now in current time zone time
        const timezone = Intl.DateTimeFormat('en-US').resolvedOptions().timeZone
       if (Array.isArray(data)) {
          console.log(data)
          for (let element of data) {
            element.timezoneOffset = localOffset
            element.timezone = timezone
          }
       }
       else {
         data.timezoneOffset = localOffset
         data.timezone = timezone
       }
       xhr.send(JSON.stringify(data));
    },

    putFile(url, data, cbUploading, cbComplete) {
      var xhr = new XMLHttpRequest();
      xhr.open('POST', url, true);
      xhr.responseType = 'json';
      xhr.onload = function() {
        var status = xhr.status;
        if (status === 200) {
          cbComplete(null, xhr.response);
        } else {
          cbComplete(status, xhr.response);
        }
      };
      xhr.onerror = function() {
        alert('Can not communicate with service');
      };
     xhr.send(data);
  },

    fuzzyCompare(subStr, inStr)  {
      if (inStr) {
        let n = inStr.indexOf(subStr);
        return (n===0);
      }
      else return false;
    }
}
        