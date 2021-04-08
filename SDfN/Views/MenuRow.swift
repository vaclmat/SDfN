//
//  MenuRow.swift
//  SDfN
//
//  Created by Václav Matoušek on 22.03.2021.
//

import SwiftUI

struct MenuRow: View {
    var sdmenu: MenuItems
    var body: some View {
        Button(action: {print(sdmenu.menuItem)}, label: {
            Text(sdmenu.menuItem)
        })
    }
}

struct MenuRow_Previews: PreviewProvider {
    static var previews: some View {
        MenuRow(sdmenu: sdmenu[0])
    }
}
