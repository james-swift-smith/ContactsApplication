//
//  ContactsTableViewController.swift
//  Contacts
//
//  Created by Taras Motyl on 2/7/17.
//  Copyright © 2017 James Smith. All rights reserved.
//

import UIKit

class ContactsTableViewController: UITableViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Database.sharedInstance.contacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell", for: indexPath) as! ContactTableViewCell

        let contact = Database.sharedInstance.contacts[indexPath.row]
        cell.contact = contact
        return cell
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            Database.sharedInstance.contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
        case "showContactDetailsSegue":
            let contactTableViewCell = sender as! ContactTableViewCell
            let detailsViewController = segue.destination as! ContactDetailsViewController
            detailsViewController.contact = contactTableViewCell.contact
        default:
            break
        }
    }
}
