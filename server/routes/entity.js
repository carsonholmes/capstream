import express from 'express';
import parseReq from '../shared/parseReq.js';
import bplEntity from '../bpl/bplEntity.js';

const router = express.Router();

router.post('/', function (req, res) {
    parseReq.parseJSONfromBody(req, (data) => {
        bplEntity.search(data, function (err, d) {
            if (err) {
                res.status(500).json({"error": err});
            }
            else {
                res.send(d);
            }
        });
    })
});

router.post('/view', function (req, res) {
    parseReq.parseJSONfromBody(req, (data) => {
        bplEntity.view(data, function (err, d) {
            if (err) {
                res.status(500).json({"error": err});
            }
            else {
                res.send(d);
            }
        });
    })
});

router.post('/load', function (req, res) {
    parseReq.parseJSONfromBody(req, (data) => {
        bplEntity.selectEntityByOwner(data, function (err, d) {
            if (err) {
                res.status(500).json({"error": err});
            }
            else {
                res.send(d);
            }
        });
    })
});

router.post('/load-content', function (req, res) {
    parseReq.parseJSONfromBody(req, (data) => {
        bplEntity.loadContent(data, function (err, d) {
            if (err) {
                res.status(500).json({"error": err});
            }
            else {
                res.send(d);
            }
        });
    })
});

router.post('/load-owner', function (req, res) {
    parseReq.parseJSONfromBody(req, (data) => {
        bplEntity.loadOwner(data, function (err, d) {
            if (err) {
                res.status(500).json({"error": err});
            }
            else {
                res.send(d);
            }
        });
    })
});

router.post('/load-categories', function (req, res) {
    parseReq.parseJSONfromBody(req, (data) => {
        bplEntity.loadCategories(data, function (err, d) {
            if (err) {
                res.status(500).json({"error": err});
            }
            else {
                res.send(d);
            }
        });
    })
});

router.post('/load-offer', function (req, res) {
    parseReq.parseJSONfromBody(req, (data) => {
        bplEntity.loadOffer(data, function (err, d) {
            if (err) {
                res.status(500).json({"error": err});
            }
            else {
                res.send(d);
            }
        });
    })
});

router.post('/load-area', function (req, res) {
    parseReq.parseJSONfromBody(req, (data) => {
        bplEntity.loadArea(data, function (err, d) {
            if (err) {
                res.status(500).json({"error": err});
            }
            else {
                res.send(d);
            }
        });
    })
});

router.post('/add', function (req, res) {
    parseReq.parseJSONfromBody(req, (data) => {
        bplEntity.insertEntity(data, (err, result)=> {
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
        bplEntity.updateEntity(data, (err, result)=> {
            if (err) {
                res.status(500).json({"error": err});
            }
            else {
                res.send(result);
            }
        });
    });  
});

router.post('/verify-relate', function (req, res) {
    parseReq.parseJSONfromBody(req, (data) => {
        bplEntity.verifyRelate(data, (err, result)=> {
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
        bplEntity.deleteEntities(data, (err, result)=> {
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