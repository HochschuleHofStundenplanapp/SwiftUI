//
// Created by max on 12/8/20.
//

import XCTest
@testable import LectureAI

import Foundation

final class LectureDateCalculatorTests: XCTestCase {


    private var dateUtil: DateUtil!
    private var lectureDateCalculator: LectureDateCalculator!

    override func setUp() {
        dateUtil = TestDateUtil()
        lectureDateCalculator = LectureDateCalculator(dateUtil: dateUtil)
    }

    func testParseEvent() {
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

        let possibleDates = lectureDateCalculator.getPossibleDates(term: "WS", lecture: testLecture)

        XCTAssertEqual(
                [
                    "06.10.2020", "13.10.2020", "20.10.2020", "27.10.2020",
                    "03.11.2020", "10.11.2020", "17.11.2020", "24.11.2020",
                    "01.12.2020", "08.12.2020", "15.12.2020", "22.12.2020",
                    "29.12.2020", "05.01.2021","12.01.2021", "19.01.2021"
                ],
                dateUtil.stringify(possibleDates, format: "dd.MM.yyyy")
        )
    }

    func testGetSemesterStartDateWS() {
        let date = lectureDateCalculator.getSemesterStartDate(term: "WS", currentMonth: dateUtil.getCurrentMonth())

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        XCTAssertEqual("2020-10-01", formatter.string(from: date))
    }

    func testGetSemesterStartDateSS() {
        let date = lectureDateCalculator.getSemesterStartDate(term: "SS", currentMonth: dateUtil.getCurrentMonth())

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        XCTAssertEqual("2020-03-15", formatter.string(from: date))
    }

    func testGetFirstLectureDate() {
        let semesterStartDate = dateUtil.getDateInWantedYear(day: "01", month: "10", yearModifier: .current)
        let firstLectureDate = lectureDateCalculator.getFirstLectureDate(semesterStartDate: semesterStartDate, lectureWeekDay: "Dienstag")

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        XCTAssertEqual("2020-10-06", formatter.string(from: firstLectureDate))
    }

    func testGetFirstLectureDate2() {
        let semesterStartDate = dateUtil.getDateInWantedYear(day: "01", month: "10", yearModifier: .current)
        let firstLectureDate = lectureDateCalculator.getFirstLectureDate(semesterStartDate: semesterStartDate, lectureWeekDay: "Donnerstag")

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        XCTAssertEqual("2020-10-01", formatter.string(from: firstLectureDate))
    }

    func testGetFirstLectureDateSS() {
        let semesterStartDate = lectureDateCalculator.getSemesterStartDate(term: "SS", currentMonth: dateUtil.getCurrentMonth())
        let firstLectureDate = lectureDateCalculator.getFirstLectureDate(semesterStartDate: semesterStartDate, lectureWeekDay: "Dienstag")

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"

        XCTAssertEqual("2020-03-17", formatter.string(from: firstLectureDate))
    }

    func testGetAllLectureDates() {
        let firstDate = dateUtil.getDateInWantedYear(day: "15", month: "03", yearModifier: .current)
        let examDate = dateUtil.getDateInWantedYear(day: "09", month: "07", yearModifier: .current)

        let dates = lectureDateCalculator.getAllLectureDates(firstLectureDate: firstDate, firstExamDate: examDate)

        let otherDates = ["2020-03-15", "2020-03-22", "2020-03-29", "2020-04-05", "2020-04-12",
                          "2020-04-19", "2020-04-26", "2020-05-03", "2020-05-10", "2020-05-17",
                          "2020-05-24", "2020-05-31", "2020-06-07", "2020-06-14", "2020-06-21",
                          "2020-06-28", "2020-07-05"]

        XCTAssertEqual(otherDates, dateUtil.stringify(dates, format: "yyyy-MM-dd"))
    }


    static var allTests = [
        ("testParseEvent", testParseEvent),
        ("testGetSemesterStartDateWS", testGetSemesterStartDateWS),
        ("testGetSemesterStartDateSS", testGetSemesterStartDateSS),
        ("testGetFirstLectureDate", testGetFirstLectureDate),
        ("testGetFirstLectureDate2", testGetFirstLectureDate2),
        ("testGetFirstLectureDateSS", testGetFirstLectureDateSS),
        ("testGetAllLectureDates", testGetAllLectureDates)
    ]


}