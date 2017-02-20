//
//  PhoneTypeTableViewController.swift
//  Contacts
//
//  Created by Taras Motyl on 2/20/17.
//  Copyright © 2017 James Smith. All rights reserved.
//

import UIKit

class PhoneTypeTableViewController: UITableViewController {

    var phoneTypes: [String]!
    var sections: [Section]!
    var selectedPhoneTypeIndex: Int?
    var selectedPhoneType: String? {
        didSet {
            if let phoneType = selectedPhoneType {
                selectedPhoneTypeIndex = phoneTypes.index(of: phoneType)
            }
        }
    }
    
    let selectPhoneTypeSegue = SegueInfo(name: "SelectPhoneType")
    let doneButtonActionSegue = SegueInfo(name: "HandleAddContactDoneButton")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sections = [Section(name: "PhoneType", rows: phoneTypes.count, cellReuseIdentifier: ["PhoneTypeCell"], header: nil)]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    
    func initializePhoneTypes() {
        phoneTypes = [String]()
        for type in NumberType.allValues {
            phoneTypes.append(type.rawValue)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[0].rows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: sections[indexPath.section].cellReuseIdentifier[0], for: indexPath)
        cell.textLabel?.text = phoneTypes[indexPath.row]
        
        if indexPath.row == selectedPhoneTypeIndex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }

        return cell
    }
    
    // MARK: Table view editing configuration
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let index = selectedPhoneTypeIndex {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: indexPath.section))
            cell?.accessoryType = .none
        }
        
        selectedPhoneType = phoneTypes[indexPath.row]
        
        //update the checkmark for the current row
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
