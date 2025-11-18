import express from 'express';
import parseReq from '../shared/parseReq.js';
import dalOrg from '../dal/dalorg.js';

const router = express.Router();

router.get('/', function (req, res) {
    dalOrg.selectOrgAll(function (err, d) {
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
        dalOrg.sortOrg(column, (err, result)=> {
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
        dalOrg.insertOrg(data, (err, result)=> {
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
        dalOrg.updateOrg(data, (err, result)=> {
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
        dalOrg.deleteOrg(data, (err, result)=> {
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