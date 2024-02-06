import UIKit
import UserNotifications
import AVFoundation

protocol AlarmServiceProtocol: UNUserNotificationCenterDelegate {
    var notificationCenter: UNUserNotificationCenter { get }
    var audioPlayer: AVAudioPlayer? { get set }
    var isAlarmPlaying: Bool { get set }
    
    func setAlarm(date: Date)
    func playAlarmSound()
    func stopAlarmSound()
}

class AlarmService: NSObject, AlarmServiceProtocol {
    var isAlarmPlaying: Bool = false
    
    let notificationCenter = UNUserNotificationCenter.current()
    var audioPlayer: AVAudioPlayer?
    
    override init() {
        super.init()
        notificationCenter.delegate = self
    }
    
    func setAlarm(date: Date) {
        notificationCenter.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
            if granted {
                try? AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: .mixWithOthers)

                let content = UNMutableNotificationContent()
                content.title = "Alarm"
                content.body = "Wake up!"
                content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "Radar-1.mp3"))
                
                let calendar = Calendar.current
                let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
                let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
                let request = UNNotificationRequest(identifier: "AlarmNotification", content: content, trigger: trigger)
                
                self.notificationCenter.add(request) { error in
                    if let error = error {
                        print("Error setting alarm: \(error.localizedDescription)")
                    } else {
                        print("Alarm set successfully")
                    }
                }
                
                let repeatCount = 4
                
                for i in 1...repeatCount {
                    let repeatContent = UNMutableNotificationContent()
                    repeatContent.title = "Alarm"
                    repeatContent.body = "Wake up!"
                    repeatContent.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "Radar-1.mp3"))
                    
                    let triggerDate = date.addingTimeInterval(TimeInterval(i * 5))
                    let repeatTrigger = UNCalendarNotificationTrigger(dateMatching: calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: triggerDate), repeats: false)
                    
                    let repeatRequest = UNNotificationRequest(identifier: "RepeatAlarmNotification\(i)", content: repeatContent, trigger: repeatTrigger)
                    
                    self.notificationCenter.add(repeatRequest) { error in
                        if let error = error {
                            print("Error setting repeating alarm: \(error.localizedDescription)")
                        } else {
                            print("Repeating alarm \(i) set successfully")
                        }
                    }
                }
            } else if let error = error {
                print("Error requesting notification authorization: \(error.localizedDescription)")
            }
        }
    }

    func playAlarmSound() {
        guard let soundURL = Bundle.main.url(forResource: "Radar-1", withExtension: "mp3") else {
            print("Failed to find alarm sound file")
            return
        }
        
        do {
            try AVAudioSession.sharedInstance().setActive(true)
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            audioPlayer?.numberOfLoops = -1 // Зацикливание воспроизведения
            audioPlayer?.play()
        } catch {
            print("Error playing alarm sound: \(error.localizedDescription)")
        }

    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        if UIApplication.shared.applicationState != .active {
            if (notification.request.identifier == "AlarmNotification" ||
                notification.request.identifier.hasPrefix("RepeatAlarmNotification")) && !isAlarmPlaying {
                playAlarmSound()
            }
        }
        completionHandler([.sound, .alert])
    }


    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        notificationCenter.removeAllPendingNotificationRequests()
        stopAlarmSound()
        completionHandler()
    }
    
    func stopAlarmSound() {
        audioPlayer?.stop()
        audioPlayer = nil
        
        do {
            try AVAudioSession.sharedInstance().setActive(false)
        } catch {
            print("Error stopping alarm sound: \(error.localizedDescription)")
        }
    }
}
