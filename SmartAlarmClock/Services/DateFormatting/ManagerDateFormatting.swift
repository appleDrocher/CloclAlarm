import Foundation

protocol DateService {
    func dayOfWeek(for date: Date) -> String
}

class DateConverterService: DateService {
    
    static let shared: DateService = DateConverterService()
    
    private let dateFormatter: DateFormatter
    
    init() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
    }
    
    func dayOfWeek(for date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
}
