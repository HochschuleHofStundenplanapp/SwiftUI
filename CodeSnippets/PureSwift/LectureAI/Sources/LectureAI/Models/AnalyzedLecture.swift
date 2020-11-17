import Foundation
public struct AnalyzedLecture {

    var lecture: Lecture
    var dates: [Date]

    public init(lecture: Lecture, dates: [Date]) {
        self.lecture = lecture
        self.dates = dates
    }
}