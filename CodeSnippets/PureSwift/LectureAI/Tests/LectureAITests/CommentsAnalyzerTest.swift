import XCTest
@testable import LectureAI
import Foundation

public final class CommentsAnalyzerTest: XCTestCase {

    private let analyzer = CommentAnalyzer()

    func test_BW_dual2_Wirtschaftsinformatik() {

        let inputComment = "- KW 10 Übungen - Start KW 174 (vorzugsweise für BW) KW10"
        let expectedOutputFacts = [
            CommentFact(type: .start_kw, value: "17")
        ]

        let actualFacts = analyzer.analyzeComment(comment: inputComment)
        XCTAssertEqual(expectedOutputFacts, actualFacts)
    }

    func test_BW_dual2_DigitaleAnwendungen() {

        let inputComment = "- Online-Anmeldung 01.04. - 06.04.2020 - Beginn KW 18 - max. 20 TN"
        let expectedOutputFacts = [
            CommentFact(type: .start_kw, value: "18")
        ]

        let actualFacts = analyzer.analyzeComment(comment: inputComment)
        XCTAssertEqual(expectedOutputFacts, actualFacts)
    }

    func test_Technical_Textiles() {
        let inputComment = "-teilweise Praktikum-  (in englisch)"
        let expectedOutputFacts: [CommentFact] = [
        ]

        let actualFacts = analyzer.analyzeComment(comment: inputComment)
        XCTAssertEqual(expectedOutputFacts, actualFacts)
    }

    func test_Wirtschaftsenglisch_II() {

        let inputComment = "- Übungen über Tutor, Beginn 20. KW (= 11.05.20)"
        let expectedOutputFacts = [
            CommentFact(type: .start_kw, value: "20")
        ]

        let actualFacts = analyzer.analyzeComment(comment: inputComment)
        XCTAssertEqual(expectedOutputFacts, actualFacts)
    }

    func test_englischBeginningKW(){
        let inputComment = "-lecture - (every second week) (language: english) start week KW 18 - online in moodle -"
        let expectedOutputFacts = [
            CommentFact(type: .start_kw, value: "18")
        ]

        let actualFacts = analyzer.analyzeComment(comment: inputComment)
        XCTAssertEqual(expectedOutputFacts, actualFacts)
    }

    func testExtensionSplitComment(){

        let stringTest = "KW 17, 18, 19, 21, 22 und 23"
        print(stringTest.replacingOccurrences(of:"KW", with:"").split(regex: ",|und").map{
            element in Int(element.trimmingCharacters(in: .whitespacesAndNewlines))!
            }
        )

    }
    


    public static var allTests = [
        ("test_BW_dual2_Wirtschaftsinformatik", test_BW_dual2_Wirtschaftsinformatik),
        ("test_BW_dual2_DigitaleAnwendungen", test_BW_dual2_DigitaleAnwendungen),
        ("test_Technical_Textiles", test_Technical_Textiles),
        ("test_Wirtschaftsenglisch_II", test_Wirtschaftsenglisch_II),
        ("test_englischBeginningKW", test_englischBeginningKW),
        ("testExtensionSplitComment", testExtensionSplitComment)
    ]

}
