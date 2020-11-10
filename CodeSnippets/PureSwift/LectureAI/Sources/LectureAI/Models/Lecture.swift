public struct Lecture: Codable {

    public init(id: String, label: String, docent: String, type: String, style: String, group: String, starttime: String, endtime: String, startdate: String, enddate: String, day: String, room: String, splusname: String, comment: String, sp: String) {
        self.id = id
        self.label = label
        self.docent = docent
        self.type = type
        self.style = style
        self.group = group
        self.starttime = starttime
        self.endtime = endtime
        self.startdate = startdate
        self.enddate = enddate
        self.day = day
        self.room = room
        self.splusname = splusname
        self.comment = comment
        self.sp = sp
    }

    public let id, label, docent: String
    public let type: String
    public let style: String
    public let group, starttime, endtime, startdate: String
    public let enddate, day, room, splusname: String
    public let comment: String
    public let sp: String
}