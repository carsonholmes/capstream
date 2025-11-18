module.exports = {

    jsonEqual(object1, object2) {
        if (!object1 && !object2) return true;
        if (object1 && !object2) return false;
        if (!object1 && object2) return false;
        const keys1 = Object.keys(object1)
        const keys2 = Object.keys(object2)
        if (!keys1 && !keys2) return true
        if (!keys1 && keys2) return false
        if (keys1 && !keys2) return false
        if (keys1.length !== keys2.length) {
            return false
        }
        for (const key of keys1) {
            const val1 = object1[key];
            const val2 = object2[key];
            const areObjects = this.isObject(val1) && this.isObject(val2);
            if (key !== 'dirty')  //dirty is the only element allowed to be different between json objects
                if (
                    (areObjects && !this.jsonEqual(val1, val2)) ||
                    (!areObjects && val1 !== val2)
                ) {
                    return false;
                }
        }
        return true;
    },

    deepCopy(object) {
        if (Array.isArray(object)) {
            var newArray = []
            for (let i=0; i<object.length; i++) {
                newArray.push(this.deepCopy(object[i]))
            }
            return newArray
        }
        else 
            if (this.isObject(object)) {
                var newObject = {}
                let keys = Object.keys(object)
                if (!keys) return {}
                for (const key of keys) {
                    newObject[key] = this.deepCopy(object[key])
                }
                return newObject
            }
            else return object;
    },

    isObject(object) {
        return object != null && typeof object === 'object';
    },

    merge(object1, object2) {
        const keys = Object.keys(object2)
        if (!keys) return object1
        let newObject = object1
        for (const key of keys) newObject[key] = object2[key]
        return newObject
    }

}