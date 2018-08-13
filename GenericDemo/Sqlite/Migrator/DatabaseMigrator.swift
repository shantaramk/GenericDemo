//
//  DatabaseMigrator.swift
//  GenericDemo
//
//  Created by Shantaram Kokate on 8/6/18.
//  Copyright © 2018 Shantaram Kokate. All rights reserved.
//

import UIKit
import FMDB
class DatabaseMigrator: NSObject {
    
    var filename = ""
    var overwriteDatabase = false
    var database: FMDatabase!
    init(databaseFile filename: String) {
        super.init()
        self.filename = filename
        database = FMDatabase(path: databasePath())
        database.logsErrors = true
        //  database.busyRetryTimeout = 15
    }
    func databasePath() -> String {
        let documentPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDir: String = documentPaths[0]
        let documentsDir1 = documentsDir + "/\(self.filename)"
        return documentsDir1
    }
    public func moveDatabaseToUserDirectory() -> Bool {
        let fileManager = FileManager.default
        var databasePath = self.databasePath()
        if fileManager.fileExists(atPath: databasePath) == true {
           /* let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
            databasePath = documentsPath + "/encrypted.sqlite"
            database = FMDatabase.init(path: databasePath)
            return false */
             return false
        }
        let fileParts = filename.split(separator: ".")
        if fileParts.count < 2 {
            print("Invalid filename passed to verifyWritableDatabase ==> \(filename)")
            NSException(name: NSExceptionName("Invalid filename"), reason: "Expected a filename like foo.db", userInfo: nil).raise()
            exit(-1)
        }
        let name = String(fileParts[0])
        let extensions = String(fileParts[1])
        print("Moving database from app package to user directory")
        let bundleDatabasePath = Bundle.main.path(forResource: name, ofType: extensions)
        if bundleDatabasePath == nil {
            let exception: NSException = NSException(name: NSExceptionName(rawValue: "Invalid bundle database path"), reason: "Expected filename like studentdb", userInfo: nil)
            exception.raise()
            exit(-1)
        }
        do {
            try fileManager.copyItem(atPath: bundleDatabasePath!, toPath: databasePath)
        } catch let error as NSError {
            print(error)
        }
        return true
    }
    func version() -> Int {
        return Int(database.userVersion)
     }
    //sets the current version of the database
    func setVersion(_ version: Int) {
        //database.executeUpdate("PRAGMA user_version=\(version)")
        do {
            try database.executeUpdate("PRAGMA user_version=?", values: [version])
        } catch {
        }
    }
    func applyMigration(_ version: Int) -> Bool {
        let migrationFile = "/migration-\(version).sql"
        print("File: \(migrationFile)")
        let fullPath = Bundle.main.resourcePath! + "\(migrationFile)"
        print("Path: \(fullPath)")
        if !FileManager.default.fileExists(atPath: fullPath) {
            print("WARNING: Couldn't find migration-\(version).sql at \(fullPath)")
            return false
        }
        let migrationSql = try? String(contentsOfFile: fullPath, encoding: .utf8)
        let queryList: [String] = (migrationSql?.components(separatedBy: ";"))!
        for query in queryList {
            let clearQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
            print(clearQuery)
            if clearQuery.isEmpty == false {
                do {
                    try database.executeUpdate(clearQuery, values: nil)
                 }
                catch let error as NSError
                {
                       print("Error in executing the migration statements in file \(fullPath) & error = \(error)")
                }
            }
        }
        return true
    }
    
    //applies all necessary migrations to bring this database up to the specified version
    
    func migrate(toVersion version: Int) {
        database.open()
        let currentVersion = self.version()
        if currentVersion == version {
            print("No migration needed, already at version \(version)")
            database.close()
            return
        }
        var success: Bool
        for m in currentVersion + 1...version {
            print("Running migration \(m)")
            success = applyMigration(m)
            if !success {
                print("Error executing migration \(m)")
                break
            }
             //update to the latest successful migration
            database.userVersion = UInt32(version)
        }
        print("Done with migrations....")
    }
}
