const uriRegister  = require("./uri-register.js");
const uriRequest  = require("./uri-request.js");
const fs = require("fs");

function registerAll(dir, callback) {
    var files = fs.readdirSync(dir);
    for (var i in files) {
        var name = dir + '/' + files[i];
        if (fs.statSync(name).isDirectory()){
            registerAll(name, callback);
        } else if ((/\.js$/i).test(files[i])) {
            callback(dir, name);
        }
    }
}

(async function() {
    const isDevEnv = process.argv[2] && process.argv[2].toString().toLocaleLowerCase() === "dev";
    const BASE_API = isDevEnv ? "http://194.163.178.42:68" : "https://apistaging.realagent.vn";
    const account = isDevEnv ? "nhanvien@gmail.tnv352" : "testbqlapp@yopmail.com";
    const password = isDevEnv ? "12345678" : "12345678";

    registerAll("./check-list", (dir, file) => {
        uriRegister.addFunc(dir, require(file));
    });

    const configs = {
        APP_API: BASE_API
    };

    const headers = {
        "content-type": "application/json",
    };

    // user login first to get token;
    try {
        const response = await uriRequest(BASE_API + "/msx-sts/api/domain/v1/auth/login", "POST", headers, {}, null, {
            "password": password,
            "email": account,
        });
        console.log("token", response);
        headers["Authorization"] = `Bearer ${response.access_token}`;
    } catch(e) {

    }

    uriRegister.getAllFunc().forEach(funcName => {
        const func = uriRegister.getFuncByName(funcName);
        
        if (func) {
            try {
                func(uriRequest, configs, headers, funcName);
            } catch(e) {
                console.log("error", funcName);
            }
        }
    });

    if (isDevEnv) {
        console.log("\nTest with Dev\n");
    } else {
        console.log("\nTest with Staging\n");
    }
})();
