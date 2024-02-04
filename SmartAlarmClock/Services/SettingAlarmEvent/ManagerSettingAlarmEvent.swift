import UIKit
import UserNotifications
import AVFoundation

class AlarmService: NSObject, UNUserNotificationCenterDelegate {
    let notificationCenter = UNUserNotificationCenter.current()
    var audioPlayer: AVAudioPlayer?
    
    override init() {
        super.init()
        notificationCenter.delegate = self
    }
    
    func setAlarm(date: Date) {
        // Создаем контент для уведомления
        let content = UNMutableNotificationContent()
        content.title = "Будильник"
        content.body = "Пора проснуться!"
        content.sound = UNNotificationSound.default
        
        // Создаем триггер для уведомления
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        
        // Создаем запрос на уведомление
        let request = UNNotificationRequest(identifier: "AlarmNotification", content: content, trigger: trigger)
        
        // Регистрируем запрос на уведомление
        notificationCenter.add(request) { error in
            if let error = error {
                print("Ошибка при установке будильника: \(error.localizedDescription)")
            } else {
                print("Будильник успешно установлен на \(date)")
            }
        }
    }
    
    func playAlarmSound() {
        guard let soundURL = Bundle.main.url(forResource: "E", withExtension: "mp3") else {
            print("Не удалось найти звуковой файл будильника")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.play()
        } catch {
            print("Ошибка при проигрывании звукового файла: \(error.localizedDescription)")
        }
    }
    
    // Обработка события при получении уведомления в активном состоянии приложения
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Вызываем событие и проигрываем звук будильника
        playAlarmSound()
        
        // Опционально можно настроить отображение уведомления в активном состоянии приложения
        completionHandler([.alert, .sound])
    }
}
