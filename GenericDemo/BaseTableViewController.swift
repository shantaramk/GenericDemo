//
//  BaseTableViewController.swift
//  GenericDemo
//
//  Created by Shantaram Kokate on 7/26/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit

class BaseTableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
        
    @IBOutlet var baseTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
             if let table = self.baseTableView {
                self.baseTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
                self.baseTableView.reloadData()
                
            }
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 100
    }
 
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = "1"
        return cell
    }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let instance = FirebaseRemoveConfiguration.shared()
        let registercheck = instance.string(forKey: ParameterKey.registercheck)
        let image = instance.string(forKey: ParameterKey.image)
        let terms = instance.string(forKey: ParameterKey.terms)

        print(terms)
        print(image)
        print(registercheck)
        
    }
  
}

