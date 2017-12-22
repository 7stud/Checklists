//
//  ItemDetailViewController.swift
//  Checklists
//
//  Created by Christopher Wooldridge on 12/15/17.
//  Copyright © 2017 7stud. All rights reserved.
//

import UIKit

protocol ItemDetailViewControllerDelegate: class {
    func itemDetailViewControllerDidCancel(_ controller: ItemDetailViewController)
    func itemDetailViewController(_ controller: ItemDetailViewController,
                               didFinishAdding item: ChecklistItem)
    func itemDetailViewController(_ controller: ItemDetailViewController,
                               didFinishEditing item: ChecklistItem)
}

class ItemDetailViewController: UITableViewController,
                             UITextFieldDelegate
{
    // MARK: - Properties:
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    weak var delegate: ItemDetailViewControllerDelegate?
    var itemToEdit: ChecklistItem?
    
    // MARK: - @IBActions:
    @IBAction func cancel() {
        //navigationController?.popViewController(animated: true)
        delegate?.itemDetailViewControllerDidCancel(self)
    }
    
    @IBAction func done() {
        //navigationController?.popViewController(animated: true)
        print("Contents of text field: \(textField.text!)")
        
        if let item = itemToEdit {
            item.text = textField.text!
            delegate?.itemDetailViewController(self, didFinishEditing: item)
        }
        else {
            let item = ChecklistItem()
            item.text = textField.text!
            delegate?.itemDetailViewController(self, didFinishAdding: item)
        }
    }

    // MARK: - UITableView methods:
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.largeTitleDisplayMode = .never
        
        if let item = itemToEdit {
            textField.text = item.text
            title = "Edit Item"
            doneBarButton.isEnabled = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    // MARK: - UITableViewDelegate methods:
    override func tableView(_ tableView: UITableView,
                            willSelectRowAt indexPath: IndexPath)
                            -> IndexPath?
    {
        return nil
    }
    
    // MARK: - UITextFieldDelegate methods:
    
    func textField(_ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String)
        -> Bool
    {
        let currentText = textField.text!
        let range = Range(range, in: currentText)!
        let newText = currentText.replacingCharacters(in: range, with: string)
        
        doneBarButton.isEnabled = !newText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        return true
    }
    
 


}
