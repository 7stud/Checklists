//
//  AllListsViewController.swift
//  Checklists
//
//  Created by Christopher Wooldridge on 12/27/17.
//  Copyright © 2017 7stud. All rights reserved.
//

import UIKit



class AllListsViewController: UITableViewController {
    var checklists: [Checklist] = []
    
    // MARK: - UIViewController methods:
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        checklists.append(Checklist("Birthdays"))
        checklists.append(Checklist("Groceries"))
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowChecklist" {
            let newViewController = segue.destination as! ChecklistViewController
            newViewController.checklist = sender as! Checklist
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UITableViewDataSource methods:

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return checklists.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = makeCell(for: tableView)
        let checklist = checklists[indexPath.row]
        cell.textLabel!.text = checklist.name

        return cell
    }
    
    // UITableViewDelegate methods:
    
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        
        let checklist = checklists[indexPath.row]
        performSegue(withIdentifier: "ShowChecklist", sender: checklist)
    }
    
    // MARK: - Custom methods
    
    func makeCell(for: UITableView) -> UITableViewCell {
        let cellId = "Cell"
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellId) {
            return cell
        }
        else {
            return UITableViewCell(style: .default, reuseIdentifier: cellId)
        }
    }

}
