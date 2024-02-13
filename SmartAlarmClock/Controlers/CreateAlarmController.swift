import UIKit
import Constraints

class CreateAlarmController: UIViewController {
    let content = UIView()
    
    let alarmService = AlarmService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
      
        
         
        let service = MathService()
        
        let example = service.generateExample()
        print("Пример:", example)
        
        if let result = service.resolveExample(example) {
            print("Результат:", result)
        
            let answers = service.generateAnswers(result)
            print("Варианты ответов:", answers)
        }
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        UNUserNotificationCenter.current().delegate = alarmService
      
        let button1 = CreateButton()
        
        view.addSubview(content)
        content.addSubview(datePicker)
        content.addSubview(button1)
    
        
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
            .bottom(42)
            .activate()
        
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        let selectedDate = sender.date
        alarmService.setAlarm(date: selectedDate)
    }
    
}

