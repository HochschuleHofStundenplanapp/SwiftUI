import Foundation
public struct AnalyzedLecture: Codable {

    let lecture: Lecture
    let dates: [Event]
    let couldNotParse: Bool
    let type: LectureType

    public init(lecture: Lecture, events: [Event], couldNotParse: Bool, type: LectureType) {
        self.lecture = lecture
        self.dates = events
        self.couldNotParse = couldNotParse
        self.type = type
    }

    public class Event : Codable {
        let startDate: Date
        let endDate: Date
        let durationMinutes: Int

        init(startDate: Date, endDate: Date, durationMinutes: Int) {
            self.startDate = startDate
            self.endDate = endDate
            self.durationMinutes = durationMinutes
        }
    }
}