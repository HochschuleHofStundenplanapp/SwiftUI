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
        let datesOfKw50 = lectureAI.getDatesInCalendarWeek(kw: "50")

        let actualDatesOfKw50 = ["2020-12-07", "2020-12-08", "2020-12-09", "2020-12-10", "2020-12-11",
                                 "2020-12-12", "2020-12-13"]

        XCTAssertEqual(dateUtil.stringify(datesOfKw50), actualDatesOfKw50)
    }

    func test_currentKW(){
        let testBool = lectureAI.isLectureKWBeforeCurrentKW(kw: "49")
        XCTAssertEqual(testBool, true)
    }

    static var allTests = [
        ("test_dateOfKW", test_dateOfKW),
        ("test_currentKW", test_currentKW),
    ]

}
