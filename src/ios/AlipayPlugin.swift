import Foundation

@objc(AlipayPlugin) class AlipayPlugin : CDVPlugin {
    var scheme_ = "";
    func initAppScheme(command: CDVInvokedUrlCommand) {
      print(">>>> initAppScheme", terminator: "")
      let scheme = command.arguments[0] as! String;
      var pluginResult = CDVPluginResult?();
      self.scheme_ = scheme;
      if((self.scheme_) != ""){
          pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAsString: "success");
      }
     else{
         pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAsString: "failed");
      }
     self.commandDelegate!.sendPluginResult(pluginResult, callbackId:command.callbackId)
    };
    func callAlipaySDK(command: CDVInvokedUrlCommand) {
      print(">>>> callAlipaySDK", terminator: "")
      let orderinfo = command.arguments[0] as! String
      var pluginResult = CDVPluginResult?();
      if((self.scheme_) != ""){
          pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAsString: "success");
      }
     else{
         pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAsString: "failed");
      }
     self.commandDelegate!.sendPluginResult(pluginResult, callbackId:command.callbackId)
      /*AlipaySDK.defaultService().payOrder(orderinfo, fromScheme: self.scheme_)
      {(result: [NSObject: AnyObject]!) -> Void in
          var resultTxt:String!="failed"
          var txt:String! = "支付失败"
          if (result != nil) {
              txt = result["memo"] as! String
              let status = result["resultStatus"] as! NSObject
              if ("\(status)" == "9000") {
              resultTxt = "success"
          }
          let pluginResult = CDVPluginResult(status: CDVCommandStatus_OK, messageAsString: resultTxt)
          self.commandDelegate!.sendPluginResult(pluginResult, callbackId:command.callbackId);
          }
        }*/
    };
}
