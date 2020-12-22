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
    
    private func getScheduleForCourseSemesterDataTask(course: String, semester: String, term: String) -> URLSession.DataTaskPublisher{
        let urlString = "\(baseURI)client.php?f=Schedule&stg=\(course)&sem=\(semester)&tt=\(term)".addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)!
        //TODO: Error handling
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        
        let passInfo = username + ":" + password
        let passData = passInfo.data(using: .utf8)
        let passCredential = passData?.base64EncodedString()
        request.setValue("Basic \(passCredential!)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
    }
    
    func getScheduleForCourseSemester(course: String, semester: String, term: String) -> AnyPublisher<ScheduleSelection, Error>{
        return getScheduleForCourseSemesterDataTask(course: course, semester: semester, term: term)
            .map {$0.data}
            .receive(on: RunLoop.main)
            .decode(type: ScheduleForCourseSemester.self, decoder: JSONDecoder())
            .map{ScheduleSelection(courseName: course, semester: semester, lectures: $0.schedule)}
            .eraseToAnyPublisher();
    }
    
    func getLecturesForSelectedCourseSemester(courseSemesters: Dictionary<String,[String]>, term: String) -> AnyPublisher<ScheduleSelection, Error> {
        
        var publisher :  AnyPublisher<ScheduleSelection, Error>? = nil
        courseSemesters.keys.forEach{course in
            
            let semesters = courseSemesters[course] ?? []
            semesters.forEach{semester in
                
                if(publisher != nil){
                    publisher = publisher?.append(getScheduleForCourseSemester(course: course, semester: semester, term: term)).eraseToAnyPublisher()
                    
                }
                else{
                    publisher = getScheduleForCourseSemester(course: course, semester: semester, term: term)
                }
            }
        }
        return publisher!
    }
    
    //changes
    private func getChangesForCourseSemesterDataTask(course: String, semester: String, term: String) -> URLSession.DataTaskPublisher
    {
        let urlString = "\(baseURI)client.php?f=Changes&stg=\(course)&sem=\(semester)&tt=\(term)"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        
        let passInfo = username + ":" + password
        let passData = passInfo.data(using: .utf8)
        let passCredential = passData?.base64EncodedString()
        request.setValue("Basic \(passCredential!)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
    }
    
    func getChangesForCourseSemester(course: String, semester: String, term: String) -> AnyPublisher<ChangesForCourseSemester, Error>
    {
        /*let urlString = "\(baseURI)client.php?f=Changes&stg=\(course)&sem=\(semester)&tt=\(term)"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        
        let passInfo = username + ":" + password
        let passData = passInfo.data(using: .utf8)
        let passCredential = passData?.base64EncodedString()
        request.setValue("Basic \(passCredential!)", forHTTPHeaderField: "Authorization")*/
        
        return getChangesForCourseSemesterDataTask(course: course, semester: semester, term: term)
            .map {$0.data}
            .receive(on: RunLoop.main)
            .decode(type: ChangesForCourseSemester.self, decoder: JSONDecoder())
            .eraseToAnyPublisher();
    }
    
    
    func getChangesForSelectedCourseSemester(courseSemesters: Dictionary<String,[String]>, term: String) -> AnyPublisher<ChangesForCourseSemester, Error> {
        
        var publisher :  AnyPublisher<ChangesForCourseSemester, Error>? = nil
        courseSemesters.keys.forEach{course in
            
            let semesters = courseSemesters[course] ?? []
            semesters.forEach{semester in
                
                if(publisher != nil){
                    publisher = publisher?.append(getChangesForCourseSemester(course: course, semester: semester, term: term)).eraseToAnyPublisher()
                    
                }
                else{
                    publisher = getChangesForCourseSemester(course: course, semester: semester, term: term)
                }
            }
        }
        return publisher!
    }
}
