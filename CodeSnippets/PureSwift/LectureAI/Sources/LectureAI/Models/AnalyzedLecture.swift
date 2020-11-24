import Foundation
public struct AnalyzedLecture {

    var lecture: Lecture
    //var dates: [(date: Date, duration: Int)]
    var dates: [Date]
    //var type: LectureType

    public init(lecture: Lecture, dates: [Date]) {
        self.lecture = lecture
        self.dates = dates
    }
}