import XCTest
@testable import LectureAI
import Foundation

public final class CommentsAnalyzerTest: XCTestCase {

    private let analyzer = CommentAnalyzer()

    func test_BW_dual2_Wirtschaftsinformatik() {

        let inputComment = "- Übungen - Start KW 17 (vorzugsweise für BW)"
        let expectedOutputFacts = [
            CommentFact(type: .start_kw, value: "17")
        ]

        let actualFacts = analyzer.analyzeComment(comment: inputComment)
        XCTAssertEqual(expectedOutputFacts, actualFacts)
    }

    func test_BW_dual2_DigitaleAnwendungen() {

        let inputComment = "- Online-Anmeldung 01.04. - 06.04.2020 - Beginn KW 17 - max. 20 TN"
        let expectedOutputFacts = [
            CommentFact(type: .start_kw, value: "17")
        ]

        let actualFacts = analyzer.analyzeComment(comment: inputComment)
        XCTAssertEqual(expectedOutputFacts, actualFacts)
    }


    public static var allTests = [
        ("test_BW_dual2_Wirtschaftsinformatik", test_BW_dual2_Wirtschaftsinformatik),
    ]

}