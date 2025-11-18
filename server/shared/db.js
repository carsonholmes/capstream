//this module is used to share a global connection to the db as dbo
var db = {"dbo": null};

// GLOBAL MS SQL CONSTANTS
export const MAX_VARCHAR_LENGTH = 65535;

export default db;