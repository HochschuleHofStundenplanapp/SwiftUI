import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(LectureAITests.allTests),
        testCase(LectureDateCalculatorTests.allTests),
        testCase(DateUtilTests.allTests),
        testCase(CommentsAnalyzerTest.allTests),
    ]
}
#endif
