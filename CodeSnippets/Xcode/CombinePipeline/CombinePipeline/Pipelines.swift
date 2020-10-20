//
//  Pipelines.swift
//  CombinePipeline
//
//  Created by Andre Klein (privat) on 20.10.20.
//

import Foundation
import Combine

class Pipelines {
        
    let username = "soapuser"
    let password = "F%98z&12"
    let baseURI = "https://app.hof-university.de/soap/"
    
    func getCoursesAfterTerm() -> AnyPublisher<CoursesAfterTerm, Error> {
        let urlString = baseURI + "client.php?f=Courses&tt=WS"
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
    
    
    
}
