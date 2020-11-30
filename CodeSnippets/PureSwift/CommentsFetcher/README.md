A description of this package.


# CommentsFetcher

## Introduction

purpose: get all comments of all lectures to determine which exceptional cases ("ab KW 41", "außer KW 38,40,41", ...) should be fixed by LectureAI.

## LectureDownloader

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

## CommentsFetcher
clerk, that gets all comments out of all stored lecture data (from LectureDownloader)

loadAndStoreAllComments()
```
filters all comments from all downloaded lecture-data and writes them into a file "comments.json"
```
* ComentInfo-struct determines which information is extracted from files (file, lecture, comment)

Methods used by loadAndStoreAllComments:
* loadAllComments() -> returns [CommentInfo]
* getOutPutFolder() -> returns String (Path of Output-Folder, where data from LectureDownloader ist stored)
* getFilesOfDirectory(folder: String) -> returns [String] of all Files in Output-folder
* storeFile(fileName: String, textData: Data) -> saves data in wanted File



## Models

provide all neccessary Models

## Tests 

* Run all tests with `swift test`
* Tests can be filtered by providing a case sensitive substring
    * Example: Only run Tests from DatenUtilTests class: `swift test --filter DateUtil`