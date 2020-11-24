A description of this package.


# CommentsFetcher

## Introduction

LectureDownloader is a clerk, that fetches all lecture data by using the Pipelines-class.
The data is then stored in files.
```
loadAllSemesters() downloads data via Pipeline-Class and stores lectures in files.
```
main methods which use the pipelines to load the data:
 - loadSemester(term: String)
```
serialization via JSONEncoder in:
 - storeSchedule(identifier: String, schedule: ScheduleForCourseSemester)
```
 Usage:
let fetcher = CommentsFetcher()
fetcher.loadAllSemesters()

=> downloads data from all courses for all semesters

## Pipelines

has 3 main methods:
 - getCoursesAfterTerm(term: String)
 - getScheduleForCourseSemester(course: String, semester: String, term: String)
 - getChangesForCourseSemester(course: String, semester: String, term: String)
 
 * all of them provide a publisher who allow the CommentsFetcher-clerk to download the data from the API

## Models

provide all neccessary Models

## Tests 

* Run all tests with `swift test`
* Tests can be filtered by providing a case sensitive substring
    * Example: Only run Tests from DatenUtilTests class: `swift test --filter DateUtil`