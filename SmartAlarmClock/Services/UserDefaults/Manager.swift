import Foundation

protocol UserDefaultsManaging {
    func saveValue(_ value: Any, forKey key: String)
    func getValue(forKey key: String) -> Any?
    func removeValue(forKey key: String)
    func clearAllValues()
}

class UserDefaultsManager: UserDefaultsManaging {
    
    static let shared: UserDefaultsManaging = UserDefaultsManager()
    
    private let defaults = UserDefaults.standard
    
    func saveValue(_ value: Any, forKey key: String) {
        defaults.set(value, forKey: key)
    }
    
    func getValue(forKey key: String) -> Any? {
        return defaults.value(forKey: key)
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
