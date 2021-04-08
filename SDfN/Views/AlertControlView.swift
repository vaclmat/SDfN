//
//  AlertControlView.swift
//  SDfN
//
//  Created by Václav Matoušek on 23.03.2021.
//

import SwiftUI
import SwiftKeychainWrapper
import Alamofire


struct AlertControlView: UIViewControllerRepresentable {
    @Binding var textString: String
    @Binding var showAlert: Bool
    @StateObject var resus = StudentStore()
    
    var title: String
    var message: String
    @State var alertmsg: String
    @State var showingAlert: Bool = false
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<AlertControlView>) -> UIViewController {
        return UIViewController()
    }
    
    func makeCoordinator() -> AlertControlView.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextFieldDelegate {
        var alert: UIAlertController?
        var control: AlertControlView
        init(_ control: AlertControlView) {
            self.control = control
        }
        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String ) -> Bool {
            if let text = textField.text as NSString? {
                self.control.textString = text.replacingCharacters(in: range, with: string)
            } else {
                self.control.textString = ""
            }
            return true
        }
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<AlertControlView>) {
        guard context.coordinator.alert == nil else {
            return
        }
        if self.showAlert {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            context.coordinator.alert = alert
            
            alert.addTextField { textField in
                textField.placeholder = "Enter some text"
                textField.text = textString
                textField.delegate = context.coordinator
            }
            alert.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .destructive) { _ in
                alert.dismiss(animated: true) {
                    self.showAlert = false
                }
            })
            alert.addAction(UIAlertAction(title: NSLocalizedString("Submit", comment: ""), style: .default) { _ in
                if let textField = alert.textFields?.first, let text = textField.text {
                    self.textString = text
                    let rtoken: String? = KeychainWrapper.standard.string(forKey: "token")
                    let headers: HTTPHeaders = ["Accept":"application/json",
                     "Authorization": "Bearer " + rtoken!]
                    AF.request("http://192.168.27.3:8081/web/services/university/student/" + text,
                           method: .get,
                           headers: headers
                           ).responseDecodable(of: StudentRec.self)
                         {
                            (response) in
                            switch response.result {
                            case .success(let results): do {
                                print("First lastName: \(String(describing: results))")
                                self.resus.ress = results
                            }
                            case .failure(let fail): do {
                                self.alertmsg = "Get REST/API command failed."
                                showingAlert = true
                                print(fail)
                            }
                            }
                            }                }
                
                alert.dismiss(animated: true) {
                    self.showAlert = false
                }
            })
            
            DispatchQueue.main.async {
                uiViewController.present(alert, animated: true, completion: {
                    self.showAlert = false
                    context.coordinator.alert = nil
                })
            }
        }
    }
}
        

/*
struct AlertControlView_Previews: PreviewProvider {
    static var previews: some View {
        AlertControlView()
    }
}*/
