//
//  ViewController.swift
//  Checklists
//


import UIKit

class ChecklistViewController: UITableViewController {
    
    var items: [ChecklistItem]
    
    required init?(coder aDecoder: NSCoder) {
        items = [ChecklistItem]()
        
        var item = ChecklistItem()
        item.text = "hello"
        item.checked = false
        items.append(item)
        
        item = ChecklistItem()
        item.text = "world"
        item.checked = false
        items.append(item)
        
        item = ChecklistItem()
        item.text = "goodbye"
        item.checked = true
        items.append(item)
 
        super.init(coder: aDecoder)
        
    }
    
    @IBAction func addItem() {
        
        let newRowIndex = items.count
        
        let item = ChecklistItem()
        item.text = "Beth"
        item.checked = true
        items.append(item)
        
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        print("added item")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath)
    {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            
            item.toggleChecked()
            configureCheckmark(forCell: cell, with: item)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int)
                            -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath)
                            -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ChecklistItem",
            for: indexPath)
        let item = items[indexPath.row]

        configureText(forCell: cell, with: item)
        configureCheckmark(forCell: cell, with: item)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCellEditingStyle,
                            forRowAt indexPath: IndexPath)
    {
        let targetRow = indexPath.row
        items.remove(at: targetRow)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    func configureCheckmark(forCell cell: UITableViewCell,
                            with item: ChecklistItem)
    {
        cell.accessoryType = (item.checked ? .checkmark : .none)
    }
    
    func configureText(forCell cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
}

