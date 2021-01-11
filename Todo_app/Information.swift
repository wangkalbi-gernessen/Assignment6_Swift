//
//  Information.swift
//  Todo_app
//
//  Created by Kazunobu Someya on 2021-01-09.
//

import Foundation

struct Information {
    var title: String
    var priorityLevel: priorityLevel
    var isCompletedIndicator: Bool
}

enum priorityLevel {
    case high
    case medium
    case low
}


