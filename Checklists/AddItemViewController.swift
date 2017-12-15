//
//  AddItemViewController.swift
//  Checklists
//
//  Created by Christopher Wooldridge on 12/15/17.
//  Copyright © 2017 7stud. All rights reserved.
//

import UIKit

class AddItemViewController: UITableViewController {
    
    @IBOutlet weak var textField: UITextField!
    
    @IBAction func cancel() {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func done() {
        navigationController?.popViewController(animated: true)
        print("Contents of text field: \(textField.text!)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func tableView(_ tableView: UITableView,
                            willSelectRowAt indexPath: IndexPath)
                            -> IndexPath?
    {
        return nil
    }
    
    

 

}
