
public struct AnalyzedLecture {

    var lecture: Lecture
    var dates: [String]

    public init(lecture: Lecture, dates: [String]) {
        self.lecture = lecture
        self.dates = dates
    }
}