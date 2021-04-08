//
//  Students.swift
//  SDfN
//
//  Created by Václav Matoušek on 08.03.2021.
//

import Foundation

struct Students: Codable {
    let students: [Student]?
    
    init(students: [Student]? = []) {
        self.students = students
    }
    }
