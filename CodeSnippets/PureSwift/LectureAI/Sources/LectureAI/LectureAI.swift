import Foundation

public class LectureAI {

    //private dateUtil = DateUtil()

    public init() {

    }

    public func parseFile(fileName: String) {

    }

    public func parseEvent(term: String, lecture: Lecture) -> AnalyzedLecture {
        let currentMonth = getCurrentMonth()
        let startDate = getSemesterStartDate(term: term, currentMonth: currentMonth)
        let startWeekdayId = "5"
        

        // DO => 5

        // unterschied zwischen startDate und

        let firstLectureDate = getFirstLectureDate(semesterStartDate: startDate, lectureWeekDay:  lecture.day)

        let examStartDate = getExamsStartDate(term: term, currentMonth: currentMonth)

        let weekdayId = getWeekdayNumberOfGermanString(germanString: lecture.day)
        // DI => 3

        // Auf startDate 5 addieren, um bei Dienstag zu landen

        let dates = getAllLectureDates(firstLectureDate: firstLectureDate, firstExamDate: examStartDate)


        return AnalyzedLecture(lecture: lecture, dates: dates)
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

    public func getAllLectureDates(firstLectureDate: Date, firstExamDate: Date) -> [Date]{
        var allDates = [Date]()
        var nextLectureDate = firstLectureDate
        if(firstLectureDate < firstExamDate){
            while (nextLectureDate < firstExamDate) {
                allDates.append(nextLectureDate)
                nextLectureDate = Calendar.current.date(byAdding: .day, value: 7, to: nextLectureDate)!            
            }
            return allDates
        } else {
            //ERROR
            return []
        }
    
    }


    public func getSemesterStartDate(term: String, currentMonth: Int) -> Date  {
        if term == "WS" {
            if currentMonth < 3 {
                return getDateInWantedYear(day: "01", month: "10", yearModifier: .previous)
            } else {
                return getDateInWantedYear(day: "01", month: "10", yearModifier: .current)
            }
        } else {
            return getDateInWantedYear(day: "15", month: "03", yearModifier: .current)
        }
    }


    // == end of semester (+1 day)
    public func getExamsStartDate(term: String, currentMonth: Int) -> Date  {
        if term == "WS" {
            if currentMonth < 3{
                return getDateInWantedYear(day: "23", month: "01", yearModifier: .current)
            } else {
                return getDateInWantedYear(day: "23", month: "01", yearModifier: .next)
            }
        } else {
            return getDateInWantedYear(day: "10", month: "07", yearModifier: .current)
        }
    }

    func getDateInWantedYear(day: String, month: String, yearModifier: YearModifier) -> Date {
        let calendar = Calendar.current
        let year = Int(calendar.component(.year, from: Date()) + yearModifier.rawValue)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.date(from: "\(day).\(month).\(year)")!
    }

    func getCurrentMonth() -> Int {
        return Int(Calendar.current.component(.month, from: Date()))
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