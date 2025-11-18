const parseReq = {  
    
    parseJSONfromBody: function ( req, callback ) {
        let body = [];
        req.on('data', (chunk) => {
            body.push(chunk);
        }).on('end', () => {
            body = Buffer.concat(body).toString();
            var JSONobj = JSON.parse(body);
            callback( JSONobj);
        });
    }

}

export default parseReq
