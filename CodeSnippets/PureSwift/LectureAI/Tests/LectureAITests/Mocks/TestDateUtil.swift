//
// Created by root on 11/23/20.
//

import Foundation

public class TestDateUtil : DateUtil {

    override public init() {

    }

    override public func getCurrentMonth() -> Int {
        return 12
    }

    override public func getCurrentYear() -> Int {
        return 2020
    }

}