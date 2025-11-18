import XMLHttpRequest from 'xhr2';

const util = {
    
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
        console.log("putJSON: " + url)
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

    putGitHub(url, data, token, callback) {
      console.log("putJSON: " + url)
      var xhr = new XMLHttpRequest();
      xhr.open('POST', url, true);
      xhr.setRequestHeader('Authorization', `token ${token}`);
      xhr.setRequestHeader('Accept', 'application/vnd.github.v3+json');
      xhr.setRequestHeader('Content-Type', 'application/json');
      xhr.responseType = 'json';
      xhr.onload = function() {
        var status = xhr.status;
        console.log("GitHub Call Status", status)
        if (status === 200 || status === 201) {
          callback(false, xhr.response);
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
  }
  
}
        
export default util