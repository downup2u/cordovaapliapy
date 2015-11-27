var exec = require('cordova/exec');

function AlipayPlugin() {};

AlipayPlugin.prototype.initAppScheme = function (scheme, success, error) {
  exec(success, error, "AlipayPlugin", "initAppScheme", [scheme]);
};

AlipayPlugin.prototype.callAlipaySDK = function(orderStr, success, error) {
    exec(success, error, "AlipayPlugin", "callAlipaySDK", [orderStr]);
};

module.exports = new AlipayPlugin();
