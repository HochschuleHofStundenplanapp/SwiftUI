//
//  Pipelines.swift
//  CombinePipeline
//
//  Created by Andre Klein (privat) on 20.10.20.
//

import Foundation

#if os(iOS)
    import Combine
#elseif os(OSX)
    import Combine
#elseif os(tvOS)
    import Combine
#else
    import FoundationNetworking
    import OpenCombine
    import OpenCombineDispatch
    import OpenCombineFoundation
#endif

public class Pipelines {

    private let username = "soapuser"
    private let password = "F%98z&12"
    private let baseURI = "https://app.hof-university.de/soap/"
    
    //URL Fragment Dummys
    //let lectureByID = "client.php?f=MySchedule&id[]=1332256"

    public func getCoursesAfterTerm(term: String) -> AnyPublisher<CoursesAfterTerm, Error>
    {
        let urlString = "\(baseURI)client.php?f=Courses&tt=\(term)"
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        
        let passInfo = username + ":" + password
        let passData = passInfo.data(using: .utf8)
        let passCredential = passData?.base64EncodedString()
        request.setValue("Basic \(passCredential!)", forHTTPHeaderField: "Authorization")
        
        print("ABC")

        return URLSession.shared.dataTaskPublisher(for: request)
            .map {$0.data}
            //.receive(on: RunLoop.main)
            .decode(type: CoursesAfterTerm.self, decoder: JSONDecoder())
            .eraseToAnyPublisher();
    }

    public func getScheduleForCourseSemester(course: String, semester: String, term: String) throws -> AnyPublisher<ScheduleForCourseSemester, Error>
    {
        let fixedCourseName = course
            .replacingOccurrences(of: " ", with: "%20")
            
        // Sprache hat als Semester statt 1,2,3,4 => Russ, Prüf, Fran
        let fixedSemester = semester
            .replacingOccurrences(of: "ü", with: "ue")

        let urlString = "\(baseURI)client.php?f=Schedule&stg=\(fixedCourseName)&sem=\(fixedSemester)&tt=\(term)"

        guard let url = URL(string: urlString) else {
            print("Invalid URL: \(urlString)")
            fatalError("abc")
        }

        var request = URLRequest(url: url)

        let passInfo = username + ":" + password
        let passData = passInfo.data(using: .utf8)
        let passCredential = passData?.base64EncodedString()
        request.setValue("Basic \(passCredential!)", forHTTPHeaderField: "Authorization")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map {$0.data}
            //.receive(on: RunLoop.main)
            .decode(type: ScheduleForCourseSemester.self, decoder: JSONDecoder())
            .eraseToAnyPublisher();
    }
    
    
    //TODO: check for function
    public func getChangesForCourseSemester(course: String, semester: String, term: String) -> AnyPublisher<ChangesForCourseSemester, Error>
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
            //.receive(on: RunLoop.main)
            .decode(type: ChangesForCourseSemester.self, decoder: JSONDecoder())
            .eraseToAnyPublisher();
    }
    
}
