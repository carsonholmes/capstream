/*****************************************************/
/** Filename: Server.js                             **/
/** Purpose: Provide RESTful webservices for MS SQL **/
/*****************************************************/
// This is a node express application
import express from 'express';
//var fileUpload = require('express-fileupload')
var app = express();
//app.use(fileUpload())
console.log("Starting server...");

// Load server configuration settings based on args from command line
import os from "os";
var hostname = os.hostname();
console.log("Host name: " + hostname)
import config from './config.js';
console.log("Configuration loaded");

// Load MYSQL Library and custom database handler
import sql from 'mysql';
import db from './shared/db.js';
var connection;

const connectDB = () => {

    console.log("Attempting to connect to MySQL DB " + config.db[hostname].database)
    connection = sql.createConnection(config.db[hostname]);

    connection.connect(err => {
        if (err == null) {
            console.log("Connected to MySQL DB - " + config.db[hostname].host + ":" + config.db[hostname].port + "/" + config.db[hostname].database )
            db.dbo = connection
        }
        else {
            console.log("Error connecting to DB. " + err);
            setTimeout(connectDB, 2000)
        }
    });

    connection.on('error', function(err) {
        console.log('Database error ' +  err)
        if (err.code === 'PROTOCOL_CONNECTION_LOST' || 
            err.code === 'PROTOCOL_PACKETS_OUT_OF_ORDER') {   // Connection to the MySQL server is usually
          connectDB()                                         // lost due to either server restart, or a
        } else {                                              // connnection idle timeout (the wait_timeout
          throw err                                           // server variable configures this)
        }
    })    
}
connectDB()

// Enable cross-origin resource sharing (So React UI can access from different port)
// WARNING!!!  Additional security still needs to be implemented
import cors from 'cors'
app.use(cors())
console.log("Cross-origin resource sharing enabled")

app.use(express.static('public'))		// set the static files location /public
console.log("Public folder enabled")

// Establish all routes for the server
// All routes are currently used for MS SQL data communication (GET/POST)
import routeMaster from './routes/routeMaster.js'
routeMaster.use(app);
console.log("All routes established")
// No need to expose a public directory at this time
//app.use(express.static(__dirname + '\\pub\\'));

app.set('port', process.env.PORT || config.server.port);

app.listen(app.get('port'), function () {
    console.log("Listening on port: " + app.get('port'));
    console.log("Server start-up completed");
});

