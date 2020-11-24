import XCTest
@testable import LectureAI
import Foundation

public final class DateUtilTests: XCTestCase {

    private let dateUtil: TestDateUtil = TestDateUtil()

    func testParseStringify() {
        let dateString = "2020-11-17"
        XCTAssertEqual(dateString, dateUtil.stringify(dateUtil.parse(dateString)))
    }

    func testStringifyDateArray() {
        let date: Date = dateUtil.parse("2020-11-17")
        let dateArray: [Date] = [date]
        let stringifiedArray = dateUtil.stringify(dateArray)

        XCTAssertEqual(["2020-11-17"], stringifiedArray)
    }

    func testGetDateInCurrentYear() {
        let sutDate = dateUtil.getDateInWantedYear(day: "10", month: "11", yearModifier: .current)
        XCTAssertEqual("2020-11-10", dateUtil.stringify(sutDate, format: "yyyy-MM-dd"))
    }

    func testGetDateInNextYear() {
        dateUtil.

        let sutDate = dateUtil.getDateInWantedYear(day: "10", month: "11", yearModifier: .next)
        XCTAssertEqual("2021-11-10", dateUtil.stringify(sutDate, format: "yyyy-MM-dd"))
    }

    func testGetDateInPreviousYear() {
        let sutDate = dateUtil.getDateInWantedYear(day: "10", month: "1", yearModifier: .previous)
        XCTAssertEqual("2019-01-10", dateUtil.stringify(sutDate, format: "yyyy-MM-dd"))
    }

    func testGetWeekDayIdOfDate() {
        let date = dateUtil.getDateInWantedYear(day: "10", month: "11", yearModifier: .current)
        let weekdayId = dateUtil.getWeekDayIdOfDate(date: date)

        XCTAssertEqual(3, weekdayId)
    }

    public static var allTests = [
        ("testParseStringify", testParseStringify),
        ("testStringifyDateArray", testStringifyDateArray),
        ("testGetDateInCurrentYear", testGetDateInCurrentYear),
        ("testGetDateInNextYear", testGetDateInNextYear),
        ("testGetDateInPreviousYear", testGetDateInPreviousYear),
        ("testGetWeekDayIdOfDate", testGetWeekDayIdOfDate)
    ]

}