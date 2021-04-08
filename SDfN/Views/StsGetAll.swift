//
//  StsGetAll.swift
//  SDfN
//
//  Created by Václav Matoušek on 08.03.2021.
//

import SwiftUI
import NavigationStack


struct StsGetAll: View {
    
    @EnvironmentObject var resu: StudentsStore
    
    var body: some View {
        ZStack {
            Color.blue
        NavigationStackView {
            ScrollView{
                VStack(alignment: .leading) {
                    ForEach(resu.res.students!, id: \.studentID)
                    { (student) in
                    PushView(destination: StudentDetail(student: student, rstudent: student, alertmsg: "")
                                .navigationBarTitle("Student Details", displayMode: .inline)
                                .navigationViewStyle(StackNavigationViewStyle())
                    ) {
                        StudentRow (student: student)
                    }
                }
                }}
        }
    }
    }
}

struct StudentRow: View {
    var student: Student
    var body: some View {
        let st: String = student.firstName + " " + student.lastName
        Text(st)
            .bold()
            .padding(.top, 5)
    }
}

struct StsGetAll_Previews: PreviewProvider{
    static var previews: some View {
        StsGetAll().environmentObject(StudentsStore())
    }
}



