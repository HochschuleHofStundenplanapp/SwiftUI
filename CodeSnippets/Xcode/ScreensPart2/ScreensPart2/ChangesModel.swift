//
//  ChangesModel.swift
//  ScreensPart2
//
//  Created by Xiongwei Zheng on 08.12.20.
//

import Foundation

struct changeModel: Identifiable{
    let id = UUID()
    var label: String
    var docent: String
    var reason: String
    var group: String
    var originalTime: String
    var originalDate: String
    var originalRoom: String
    var alternativeTime: String
    var alternativeDate: String
    var alternativeRoom: String
}
