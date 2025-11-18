import express from 'express';
import parseReq from '../shared/parseReq.js';
import bplUser from '../bpl/bplUser.js';

var router = express.Router();

router.get('/', function (req, res) {
    bplUser.selectUserAll(function (err, d) {
        if (err) {
            res.status(500).json({"error": err});
        }
        else {
            res.send(d);
        }
    });
});

router.post('/sign-in', function (req, res) {
    parseReq.parseJSONfromBody(req, (data) => {
        bplUser.signInUser(data, (err, result)=> {
            if (err) {
                res.status(500).json({"error": err});
            }
            else {
                res.send(result);
            }
        });
    });  
});

router.post('/load', function (req, res) {
    parseReq.parseJSONfromBody(req, (data) => {
        bplUser.loadUser(data, (err, result)=> {
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
    console.log("Web service call recieved for: user - add")
    parseReq.parseJSONfromBody(req, (data) => {
        bplUser.insertUser(data, (err, result)=> {
            if (err) {
                res.status(500).json({"error": err});
            }
            else {
                res.send(result);
            }
        });
    });  
});

router.post('/check-user-name', function (req, res) {
    parseReq.parseJSONfromBody(req, (data) => {
        bplUser.checkUserName(data, (err, result)=> {
            if (err) {
                res.status(500).json({"error": err});
            }
            else {
                res.send(result);
            }
        });
    });  
});

router.post('/verify-email', function (req, res) {
    parseReq.parseJSONfromBody(req, (data) => {
        bplUser.verifyEmail(data, (err, result)=> {
            if (err) {
                res.status(500).json({"error": err});
            }
            else {
                res.send(result);
            }
        });
    });  
});

router.post('/verify-session', function (req, res) {
    parseReq.parseJSONfromBody(req, (data) => {
        bplUser.verifySession(data, (err, result)=> {
            if (err) {
                res.status(500).json({"error": err});
            }
            else {
                res.send(result);
            }
        });
    });  
});

router.post('/resend-email', function (req, res) {
    parseReq.parseJSONfromBody(req, (data) => {
        bplUser.resendEmail(data, (err, result)=> {
            if (err) {
                res.status(500).json({"error": err});
            }
            else {
                res.send(result);
            }
        });
    });  
});

router.post('/forgot-password', function (req, res) {
    parseReq.parseJSONfromBody(req, (data) => {
        bplUser.forgotPassword(data, (err, result)=> {
            if (err) {
                res.status(500).json({"error": err});
            }
            else {
                res.send(result);
            }
        });
    });  
});

router.post('/forgot-user-name', function (req, res) {
    parseReq.parseJSONfromBody(req, (data) => {
        bplUser.forgotUserName(data, (err, result)=> {
            if (err) {
                res.status(500).json({"error": err});
            }
            else {
                res.send(result);
            }
        });
    });  
});

router.post('/reset-password', function (req, res) {
    parseReq.parseJSONfromBody(req, (data) => {
        bplUser.resetPassword(data, (err, result)=> {
            if (err) {
                res.status(500).json({"error": err});
            }
            else {
                res.send(result);
            }
        });
    });  
});

router.post('/change-password', function (req, res) {
    parseReq.parseJSONfromBody(req, (data) => {
        bplUser.changePassword(data, (err, result)=> {
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
        bplUser.updateUser(data, (err, result)=> {
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
        bplUser.deleteUser(data, (err, result)=> {
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