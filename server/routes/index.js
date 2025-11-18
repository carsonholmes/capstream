import express from 'express';

var router = express.Router();

router.get('/', function (req, res) {
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.write('CapStream Web Service Home!\n');
    res.end();
    //res.send('index', { name: "Home", children: "Hello World" });
});

export default router;
