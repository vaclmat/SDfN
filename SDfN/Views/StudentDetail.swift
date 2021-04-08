//
//  StudentDetail.swift
//  SDfN
//
//  Created by Václav Matoušek on 25.03.2021.
//

import SwiftUI
import SwiftKeychainWrapper
import Alamofire
import NavigationStack

struct StudentDetail: View {
    @Environment(\.presentationMode) var presentationMode
    @State var student: Student
    @State var rstudent: Student
    @State var alertmsg: String
    @State var deleteAlert: Bool = false
    @State var updateAlert: Bool = false
    @State var updatebuttonActive: Bool = true
    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Student ID: ")
                    .bold()
                    .padding()
                TextField("Enter Student ID: ", text: $student.studentID)
                    .autocapitalization(.none)
                    .padding()
                    .background(lightGreyColor)
                    .border(Color.black)
                    .cornerRadius(5.0)
                    .disabled(true)
            }
            HStack {
                Text("First Name: ")
                    .bold()
                    .padding()
                TextField("Update First Name", text: $student.firstName)
                    .onChange(of: student.firstName, perform: { value in
                        if student.firstName == rstudent.firstName {
                        updatebuttonActive = true
                    } else {
                        updatebuttonActive = false
                    }
                    })
                    .autocapitalization(.none)
                    .padding()
                    .background(lightGreyColor)
                    .border(Color.black)
                    .cornerRadius(5.0)
            }
            HStack {
                Text("Last Name: ")
                    .bold()
                    .padding()
                TextField("Update Last Name", text: $student.lastName)
                    .onChange(of: student.lastName, perform: { value in
                        if student.lastName == rstudent.lastName {
                            updatebuttonActive = true
                        } else {
                       updatebuttonActive = false
                        }
                    })
                    .autocapitalization(.none)
                    .padding()
                    .background(lightGreyColor)
                    .border(Color.black)
                    .cornerRadius(5.0)
            }
            HStack {
                Text("Gender:       ")
                    .bold()
                    .padding()
                TextField("Update Student Gender", text: $student.gender)
                    .onChange(of: student.gender, perform: { value in
                        if student.gender == rstudent.gender {
                            updatebuttonActive = true
                        } else {
                       updatebuttonActive = false
                        }
                    })
                    .autocapitalization(.none)
                    .padding()
                    .background(lightGreyColor)
                    .border(Color.black)
                    .cornerRadius(5.0)
            }
            HStack(alignment: .center) {
                Button(action: {
                        let rtoken: String? = KeychainWrapper.standard.string(forKey: "token")
                        let headers: HTTPHeaders = ["Accept":"application/json",
                         "Content-Type":"application/json",
                         "Authorization": "Bearer " + rtoken!]
                        let updp = Student(studentID: student.studentID, firstName: student.firstName, lastName: student.lastName, gender: student.gender);                        AF.request("http://192.168.27.3:8081/web/services/university/students",
                               method: .put,
                               parameters: updp,
                               encoder: JSONParameterEncoder.default,
                               headers: headers
                               ).response {
                                (response) in
                                switch response.result {
                                case .success( _): do {
//                                    print("Update Response: \(String(describing: response.description))")
                                    alertmsg = "Student " + student.lastName + " was successfuly updated"
                                    updateAlert = true
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                                case .failure( _): do {
                                    alertmsg = "Get REST/API command failed."
                                    updateAlert = true
                                }}}
                }, label: {
                    Text("Update Student Data")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 160, height: 80, alignment: .center)
                        .background(updatebuttonActive ? Color.yellow : Color.green)
                        .cornerRadius(15.0)
                        .multilineTextAlignment(.center)
                })
                .disabled(updatebuttonActive)
                .alert(isPresented: self.$updateAlert, content: {
                    Alert(title: Text( "Message from Update Student Data button"), message: Text(alertmsg),
                          dismissButton: .cancel())
                })

                Button(action: {
                        let rtoken: String? = KeychainWrapper.standard.string(forKey: "token")
                        let headers: HTTPHeaders = ["Accept":"application/json",
                         "Content-Type":"application/json",
                         "Authorization": "Bearer " + rtoken!]
                    AF.request("http://192.168.27.3:8081/web/services/university/student/" + student.studentID,
                               method: .delete,
                               headers: headers
                               ).response {
                                (response) in
                                switch response.result {
                                case .success( _): do {
//                                    print("Delete Response: \(String(describing: response.value))")
                                    alertmsg = "Student " + student.lastName + " was successfuly deleted"
                                    deleteAlert = true
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                                case .failure( _): do {
                                    alertmsg = "Get REST/API command failed."
                                    deleteAlert = true
                                }}}
                    }, label: {
                    Text("Delete Student")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 120, height: 80, alignment: .center)
                        .background(Color.red)
                        .cornerRadius(15.0)
                    })
                    .alert(isPresented: self.$deleteAlert, content: {
                        Alert(title: Text( "Message from Delete Student button"), message: Text(alertmsg),
                              dismissButton: .cancel())
                    })
            }
        }
    }
}

struct StudentDetail_Previews: PreviewProvider {
    static var previews: some View {
        StudentDetail(student: Student(), rstudent: Student(), alertmsg: "")
    }
}
