import Foundation
import XCTest

@testable import LectureAI

public final class CommentsAnalyzerTest: XCTestCase {

    private let analyzer = CommentAnalyzer()

    func test_BW_dual2_Wirtschaftsinformatik() {

        let inputComment = "- Übungen - Start KW 17 (vorzugsweise für BW) "
        let expectedOutputFacts = [
            CommentFact(type: .start_kw(17), interval: .weekly)
        ]

        let actualFacts = analyzer.analyzeComment(comment: inputComment)
        XCTAssertEqual(expectedOutputFacts, actualFacts)
    }

    func test_BW_dual2_DigitaleAnwendungen() {

        let inputComment = "- Online-Anmeldung 01.04. - 06.04.2020 - Beginn KW 18 - max. 20 TN"
        let expectedOutputFacts = [
            CommentFact(type: .start_kw(18), interval: .weekly)
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
            CommentFact(type: .start_kw(20), interval: .weekly)
        ]

        let actualFacts = analyzer.analyzeComment(comment: inputComment)
        XCTAssertEqual(expectedOutputFacts, actualFacts)
    }

    func test_englischBeginningKW(){
        let inputComment = "-lecture - (every second week) (language: english) start week KW 18 - online in moodle -"
        let expectedOutputFacts = [
            CommentFact(type: .start_kw(18), interval: .bi_weekly)
        ]

        let actualFacts = analyzer.analyzeComment(comment: inputComment)
        XCTAssertEqual(expectedOutputFacts, actualFacts)
    }

    func test_englischBeginningKW2(){
        let inputComment = "- Exercises - (all 14 days, begin: calendar Week 18)"
        let expectedOutputFacts = [
            CommentFact(type: .start_kw(18), interval: .bi_weekly)
        ]

        let actualFacts = analyzer.analyzeComment(comment: inputComment)
        XCTAssertEqual(expectedOutputFacts, actualFacts)
    }

    func test_bwDual2(){
        let inputComment = "KW 17, 18, 19, 21, 22 und 23"
        let expectedOutputFacts = [
            CommentFact(type: .list_kws([17, 18, 19, 21, 22, 23]), interval: .not_defined)
        ]

        let actualFacts = analyzer.analyzeComment(comment: inputComment)
        XCTAssertEqual(expectedOutputFacts, actualFacts)
    }

    func test_md3(){
        let inputComment = "Ausstellungsdesign /  KW 43, 45, 47, virtuell"
        let expectedOutputFacts = [
            CommentFact(type: .list_kws([43, 45, 47]), interval: .not_defined)
        ]

        let actualFacts = analyzer.analyzeComment(comment: inputComment)
        XCTAssertEqual(expectedOutputFacts, actualFacts)
    }
    
    func test_md3_2(){
        let inputComment = "Ausstellungsdesign /  KW 42,44,46,48"
        let expectedOutputFacts = [
            CommentFact(type: .list_kws([42, 44, 46, 48]), interval: .not_defined)
        ]

        let actualFacts = analyzer.analyzeComment(comment: inputComment)
        XCTAssertEqual(expectedOutputFacts, actualFacts)
    }

    func test_md3_3(){
        let inputComment = "Ausstellungsdesign / KW 49, 50, 51, 2, 3"
        let expectedOutputFacts = [
            CommentFact(type: .list_kws([49, 50, 51, 2, 3]), interval: .not_defined)
        ]

        let actualFacts = analyzer.analyzeComment(comment: inputComment)
        XCTAssertEqual(expectedOutputFacts, actualFacts)
    }

    func test_kd1(){
        let inputComment = "KW 42 - 3, außer KW 43, 47, 53, 1"
        let expectedOutputFacts = [
            CommentFact(type: .no_info, interval: .not_defined)
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

  func test_BW_dual_4() {
    let inputComment = "SAP ERP Simulation / - 14-tägig - ab KW 17"
    let expectedOutputFacts = [
      CommentFact(type: .start_kw(17), interval: .bi_weekly)
    ]

    let actualFacts = analyzer.analyzeComment(comment: inputComment)
    XCTAssertEqual(expectedOutputFacts, actualFacts)
  }

  public static var allTests = [
    ("test_BW_dual2_Wirtschaftsinformatik", test_BW_dual2_Wirtschaftsinformatik),
    ("test_BW_dual2_DigitaleAnwendungen", test_BW_dual2_DigitaleAnwendungen),
    ("test_Technical_Textiles", test_Technical_Textiles),
    ("test_Wirtschaftsenglisch_II", test_Wirtschaftsenglisch_II),
    ("test_englischBeginningKW", test_englischBeginningKW),
    ("testExtensionSplitComment", testExtensionSplitComment),
    ("test_md3", test_md3),
    ("test_md3_2", test_md3_2),
    ("test_md3_3", test_md3_3),
    ("test_bwDual2", test_bwDual2),
    ("test_kd1", test_kd1),
    ("test_BW_dual_4", test_BW_dual_4),
    ("test_englischBeginningKW2", test_englischBeginningKW2),
  ]

}
