module.exports = {
    
    loadFromSessionStorage(key) {
      const sessionData = JSON.parse(sessionStorage.getItem(key))
      return sessionData ? sessionData : {}
    },

    storeToSessionStorage(key, jsonData) {
      sessionStorage.setItem(key, JSON.stringify(jsonData))
    },

    loadFromLocalStorage(key) {
      const localData = JSON.parse(localStorage.getItem(key))
      return localData ? localData : {}
    },

    storeToLocalStorage(key, jsonData) {
      localStorage.setItem(key, JSON.stringify(jsonData))
    }

}
        