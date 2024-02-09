import UIKit

class CustomTabBarController: UITabBarController {

    let tabBarHeight: CGFloat = 50
    let statusBarHeight: CGFloat = 70
    let tabBarView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

      
        let firstViewController = CreateAlarmController()
      

        let secondViewController = TimerAlarmViewController()
       

        let thirdViewController = ListNameController()

        self.viewControllers = [firstViewController, secondViewController, thirdViewController]

        tabBarView.frame = CGRect(x: 0, y: statusBarHeight, width: view.frame.width, height: tabBarHeight)

        tabBarView.backgroundColor = .clear
        view.addSubview(tabBarView)

        let button1 = UIButton()
        button1.setImage(UIImage(named: "Frame-6"), for: .normal)
        button1.setImage(UIImage(named: "Frame-8"), for: .selected) // Устанавливаем изображение для выбранного состояния
        button1.frame = CGRect(x: 0, y: 0, width: view.frame.width / 3, height: tabBarHeight)
        button1.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
        button1.tag = 0
        tabBarView.addSubview(button1)

        let button2 = UIButton()
        button2.setImage(UIImage(named: "Icons"), for: .normal)
        button2.setImage(UIImage(named: "Vector-3"), for: .selected) // Устанавливаем изображение для выбранного состояния
        button2.frame = CGRect(x: view.frame.width / 3, y: 0, width: view.frame.width / 3, height: tabBarHeight)
        button2.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
        button2.tag = 1
        tabBarView.addSubview(button2)

        let button3 = UIButton()
        button3.setImage(UIImage(named: "Frame-5"), for: .normal)
        button3.setImage(UIImage(named: "Frame-7"), for: .selected) // Устанавливаем изображение для выбранного состояния
        button3.frame = CGRect(x: 2 * view.frame.width / 3, y: 0, width: view.frame.width / 3, height: tabBarHeight)
        button3.addTarget(self, action: #selector(tabButtonTapped(_:)), for: .touchUpInside)
        button3.tag = 2
        tabBarView.addSubview(button3)

        selectedTab = 0

    }


    @objc func tabButtonTapped(_ sender: UIButton) {

        selectedTab = sender.tag
        for subview in tabBarView.subviews {
            if let button = subview as? UIButton {
                button.isSelected = (button == sender)
            }
        }
    }

    var selectedTab: Int = 0 {
        didSet {
            selectedIndex = selectedTab
        }
    }
}

extension CustomTabBarController {

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let selectedIndex = self.selectedIndex
        let selectedButton = tabBarView.subviews[selectedIndex] as! UIButton
        selectedButton.isSelected = true
    }
}
