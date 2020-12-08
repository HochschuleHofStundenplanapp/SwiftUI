//
//  LectureViewModel.swift
//  ScreensPart6
//
//  Created by Xiongwei Zheng on 08.12.20.
//

import Foundation

class LectureViewModel: ObservableObject {
    @Published var allLectures: [lectureModel] = [
        lectureModel(time: "8:00 - 9:30", lessonName: "Architektur mobiler Anwendungen", room: "virt_pstöhr", lecturer: "Prof. Dr. Peter Stöhr", type: "online", addtional: "Further Information concerning the lesson", isBlockLesson: false, datesForBlocklesson: [], comment: "(MC5 + MI5)"),
        lectureModel(time: "11:30 - 13:00", lessonName: "Robotik", room: "virt_cgroth", lecturer: "Prof. Dr. Christian Groth", type: "online", addtional: "Einführung in die Robotik",isBlockLesson: false, datesForBlocklesson: [], comment: "(MC5 + MI5)"),
        lectureModel(time: "11:30 - 13:00", lessonName: "Robotik", room: "virt_cgroth", lecturer: "Prof. Dr. Christian Groth", type: "online", addtional: "Einführung in die Robotik",isBlockLesson: false, datesForBlocklesson: [], comment: "(MC5 + MI5)"),
        lectureModel(time: "11:30 - 13:00", lessonName: "Robotik", room: "virt_cgroth", lecturer: "Prof. Dr. Christian Groth", type: "online", addtional: "Einführung in die Robotik",isBlockLesson: false, datesForBlocklesson: [], comment: "(MC5 + MI5)"),
        lectureModel(time: "11:30 - 13:00", lessonName: "Robotiksblockstunde", room: "virt_cgroth", lecturer: "Prof. Dr. Christian Groth", type: "online", addtional: "Einführung in die Robotik",isBlockLesson: true, datesForBlocklesson: [lectureDateDuration(date: Date(), durationInMinutes: 180)], comment: "(MC5 + MI5)"),
        lectureModel(time: "13:00 - 19:00", lessonName: "Irendein langes Fach", room: "FG_023b", lecturer: "Prof. Dr. Christian Anderson", type: "Vortrag", addtional: "Einfach nur sehr lange Zeitverschwendung",isBlockLesson: true, datesForBlocklesson: [lectureDateDuration(date: Date(), durationInMinutes: 180)], comment: "(MC5 + MI5)")
    ]
}
