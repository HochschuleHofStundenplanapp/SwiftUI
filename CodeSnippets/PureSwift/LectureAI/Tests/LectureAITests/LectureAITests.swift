import XCTest
@testable import LectureAI

import Foundation

final class LectureAITests: XCTestCase {

    private var dateUtil: DateUtil!
    private var lectureAI: LectureAI!

    override func setUp() {
        dateUtil = TestDateUtil()
        lectureAI = LectureAI(dateUtil: dateUtil)
    }

    func test_dateOfKW(){
        let datesOfKw50 = lectureAI.getDatesInCalendarWeek(term: "WS", kw: 50)

        let actualDatesOfKw50 = ["2020-12-07", "2020-12-08", "2020-12-09", "2020-12-10", "2020-12-11",
                                 "2020-12-12", "2020-12-13"]

        XCTAssertEqual(dateUtil.stringify(datesOfKw50), actualDatesOfKw50)
    }

    func test_filterDatesStartingInKW() {
        let testDates = ["2020-01-01", "2020-10-05", "2020-11-01", "2020-12-07", "2020-12-08"]
        let expectedDates = ["2020-12-07", "2020-12-08"]

        let actualDates = lectureAI.filterDatesStartingInKW(term: "WS", dates: dateUtil.parse(testDates), kw: 50)

        XCTAssertEqual(dateUtil.stringify(actualDates), expectedDates)
    }

    func test_filterDatesInKWs() {
        let testDates = ["2020-01-01", "2020-10-05", "2020-11-01", "2020-12-07", "2020-12-08"]
        let expectedDates = ["2020-10-05", "2020-12-07", "2020-12-08"]

        let actualDates = lectureAI.filterDatesInKWs(term: "WS", dates: dateUtil.parse(testDates), kws: [41, 50])

        XCTAssertEqual(dateUtil.stringify(actualDates), expectedDates)
    }

    func test_currentKW(){
        let testBool = lectureAI.isLectureKWBeforeCurrentKW(kw: 49)
        XCTAssertEqual(testBool, true)
    }

    func test_parseLectureStyle_vorlesung_fixzeit() {
        let type = lectureAI.parseLectureStyle(style: "Vorlesung Fixzeit")

        XCTAssertEqual(LectureType.fixed_time, type)
    }

    func test_parseLectureStyle_vorlesung_blockverantaltung() {
        let type = lectureAI.parseLectureStyle(style: "Blockveranstaltung")

        XCTAssertEqual(LectureType.block, type)
    }

    func test_parseLectureStyle_vorlesung_uebung_fixzeit() {
        let type = lectureAI.parseLectureStyle(style: "Übung Fixzeit")

        XCTAssertEqual(LectureType.fixed_time, type)
    }


    static var allTests = [
        ("test_dateOfKW", test_dateOfKW),
        ("test_currentKW", test_currentKW),
        ("test_filterDatesStartingInKW", test_filterDatesStartingInKW),
        ("test_filterDatesInKWs", test_filterDatesInKWs),
        ("test_parseLectureStyle_vorlesung_fixzeit", test_parseLectureStyle_vorlesung_fixzeit),
        ("test_parseLectureStyle_vorlesung_blockverantaltung", test_parseLectureStyle_vorlesung_blockverantaltung),
        ("test_parseLectureStyle_vorlesung_uebung_fixzeit", test_parseLectureStyle_vorlesung_uebung_fixzeit)
    ]

}
