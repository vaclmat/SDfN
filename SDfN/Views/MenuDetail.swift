//
//  MenuDetail.swift
//  SDfN
//
//  Created by Václav Matoušek on 22.03.2021.
//

import SwiftUI
import SwiftKeychainWrapper
import Alamofire

struct MenuDetail: View {
//    var sdmenu: MenuItems

    var body: some View {
        ScrollView {
//            Text(sdmenu.menuItem)
            
            }
            .padding()
//        .navigationTitle(sdmenu.menuItem)
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct MenuDetail_Previews: PreviewProvider {
    static var previews: some View {
        MenuDetail()
    }
}

