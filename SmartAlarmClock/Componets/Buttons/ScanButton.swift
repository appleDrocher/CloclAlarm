import UIKit

class ScanButton: SaveButton {
    
    override func setupButton() {
        super.setupButton()
        
        setTitle("СКАНИРОВАТЬ", for: .normal)
        titleLabel?.font = .systemFont(ofSize: 28, weight: .medium)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: -110, bottom: 0, right: 0)
        
       
        
    }
}
