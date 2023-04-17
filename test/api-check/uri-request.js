// simple http request;
// create by Minh Nguyen;
// email: mnx2012@gmail.com;

const https = require('https');
const http = require('http');
const url = require('url');

/*
    uriRequest
        link,
        method,
        headers,
        options,
        searchParams,
        dataRequest
*/

const uriRequest = (link, method = "GET", headers = {}, options = {}, searchParams = null, dataRequest = null) => {
    var { protocol, hostname, port, path } = url.parse(link);

    const xhrOptions = {
        hostname: hostname,
        port: port,
        path: path,
        method: method.toLowerCase(),
        headers: Object.assign({'User-Agent': '*'}, headers)
    };

    if (searchParams !== null) {
        var urlSearch = new URLSearchParams();

        for (let i in searchParams) {
            if (searchParams.hasOwnProperty(i)) {
                urlSearch.append(i, searchParams[i]);
            }
        }

        xhrOptions.body = urlSearch;
    }

    return new Promise((resolve, reject) => {
        let xProtocal = protocol && protocol.startsWith('https') ? https : http;
        let responseData = '';

        const request = xProtocal.request(xhrOptions, (result) => {

            result.on("data", (data) => {
                responseData += data;
            });

            result.on("error", (err) => {
				console.log("result error");
                reject(err);
            });

            result.on("end", (a, b, c) => {
                const { rawHeaders } = result;

                try {
                    if (options.noParse === true || !rawHeaders.join("").includes("application/json;")) {
                        resolve(responseData);
                    } else {
                        resolve(JSON.parse(responseData));
                    }
                } catch(err) {
					console.log("parse error");
                    reject(err);
                }
            });

        });

        request.on("error", (error) => {
			console.log("request error");
            reject(error);
        });

        if (dataRequest != null) {
            request.write(JSON.stringify(dataRequest));
        }

        request.end();
    });
};

module.exports = uriRequest;
