import UIKit
import Constraints

class ListNameController: UIViewController {
    let content = UIView()
    
    
    let alarmService = AlarmService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let button3: ScanButton = {
            let button = ScanButton()
            button.addTarget(self, action: #selector(goToScan), for: .touchUpInside)
            return button
        }()
        
        view.addSubview(content)
        content.addSubview(button3)
     
        content.layout
            .box(in: view)
            .activate()
        
        
        button3.layout
            .leading(28)
            .trailing(28)
            .height(80)
            .top(600)
            .activate()
        
    }
    @objc func goToScan() {
        let controller = ScannerViewController()
        
        navigationController?.pushViewController(controller, animated: true)
    }
    
}
