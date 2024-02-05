import Foundation

protocol UserDefaultsServiceProtocol {
    func saveValue<T>(_ value: T, forKey key: String)
    func getValue<T>(forKey key: String) -> T?
    func removeValue(forKey key: String)
    func clearAllValues()
}

class UserDefaultsService: UserDefaultsServiceProtocol {
    
    static let shared: UserDefaultsServiceProtocol = UserDefaultsService()
    
    private let defaults = UserDefaults.standard
    
    func saveValue<T>(_ value: T, forKey key: String) {
        defaults.set(value, forKey: key)
    }
    
    func getValue<T>(forKey key: String) -> T? {
        return defaults.value(forKey: key) as? T
    }
    
    func removeValue(forKey key: String) {
        defaults.removeObject(forKey: key)
    }
    
    func clearAllValues() {
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
}
