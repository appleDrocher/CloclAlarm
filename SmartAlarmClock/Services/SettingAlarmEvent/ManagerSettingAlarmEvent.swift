import UIKit
import UserNotifications
import AVFoundation

protocol AlarmServiceProtocol: UNUserNotificationCenterDelegate {
    var notificationCenter: UNUserNotificationCenter { get }
    var audioPlayer: AVAudioPlayer? { get set }
    
    func setAlarm(date: Date)
    func playAlarmSound()
    func stopAlarmSound()
}

class AlarmService: NSObject, AlarmServiceProtocol {
    let notificationCenter = UNUserNotificationCenter.current()
    var audioPlayer: AVAudioPlayer?
    
    override init() {
        super.init()
        notificationCenter.delegate = self
       
    }
    
    func setAlarm(date: Date) {
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                let content = UNMutableNotificationContent()
                content.title = "Будильник"
                content.body = "Пора проснуться!"
                content.sound = UNNotificationSound.default
                content.categoryIdentifier = "AlarmCategory"
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: date.timeIntervalSinceNow, repeats: false)
                let request = UNNotificationRequest(identifier: "AlarmNotification", content: content, trigger: trigger)
                
                self.notificationCenter.add(request) { error in
                    if let error = error {
                        print("Ошибка при установке будильника: \(error.localizedDescription)")
                    } else {
                        print("Будильник успешно установлен на \(date)")
                    }
                }
            } else if let error = error {
                print("Ошибка при запросе разрешения на уведомления: \(error.localizedDescription)")
            }
        }
    }
    
    func playAlarmSound() {
        guard let soundURL = Bundle.main.url(forResource: "Radar-1", withExtension: "mp3") else {
            print("Не удалось найти звуковой файл будильника")
            return
        }
        
        do {
                try AVAudioSession.sharedInstance().setCategory(.playback, options: .mixWithOthers)
                try AVAudioSession.sharedInstance().setActive(true)
                
            var backgroundTaskIdentifier: UIBackgroundTaskIdentifier = .invalid
                  
                  backgroundTaskIdentifier = UIApplication.shared.beginBackgroundTask(withName: "AlarmBackgroundTask") {
                    
                      UIApplication.shared.endBackgroundTask(backgroundTaskIdentifier)
                  }
                  
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("Ошибка при проигрывании звукового файла: \(error.localizedDescription)")
            }
        }
    func stopAlarmSound() {
        audioPlayer?.stop()
        audioPlayer = nil
        
        do {
            try AVAudioSession.sharedInstance().setActive(false)
        } catch {
            print("Ошибка при остановке звукового файла: \(error.localizedDescription)")
        }
    }
    
}

