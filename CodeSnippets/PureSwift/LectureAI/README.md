# LectureAI

## Introduction

Intelligence, that generates lecture dates for a given lecture.
All starts with the following api call:
```
let ai = LectureAI()
let analyzedEvent = ai.parseEvent(term: "WS", lecture: testLecture)
```

Analyzed Lecture returns:
* The passed-in lecture struct
* All dates for this lecture

=> As a second step these dates can be displayed in the apple calendar

## Utilities

* `DateUtil`: Utility-Functions, to work with Foundations-Date Library

## Tests

* Run all tests with `swift test`  