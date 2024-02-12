import UIKit
import Constraints

protocol SaveProduktControllerDelegate: AnyObject {
    func didSaveNewItem()
}

class ListNameController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        let item = items[indexPath.row]
        cell.textLabel?.text = item.name
        return cell
    }
    
    let content = UIView()
    
    let shadowView = ShadowView()
    
    let manager = CoreManager.shared
    
    var tableview: UITableView = {
        let table = UITableView()
        
        
        return table
    }()
    
    let itemsName: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.003, green: 0.203, blue: 0.437, alpha: 1)
        label.font = .systemFont(ofSize: 28, weight: .medium)
        return label
    }()
    
    let itemsEmoji: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.098, green: 0.102, blue: 0.11, alpha: 1)
        label.font = .systemFont(ofSize: 28, weight: .heavy)
        return label
    }()
    
    let scanedData: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.003, green: 0.203, blue: 0.437, alpha: 1)
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
        
    let button3: ScanButton = {
        let button = ScanButton()
        button.addTarget(Any?(nilLiteral: ()), action: #selector(goToScan), for: .touchUpInside)
        return button
    }()
    
    var items: [ScannedItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        tableview.dataSource = self
        tableview.delegate = self
        updateItems()
        didSaveNewItem()
        view.addSubview(content)
        content.addSubview(button3)
        content.addSubview(shadowView)
        shadowView.addSubview(itemsName)
        shadowView.addSubview(itemsEmoji)
        shadowView.addSubview(scanedData)
        
        content.layout
            .box(in: view)
            .activate()
        
        button3.layout
            .leading(28)
            .trailing(28)
            .height(80)
            .top.equal(content.bottom, -66)
            .activate()
        
        shadowView.layout
            .leading(28)
            .trailing(28)
            .width(350)
            .height(101)
            .top(100)
            .activate()
        
        itemsName.layout
            .leading(16)
            .top(40)
            .activate()
        
        itemsEmoji.layout
            .top(31)
            .trailing(28)
            .activate()
        
        scanedData.layout
            .top(22)
            .leading(16)
            .activate()
        
    }
    
    @objc func goToScan() {
        let controller = SaveProduktController()
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
  
    
    public func updateItems() {
        DispatchQueue.main.async { [self] in
            items = manager.clockAlarm.map({ clockAlar in
                    .init(name: clockAlar.listName ?? "", image: clockAlar.emoji ?? "", scanData: clockAlar.scanData ?? "")
            })
            
            itemsName.text = items.last?.name
            itemsEmoji.text = items.last?.image
            scanedData.text = items.last?.scanData
            
            view.layoutIfNeeded()
            
        }
    }
}

extension ListNameController: SaveProduktControllerDelegate {
    func didSaveNewItem() {
        updateItems()
        tableview.reloadData()
    }
}
