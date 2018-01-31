import Foundation
import OAuth2

public class PerfectFCM {
    
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
	
	public class func prepare() {
		if let path = ProcessInfo.processInfo.environment["GOOGLE_APPLICATION_CREDENTIALS"] {
			print(path)
		}
	}
    
}
