import UIKit

class ShadowView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupShadow()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupShadow()
    }

    private func setupShadow() {
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.01).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 15
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.masksToBounds = false
        backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
        layer.cornerRadius = 16
    }

}
