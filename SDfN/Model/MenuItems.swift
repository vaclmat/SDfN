//
//  MenuItems.swift
//  SDfN
//
//  Created by Václav Matoušek on 22.03.2021.
//

import Foundation

struct MenuItems: Hashable, Codable, Identifiable {
    var id: Int
    var menuItem: String
    
    init(id: Int,
         menuItem: String) {
        self.id = id;
        self.menuItem = menuItem
    }
}
