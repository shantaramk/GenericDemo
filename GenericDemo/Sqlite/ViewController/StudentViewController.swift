//
//  StudentViewController.swift
//  GenericDemo
//
//  Created by Shantaram Kokate on 8/6/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit

class StudentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: - Outlet
    @IBOutlet var nameTF: UITextField!
    @IBOutlet var ageTF: UITextField!
    @IBOutlet var baseTableView: UITableView!
    //MARK: - Properties
    var studentList = [StudentModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeDatabase()
        getStudentList()
        self.baseTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        initWithStudent()
        self.baseTableView.reloadData()
    }
    func getStudentList() {
         studentList = StudentModel().fetch()
        self.baseTableView.reloadData()

    }
    func initializeDatabase() {
        let dbMigrator = DatabaseMigrator(databaseFile: AbstractRepository.databaseFilename())
        dbMigrator.moveDatabaseToUserDirectory()
        dbMigrator.migrate(toVersion: 1)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    func initWithStudent() {
      //  self.studentList.append(StudentModel().initWithStudent(name: "SBK", age: "10"))
       // self.studentList.append(StudentModel().initWithStudent(name: "RCK", age: "10"))
        print(self.studentList)
    }
    // MARK: - Action
    @IBAction func saveButton(_ sender: Any) {
        StudentModel().insert(StudentModel().initWithStudent(name: self.nameTF.text!, age: self.ageTF.text!))
        getStudentList()
    }
    @IBAction func updateButton(_ sender: Any) {
        let status = StudentModel().update(StudentModel().initWithStudent(name: self.nameTF.text!, age: self.ageTF.text!))
        getStudentList()
    }
    @IBAction func deleteButton(_ sender: Any) {
       let status = StudentModel().delete(StudentModel().initWithStudent(name: self.nameTF.text!, age: self.ageTF.text!))
        getStudentList()
    }
    @IBAction func searchButton(_ sender: Any) {
        studentList =  StudentModel().search(StudentModel().initWithStudent(name: self.nameTF.text!, age: self.ageTF.text!))
        self.baseTableView.reloadData()
      }
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return studentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = studentList[indexPath.row].name! + studentList[indexPath.row].age!
        
 
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
