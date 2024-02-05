import UIKit

class SaveButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        buttonPressAnimation()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        buttonReleaseAnimation()
    }
    
    private func buttonPressAnimation() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform(scaleX: 0.97, y: 0.97)
        }, completion: nil)
    }
    
    private func buttonReleaseAnimation() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
    }
    
    func setupButton() {
        layer.shadowColor = UIColor(red: 1, green: 0.455, blue: 0.408, alpha: 0.45).cgColor
        layer.shadowOpacity = 1
        layer.shadowRadius = 30
        layer.shadowOffset = CGSize(width: 0, height: 4)
        
        backgroundColor = UIColor(red: 1, green: 0.455, blue: 0.408, alpha: 1)
        layer.cornerRadius = 16
        
        setTitle("СОЗДАТЬ", for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 28, weight: .medium)
        
        
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 175)
        
        let image = UIImage(named: "plusImage")
        setImage(image, for: .normal)
        
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 280, bottom: 0, right: 0)
        
        adjustsImageWhenHighlighted = false
         }
     }

    
