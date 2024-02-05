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
        NotificationCenter.default.addObserver(self, selector: #selector(handleInterruption), name: AVAudioSession.interruptionNotification, object: nil)
        
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
        guard let soundURL = Bundle.main.url(forResource: "testSound", withExtension: "mp3") else {
            print("Не удалось найти звуковой файл будильника")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setActive(false, options: .notifyOthersOnDeactivation)
            try AVAudioSession.sharedInstance().setCategory(.playback, options: .mixWithOthers)
            try AVAudioSession.sharedInstance().setActive(true)
            
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
    
    @objc func handleInterruption(notification: Notification) {
        guard let info = notification.userInfo,
              let typeValue = info[AVAudioSessionInterruptionTypeKey] as? UInt,
              let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
            return
        }
        
        switch type {
        case .began:
            // Прерывание началось, остановите воспроизведение
            stopAlarmSound()
        case .ended:
            // Прерывание закончилось, возобновите воспроизведение
            if let optionsValue = info[AVAudioSessionInterruptionOptionKey] as? UInt {
                let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
                if options.contains(.shouldResume) {
                    playAlarmSound()
                }
            }
        default: ()
        }
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "AlarmNotification" {
            stopAlarmSound()
        }
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if notification.request.identifier == "AlarmNotification" {
            playAlarmSound()
        }
        
        let presentationOptions: UNNotificationPresentationOptions = [.alert, .sound]
        completionHandler(presentationOptions)
    }
}

