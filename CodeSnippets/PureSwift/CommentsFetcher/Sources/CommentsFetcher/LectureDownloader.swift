import Foundation

#if os(iOS)
    import Combine
#elseif os(OSX)
    import Combine
#elseif os(tvOS)
    import Combine
#else
    import FoundationNetworking
    import OpenCombine
    import OpenCombineDispatch
    import OpenCombineFoundation
#endif

public class LectureDownloader {

    let pipelines = Pipelines()


    var schedulePublishers = Set<AnyCancellable>()
    var wsCoursePublisher: AnyCancellable? 
    var ssCoursePublisher: AnyCancellable?

    public init() {

    }

    public func main() {
        loadAllSemesters()
    }

    public func loadAllSemesters() {
        self.wsCoursePublisher = loadSemester(term: "WS")
        self.ssCoursePublisher = loadSemester(term: "SS")
    }


    public func loadSemester(term: String) -> AnyCancellable {
        return pipelines.getCoursesAfterTerm(term: term)
                .sink(receiveCompletion: { _ in

                }, receiveValue: { (response: CoursesAfterTerm) in
                    
                    for course in response.courses {
                        print("Loading \(course.course)..")
                        self.loadTimetableForCourse(term: term, course: course)
                    }

                })
    }

    public func loadTimetableForCourse(term: String, course: Course) {
        let courseName = course.course
        let semesters = course.semester

        for semester in semesters {

            try? pipelines.getScheduleForCourseSemester(course: courseName, semester: semester, term: term)
                .sink(receiveCompletion: { _ in

                }, receiveValue: { (response: ScheduleForCourseSemester) in
                    self.storeSchedule(identifier:term + "_" + courseName + "_" + semester, schedule: response)
                }).store(in: &schedulePublishers)
        }

    }

    public func storeSchedule(identifier: String, schedule: ScheduleForCourseSemester) {
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(schedule)

        storeFile(fileName: "\(identifier).json", textData: jsonData)
    }

    public func storeFile(fileName: String, textData: Data) {
        let projectPath = FileManager.default.currentDirectoryPath
        let outputPath = projectPath + "/Output/Lectures"
        let filePath = outputPath + "/" + fileName

        FileManager.default.createFile(atPath: filePath, contents: textData)
    }

}