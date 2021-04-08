//
//  ContentView.swift
//  SDfN
//
//  Created by Václav Matoušek on 24.02.2021.
//

import SwiftUI
import Alamofire
import SwiftKeychainWrapper
import JWTDecode

struct ContentView: View {
    @State var isLoginActive = false
    @State var showingAlert = false
    @State var username = ""
    @State var passwd = ""
    @State var alertmessage = ""
    let lightGreyColor = Color(red: 239.0/255.0, green: 243.0/255.0, blue: 244.0/255.0, opacity: 1.0)
    
    var body: some View {
        NavigationView {
            VStack{
            WelcomeText()
            UserImage()
            TextField("Username", text: $username)
                .autocapitalization(.none)
                .padding()
                .background(lightGreyColor)
                .border(Color.black)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            SecureField("Password", text: $passwd)
                .padding()
                .background(lightGreyColor)
                .border(Color.black)
                .cornerRadius(5.0)
                .padding(.bottom, 20)
            NavigationLink(
                destination: MainMenu(username: $username, passwd: $passwd)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarTitle("Main Menu", displayMode: .inline),
                isActive: $isLoginActive) {
                Button(action: {
                struct Log_in: Codable {
                var username: String
                var password: String
                    }
                struct Tk: Codable {
                let token: String
                enum CodingKeys: String, CodingKey {
                    case token
                    }
                    }
                if ( username == "" || passwd == "") {
                    alertmessage = "Fill username and password!"
                    showingAlert = true
                    } else {
                let logins = Log_in(username: username, password: passwd)
//                print(logins)
                let headers: HTTPHeaders = ["Accept":"application/json",
                     "Content-Type":"application/json"]
                AF.request("http://192.168.27.3:8081/web/services/university/user/login",
                           method: .post,
                           parameters: logins,
                           encoder: JSONParameterEncoder.default,
                           headers: headers
                )
                .responseDecodable(of: Tk.self) {
                    (response) in
                    switch response.result {
                    case .success(let tokenstr):
                        let utoken = tokenstr.token
//                        print("Token String: \(utoken)")
                        let _: Bool = KeychainWrapper.standard.set(utoken, forKey: "token")
                        let _: Bool = KeychainWrapper.standard.set(username, forKey: "user")
                        do {
                            let decoded = try! decode(jwt: utoken)
                            let drole: String = decoded.body["role"] as! String
//                            print("Role: \(drole)")
                            let _: Bool = KeychainWrapper.standard.set(drole, forKey: "role")
                            self.isLoginActive = true
                            }
                    case .failure( _):
                        alertmessage = "Authentication failed"
                        showingAlert = true
//                        print("error: \(fail)")
                    }}
                    }}) {
                LoginButtonContent()
                    }
                .alert(isPresented: self.$showingAlert, content: {
                Alert(title: Text( "Authentication failure"), message: Text(alertmessage),
                      dismissButton: .cancel())
            })
            }
        }.padding()
        }
    }
}
            

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
            ContentView()
    }
}

struct WelcomeText: View {
    var body: some View {
        return Text("Student Database")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .padding(.bottom, 0)
    }
}

struct UserImage: View {
    var body: some View {
        return Image("userImage")
            .resizable()
            .aspectRatio(UIImage(named: "userImage")!.size, contentMode: .fill)
            .frame(width: 150, height: 150, alignment: .center)
            .clipped()
            .cornerRadius(150)
            .padding(.bottom, 0)
    }
}

struct LoginButtonContent: View {
    var body: some View {
        return Text("LOGIN")
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(width: 220, height: 60, alignment: .center)
            .background(Color.green)
            .cornerRadius(15.0)
    }
}
