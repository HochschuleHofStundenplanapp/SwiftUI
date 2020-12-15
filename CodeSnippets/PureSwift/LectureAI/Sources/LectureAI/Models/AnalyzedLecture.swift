import Foundation
public struct AnalyzedLecture {

    let lecture: Lecture
    let dates: [Event]
    let couldNotParse: Bool
    var type: LectureType

    public init(lecture: Lecture, dates: [Event], couldNotParse: Bool, type: LectureType) {
        self.lecture = lecture
        self.dates = dates
        self.couldNotParse = couldNotParse
        self.type = type
    }

    public class Event {
        let startDate: Date
        let endDate: Date
        let durationMinutes: Int

        init(start: Date, end: Date, durationMinutes: Int) {
            self.startDate = start
            self.endDate = end
            self.durationMinutes = durationMinutes
        }
    }
}