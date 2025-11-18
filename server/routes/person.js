import express from 'express';
import parseReq from '../shared/parseReq.js';
import dalPerson from '../dal/dalPlace.js';

var router = express.Router();

router.get('/', function (req, res) {
    dalPerson.selectPersonAll(function (err, d) {
        if (err) {
            res.status(500).json({"error": err});
        }
        else {
            res.send(d);
        }
    });
});

router.post('/sort', function (req, res) {
    parseReq.parseJSONfromBody(req, (column) => {
        dalPerson.sortPerson(column, (err, result)=> {
            if (err) {
                res.status(500).json({"error": err});
            }
            else {
                res.send(result);
            }
        });
    });  
});

router.post('/add', function (req, res) {
    parseReq.parseJSONfromBody(req, (data) => {
        dalPerson.insertPerson(data, (err, result)=> {
            if (err) {
                res.status(500).json({"error": err});
            }
            else {
                res.send(result);
            }
        });
    });  
});

router.post('/update', function (req, res) {
    parseReq.parseJSONfromBody(req, (data) => {
        dalPerson.updatePerson(data, (err, result)=> {
            if (err) {
                res.status(500).json({"error": err});
            }
            else {
                res.send(result);
            }
        });
    });  
});

router.post('/delete', function (req, res) {
    parseReq.parseJSONfromBody(req, (data) => {
        dalPerson.deletePerson(data, (err, result)=> {
            if (err) {
                res.status(500).json({"error": err});
            }
            else {
                res.send(result);
            }
        });
    });  
});

export default router;