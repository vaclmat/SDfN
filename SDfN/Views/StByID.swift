//
//  StByID.swift
//  SDfN
//
//  Created by Václav Matoušek on 08.03.2021.
//

import SwiftUI
import NavigationStack



struct StByID: View {
    @State var stid: String
    @State var showstidw: Bool = false
    @State var alertmsg: String
    @State var deleteAlert: Bool = false
    @State var updateAlert: Bool = false
    @State var updatebuttonActive: Bool = true
    @EnvironmentObject var stbiresult: StudentStore
    @EnvironmentObject var rstbiresult: StudentStore
    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)

    var body: some View {
//        NavigationView {
        NavigationStackView {
            ZStack {
                
                if self.showstidw {
                    AlertControlView(textString: $stid, showAlert: $showstidw, resus: stbiresult, title: "", message: "Enter Student ID", alertmsg: "")
                }
                VStack {
                    /*
                    
                    HStack {
                        Text("First Name: ")
                            .bold()
                            .padding()
        //                    .padding(.bottom, 10)
                        TextField("Update First Name", text: $stbiresult.ress.student.firstName)
                            .onChange(of: stbiresult.ress.student!.firstName, perform: { value in
                                if stbiresult.ress.student.firstName == rstbiresult.ress.student.firstName {
                                updatebuttonActive = true
                            } else {
                                updatebuttonActive = false
                            }
                            })
                            .autocapitalization(.none)
                            .padding()
                            .background(lightGreyColor)
                            .cornerRadius(5.0)
        //                    .padding(.bottom, 20)
                    }
                    HStack {
                        Text("Last Name: ")
                            .bold()
                            .padding()
        //                    .padding(.bottom,10)
                        TextField("Update Last Name", text: $stbiresult.ress.student.lastName)
                            .onChange(of: stbiresult.ress.student!.lastName, perform: { value in
                                if stbiresult.ress.student.lastName == rstbiresult.ress.student.lastName {
                                    updatebuttonActive = true
                                } else {
                               updatebuttonActive = false
                                }
                            })
                            .autocapitalization(.none)
                            .padding()
                            .background(lightGreyColor)
                            .cornerRadius(5.0)
        //                    .padding(.bottom, 20)
                        
                    }
                    HStack {
                        Text("Gender:       ")
                            .bold()
                            .padding()
        //                    .padding(.bottom, 10)
                        TextField("Update Student Gender", text: $stbiresult.ress.student.gender)
                            .onChange(of: stbiresult.ress.student!.gender, perform: { value in
                                if stbiresult.ress.student.gender == rstbiresult.ress.student.gender {
                                    updatebuttonActive = true
                                } else {
                               updatebuttonActive = false
                                }
                            })
                            .autocapitalization(.none)
                            .padding()
                            .background(lightGreyColor)
                            .cornerRadius(5.0)
         //                   .padding(.bottom, 20)
                    }*/
        //            Divider()
                    /*
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
                                            print("Update Response: \(String(describing: response.description))")
                                            alertmsg = "Student " + student.lastName + " was successfuly updated"
                                            updateAlert = true
                                            self.presentationMode.wrappedValue.dismiss()
        //                                    self.navStack.pop()
                                        }
                                        case .failure(let fail): do {
                                            alertmsg = "Get REST/API command failed."
                                            updateAlert = true
                                            print(fail)
                                        }}}
                        }, label: {
                            Text("Update Student Data")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 160, height: 80, alignment: .center)
                                .background(updatebuttonActive ? lightGreyColor : Color.green)
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
                                            print("Delete Response: \(String(describing: response.value))")
                                            alertmsg = "Student " + student.lastName + " was successfuly deleted"
                                            deleteAlert = true
                                            self.presentationMode.wrappedValue.dismiss()
                                        }
                                        case .failure(let fail): do {
                                            alertmsg = "Get REST/API command failed."
                                            deleteAlert = true
                                            print(fail)
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
                        
                    }*//*
                     Text("Student ID: \(stid)")
                     */
                    /*
 //                  HStack {
                        Text("Student ID: ")
                            .bold()
                            .padding()
        //                    .padding(.bottom, 10)
                        TextField("Enter Student ID: ", text: $stbiresult.ress.student.studentID)
                            .autocapitalization(.none)
                            .padding()
                            .background(lightGreyColor)
                            .cornerRadius(5.0)
        //                    .padding(.bottom, 20)
                            .disabled(true)
//                    }*/
                    HStack{
                        Text("Student ID: \((stbiresult.ress.student?.studentID)!)")
                            .bold()
                            .padding()
//                        TextField("Enter Student ID: ", text: (stbiresult.ress.student?.studentID)!)
                        
                    }
                    Text("First Name: \((stbiresult.ress.student?.firstName)!)")
                    Text("Last Name: \((stbiresult.ress.student?.lastName)!)")
                    Text("Gender: \((stbiresult.ress.student?.gender)!)")
                   
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(trailing:
                                    VStack {
                                        Button(action: {
                                        self.stid = ""
                                        self.showstidw = true
                                    }) {
                                            Text("Enter Student ID")
                                    }
                                    })
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}
    
/*
struct StByID_Previews: PreviewProvider {
    static var previews: some View {
        StByID(stid: "", stbiresult: <#Student#>)
    }
}*/
