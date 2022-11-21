//
//  ContentView.swift
//  reddyt
//
//  Created by Mani on 21/11/2022.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var userSubreddits: FetchedResults<Item>
    
    private let popularSubreddits = [
        PopularSubreddits(subreddit: "funny"),
        PopularSubreddits(subreddit: "AskReddit"),
        PopularSubreddits(subreddit: "gaming"),
        PopularSubreddits(subreddit: "aww"),
        PopularSubreddits(subreddit: "movies"),
        PopularSubreddits(subreddit: "worldnews"),
        PopularSubreddits(subreddit: "todayilearned")
    ]
    
    var body: some View {
        NavigationView {
            List {
                
                Section(header: Text("Popular")){
                    ForEach(popularSubreddits){ subreddit in
                        NavigationLink {
                            //                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                            Text("subreddit body")
                        } label: {
                            //                        Text(item.timestamp!, formatter: itemFormatter)
                            Text(subreddit.subreddit)
                        }
                    }
                    
                    
                }
                
                Section(header: Text("Custom")){
                    ForEach(userSubreddits) { subreddit in
                        NavigationLink {
                            //                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
                            Text("subreddit body")
                        } label: {
                            //                        Text(item.timestamp!, formatter: itemFormatter)
                            Text("subreddit names")
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                
            }
            
            .toolbar {
                ToolbarItem {
                    Button(action: addItem) {
                        Label("Add Subreddit", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.timestamp = Date()
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { userSubreddits[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct PopularSubreddits: Identifiable {
    var id = UUID()
    var subreddit: String
}

//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
