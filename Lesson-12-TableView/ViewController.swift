//
//  ViewController.swift
//  Lesson-12-TableView
//
//  Created by Aleksandr Moroshovskyi on 28.03.2024.
//

import UIKit

class DataSource {
    
    var sections: [Section] = []
    
    //func
}

class Section {
    
    var headerTitle = ""
    var footerTitle = ""
    
    var rows: [String] = []
}

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var products: [String] = ["Молоко", "Хліб", "Апельсини", "Банани", "Вода"]
    var contacts: [String] = ["Admin", "Vasia", "Stepan"]
    
    var sections: [Section] = [Section(), Section()]
    
    @IBAction func addLasl(_ sender: Any) {
        products.append("Product \(products.count + 1)")
        //tableView.reloadData() - не бажано використовувати, особливо, коли багато даних
        /* правильний варінт
        let newIndexPath = IndexPath(row: products.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .fade)
        */
        tableView.reloadData()
        
        sections[0].rows.append("Product")
        tableView.reloadData()

        sections[1].rows.append("Contact")
        tableView.reloadData()
    }
    
    @IBAction func removeLast(_ sender: Any) {
        if !products.isEmpty {
            products.removeLast()
            //tableView.reloadData() - не бажано використовувати, особливо, коли багато даних
            /* правильний варінт
            let newIndexPath = IndexPath(row: products.count, section: 0)
            tableView.deleteRows(at: [newIndexPath], with: .fade)
            */
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.products = ["Молоко", "Хліб", "Кефір"]
            self.tableView.reloadData()
            
            let productSection = Section()
            productSection.headerTitle = "Products:"
            productSection.footerTitle = "Total:"
            productSection.rows = ["Milk", "Fish", "Water"]
            
            let contactSection = Section()
            contactSection.headerTitle = "Contacts:"
            contactSection.footerTitle = "Total:"
            contactSection.rows = ["John", "Bob"]
            
//            self.sections.append(productSection)
//            self.sections.append(contactSection)
//            self.tableView.reloadData()
            
            self.sections = [productSection,
                        contactSection]
            
            self.tableView.isEditing = true
            self.tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return products.count
        
        /*
        switch section {
        case 0:
            return products.count
        case 1:
            return contacts.count
        default:
            return 0
        }
        */
        
        return sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell") else {
            assertionFailure("Unable to dequeue cell")
            return UITableViewCell()
        }
        
        //cell.textLabel?.text = "My Cell index \(indexPath.row)"
        /*
        cell.textLabel?.text = products[indexPath.row]
        
        return cell
        */
        
        /*
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = products[indexPath.row]
        case 1:
            cell.textLabel?.text = contacts[indexPath.row]
        default:
            cell.textLabel?.text = ""
        }
        */
        
        cell.textLabel?.text = sections[indexPath.section].rows[indexPath.row]
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //return 2
        return sections.count
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        debugPrint("User did select cell at section: \(indexPath.section), row: \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "titleForHeaderInSection \(section)"
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "titleForFooterInSection \(section)"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            sections[indexPath.section].rows.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
//        sections[sections]
    }
}
