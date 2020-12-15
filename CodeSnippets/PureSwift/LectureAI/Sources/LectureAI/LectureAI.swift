import Foundation

public class LectureAI {

    let dateUtil: DateUtil
    let lectureDateCalculator: LectureDateCalculator
    let commentAnalyzer: CommentAnalyzer

    public init(dateUtil: DateUtil) {
        self.dateUtil = dateUtil;
        self.lectureDateCalculator = LectureDateCalculator(dateUtil: dateUtil)
        self.commentAnalyzer = CommentAnalyzer()
    }

    public func parseEvent(term: String, lecture: Lecture) -> AnalyzedLecture {

        var possibleDates = lectureDateCalculator.getPossibleDates(term: term, lecture: lecture)
        let commentFacts = commentAnalyzer.analyzeComment(comment: lecture.comment)

        var couldNotParse = false

        for fact in commentFacts {

            if case .start_kw(let kw) = fact.type {
                possibleDates = filterDatesStartingInKW(term: term, dates: possibleDates, kw: kw)
            }

            if case .list_kws(let kws) = fact.type {
                possibleDates = filterDatesInKWs(term: term, dates: possibleDates, kws: kws)
            }

            if case .excluded_kws(let kws) = fact.type {
                //TODO
            }

            if case .no_info = fact.type {
                couldNotParse = true
            }

        }

        let parsedType = parseLectureStyle(style: lecture.style)
        return AnalyzedLecture(lecture: lecture, dates: [], couldNotParse: couldNotParse, type: parsedType)
    }

    public func generateEventForDate(date: Date, startTimeString: String, endTimeString: String) -> AnalyzedLecture.Event {
        let (startHour, startMinute) = dateUtil.getHourAndMinutesFrom(string: startTimeString)
        let (endHour, endMinute) = dateUtil.getHourAndMinutesFrom(string: endTimeString)

        let startDate = Calendar.current.date(bySettingHour: startHour, minute: startMinute, second: 0, of: date)!
        let endDate = Calendar.current.date(bySettingHour: endHour, minute: endMinute, second: 0, of: date)!
        let duration = Int(endDate.timeIntervalSince(startDate))

        return AnalyzedLecture.Event(start: startDate, end: endDate, durationMinutes: duration)
    }

    public func parseLectureStyle(style: String) -> LectureType {
        let lcStyle = style.lowercased()

        if lcStyle.contains("fixzeit") {
            return .fixed_time
        }

        if lcStyle.contains("block") {
            return .block
        }

        return .other
    }

    public func filterDatesStartingInKW(term: String, dates: [Date], kw: Int) -> [Date] {
        var filteredDays: [Date] = []
        let firstMonday = getDatesInCalendarWeek(term: term, kw: kw)[0]

        for date in dates {
            if date >= firstMonday {
                filteredDays.append(date)
            }
        }

        return filteredDays
    }

    public func filterDatesInKWs(term: String, dates: [Date], kws: [Int]) -> [Date] {

        var filteredDates: [Date] = []
        var possibleDates: [Date] = []

        for kw in kws {
            let kwDates = getDatesInCalendarWeek(term: term, kw: kw)
            possibleDates += kwDates
        }

        for date in dates {
            if possibleDates.contains(date) {
                filteredDates.append(date)
            }
        }

        return filteredDates
    }

    public func getDatesInCalendarWeek(term: String, kw: Int) -> [Date] {

        var year = dateUtil.getCurrentYear()

        if term == "WS" && kw < 7 { // KW 7 ist ca. Ende des Wintersemesters; SO-Semester immer im aktuellen Jahr
            year += 1
        }

        let components = DateComponents(weekOfYear: kw, yearForWeekOfYear: year)
        let date = Calendar.current.date(from: components)!

        let dateFixedTimezone = Calendar.current.date(byAdding: .hour, value: 1, to: date)!
        let actualKwStartDate = Calendar.current.date(byAdding: .day, value: 1, to: dateFixedTimezone)!
        let actualKwStartDateMidnight = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: actualKwStartDate)!

        var datesInCalendarWeek: [Date] = []

        var dateInKW = actualKwStartDateMidnight
        while (dateInKW < Calendar.current.date(byAdding: .day, value: 7, to: actualKwStartDateMidnight)!){
            datesInCalendarWeek.append(dateInKW)
            dateInKW = Calendar.current.date(byAdding: .day, value: 1, to: dateInKW)!
        }
        return datesInCalendarWeek
    }

    public func isLectureKWBeforeCurrentKW(kw: Int) -> Bool{
        var calendar = Calendar.current
        calendar.firstWeekday = 2
        let currentWeekOfYear = calendar.component(.weekOfYear, from: Date())

        if (kw < currentWeekOfYear){
            return true
        } else {
            return false
        }
    }
}