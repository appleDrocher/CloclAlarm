import UIKit

class CreateButton: SaveButton {
    
    override func setupButton() {
        super.setupButton()
        
        setTitle("СОХРАНИТЬ", for: .normal)
        titleLabel?.font = .systemFont(ofSize: 28, weight: .medium)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -150, bottom: 0, right: 0)
        
        let image = UIImage(named: "checkmarkImage")
        setImage(image, for: .normal)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: 270, bottom: 0, right: 0)
        
    }
}
