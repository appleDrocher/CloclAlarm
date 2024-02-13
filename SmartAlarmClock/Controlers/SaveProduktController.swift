
import Constraints
import UIKit
import MCEmojiPicker

class SaveProduktController: UIViewController {
    
    let content = UIView()
    
    let manager = CoreManager.shared
    
    weak var delegate: SaveProduktControllerDelegate?
    
    lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(selectEmojiAction), for: .touchUpInside)
        button.layer.backgroundColor = UIColor(red: 0.933, green: 0.931, blue: 0.931, alpha: 1).cgColor
        button.layer.cornerRadius = 8
     
        button.setTitle("🙋🏻‍♂️", for: .normal)
        return button
    }()
    
    let shadowView = ShadowView()
    
    let button1 = CreateButton()
    
    let textField = TextField()
    
    var scanData = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let backButton = UIBarButtonItem()
        backButton.title = "Список вещей"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.tintColor = .black
        view.backgroundColor = UIColor(red: 0.975, green: 0.975, blue: 0.975, alpha: 1)
        button1.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        button1.isEnabled = false
        button1.alpha = 0.5
        dismissButton.titleLabel?.font = UIFont.systemFont(ofSize: 28)

        textField.delegate = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let currentDate = dateFormatter.string(from: Date())
        
        scanData.text = currentDate
        
        
        view.addSubview(content)
        content.addSubview(shadowView)
        content.addSubview(button1)
        shadowView.addSubview(textField)
        shadowView.addSubview(dismissButton)
        
        content.layout
            .box(in: view)
            .activate()
        
        shadowView.layout
            .leading(28)
            .trailing(28)
            .width(350)
            .height(101)
            .top(28)
            .activate()
        
        button1.layout
            .leading.equal(shadowView)
            .trailing.equal(shadowView)
            .height(80)
            .bottom(42)
            .activate()
        
        dismissButton.layout
            .leading(20)
            .top(20)
            .width(64)
            .height(64)
            .activate()
        
        textField.layout
            .leading(100)
            .top(20)
            .height(64)
            .trailing(20)
            .activate()
        
    }
    
    @objc private func selectEmojiAction(_ sender: UIButton) {
        let viewController = MCEmojiPickerViewController()
        viewController.delegate = self
        viewController.sourceView = sender
        viewController.customHeight = 300
        present(viewController, animated: true)
    }
    
    @objc private func saveButtonTapped() {
        self.manager.addNewAlarm(listName: textField.text ?? "", Emoji: dismissButton.titleLabel?.text ?? "", scanData: scanData.text ?? "")
        if let listNameController = navigationController?.viewControllers.first as? ListNameController {
            DispatchQueue.main.async {
                listNameController.updateItems()
            }
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
        delegate?.didSaveNewItem()
        navigationController?.popToRootViewController(animated: true)
       
        
    }
}

extension SaveProduktController: MCEmojiPickerDelegate {
    func didGetEmoji(emoji: String) {
        self.dismissButton.setTitle(emoji, for: .normal)
    }
}

extension SaveProduktController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = (textField.text as NSString?)?.replacingCharacters(in: range, with: string), !text.isEmpty {
            button1.isEnabled = true
            button1.alpha = 1.0
        } else {
            button1.isEnabled = false
            button1.alpha = 0.5
        }
        
        return true
    }
}
