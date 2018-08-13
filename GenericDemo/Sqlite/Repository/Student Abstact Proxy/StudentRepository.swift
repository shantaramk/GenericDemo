//
//  StudentRepository.swift
//  GenericDemo
//
//  Created by Shantaram Kokate on 8/6/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit
import FMDB
private let INSERT_QUERY = "INSERT INTO students(name, city) VALUES (?,?)"
private let UPDATE_QUERY = "UPDATE students SET name = (?) Where city = (?)"
private let DELETE_QUERY = "DELETE from students Where city = (?)"
private let SEARCH_QUERY = "SELECT * from students Where city = (?)"
private let FETCH_QUERY = "SELECT * from students"

class StudentRepository: AbstractRepository {
    func insert(_ student: StudentModel) -> Bool {
        //Data Sanitization
        let result = db.executeUpdate(INSERT_QUERY, withArgumentsIn: [student.name!, student.age!])
        if result == false {
            print("Errror :--- " + db.lastErrorMessage())
        }
        return result
    }
    func update(_ student: StudentModel) -> Bool {
        let result = db.executeUpdate(UPDATE_QUERY, withArgumentsIn: [student.name!, student.age!])
        if result == false {
            print("Errror :--- " + db.lastErrorMessage())
        }
        return result
    }
    func delete(_ student: StudentModel) -> Bool {
        let result = db.executeUpdate(DELETE_QUERY, withArgumentsIn: [student.age!])
        if result == false {
            print("Errror :--- " + db.lastErrorMessage())
        }
        return result
    }
    func fetch() -> [StudentModel] {
        var studentList = [StudentModel]()
        do {
            let resultSet = try db.executeQuery(FETCH_QUERY, values: [])
            while resultSet.next() {
                let student: StudentModel = self.getStudentsFromResultSet(resultSet)
                studentList.append(student)
            }
        } catch let error as NSError
        {
            print("Error = \(error)")
        }
        return studentList
    }
    func search(_ student: StudentModel) -> [StudentModel] {
        var studentList = [StudentModel]()
        do {
            let resultSet = try db.executeQuery(SEARCH_QUERY, values: [student.age!])
            while resultSet.next() {
                let student: StudentModel = self.getStudentsFromResultSet(resultSet)
                studentList.append(student)
            }
        }
        catch let error as NSError {
            print("Error")
        }
        return studentList
    }
    func getStudentsFromResultSet(_ resultSet: FMResultSet) -> StudentModel {
        let studentModel = StudentModel()
        studentModel.name = resultSet.string(forColumn: "name")
        studentModel.age = resultSet.string(forColumn: "city")
        return studentModel
    }
}
