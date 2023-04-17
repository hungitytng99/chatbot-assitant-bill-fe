// create by Minh Nguyen;
// email: mnx2012@gmail.com;

const funcStore = {};

const uriRegister = {
    addFunc: function(name, func) {
        if (funcStore[name]) {
            console.log(`The function ${name} have been exist!`);
        }

        funcStore[name] = func;
    },
    getAllFunc: function() {
        return Object.keys(funcStore);
    },
    getFuncByName: function(name) {
        return funcStore[name];
    }
}

module.exports = uriRegister;
