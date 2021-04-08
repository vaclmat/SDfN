//
//  StudentRec.swift
//  SDfN
//
//  Created by Václav Matoušek on 25.03.2021.
//

import Foundation

struct StudentRec: Codable, Equatable {
    var student: Student?
    
    init(student: Student? = Student()) {
        self.student = student
    }
    }
