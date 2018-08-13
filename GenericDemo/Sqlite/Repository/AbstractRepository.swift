//
//  AbstractRepository.swift
//  GenericDemo
//
//  Created by Shantaram Kokate on 8/6/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit
import FMDB
private let DATABASENAME = "studentdb.sqlite"
class AbstractRepository: NSObject {

    //MARK: - Properties
    var db: FMDatabase!
    override init() {
        super.init()
        let dbPath = AbstractRepository.databasePath()
        db = FMDatabase(path: dbPath)
        db.logsErrors = true
        db.open()
    }
   static func databaseFilename() -> String {
        return DATABASENAME
    }
    static func databasePath() -> String {
        var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as [String]
         let documentsDirectory = paths[0] + "/\(DATABASENAME)"
            return documentsDirectory
 
     }
}
