import Foundation

protocol DateConverterServiceProtocol {
    func dayOfWeek(for date: Date) -> String
}

class DateConverterService: DateConverterServiceProtocol {
    
    static let shared: DateConverterServiceProtocol = DateConverterService()
    
    private let dateFormatter: DateFormatter
    
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
    }
    
    func dayOfWeek(for date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
}
