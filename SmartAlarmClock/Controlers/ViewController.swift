import UIKit
import Constraints

class ViewController: UIViewController {
    let content = UIView()
    
    let alarmService = AlarmService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        view.addSubview(content)
        content.addSubview(datePicker)
        
        content.layout
            .box(in: view)
            .activate()
        
        datePicker.layout
            .centerX()
            .centerY()
            .activate()
        
    }
        
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        alarmService.setAlarm(date: selectedDate)
        
        let timer = Timer(fireAt: selectedDate, interval: 0, target: self, selector: #selector(playAlarmSound), userInfo: nil, repeats: false)
        RunLoop.main.add(timer, forMode: .common)
    }
    
    @objc func playAlarmSound() {
        alarmService.playAlarmSound()
    }
}
