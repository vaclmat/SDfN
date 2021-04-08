//
//  Student.swift
//  SDfN
//
//  Created by Václav Matoušek on 08.03.2021.
//

import Foundation

struct Student: Codable, Equatable {
    var studentID: String
    var firstName: String
    var lastName: String
    var gender: String
    
    enum CodingKeys: String, CodingKey {
        case studentID
        case firstName
        case lastName
        case gender
    }
    
    init(studentID: String? = "",
         firstName: String? = "",
         lastName: String? = "",
         gender: String? = "") {
        
        self.studentID = studentID!
        self.firstName = firstName!
        self.lastName = lastName!
        self.gender = gender!
        
    }
}
