import XCTest
@testable import LectureAI
import Foundation

public final class DateUtilTests: XCTestCase {

    func testParseStringify() {
        let dateString = "2020-11-17"
        XCTAssertEqual(dateString, DateUtil.stringify(DateUtil.parse(dateString)))
    }

    func testStringifyDateArray() {
        let date: Date = DateUtil.parse("2020-11-17")
        let dateArray: [Date] = [date]
        let stringifiedArray = DateUtil.stringify(dateArray)

        XCTAssertEqual(["2020-11-17"], stringifiedArray)
    }

    public static var allTests = [
        ("testExample", testParseStringify),
        ("testStringifyDateArray", testStringifyDateArray),
    ]

}