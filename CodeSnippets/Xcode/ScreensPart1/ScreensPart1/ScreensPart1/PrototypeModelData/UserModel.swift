


/**
 THE DATA THIS WILL RECEIVE FROM THE MODEL
 */
struct ScheduleForCourseSemester: Codable {
    let version: Double
    let schedule: [Lecture]
}

struct Lecture: Codable,Identifiable {
    let id: String
    let label: String
    let docent: String
    let type: String
    let style: String
    let group: String
    let starttime:String
    let endtime:String
    let startdate: String
    let enddate :String
    let day: String
    let room: String
    let splusname: String
    let comment: String
    let sp: String
}

extension Lecture{
    func isBlockLecture() -> Bool {
        return style.lowercased().contains("block") || type.lowercased().contains("block")
    }
}


