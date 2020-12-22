import Foundation

class AllLectureAnalyzer{

    public func getOutputFolder() -> String {
        return "\(FileManager.default.currentDirectoryPath)/Output"
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

}