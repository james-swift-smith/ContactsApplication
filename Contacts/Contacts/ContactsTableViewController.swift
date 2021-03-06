//
//  ContactsTableViewController.swift
//  Contacts
//
//  Created by James Smith on 2/7/17.
//  Copyright © 2017 James Smith. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    
    var contactDetailsSegue = SegueInfo(name: "ShowContactDetailsSegue")
    var addContactSegue = SegueInfo(name: "AddContactSegue")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Database.sharedInstance.sortContacts()
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Database.sharedInstance.contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactTableViewCell

        let contact = Database.sharedInstance.contacts[indexPath.row]
        cell.contact = contact
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            Database.sharedInstance.contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: - Navigation  
    
    @IBAction func handleAddContactCancelButtonAction(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func handleAddContactDoneButtonAction(segue: UIStoryboardSegue) {
        if let addContactViewController = segue.source as? AddContactTableViewController {
            if let contact = addContactViewController.contact {
                Database.sharedInstance.contacts.append(contact)
                
                let indexPath = IndexPath(row: Database.sharedInstance.contacts.count - 1, section: 0)
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
        case contactDetailsSegue.name:
            let contactTableViewCell = sender as! ContactTableViewCell
            let contactDetailsViewController = segue.destination as! ContactDetailsTableViewController
            contactDetailsViewController.contact = contactTableViewCell.contact
            contactDetailsViewController.contactIndex = (tableView.indexPath(for: contactTableViewCell)?.row)!
        case addContactSegue.name:
            if let navigationController = segue.destination as? UINavigationController {
                if let addContactTableViewController = navigationController.topViewController as? AddContactTableViewController {
                    addContactTableViewController.addContactSegue = true
                }
            }
        default:
            break
        }
    }
}
