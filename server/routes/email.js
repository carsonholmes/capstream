import express from 'express';
const router = express.Router();
import parseReq from '../shared/parseReq.js';
import bplEmail from '../bpl/bplEmail.js';

// router.get('/', function (req, res) {
//     bplEmail.selectEmailAll(function (err, d) {
//         if (err) {
//             res.status(500).json({"error": err});
//         }
//         else {
//             res.send(d);
//         }
//     });
// });

router.post('/load', function (req, res) {
    parseReq.parseJSONfromBody(req, (column) => {
        bplEmail.loadUserEmail(column, (err, result)=> {
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
        bplEmail.insertEmail(data, (err, result)=> {
            if (err) {
                res.status(500).json({"error": err});
            }
            else {
                res.send(result);
            }
        });
    });  
});

router.post('/test', function (req, res) {
    console.log('reached back end')
    parseReq.parseJSONfromBody(req, (data) => {
        bplEmail.testEmail(data, (err, result)=> {
            if (err) {
                res.status(500).json({"error": err});
            }
            else {
                res.send('result');
            }
        });
    });  
});

router.post('/update', function (req, res) {
    parseReq.parseJSONfromBody(req, (data) => {
        bplEmail.updateEmail(data, (err, result)=> {
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
        bplEmail.deleteEmail(data, (err, result)=> {
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