//
//  ViewController.swift
//  SwipeToDeleteTableViewExample
//
//  Created by John Codeos on 25/09/2019.
//  Copyright © 2019 John Codeos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var Items = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 80
        self.tableView.estimatedRowHeight = 80
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.allowsSelection = false
        self.getData()
    }
    
    func getData() {
        for i in 0...20 {
            self.Items.append("Item \(i)")
        }
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.Items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath) as! TableViewCell
        cell.itemLabel.text = self.Items[indexPath.row]
        return cell
    }
    
    @available(iOS 11.0, *)
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: nil) { _, _, complete in
            self.Items.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            complete(true)
        }
        
        // here set your image and background color
        deleteAction.image = UIImage(named: "deletebin")
        deleteAction.backgroundColor = .red
        
        let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
        configuration.performsFirstActionWithFullSwipe = true
        return configuration
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { _, _ in
            self.Items.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        deleteAction.backgroundColor = .red
        return [deleteAction]
    }
}
