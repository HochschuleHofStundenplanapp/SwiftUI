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
                day: "Dienstag",
                room: "virt_pstöhr",
                splusname: "xxx",
                comment: "(Inf5 + MI5 + MC5)",
                sp: "-"
        )

        let parsedEvent = ki.parseEvent(term: "WS", lecture: testLecture)
        
        XCTAssertEqual(
                ["06.10.2020", "13.10.2020", "20.10.2020", "27.10.2020",
                 "03.11.2020", "10.11.2020", "17.11.2020", "24.11.2020",
                 "01.12.2020", "08.12.2020", "15.12.2020", "22.12.2020",
                 "29.12.2020", "05.01.2021","12.01.2021", "19.01.2021"], DateUtil.stringify(parsedEvent.dates, format: "dd.MM.yyyy")
        )
    }

    func testGetDateInCurrentYear() {
        let ai = LectureAI()

        let date = ai.getDateInWantedYear(day: "10", month: "11", yearModifier: .current)

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        XCTAssertEqual("2020-11-10", formatter.string(from: date))
    }

    func testGetDateInNextYear() {
        let ai = LectureAI()

        let date = ai.getDateInWantedYear(day: "10", month: "11", yearModifier: .next)

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        XCTAssertEqual("2021-11-10", formatter.string(from: date))
    }

    func testGetSemesterStartDateWS() {
        let ai = LectureAI()
        let date = ai.getSemesterStartDate(term: "WS", currentMonth: ai.getCurrentMonth())

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        XCTAssertEqual("2020-10-01", formatter.string(from: date))
    }

    func testGetSemesterStartDateSS() {
        let ai = LectureAI()
        let date = ai.getSemesterStartDate(term: "SS", currentMonth: ai.getCurrentMonth())

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        XCTAssertEqual("2020-03-15", formatter.string(from: date))
    }

    func testGetWeekDayIdOfDate() {
        let ai = LectureAI()

        let date = ai.getDateInWantedYear(day: "10", month: "11", yearModifier: .current)
        let weekdayId = ai.getWeekDayIdOfDate(date: date)

        XCTAssertEqual(3, weekdayId)
    }

    func testGetFirstLectureDate() {
        let ai = LectureAI()

        let semesterStartDate = ai.getDateInWantedYear(day: "01", month: "10", yearModifier: .current)
        let firstLectureDate = ai.getFirstLectureDate(semesterStartDate: semesterStartDate, lectureWeekDay: "Dienstag")

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        XCTAssertEqual("2020-10-06", formatter.string(from: firstLectureDate))
    }

    func testGetFirstLectureDate2() {
        let ai = LectureAI()

        let semesterStartDate = ai.getDateInWantedYear(day: "01", month: "10", yearModifier: .current)
        let firstLectureDate = ai.getFirstLectureDate(semesterStartDate: semesterStartDate, lectureWeekDay: "Donnerstag")

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        XCTAssertEqual("2020-10-01", formatter.string(from: firstLectureDate))
    }

    func testGetFirstLectureDateSS() {
        let ai = LectureAI()

        let semesterStartDate = ai.getSemesterStartDate(term: "SS", currentMonth: ai.getCurrentMonth())
        let firstLectureDate = ai.getFirstLectureDate(semesterStartDate: semesterStartDate, lectureWeekDay: "Dienstag")

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        XCTAssertEqual("2020-03-17", formatter.string(from: firstLectureDate))
    }

    func testYearModifier() {
        let ai = LectureAI()

        let date = ai.getDateInWantedYear(day: "10", month: "1", yearModifier: .previous)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        XCTAssertEqual("2020-02-17", formatter.string(from: date))
    }

    func testGetAllLectureDates() {
        let ai = LectureAI()

        let firstDate = ai.getDateInWantedYear(day: "15", month: "03", yearModifier: .current)
        let examDate = ai.getDateInWantedYear(day: "09", month: "07", yearModifier: .current)

        let dates = ai.getAllLectureDates(firstLectureDate: firstDate, firstExamDate: examDate)
        XCTAssertEqual([("2020-10-10")], DateUtil.stringify(dates))
    }


    static var allTests = [
        ("testExample", testAI),
    ]
}
