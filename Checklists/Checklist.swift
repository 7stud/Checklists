//
//  Checklist.swift
//  Checklists
//
//  Created by Christopher Wooldridge on 1/6/18.
//  Copyright © 2018 7stud. All rights reserved.
//

import UIKit

class Checklist: NSObject {
    var name = ""
    
    init(_ name: String) {
        self.name = name
        super.init()
    }
}
