//
//  ViewController.swift
//  Checklists
//


import UIKit

class ChecklistViewController: UITableViewController,
                               ItemDetailViewControllerDelegate
{
    var items: [ChecklistItem] = []
    /*
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
        
        print("documentDir:\n \(documentsDir())")
        print("dataFilePath:\n \(dataFilePath())")
        
    }
    */
    
    // MARK: - @IBAction methods:
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
    
    //MARK: - ItemDetailViewControllerDelegate methods:
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController) {
        print("DidCancel delegate")
        navigationController?.popViewController(animated: true)
    }
    func itemDetailViewController(_ controller: ItemDetailViewController,
                               didFinishAdding item: ChecklistItem) {
        let newRow = items.count
        items.append(item)
        let indexPath = IndexPath(row: newRow, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        navigationController?.popViewController (animated: true)
        
        saveChecklistItems()
    }
    func itemDetailViewController(_ controller: ItemDetailViewController,
                               didFinishEditing item: ChecklistItem) {
        
        if let row = items.index(of: item) {
            let indexPath = IndexPath(row: row, section:0)
            if let cell = tableView.cellForRow(at: indexPath) {
                let label = cell.viewWithTag(1000) as! UILabel
                label.text = item.text
                navigationController?.popViewController(animated: true)
            }
            saveChecklistItems()
        }
    }
    
    // MARK: - UIViewController methods:
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddItem" {
            let newViewController = segue.destination as! ItemDetailViewController
            newViewController.delegate = self
        }
        else if segue.identifier == "EditItem" {
            let newViewController = segue.destination as! ItemDetailViewController
            newViewController.delegate = self
            
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell) {
                newViewController.itemToEdit = items[indexPath.row]
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationController?.navigationBar.prefersLargeTitles = true
        loadCheckListItems()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDelegate methods:
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath)
    {
        if let cell = tableView.cellForRow(at: indexPath) {
            let item = items[indexPath.row]
            
            item.toggleChecked()
            configureCheckmark(forCell: cell, with: item)
            
            saveChecklistItems()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - UITableViewDataSource methods:
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
        saveChecklistItems()
    }
    
    // MARK: - Custom methods
    func configureCheckmark(forCell cell: UITableViewCell,
                            with item: ChecklistItem)
    {
        let checkLabel = cell.viewWithTag(1001) as! UILabel
        
        if item.checked {
            checkLabel.text = "✓"
        }
        else {
            checkLabel.text = ""
        }
        
        //cell.accessoryType = (item.checked ? .checkmark : .none)
    }
    
    func configureText(forCell cell: UITableViewCell, with item: ChecklistItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = item.text
    }
    
    func documentsDir() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory,
                                             in: .userDomainMask)
        return paths[0]
    }
    
    func dataFilePath() -> URL {
        return documentsDir().appendingPathComponent("Checklists.plist")
    }
    
    func saveChecklistItems() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(items)
            try data.write(to: dataFilePath(), options: Data.WritingOptions.atomic)
        }
        catch {
            print("***Error saving items***")
        }
    }
    
    func loadCheckListItems() {
        if let data = try? Data(contentsOf: dataFilePath() ) {
            do {
                let decoder = PropertyListDecoder()
                items = try decoder.decode([ChecklistItem].self, from: data)
            }
            catch {
                print("Couldn't decode items array in file.")
            }
        }
    }
    
}

