//
// Created by root on 11/24/20.
//

import Foundation

public class CommentsFetcher {


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
        let outputFolder = getOutputFolder()
        let files = getFilesOfDirectory(folder: outputFolder)

        var commentInfos: [CommentInfo] = []

        do {
            for file in files {
                let filePath = "\(outputFolder)/\(file)"

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
        return "\(FileManager.default.currentDirectoryPath)/Output/Lectures"
    }

}
