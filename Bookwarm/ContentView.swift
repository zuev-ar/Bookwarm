//
//  ContentView.swift
//  Bookwarm
//
//  Created by Arkasha Zuev on 07.06.2021.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Student.entity(), sortDescriptors: []) var students: FetchedResults<Student>
    
    var body: some View {
        VStack {
            List {
                ForEach(students, id: \.id) { student in
                    Text(student.name ?? "")
                }
                .onDelete(perform: deleteStudent)
            }
            .toolbar {
                EditButton()
                Button(action: addStudent) {
                    Label("Add", image: "plus")
                }
            }
        }
        
        Button("Add") {
            addStudent()
        }
    }
    
    private func addStudent() {
        withAnimation {
            let student = Student(context: moc)
            student.id = UUID()
            student.name = "No name"
            
            do {
                try moc.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteStudent(offsets: IndexSet) {
        withAnimation {
            for offset in offsets {
                let student = students[offset]
                moc.delete(student)
            }
            
            do {
                try moc.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
