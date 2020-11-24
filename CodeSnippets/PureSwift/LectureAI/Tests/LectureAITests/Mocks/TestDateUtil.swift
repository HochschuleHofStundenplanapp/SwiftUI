//
// Created by root on 11/23/20.
//

import Foundation
import LectureAI

public class TestDateUtil : DateUtil {

    var currentMonth = 12
    var currentYear = 2020

    override public init() {

    }

    override public func getCurrentMonth() -> Int {
        return self.currentMonth
    }

    override public func getCurrentYear() -> Int {
        return self.currentYear
    }

}