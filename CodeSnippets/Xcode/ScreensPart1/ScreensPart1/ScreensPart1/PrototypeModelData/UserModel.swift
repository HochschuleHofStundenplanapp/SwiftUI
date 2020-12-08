


/**
 THE DATA THIS WILL RECEIVE FROM THE MODEL
 */
struct ScheduleForCourseSemester: Codable {
    let version: Double
    let schedule: [Lecture]
}

struct Lecture: Codable,Identifiable {
    let id, label, docent: String
    let type: String
    let style: String
    let group, starttime, endtime, startdate: String
    let enddate, day, room, splusname: String
    let comment: String
    let sp: String
}
