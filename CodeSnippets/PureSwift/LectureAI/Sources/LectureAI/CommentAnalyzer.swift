//
// Created by root on 11/24/20.
//

import Foundation

public class CommentAnalyzer {

  public init() {

  }

  public func analyzeComment(comment: String) -> [CommentFact] {

    var facts: [CommentFact] = []
    var interval = CommentFactInterval.weekly

    let commentLowercased = comment.lowercased()

    let pattern  = "(start|begin|beginn|beginning|ab):?\\s*(calendar)?\\s*(week|kw)\\s*(kw)?\\s*(\\d{1,2})"  // z.B. "start kw15"
    let pattern2 = "(start|begin|beginn|ab)\\s*(\\d{1,2})\\.?\\s*kw"  // z.B. "start 15. kw"
    let pattern3 = "kw\\s\\d+(,+\\s*\\d+)+(\\s*und\\s*\\d+)*"
    let pattern4 = "kw.*kw.*"
    let pattern5 = "14-tägig"
    let pattern6 = "14 days"
    let pattern7 = "every second week"
    //regex aufzählung: KW\s\d+(,+\s*\d+)+(\s*und\s*\d+)*
    //comments mit - nicht möglich! -> "- ONLINE - KW 41 - 43 (Kick-Off und Coaching)"
    if getGroupOf(pattern: pattern4, target: commentLowercased, group: 0) != nil {
      facts.append(CommentFact(type: .no_info, interval: interval))
      return facts
    }

    if getGroupOf(pattern: pattern5, target: commentLowercased, group: 0) != nil {
      interval = .bi_weekly
    }

    if getGroupOf(pattern: pattern6, target: commentLowercased, group: 0) != nil {
      interval = .bi_weekly
    }

    if getGroupOf(pattern: pattern7, target: commentLowercased, group: 0) != nil {
      interval = .bi_weekly
    }

      if getGroupOf(pattern: pattern4, target: commentLowercased, group: 0) != nil {
          facts.append(CommentFact(type: .no_info, interval: .not_defined))
          return facts
      }

      //TODO: Ausstellungsdesign \/  KW 43, 45, 47, virtuell
      if let kw = getGroupOf(pattern: pattern3, target: commentLowercased, group: 0) {
        let list = kw.replacingOccurrences(of:"kw", with:"").replacingOccurrences(of:" ", with:"").split(regex: ",|und")
        facts.append(CommentFact(type: .list_kws(list.map { Int($0)! }), interval: interval))
        return facts
      }

    if let kw = getGroupOf(pattern: pattern, target: commentLowercased, group: 5) {
      facts.append(CommentFact(type: .start_kw(Int(kw)!), interval: interval))
        return facts
    }
    if let kw = getGroupOf(pattern: pattern2, target: commentLowercased, group: 2) {
      facts.append(CommentFact(type: .start_kw(Int(kw)!), interval: interval))
        return facts
    }

    return facts
  }

  private func getGroupOf(pattern: String, target: String, group: Int) -> String? {
    let regex = try! NSRegularExpression(pattern: pattern)
    let matches = regex.matches(in: target, range: NSMakeRange(0, target.utf16.count))

    if matches.isEmpty || group >= matches[0].numberOfRanges {
      return nil
    }

    let match = matches[0].range(at: group)
    return target.substring(from: match.location).substring(to: match.length)

  }
}


public struct CommentFact : Equatable {

  let type: CommentFactType
  let interval: CommentFactInterval

  public init(type: CommentFactType, interval: CommentFactInterval) {
    self.type = type
    self.interval = interval
  }

  public static func ==(lhs: CommentFact, rhs: CommentFact) -> Bool {
    String(describing: lhs.type) == String(describing: rhs.type)
  }

}

public enum CommentFactType {
  case start_kw(Int), excluded_kws([Int]), list_kws([Int]), no_info
}

public enum CommentFactInterval {
  case weekly, bi_weekly, not_defined
}

extension String {

  func split(regex pattern: String) -> [String] {

    guard let re = try? NSRegularExpression(pattern: pattern, options: [])
    else { return [] }

    let nsString = self as NSString  // needed for range compatibility
    let stop = "<SomeStringThatYouDoNotExpectToOccurInSelf>"
    let modifiedString = re.stringByReplacingMatches(
      in: self,
      options: [],
      range: NSRange(location: 0, length: nsString.length),
      withTemplate: stop)
    return modifiedString.components(separatedBy: stop)
  }
}
