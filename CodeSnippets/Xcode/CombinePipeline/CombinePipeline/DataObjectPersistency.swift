//
//  DataObjectPersistency.swift
//  StundenplanAppModel
//
//  Created by Xiongwei Zheng
//  Copyright © 2020 kaw_solutions. All rights reserved.
//

import UIKit

class DataObjectPersistency {
    private let fileName = "data2.plist"
    private let dataKey  = "Data2Object"
    private let fileNameCalendar = "IDList.plist"
    private let IDListKey = "IDList"
    
    func loadDataObject() -> UserData {
        var item : UserData!
        let file = dataFileForName(fileName: fileName)
        
        if (!FileManager.default.fileExists(atPath: file)) {
            return UserData.sharedInstance
        }
        
        if let data = NSData(contentsOfFile: file) {
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data as Data)
          item = unarchiver.decodeObject(forKey: dataKey) as? UserData
            unarchiver.finishDecoding()
        }
        
        return item
    }
    
    func saveDataObject(items : UserData) {
        let file = dataFileForName(fileName: fileName)
        let data = NSMutableData()
        
        let archiver = NSKeyedArchiver(requiringSecureCoding: true)
        //previously: let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(items, forKey: dataKey)
        archiver.finishEncoding()
        data.write(toFile: file, atomically: true)
    }
    
    
    //TODO: Adapt Calendar Data
    /*
    func loadCalendarData() -> CalendarData {
        var item : CalendarData!
        let file = dataFileForName(fileName: fileNameCalendar)
        
        if (!FileManager.default.fileExists(atPath: file)) {
            return CalendarData.sharedInstance
        }
        
        if let data = NSData(contentsOfFile: file) {
            let unarchiver = NSKeyedUnarchiver(forReadingWith: data as Data)
            item = unarchiver.decodeObject(forKey: IDListKey) as? CalendarData
            unarchiver.finishDecoding()
        }
        
        return item
    }
    
    func saveCalendarData(items : CalendarData) {
        let file = dataFileForName(fileName: fileNameCalendar)
        let data = NSMutableData()
        
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(items, forKey: IDListKey)
        archiver.finishEncoding()
        data.write(toFile: file, atomically: true)
    }
    */
    
    private func documentPath() -> String {
        let allPathes = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        return allPathes[0]
    }
    
    private func tmpPath() -> String
    {
        return NSTemporaryDirectory()
    }
    
    private func dataFileForName(fileName : String) -> String {
        return (documentPath() as NSString).appendingPathComponent(fileName)
    }
    
    private func tmpFileForName(fileName : String) -> String {
        return (tmpPath() as NSString).appendingPathComponent(fileName)
    }
 
}
