import Flutter
import UIKit
import Evergage
import CommonCrypto

public class SwiftEvergageFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "evergage_flutter", binaryMessenger: registrar.messenger())
    let instance = SwiftEvergageFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
      
      let arguments = call.arguments as! NSDictionary
      
      let evergage = Evergage.sharedInstance()
      
      evergage.logLevel = EVGLogLevel.all
      
      switch call.method {
      case "start":
          evergage.start { (clientConfigurationBuilder) in
              clientConfigurationBuilder.account = arguments["account"] as! String
              clientConfigurationBuilder.dataset = arguments["dataset"] as! String
              clientConfigurationBuilder.usePushNotifications = arguments["usePushNotification"] as! Bool
          }
          
          result(nil)
      case "setUser":
          let email = arguments["email"] as? String
          
          evergage.userId = arguments["userId"] as? String
          evergage.setUserAttribute(arguments["firstName"] as? String, forName: "firstName")
          evergage.setUserAttribute(arguments["lastName"] as? String, forName: "lastName")
          evergage.setUserAttribute( email, forName: "emailAddress")
          
          if(email != nil){
              evergage.setUserAttribute( email!.sha256(), forName: "emailSHA256")
          }
          
          result(nil)
      case "setZipCode":
          evergage.setUserAttribute(arguments["zipCode"] as? String, forName: "zipCode")
          result(nil)
      case "viewProduct":
          let product = EVGProduct.init(id: arguments["id"] as! String)
          product.name = arguments["name"] as? String
          evergage.globalContext?.viewItem(product)
          result(nil)
      case "viewCategory":
          let category = EVGCategory.init(id: arguments["id"] as! String)
          category.name = arguments["name"] as? String
          evergage.globalContext?.viewCategory(category);
          result(nil)
      case "addToCart":
          let product = EVGProduct.init(id: arguments["id"] as! String)
          product.name = arguments["name"] as? String
          product.price = NSNumber(value: arguments["price"] as! Double)
          
          let lineItem = EVGLineItem.init(item: product, quantity: NSNumber(value: arguments["quantity"] as! Double))
          evergage.globalContext?.add(toCart: lineItem)
          result(nil)
      case "purchase":
          let orderId = arguments["orderId"] as? String
          let total = arguments["total"] as? Double
          let lines = arguments["lines"] as? String
          
          let linesDecodes = try! JSONDecoder().decode(ListSaleLine.self, from: lines!.data(using: String.Encoding.utf8)!)
          let saleLines: [SaleLine] = linesDecodes.list;
          var linesEvent: [EVGLineItem] = []
          
          for saleLine in saleLines {
              let product = EVGProduct.init(id: saleLine.id)
              product.name = saleLine.name
              product.price = NSNumber(value: saleLine.price)
              linesEvent.append(EVGLineItem.init(item: product, quantity: NSNumber(value: saleLine.quantity)))
          }
          
          let order = EVGOrder.init(id: orderId, lineItems: linesEvent, totalValue: NSNumber(value: total!))
          
          evergage.globalContext?.purchase(order)
          result(nil)
      default:
          result(FlutterMethodNotImplemented)
      }
  }
}

public extension Data{
    func sha256() -> String{
        return hexStringFromData(input: digest(input: self as NSData))
    }
    
    private func digest(input : NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(input.bytes, UInt32(input.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }
    
    private  func hexStringFromData(input: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: input.length)
        input.getBytes(&bytes, length: input.length)
        
        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }
        
        return hexString
    }
}

public extension String {
    func sha256() -> String{
        if let stringData = self.data(using: String.Encoding.utf8) {
            return stringData.sha256()
        }
        return ""
    }
}
