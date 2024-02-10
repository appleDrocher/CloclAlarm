import UIKit

class TextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    private func setup() {
        backgroundColor = UIColor(red: 0.933, green: 0.931, blue: 0.931, alpha: 1)
        layer.cornerRadius = 8
        placeholder = "Название"
        tintColor = UIColor(red: 0.722, green: 0.725, blue: 0.729, alpha: 1)
        
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 10))
        leftPaddingView.backgroundColor = .clear 
        
        leftView = leftPaddingView
        leftViewMode = .always
    }
}
