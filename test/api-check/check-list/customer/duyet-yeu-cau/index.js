
const fs = require("fs");

//http://194.163.178.42:68/msx-utility/api/domain/v1/bql/booking/approve/5ea48deb-7332-4898-a316-c99a5876a513
//http://194.163.178.42:68/msx-utility/api/domain/v1/bql/booking/reject/6cee2743-383b-45de-a983-1f9e26d46038
// get user role;
module.exports = async function(iRequest, configs, headers, funcName) {

    const wstream = fs.createWriteStream(funcName + "/result-test.json");

    console.time(funcName);
    const response = await iRequest(configs.APP_API + "/msx-utility/api/domain/v1/bql/booking/approve/7257a7ad-78f6-462f-8d5d-0a0169c7a0fc", "POST", headers, {}, null, {
    });
    console.timeEnd(funcName);

    const message = JSON.stringify(response, null, "\t");

    // finish write;
    wstream.write(message);
    wstream.end(function () {
        console.log("check", funcName, "done\n");
    });
};
