//
//  AddBookView.swift
//  Bookwarm
//
//  Created by Arkasha Zuev on 08.06.2021.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    
    let geners = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Thriller"]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Gener", selection: $genre) {
                        ForEach(geners, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    RatingView(rating: $rating)
                    TextField("Write a review", text: $review)
                }
                
                Section {
                    Button("Save") {
                        addStudent()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Add Book")
        }
    }
    
    private func addStudent() {
        withAnimation {
            let newBook = Book(context: self.moc)
            newBook.title = title
            newBook.author = author
            newBook.rating = Int16(rating)
            newBook.genre = genre
            newBook.review = review
            
            do {
                try moc.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
