import XCTest
@testable import CommentsFetcher

#if os(Linux)
    import FoundationNetworking
    import OpenCombine
    import OpenCombineDispatch
    import OpenCombineFoundation
#else 
    import Combine
#endif

final class CommentsFetcherTests: XCTestCase {

    var pipelines: Pipelines = Pipelines()
    var cancellable: AnyCancellable? = nil
    var asyncExpectation : XCTestExpectation!

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.

        self.cancellable = self.pipelines.getCoursesAfterTerm(term: "WS")
            .sink(receiveCompletion: { _ in
                print("end")
                sleep(5)
                XCTAssertTrue(false)
            }, receiveValue: { (response: CoursesAfterTerm) in
                print("XXX")
                print(response.courses.count)
                XCTAssertTrue(response.courses.count == 0)
            })
        
        sleep(5)
    }

    func test2() {
        let fetcher = CommentsFetcher()

        fetcher.main()
        //fetcher.loadTimetableForCourse(term: "WS", course: Course(course: "MC", year: "2020", labels: Labels(de: "MC", en: "MC"), semester: ["3", "5"]))
        sleep(5)
        //fetcher.storeSchedule(identifier: "x", schedule: ScheduleForCourseSemester(version: 1.0, schedule: [Lecture(id: "1", label: "lbl", docent: "kern", type: "xxx", style: "String", group: "String", starttime: "String", endtime: "String", startdate: "String", enddate: "String", day: "String", room: "String", splusname: "String", comment: "String", sp: "String")]))
        //fetcher.storeFile(fileName: "testfile", text: "testcontent")
    }

    static var allTests = [
        ("testExample", test2),
    ]
}