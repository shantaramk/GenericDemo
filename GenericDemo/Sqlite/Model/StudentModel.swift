//
//  StudentModel.swift
//  GenericDemo
//
//  Created by Shantaram Kokate on 8/6/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit

class StudentModel {
    var name: String?
    var age: String?
    func initWithStudent(name: String, age: String) -> StudentModel {
        let object = StudentModel()
        object.name = name
        object.age = age
        return object
    }
    func insert(_ student: StudentModel) {
        let studentRepository = StudentRepository()
        let result = studentRepository.insert(student)
    }
    func fetch() -> [StudentModel] {
        let studentRepository = StudentRepository()
        return studentRepository.fetch()
     }
    func update(_ student: StudentModel) -> Bool {
        let studentRepository = StudentRepository()
        let result = studentRepository.update(student)
        return result
    }
    func delete(_ student: StudentModel) -> Bool {
        let studentRepository = StudentRepository()
        let result = studentRepository.delete(student)
        return result
    }
    func search(_ student: StudentModel) -> [StudentModel] {
        let studentRepository = StudentRepository()
        return studentRepository.search(student)
    }
}
