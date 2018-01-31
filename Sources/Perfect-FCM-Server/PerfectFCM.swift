import Foundation
import OAuth2
import cURL
import PerfectCURL

public class PerfectFCM {
    
    public enum Exception: Error {
        case UnknownHost
        case InvalidFile
        case InvalidHeader
        case CannonConvertToJson
        case CannotSign
        case CannotGetAccessToken
    }
    
    static var access: Access?
    
    public static var debug = false
    
	open class Config {
		var serverKeyPath: String?
	}
	
	class Access {
		var accessToken: String
		var refreshToken: String
		
        
		init(_ accessToken: String, _ refreshToken: String) {
			self.accessToken = accessToken
			self.refreshToken = refreshToken
		}
	}
	
	public class func prepare() throws -> CURLRequest {
        let scope: [String] = ["https://www.googleapis.com/auth/firebase.messaging"]
		
		GoogleConfig.appid = "111461389955152133646"
		GoogleConfig.secret = "9875bbdfd84a62b730751a85de8946aff087dfd8"
		GoogleConfig.endpointAfterAuth = "http://localhost:8181/auth/response/google"
		GoogleConfig.redirectAfterAuth = "http://localhost:8181/"
		
		
//        if let provider = DefaultTokenProvider(scopes: scope) {
//            let sem = DispatchSemaphore(value: 0)
//
//            try? provider.withToken() { (token, error) -> Void in
//                if let token = token {
//                    self.token = token
//                }
//                if let error = error {
//                    print("ERROR \(error)")
//                }
//                sem.signal()
//            }
//            _ = sem.wait(timeout: DispatchTime.distantFuture)
//
//            let curlRequest = CURLRequest("https://fcm.googleapis.com/v1/projects/elyot-fc163/messages:send", .failOnError)
//            curlRequest.addHeader(.authorization, value: "Bearer \(self.token?.AccessToken ?? "")")
//            curlRequest.addHeader(.contentType, value: "application/json")
//
//            return curlRequest
//        } else {
//            print("Unable to obtain an auth token.\nTry pointing GOOGLE_APPLICATION_CREDENTIALS to your service account credentials.")
//            throw Exception.CannotGetAccessToken
//        }
	}
    
    public class func send(topic: String, title: String, body: String, data: [String: String]?) throws {
        var json: [String: Any] = [
            "message": [
                "topic": topic,
                "notification": [
                    "title": title,
                    "body": body
                ]
            ]
        ]
        
        if let data = data {
            json["data"] = data
        }
        
        let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
        
        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            throw Exception.CannonConvertToJson
        }
        
        let curlRequest = try prepare()
        curlRequest.options.append(.httpMethod(.post))
        curlRequest.options.append(.postString(jsonString))
        
        let curlResponse = try curlRequest.perform()
        
        print(curlResponse.bodyString)
    }
    
    public class func send(token: String, title: String, body: String, data: [String: String]?) throws {
        var json: [String: Any] = [
            "message": [
                "token": token,
                "notification": [
                    "title": title,
                    "body": body
                ]
            ]
        ]
        
        if let data = data {
            json["data"] = data
        }
        
        let jsonData = try JSONSerialization.data(withJSONObject: json, options: [])
        
        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            throw Exception.CannonConvertToJson
        }
        
        let curlRequest = try prepare()
        curlRequest.options.append(.httpMethod(.post))
        curlRequest.options.append(.postString(jsonString))
        
        let curlResponse = try curlRequest.perform()
        
        print(curlResponse.bodyString)
    }
    
}
