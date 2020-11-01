//
//  Mission.swift
//  MoonShot
//
//  Created by Shishira on 10/20/20.
//  Copyright © 2020 Shishira. All rights reserved.
//

import Foundation

struct Mission : Codable, Identifiable {
    struct CrewRole : Codable {
        let name : String
        let role : String
    }

    let id: Int
    let launchDate : String?
    let crew : [CrewRole]
    let description : String
    
    var displayName :String {
        "Apollo \(id)"
    }
    
    var image : String {
        "apollo\(id)"
        .KMHTDE    }
}
