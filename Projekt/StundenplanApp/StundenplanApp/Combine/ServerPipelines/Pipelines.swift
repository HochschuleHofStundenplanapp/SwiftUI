//
//  Pipelines.swift
//  CombinePipeline
//
//  Created by Andre Klein (privat) on 20.10.20.
//

import Foundation
import Combine

class Pipelines {
    
    private let username = "soapuser"
    private let password = "F%98z&12"
    private let baseURI = "https://app.hof-university.de/soap/"
    
    //URL Fragment Dummys
    //let lectureByID = "client.php?f=MySchedule&id[]=1332256"
    
    func getCoursesAfterTerm(term: String) -> AnyPublisher<CoursesAfterTerm, Error>
    {
        let urlString = "\(baseURI)client.php?f=Courses&tt=\(term)"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        
        let passInfo = username + ":" + password
        let passData = passInfo.data(using: .utf8)
        let passCredential = passData?.base64EncodedString()
        request.setValue("Basic \(passCredential!)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map {$0.data}
            .receive(on: RunLoop.main)
            .decode(type: CoursesAfterTerm.self, decoder: JSONDecoder())
            .eraseToAnyPublisher();
    }
    
    func getScheduleForCourseSemester(course: String, semester: Int, term: String) -> AnyPublisher<ScheduleForCourseSemester, Error>
    {
        let urlString = "\(baseURI)client.php?f=Schedule&stg=\(course)&sem=\(semester)&tt=\(term)"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        
        let passInfo = username + ":" + password
        let passData = passInfo.data(using: .utf8)
        let passCredential = passData?.base64EncodedString()
        request.setValue("Basic \(passCredential!)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map {$0.data}
            .receive(on: RunLoop.main)
            .decode(type: ScheduleForCourseSemester.self, decoder: JSONDecoder())
            .eraseToAnyPublisher();
    }
    
    
    //TODO: check for function
    func getChangesForCourseSemester(course: String, semester: Int, term: String) -> AnyPublisher<ChangesForCourseSemester, Error>
    {
        let urlString = "\(baseURI)client.php?f=Changes&stg=\(course)&sem=\(semester)&tt=\(term)"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        
        let passInfo = username + ":" + password
        let passData = passInfo.data(using: .utf8)
        let passCredential = passData?.base64EncodedString()
        request.setValue("Basic \(passCredential!)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map {$0.data}
            .receive(on: RunLoop.main)
            .decode(type: ChangesForCourseSemester.self, decoder: JSONDecoder())
            .eraseToAnyPublisher();
    }
    
}
