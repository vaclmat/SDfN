//
//  MainMenu.swift
//  SDfN
//
//  Created by Václav Matoušek on 06.03.2021.
//

import SwiftUI
import Alamofire
import SwiftKeychainWrapper
import NavigationStack

class StudentsStore: ObservableObject {
    @Published var res: Students = Students()
}
class StudentStore: ObservableObject {
    @Published var ress: StudentRec = StudentRec()
}

struct MainMenu: View {
    @Environment(\.presentationMode) var presentationMode
    @State var stidwa = false
    @State var stid: String = ""
    @State private var selection: String? = nil
    @State var showingAlert = false
    @Binding var username: String
    @Binding var passwd: String
    @State var alertmsg = ""
    @ObservedObject var resu = StudentsStore()
    @ObservedObject var resus = StudentStore()
    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    
    var body: some View {
        ZStack {
            Color.gray
        NavigationStackView {
            VStack(alignment: .center) {
                TextField("Enter Student ID", text: $stid)
                    .autocapitalization(.none)
                    .padding()
                    .frame(width: 220, height: 60, alignment: .center)
                    .background(lightGreyColor)
                    .border(Color.black)
                    .cornerRadius(15.0)
                    .padding(.top, 20)
                
                NavigationLink(
                    destination: StudentDetail(student: self.resus.ress.student!, rstudent: self.resus.ress.student!, alertmsg: "")
//                    destination: StudentDetail(alertmsg: "")
                        .environmentObject(resus)
                        .navigationBarTitle("Student Details", displayMode: .inline),
                    tag: "First",
                    selection: $selection) {
                    EmptyView()
                }
                NavigationLink(
//                    destination: StsGetAll(results: self.$resu.res)
                    destination: StsGetAll()
                        .environmentObject(resu)
                        .navigationBarTitle("Get All Students", displayMode: .inline),
                    tag: "Second",
                    selection: $selection) {
                    EmptyView()
                }
                NavigationLink(
                    destination: AddSt(astid: "", afN: "", alN: "", ag: "", alertmsg: "")
                        .navigationBarTitle("Add Student", displayMode: .inline),
                    tag: "Third",
                    selection: $selection) {
                    EmptyView()
                }
                NavigationLink(
                    destination: EmptyView(),
                    tag: "Four",
                    selection: $selection) {
                    EmptyView()
                }
                
            Button("Get Student By ID") {
                let rtoken: String? = KeychainWrapper.standard.string(forKey: "token")
                let headers: HTTPHeaders = ["Accept":"application/json",
                 "Authorization": "Bearer " + rtoken!]
                AF.request("http://192.168.27.3:8081/web/services/university/student/" + stid,
                       method: .get,
                       headers: headers
                       ).responseDecodable(of: StudentRec.self)
                     {
                        (response) in
                        switch response.result {
                        case .success(let results): do {
//                            print("First lastName: \(String(describing: results))")
                            self.resus.ress = results
                            self.stid = ""
                            self.selection = "First"
                        }
                        case .failure( _): do {
                            self.alertmsg = "Get REST/API command failed."
                            showingAlert = true
                        }
                        }
                        }
                }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60, alignment: .center)
            .background(stid.count != 9 ? Color.yellow : Color.green)
            .cornerRadius(15.0)
            .padding(.top, 10)
            .disabled(stid.count != 9)
            .alert(isPresented: self.$showingAlert, content: {
            Alert(title: Text( "REST/API command failure"), message: Text(alertmsg),
                  dismissButton: .cancel())
        })
                
                Button("Get All Students") {
                    let rtoken: String? = KeychainWrapper.standard.string(forKey: "token")
                    let headers: HTTPHeaders = ["Accept":"application/json",
                     "Content-Type":"application/json",
                     "Authorization": "Bearer " + rtoken!]
                    AF.request("http://192.168.27.3:8081/web/services/university/students",
                           method: .get,
                           headers: headers
                           ).responseDecodable(of: Students.self) {
                            (response) in
                            switch response.result {
                            case .success(let results): do {
//                                print("First lastName: \(String(describing: results.students?.first?.lastName))")
                                self.resu.res = results
                                self.selection = "Second"
                            }
                            case .failure( _): do {
                                alertmsg = "Get REST/API command failed."
                                showingAlert = true
                            }}}
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60, alignment: .center)
                .background(Color.green)
                .cornerRadius(15.0)
                .alert(isPresented: self.$showingAlert, content: {
                Alert(title: Text( "REST/API command failure"), message: Text(alertmsg),
                      dismissButton: .cancel())
            })
                
                Button("Add Student") {
                    self.selection = "Third"
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60, alignment: .center)
                .background(Color.green)
                .cornerRadius(15.0)
                
                Button("Logout") {
                    self.username = ""
                    self.passwd = ""
 //                   self.selection = "Four"
                    let _: Bool = KeychainWrapper.standard.set("", forKey: "token")
                    let _: Bool = KeychainWrapper.standard.set("", forKey: "username")
                    let _: Bool = KeychainWrapper.standard.set("", forKey: "role")
                    self.presentationMode.wrappedValue.dismiss()
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(width: 220, height: 60, alignment: .center)
                .background(Color.green)
                .cornerRadius(15.0)
                
//                Spacer()
            }}}
    }
}

struct MainMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainMenu(username: .constant(""), passwd: .constant(""))
    }
}


