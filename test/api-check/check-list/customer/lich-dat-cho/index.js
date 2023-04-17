
const fs = require("fs");

// get user role;
module.exports = async function(iRequest, configs, headers, funcName) {

    const wstream = fs.createWriteStream(funcName + "/result-test.json");

    console.time(funcName);
    const response = await iRequest(configs.APP_API + "/msx-utility/api/query/v1/bql/utility/schedule?utilityid=fbc65682-fb14-40e7-bb3c-6dc3e74b05d0&bookingDate=2022-01-18", "GET", headers, {}, null, {
    });
                                                      ///msx-utility/api/query/v1/bql/utility/schedule?utilityid=dc2d154a-cfa0-413d-8f6b-79d76141a412&bookingDate=2022-01-17
    console.timeEnd(funcName);

    const message = JSON.stringify(response, null, "\t");

    // finish write;
    wstream.write(message);
    wstream.end(function () {
        console.log("check", funcName, "done\n");
    });
};
