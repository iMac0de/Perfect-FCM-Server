import Foundation
import cURL
import PerfectCURL

open class PerfectFCM {
    
    open class Config {
        var serverKey: String
        
        public init(serverKey: String) {
            self.serverKey = serverKey
        }
    }
    
    public enum Exception: Error {
        case UnknownHost
        case InvalidHeader
        case CannonConvertToJson
        case CannotGetAccessToken
    }
    
    public static var debug = false
	
    public class func prepare(_ config: Config) throws -> CURLRequest? {
        if !config.serverKey.isEmpty {
            let curlRequest = CURLRequest("https://fcm.googleapis.com/fcm/send", .failOnError)
            curlRequest.addHeader(.authorization, value: "key=\(config.serverKey)")
            curlRequest.addHeader(.contentType, value: "application/json")
            
            return curlRequest
        }
        
        return nil
	}
    
    public class func send(_ config: PerfectFCM.Config, to: String, title: String, body: String, data: [String: String]?) throws {
        var json: [String: Any] = [
            "to": to,
            "notification": [
                "title": title,
                "body": body
            ]
        ]
        
        if let data = data {
            json["data"] = data
        }
        
        let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
        
        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            throw Exception.CannonConvertToJson
        }
        
        if let curlRequest = try prepare(config) {
            curlRequest.options.append(.httpMethod(.post))
            curlRequest.options.append(.postString(jsonString))
            let _ = try curlRequest.perform()
        }
    }
    
}
