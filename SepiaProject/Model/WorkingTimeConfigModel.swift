//
//  WorkingTimeConfigModel.swift
//  sepia
//
//  Created by User on 17/12/22.
//

import Foundation

public struct WorkingTimeConfigModel: Codable {
    let settings: Settings?
}

public struct Settings: Codable {
    let workHours: String?
}
