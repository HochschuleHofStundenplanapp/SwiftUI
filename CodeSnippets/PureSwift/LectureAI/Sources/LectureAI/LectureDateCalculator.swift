//
// Created by max on 12/8/20.
//

import Foundation

public class LectureDateCalculator {

    let dateUtil: DateUtil

    public init(dateUtil: DateUtil) {
        self.dateUtil = dateUtil;
    }

    public func getPossibleDates(term: String, lecture: Lecture) -> [Date] {

        //all relevant information about a Lecture in a Semester
        let currentMonth = dateUtil.getCurrentMonth()
        let startDate = getSemesterStartDate(term: term, currentMonth: currentMonth)
        let firstLectureDate = getFirstLectureDate(semesterStartDate: startDate, lectureWeekDay:  lecture.day)
        let examStartDate = getExamsStartDate(term: term, currentMonth: currentMonth) // = Date of Last Lecture + 1

        let dates = getAllLectureDates(firstLectureDate: firstLectureDate, firstExamDate: examStartDate)
        return dates
    }

    public func getFirstLectureDate(semesterStartDate: Date, lectureWeekDay: String) -> Date {
        let semesterStartWeekId = dateUtil.getWeekDayIdOfDate(date: semesterStartDate)
        let lectureWeekId = dateUtil.getWeekdayNumberOfGermanString(germanString: lectureWeekDay)

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
                return dateUtil.getDateInWantedYear(day: "01", month: "10", yearModifier: .previous)
            } else { //if WS and month is 10 - 12
                return dateUtil.getDateInWantedYear(day: "01", month: "10", yearModifier: .current)
            }
        } else { //Year of SS is always in current year
            return dateUtil.getDateInWantedYear(day: "15", month: "03", yearModifier: .current)
        }
    }

    // == end of semester (+1 day)
    public func getExamsStartDate(term: String, currentMonth: Int) -> Date  {
        if term == "WS" {
            if currentMonth < 4 { //if WS and month is 1 - 3 -> exams start in current year
                return dateUtil.getDateInWantedYear(day: "23", month: "01", yearModifier: .current)
            } else { //if WS and month is 10 - 12 -> exams start next year
                return dateUtil.getDateInWantedYear(day: "23", month: "01", yearModifier: .next)
            }
        } else { //exams of SS always start in current year
            return dateUtil.getDateInWantedYear(day: "10", month: "07", yearModifier: .current)
        }
    }


}
