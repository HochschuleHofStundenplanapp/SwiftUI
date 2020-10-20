//
//  Connection.swift
//  StundenplanAppModel
//
//  Created by MACBOOK on 15.10.20.
//  Copyright © 2020 kaw_solutions. All rights reserved.
//

import UIKit


/**
 TEST CLASS, intended for testing the connection to the server and trying to parse the incoming JSON Data
 To be deleted or reformed as proper network backend without temporary test functions or variables
 */
struct Connection{
    
    let testCourse = "MC"
    let testSemester = "5"
    
    
    func fetch(url: String, username: String?, password: String?) -> Void
    {
        let urlString = url
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        
        if (username != nil && password != nil)
        {
            let passInfo = String(format: "%@:%@", username!, password!)
            let passData = passInfo.data(using: .utf8)
            let passCredential = passData?.base64EncodedString()
            request.setValue("Basic \(passCredential!)", forHTTPHeaderField: "Authorization")
            
        }
        request.httpMethod = "POST"
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: {
            data, response, error in
            DispatchQueue.main.async(execute: { () -> Void in
                //Do Stuff with Data
                guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data returned")
                    return
                }
                //convert data to string
                let dataString = (String(data: data, encoding: .utf8) ?? "Error fetching data")
                print(dataString)
                
            })
        })
        task.resume()
    }
}


