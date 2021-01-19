//
// Created by root on 11/24/20.
//

import Foundation

public class CommentsExtractor {


    public init () {

    }

    public func loadAndStoreAllComments() {
        let commentInfos = loadAllComments()

        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(commentInfos)

        storeFile(fileName: "comments.json", textData: jsonData)
    }

    public func storeFile(fileName: String, textData: Data) {
        let projectPath = FileManager.default.currentDirectoryPath
        let outputPath = projectPath + "/Output"
        let filePath = outputPath + "/" + fileName

        FileManager.default.createFile(atPath: filePath, contents: textData)
    }


    public func loadAllComments() -> [CommentInfo] {
        let lectureFolder = "\(getOutputFolder())/Lectures"
        let files = getFilesOfDirectory(folder: lectureFolder)

        var commentInfos: [CommentInfo] = []

        do {
            for file in files {
                let filePath = "\(lectureFolder)/\(file)"

                let jsonData = try String(contentsOfFile: filePath).data(using: .utf8)

                let decodedData: ScheduleForCourseSemester = try JSONDecoder().decode(
                        ScheduleForCourseSemester.self,
                        from: jsonData!)

                for lecture in decodedData.schedule {

                    if lecture.comment == "" || commentInfos.contains(where: { $0.comment == lecture.comment }) {
                        continue
                    }

                    let commentInfo = CommentInfo(
                            file: file,
                            lecture: lecture.label,
                            comment: lecture.comment
                    )

                    commentInfos.append(commentInfo)
                }
            }
        }
        catch {
            print("Error!!!")
        }

        return commentInfos
    }

    public struct CommentInfo: Codable {
        let file: String
        let lecture: String
        let comment: String
    }


    public func getFilesOfDirectory(folder: String) -> [String] {
        let fm = FileManager.default
        return try! fm.contentsOfDirectory(atPath: folder)
    }

    public func getOutputFolder() -> String {
        return "\(FileManager.default.currentDirectoryPath)/Output"
    }




     public func loadAllLectures(term: String) -> [Lecture] {
        let lectureFolder = "\(getOutputFolder())/Lectures"
        let files = getFilesOfDirectory(folder: lectureFolder)

        var allLectures: [Lecture] = []

        do {
            for file in files {
                if (file.hasPrefix(term)){
                    let filePath = "\(lectureFolder)/\(file)"

                    let jsonData = try String(contentsOfFile: filePath).data(using: .utf8)

                    let decodedData: ScheduleForCourseSemester = try JSONDecoder().decode(
                            ScheduleForCourseSemester.self,
                            from: jsonData!)

                    for lecture in decodedData.schedule {

                        if allLectures.contains(where: { $0.comment == lecture.comment }) {
                            continue
                        }

                        allLectures.append(lecture)
                    }
                }
            }
        }
        catch let error{
            print("Error!!!")
            print(error)
            
        }

        return allLectures
    }

    public func loadAndStoreAllLectures() {
        let allLecturesSS = loadAllLectures(term: "SS")
        let allLecturesWS = loadAllLectures(term: "WS")

        let encoder = JSONEncoder()
        let jsonDataSS = try! encoder.encode(allLecturesSS)
        let jsonDataWS = try! encoder.encode(allLecturesWS)

        storeFile(fileName: "allLecturesSS.json", textData: jsonDataSS)
        storeFile(fileName: "allLecturesWS.json", textData: jsonDataWS)
    }

    public func readAllLecturesOfTerm(term: String) -> [Lecture] {
        let outputFolder = getOutputFolder()
        let filePath = "\(outputFolder)/allLectures\(term).json"

        do{
                let jsonData = try String(contentsOfFile: filePath).data(using: .utf8)

                let decodedData: [Lecture] = try JSONDecoder().decode(
                        [Lecture].self,
                        from: jsonData!)

                return decodedData
        } catch let error{
            print(error)
            print("Error!!!")
        }

        return []
    }

/*
    func contentsOrBlank()->String {
        if let path = Bundle.main.path(forResource:self , ofType: nil) {
            do {
                let text = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                return text
                } catch { print("Failed to read text from bundle file \(self)") }
        } else { print("Failed to load file from bundle \(self)") }
        return ""
    }
    */


}
