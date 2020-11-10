import Foundation

public class LectureAI {

    public init() {

    }

    public func parseFile(fileName: String) {

    }

    public func parseEvent(term: String, lecture: Lecture) -> AnalyzedLecture {
        let startDate = getSemesterStartDate(term: term)
        let startWeekdayId = "5"

        // DO => 5

        // unterschied zwischen startDate und

        let examStartDate = getExamsStartDate(term: term)

        let weekdayId = getWeekdayNumberOfGermanString(germanString: lecture.day)
        // DI => 3

        // Auf startDate 5 addieren, um bei Dienstag zu landen


        return AnalyzedLecture(lecture: lecture, dates: ["TEST_DATE"])
    }

    public func getFirstLectureDate(semesterStartDate: Date, lectureWeekDay: String) -> Date {
        let semesterStartWeekId = getWeekDayIdOfDate(date: semesterStartDate)
        let lectureWeekId = getWeekdayNumberOfGermanString(germanString: lectureWeekDay)

        var daysToAdd = -1

        // Wenn semesterStartWeekId = lectureWeekId => startDate ist erster Tag
        if semesterStartWeekId == lectureWeekId {
            daysToAdd = 0
        }

        // Wenn semesterStartWeekId < lectureWeekId => addiere lectureWeekId - semesterStartWeekId auf startDate
        if semesterStartWeekId < lectureWeekId {
            daysToAdd = lectureWeekId - semesterStartWeekId
        }

        // Wenn semesterStartWeekId > lectureWeekId => addiere (7 - semesterStartWeekId) + lectureWeekId
        if semesterStartWeekId > lectureWeekId {
            daysToAdd = (7 - semesterStartWeekId) + lectureWeekId
        }

        let firstLectureDate = Calendar.current.date(byAdding: .day, value: daysToAdd, to: semesterStartDate)!
        return firstLectureDate
    }


    public func getSemesterStartDate(term: String) -> Date  {
        if term == "WS" {
            return getDateInCurrentYear(day: "01", month: "10")
        } else {
            return getDateInCurrentYear(day: "15", month: "03")
        }
    }

    public func getExamsStartDate(term: String) -> Date  {
        if term == "WS" {
            return getDateInNextYear(day: "23", month: "01")
        } else {
            return getDateInCurrentYear(day: "10", month: "07")
        }
    }

    func getDateInCurrentYear(day: String, month: String) -> Date {
        let calendar = Calendar.current
        let year = calendar.component(.year, from: Date())

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.date(from: "\(day).\(month).\(year)")!;
    }

    func getDateInNextYear(day: String, month: String) -> Date {
        let calendar = Calendar.current
        let year = Int(calendar.component(.year, from: Date()) + 1)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.date(from: "\(day).\(month).\(year)")!;
    }

    func test() {
//        let calendar = Calendar.current

//        calendar.component(.weekday, from: <#T##Date##Foundation.Date#>)
    }

    func getWeekdayNumberOfGermanString(germanString: String) -> Int {
        switch germanString {
        case "Sonntag":
            return 1
        case "Montag":
            return 2
        case "Dienstag": // 06.10.
            return 3
        case "Mittwoch":
            return 4
        case "Donnerstag": // 01.10. Vorlesungstart
            return 5
        case "Freitag":
            return 6
        case "Samstag":
            return 7 // 03.10.
        default:
            return -1
        }
    }

    func getWeekDayIdOfDate(date: Date) -> Int {
        let calendar = Calendar.current

        return Int(calendar.component(.weekday, from: date))
    }

    public func getEndDate(term: String) {

    }


}