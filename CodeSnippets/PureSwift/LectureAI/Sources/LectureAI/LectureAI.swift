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

        for fact in commentFacts {

            if fact.type == .start_kw {
                possibleDates = filterDatesStartingAfterKW(dates: possibleDates, kw: Int(fact.value) ?? 0)
            }
        }

        return AnalyzedLecture(lecture: lecture, dates: possibleDates)
    }

    public func filterDatesStartingAfterKW(dates: [Date], kw: Int) -> [Date] {
        //TODO
        return dates
    }

    public func filterDatesFor(dates: [Date]) {

    }



    public func getDatesInCalendarWeek(kw: String) -> [Date] {
        var rightYearforKW = Calendar.current.component(.year, from: Date()) //if kw before current -> must be in next year
        if isLectureKWBeforeCurrentKW(kw: kw){
            rightYearforKW += 1
        } 

        let components = DateComponents(weekOfYear: Int(kw), yearForWeekOfYear: rightYearforKW)
        let date = Calendar.current.date(from: components)!
        let dateFixedTimezone = Calendar.current.date(byAdding: .hour, value: 1, to: date)!
        let actualKwStartDate = Calendar.current.date(byAdding: .day, value: 1, to: dateFixedTimezone)!

        var datesInCalendarWeek: [Date] = []

        var dateInKW = actualKwStartDate
        while (dateInKW < Calendar.current.date(byAdding: .day, value: 7, to: actualKwStartDate)!){
            datesInCalendarWeek.append(dateInKW)
            dateInKW = Calendar.current.date(byAdding: .day, value: 1, to: dateInKW)!
        }
        return datesInCalendarWeek
    }

    public func isLectureKWBeforeCurrentKW(kw: String) -> Bool{
        var calendar = Calendar.current
        calendar.firstWeekday = 2
        let currentWeekOfYear = calendar.component(.weekOfYear, from: Date())

        if (Int(kw)! < currentWeekOfYear){
            return true
        } else {
            return false
        }
    }
}