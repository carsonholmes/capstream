import express from 'express';
import parseReq from '../shared/parseReq.js';
import multer from 'multer'
import bplMedia from '../bpl/bplMedia.js';

const router = express.Router();
const upload = multer({dest: 'uploads/'})

router.get('/', function (req, res) {
    bplMedia.selectMediaAll(function (err, d) {
        if (err) {
            res.status(500).json({"error": err});
        }
        else {
            res.send(d);
        }
    });
});

router.post('/load', function (req, res) {
    parseReq.parseJSONfromBody(req, (column) => {
        bplMedia.loadMedia(column, (err, result)=> {
            if (err) {
                res.status(500).json({"error": err});
            }
            else {
                res.send(result);
            }
        });
    });  
});

router.post('/upload', upload.single('file'), function (req, res) {
    if (req.files === null) {
            return res.status(500).json({error: 'No file uploaded' })
    }
    //combine file attributes and additional JSON into data
    var data = JSON.parse(JSON.stringify(req.file))
    for (let itemName in req.body) {
        data[itemName] = req.body[itemName]
    }
    console.table(data)
    bplMedia.uploadMedia(data, (err, result)=> {
        if (err) { 
            res.status(500).json({error: err})
        }
        else {
            res.send(result);
        }
    })
});

router.post('/add', function (req, res) {
    parseReq.parseJSONfromBody(req, (column) => {
        console.log('done parse, call insertMedia')
        bplMedia.insertMedia(column, (err, result)=> {
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
        bplMedia.updateMedia(data, (err, result)=> {
            if (err) {
                res.status(500).json({"error": err});
            }
            else {
                res.send(result);
            }
        });
    });  
});

router.post('/update-all', function (req, res) {
    parseReq.parseJSONfromBody(req, (data) => {
        bplMedia.updateMediaArray(data, (err, result)=> {
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
        bplMedia.deleteMedia(data, (err, result)=> {
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