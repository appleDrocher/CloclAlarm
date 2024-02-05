import UIKit
import Constraints

class ViewController: UIViewController {
    let content = UIView()
    
    let alarmService = AlarmService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        
        let button1 = CreateButton()
        
        let button2 = SaveButton()
        
        let button3 = ScanButton()
       
        view.addSubview(content)
        content.addSubview(datePicker)
        content.addSubview(button1)
        content.addSubview(button2)
        content.addSubview(button3)
        
        content.layout
            .box(in: view)
            .activate()
        
        datePicker.layout
            .top(250)
            .centerX()
            .activate()
        
        button1.layout
            .leading(28)
            .trailing(28)
            .height(80)
            .top(600)
            .activate()
        
        button2.layout
            .leading(28)
            .trailing(28)
            .height(80)
            .top(500)
            .activate()
        
        button3.layout
            .leading(28)
            .trailing(28)
            .height(80)
            .top(400)
            .activate()
        
    }
        
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        alarmService.setAlarm(date: selectedDate)
    }
    
    @objc func playAlarmSound() {
        alarmService.playAlarmSound()
    }
}
