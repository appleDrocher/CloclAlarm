import Foundation

struct Alarm {
    let name: String
    let time: Date
    let isEnabled: Bool
    let repeatDays: [Weekday]
    let sound: Sound
}

enum Weekday: String {
    case monday = "Пн"
    case tuesday = "Вт"
    case wednesday = "Ср"
    case thursday = "Чт"
    case friday = "Пт"
    case saturday = "Сб"
    case sunday = "Вс"
    case other = "Без повтора"
}

struct Sound {
    let name: String
    let fileURL: URL
}


