//
//  Temple.swift
//  Project 2 Sou Mizobuchi
//
//  Created by user144546 on 10/12/18.
//  Copyright © 2018 IS543. All rights reserved.
//

import Foundation

class Temple {
    // Mark - Properties
    var name: String
    var filename: String
    var matched: Bool = false
    
    // Mark - Init
    init(filename: String, name: String) {
        self.filename = filename
        self.name = name
    }
}
