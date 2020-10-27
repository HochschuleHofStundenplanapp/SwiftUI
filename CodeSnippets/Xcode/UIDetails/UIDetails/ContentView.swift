//
//  ContentView.swift
//  UIDetails
//
//  Created by MACBOOK on 27.10.20.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @State private var terms:[String] = ["NONE","DUMMY 1", "DUMMY 2"]
    @State private var selected = 0
    
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Select a term").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                Picker(selection: $selected, label:     Text("Select a term")){
                    ForEach( 0 ..< terms.count){
                        Text(self.terms[$0])
                    }
                }
                
                NavigationLink(destination: SecondView() ){
                        Text("Next").font(.title)
                }.buttonStyle(PlainButtonStyle())
            }
        }
    }
}

struct SecondView: View{
    
    @State private var terms:[String] = ["NONE","DUMMY 1", "DUMMY 2"]
    @State private var selected = 0
    
    var body: some View{
        VStack {
            Text("Select a course of studies").font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
            Picker(selection: $selected, label:     Text("Select a course of studies")){
                ForEach( 0 ..< terms.count){
                    Text(self.terms[$0])
                }
            }
            NavigationLink( destination: Text("Screen 3") ){
                Text("Next").font(.title)
            }.buttonStyle(PlainButtonStyle())
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
