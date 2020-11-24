//
// Created by root on 11/24/20.
//

import Foundation

public class CommentAnalyzer {

    public init() {

    }

    public func analyzeComment(comment: String) -> [CommentFact] {

        var facts = [
            CommentFact(type:  .start_kw, value: "23"),
            CommentFact(type: .excluded_kws, value: "23,24"),
        ]

        return facts
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
