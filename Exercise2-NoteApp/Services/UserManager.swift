
import Foundation
import Security


internal class KeyChainHelper {
    @discardableResult
    static func save(key: String, data: String) -> OSStatus{
        guard let value = data.data(using: .utf8) else {return OSStatus()}
        let query: [CFString: Any ] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: value
        ]
        
        SecItemDelete(query as CFDictionary)
        return SecItemAdd(query as CFDictionary, nil)
    }
    
    static func load(key: String) -> Data?{
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ]
        
        var data: AnyObject? = nil
        let status: OSStatus = SecItemCopyMatching(query as CFDictionary, &data)
        if status == noErr {
            return data as? Data
        }else {
            return nil
        }
    }
    
    static func delete(key: String) -> OSStatus {
        let query: [CFString: Any] = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ]
        return SecItemDelete(query as CFDictionary)
    }
}

class AccountManager{
    static var shared = AccountManager()
    private init(){}
    
    static func validateCredentail(username: String, password: String) -> Bool{
        guard let retrivedData = KeyChainHelper.load(key: username),
              let passwordData = String(data: retrivedData, encoding: .utf8) else {return false}
        if passwordData == password {
            setAccountInfo(username: username)
        }
        return passwordData == password
    }
    
    static func setAccountInfo(username: String){
        UserDefaults.standard.setValue(username, forKey: "username")
    }
    static func getAccountInfo()-> String {
        guard let username = UserDefaults.standard.string(forKey: "username") else {return ""}
        return username
    }
    
    
}

