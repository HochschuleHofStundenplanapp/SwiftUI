import XCTest
@testable import LectureAI
import Foundation

final class LectureAITests: XCTestCase {

    func testAI() {
        let ki = LectureAI()
        let testLecture = Lecture(
                id: "1",
                label: "Architektur mobiler Anwendungen",
                docent: "Prof. Dr. Peter Stöhr", type: "FWPM",
                style: "Vorlesung Fixzeit", group: "",
                starttime: "14:00",
                endtime: "15:30",
                startdate: "",
                enddate: "",
                day: "Montag",
                room: "virt_pstöhr",
                splusname: "xxx",
                comment: "(Inf5 + MI5 + MC5)",
                sp: "-"
        )

        let parsedEvent = ki.parseEvent(term: "WS", lecture: testLecture)

        XCTAssertEqual(
                ["06.10.2020", "13.10.2020", "20.10.2020", "27.10.2020",
                 "03.11.2020", "10.11.2020", "17.11.2020", "24.11.2020",
                 "01.12.2020", "08.12.2020", "15.12.2020", "22.12.2020", "08.12.2020",
                 "12.01.2021", "19.01.2021"], parsedEvent.dates
        )

        print("Event: \(parsedEvent)")

    }

    func testGetDateInCurrentYear() {
        let ai = LectureAI()

        let date = ai.getDateInCurrentYear(day: "10", month: "11")

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        XCTAssertEqual("2020-11-10", formatter.string(from: date))
    }

    func testGetDateInNextYear() {
        let ai = LectureAI()

        let date = ai.getDateInNextYear(day: "10", month: "11")

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        XCTAssertEqual("2021-11-10", formatter.string(from: date))
    }

    func testGetSemesterStartDateWS() {
        let ai = LectureAI()
        let date = ai.getSemesterStartDate(term: "WS")

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        XCTAssertEqual("2020-10-01", formatter.string(from: date))
    }

    func testGetSemesterStartDateSS() {
        let ai = LectureAI()
        let date = ai.getSemesterStartDate(term: "SS")

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        XCTAssertEqual("2020-03-15", formatter.string(from: date))
    }

    func testGetWeekDayIdOfDate() {
        let ai = LectureAI()

        let date = ai.getDateInCurrentYear(day: "10", month: "11")
        let weekdayId = ai.getWeekDayIdOfDate(date: date)

        XCTAssertEqual(3, weekdayId)
    }

    func testGetFirstLectureDate() {
        let ai = LectureAI()

        let semesterStartDate = ai.getDateInCurrentYear(day: "01", month: "10")
        let firstLectureDate = ai.getFirstLectureDate(semesterStartDate: semesterStartDate, lectureWeekDay: "Dienstag")

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        XCTAssertEqual("2020-10-06", formatter.string(from: firstLectureDate))
    }

    func testGetFirstLectureDate2() {
        let ai = LectureAI()

        let semesterStartDate = ai.getDateInCurrentYear(day: "01", month: "10")
        let firstLectureDate = ai.getFirstLectureDate(semesterStartDate: semesterStartDate, lectureWeekDay: "Donnerstag")

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        XCTAssertEqual("2020-10-01", formatter.string(from: firstLectureDate))
    }

    static var allTests = [
        ("testExample", testGetFirstLectureDate2),
    ]
}
