//
// Created by root on 11/24/20.
//

import Foundation

public class CommentAnalyzer {

    public init() {

    }

    public func analyzeComment(comment: String) -> [CommentFact] {

        var facts: [CommentFact] = []

        let commentLowercased = comment.lowercased()

        let pattern = "(start|begin|beginn|ab):? kw\\s*(\\d{1,2})" // z.B. "start kw15"

        if let kw = getGroupOf(pattern: pattern, target: commentLowercased, group: 2) {
            facts.append(CommentFact(type: .start_kw, value: kw))
        }

        return facts
    }

    private func getGroupOf(pattern: String, target: String, group: Int) -> String? {
        let regex = try! NSRegularExpression(pattern: pattern)
        let matches = regex.matches(in: target, range: NSMakeRange(0, target.utf16.count))

        if matches.isEmpty || group >= matches[0].numberOfRanges {
            return nil
        }

        let match =  matches[0].range(at: group)
        return target.substring(from: match.location).substring(to: match.length)

    }
}

public struct CommentFact: Equatable {
    let type: CommentFactType
    let value: String

    public init(type: CommentFactType, value: String) {
        self.type = type
        self.value = value
    }
}

public enum CommentFactType {
    case start_kw, excluded_kws, list_kws
}
