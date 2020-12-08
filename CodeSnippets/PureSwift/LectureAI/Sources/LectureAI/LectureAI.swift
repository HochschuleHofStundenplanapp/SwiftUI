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



}