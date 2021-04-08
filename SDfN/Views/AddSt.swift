//
//  AddSt.swift
//  SDfN
//
//  Created by Václav Matoušek on 08.03.2021.
//

import SwiftUI
import SwiftKeychainWrapper
import Alamofire

struct AddSt: View {
    @State var astid: String
    @State var afN: String
    @State var alN: String
    @State var ag: String
    @State var alertmsg: String
    @State var ashA: Bool = false
    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            HStack{
                Text("Student ID:")
                    .bold()
                    .padding(.leading)
                TextField("Enter Student ID", text: $astid)
                    .autocapitalization(.none)
                    .padding()
                    .background(lightGreyColor)
                    .border(Color.black)
                    .cornerRadius(5.0)
                    .padding(.bottom, 0)
            }
            HStack{
                Text("First Name:")
                    .bold()
                    .padding(.leading)
                TextField("Enter First Name", text: $afN)
                    .autocapitalization(.none)
                    .padding()
                    .background(lightGreyColor)
                    .border(Color.black)
                    .cornerRadius(5.0)
                    .padding(.bottom, 0)
            }
            HStack{
                Text("Last Name:")
                    .bold()
                    .padding(.leading)
                TextField("Enter Last Name", text: $alN)
                    .autocapitalization(.none)
                    .padding()
                    .background(lightGreyColor)
                    .border(Color.black)
                    .cornerRadius(5.0)
                    .padding(.bottom, 0)
            }
            HStack{
                Text("Gender:      ")
                    .bold()
                    .padding(.leading)
                TextField("Enter Gender", text: $ag)
                    .autocapitalization(.none)
                    .padding()
                    .background(lightGreyColor)
                    .border(Color.black)
                    .cornerRadius(5.0)
                    .padding(.bottom, 0)
            }
            Divider()
            VStack(alignment: .center) {
                Button(action: {
                    if (afN == "" || alN == "" || ag == "" || astid.count != 9) {
                        alertmsg = "All items has to be filled and Student ID hast to have 9 characters"
                        ashA = true
                    } else {
                        let rtoken: String? = KeychainWrapper.standard.string(forKey: "token")
                        let headers: HTTPHeaders = ["Accept":"application/json",
                         "Content-Type":"application/json",
                         "Authorization": "Bearer " + rtoken!]
                        let addp = Student(studentID: astid, firstName: afN, lastName: alN, gender: ag);                        AF.request("http://192.168.27.3:8081/web/services/university/students",
                               method: .post,
                               parameters: addp,
                               encoder: JSONParameterEncoder.default,
                               headers: headers
                               ).response  {
                                (response) in
                                switch response.result {
                                case .success( _): do {
                                    alertmsg = "Student " + alN + " was added successfuly"
                                    ashA = true
                                    astid = ""
                                    afN = ""
                                    alN = ""
                                    ag = ""
                                }
                                case .failure( _): do {
                                    alertmsg = "Get REST/API command failed."
                                    ashA = true
                                }}}}
                }, label: {
                Text("Add Student")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60, alignment: .center)
                    .background(Color.green)
                    .cornerRadius(15.0)
                })
                .alert(isPresented: self.$ashA, content: {
                    Alert(title: Text( "Message from Add Student menu item"), message: Text(alertmsg),
                          dismissButton: .cancel())
                })
                
            }
        }
    }
}

struct AddSt_Previews: PreviewProvider {
    static var previews: some View {
        AddSt(astid: "", afN: "", alN: "", ag: "", alertmsg: "")
    }
}
