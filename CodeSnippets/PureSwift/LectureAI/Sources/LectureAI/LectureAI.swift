import Foundation

public class LectureAI {

    public init() {

    }

    public func parseEvent(term: String, lecture: Lecture) -> AnalyzedLecture {
        //all relevant informations about a Lecture in a Semester
        let currentMonth = getCurrentMonth()
        let startDate = getSemesterStartDate(term: term, currentMonth: currentMonth)
        let firstLectureDate = getFirstLectureDate(semesterStartDate: startDate, lectureWeekDay:  lecture.day) 
        let examStartDate = getExamsStartDate(term: term, currentMonth: currentMonth) // = Date of Last Lecture + 1
        let dates = getAllLectureDates(firstLectureDate: firstLectureDate, firstExamDate: examStartDate)

        return AnalyzedLecture(lecture: lecture, dates: dates)
    }

    public func getFirstLectureDate(semesterStartDate: Date, lectureWeekDay: String) -> Date {
        let semesterStartWeekId = getWeekDayIdOfDate(date: semesterStartDate)
        let lectureWeekId = getWeekdayNumberOfGermanString(germanString: lectureWeekDay)

        var daysToAdd = -1

        // If semesterStartWeekId = lectureWeekId => startDate is first day
        if semesterStartWeekId == lectureWeekId {
            daysToAdd = 0
        }

        // If semesterStartWeekId < lectureWeekId => add lectureWeekId - semesterStartWeekId to startDate
        if semesterStartWeekId < lectureWeekId {
            daysToAdd = lectureWeekId - semesterStartWeekId
        }

        // If semesterStartWeekId > lectureWeekId => add (7 - semesterStartWeekId) + lectureWeekId
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
            //ERROR (firstLectureDate must be before Beginning of Exams)
            return []
        }
    
    }

    public func getSemesterStartDate(term: String, currentMonth: Int) -> Date  {
        if term == "WS" {
            if currentMonth < 4 { //if WS and month is 1 - 3 -> semesterStart must be in previous Year
                return getDateInWantedYear(day: "01", month: "10", yearModifier: .previous)
            } else { //if WS and month is 10 - 12
                return getDateInWantedYear(day: "01", month: "10", yearModifier: .current)
            }
        } else { //Year of SS is always in current year
            return getDateInWantedYear(day: "15", month: "03", yearModifier: .current)
        }
    }


    // == end of semester (+1 day)
    public func getExamsStartDate(term: String, currentMonth: Int) -> Date  {
        if term == "WS" {
            if currentMonth < 4 { //if WS and month is 1 - 3 -> exams start in current year
                return getDateInWantedYear(day: "23", month: "01", yearModifier: .current)
            } else { //if WS and month is 10 - 12 -> exams start next year
                return getDateInWantedYear(day: "23", month: "01", yearModifier: .next)
            }
        } else { //exams of SS always start in current year
            return getDateInWantedYear(day: "10", month: "07", yearModifier: .current)
        }
    }

    //returns date with wanted year (possible YearModifiers: .previous, .current, .next)
    func getDateInWantedYear(day: String, month: String, yearModifier: YearModifier) -> Date {
        let calendar = Calendar.current
        let year = Int(calendar.component(.year, from: Date()) + yearModifier.rawValue) //add value of enums to year from date

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        return dateFormatter.date(from: "\(day).\(month).\(year)")!
    }

    func getCurrentMonth() -> Int {
        return Int(Calendar.current.component(.month, from: Date()))
    }

    
    func getWeekdayNumberOfGermanString(germanString: String) -> Int {
        switch germanString {
        case "Sonntag":
            return 1
        case "Montag":
            return 2
        case "Dienstag":
            return 3
        case "Mittwoch":
            return 4
        case "Donnerstag":
            return 5
        case "Freitag":
            return 6
        case "Samstag":
            return 7 
        default:
            return -1
        }
    }

    func getWeekDayIdOfDate(date: Date) -> Int {
        let calendar = Calendar.current

        return Int(calendar.component(.weekday, from: date))
    }

}