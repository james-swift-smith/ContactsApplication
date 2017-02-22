//
//  ContactDetailsTableViewController.swift
//  Contacts
//
//  Created by James Smith on 2/20/17.
//  Copyright © 2017 James Smith. All rights reserved.
//

import UIKit

class ContactDetailsTableViewController: UITableViewController {

    var contact: Contact!
    var personalInfo: [String]!
    var sections: [Section]!
    
    var editSegue = SegueInfo(name: "HandleEditButtonActionSegue")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //personalInfo = [String]()
        configureSection()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].header
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !personalInfo.isEmpty {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: sections[0].cellReuseIdentifier[0], for: indexPath)
                cell.textLabel?.text = personalInfo[indexPath.row]
                
                return cell
            }
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: sections[indexPath.section].cellReuseIdentifier[0], for: indexPath)
        cell.textLabel?.text = contact.numbers[indexPath.row].numberType.rawValue
        cell.detailTextLabel?.text = contact.numbers[indexPath.row].numberString
        
        return cell
    }
    
    func configureSection() {
        sections = [Section]()
        personalInfo = [String]()
        if let firstName = contact.firstName {
            personalInfo.append(firstName)
        }
        if let lastName = contact.lastName {
            personalInfo.append(lastName)
        }
        
        if !personalInfo.isEmpty {
            sections.append(Section(name: "Personal Information", rows: personalInfo.count, cellReuseIdentifier: ["ContactPersonalInformationCell"], header: "Personal Information"))
        }
        
        if !contact.numbers.isEmpty  {
            var header: String
            if contact.numbers.count > 1 {
                header = "Phone Numbers"
            } else {
                header = "Phone Number"
            }
            sections.append(Section(name: "Phone Numbers", rows: contact.numbers.count, cellReuseIdentifier: ["ContactNumberCell"], header: header))
        }
    }

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
        case editSegue.name:
            if let navigationController = segue.destination as? UINavigationController {
                if let addContactTableViewController = navigationController.topViewController as? AddContactTableViewController {
                    addContactTableViewController.addContactSegue = false
                    addContactTableViewController.contact = contact
                    addContactTableViewController.navigationItem.title = "Edit Contact"
                }
            }
        default:
            break
        }

    }
    
    @IBAction func handleEditContactCancelButtonAction(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func handleEditContactDoneButtonAction(segue: UIStoryboardSegue) {
        if let editContactViewController = segue.source as? AddContactTableViewController {
            if let editedContact = editContactViewController.contact{
                contact = editedContact
                configureSection()
                tableView.reloadData()
            }
        }
        
    }
}
