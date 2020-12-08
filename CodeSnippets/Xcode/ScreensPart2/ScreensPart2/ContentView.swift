//
//  ContentView.swift
//  ScreensPart2
//
//  Created by Xiongwei Zheng on 10.11.20.
//

import SwiftUI



struct ContentView: View {
    @ObservedObject var changesVM = ChangesViewModel()
    
    var body: some View {
        ScrollView(){
            ForEach(changesVM.allChanges){ change in
                ChangesRow(changes: change)
            }
        }
        .padding(10)
    }
}

struct ChangesRow: View {
    var changes : changeModel
    
//    let background = Color(red: 0.745, green:0.824, blue: 0.75, opacity: 100)
    
    var body: some View{
        if self.changes.alternativeTime == "" && self.changes.alternativeDate == "" {
            VStack(alignment: .leading){
                HStack{
                    Text(self.changes.label)
                        .font(.headline)
                    Text("(" + self.changes.reason + ")").font(.subheadline)
                    Spacer()
                }.padding(5)
                HStack{
                    Text(self.changes.originalDate)
                        .font(.caption)
                        .strikethrough()
                }.padding(5)
                HStack{
                    Text(self.changes.originalTime)
                        .font(.caption)
                        .strikethrough()
                }.padding(5)
                HStack{
                    Text(self.changes.originalRoom)
                        .font(.caption)
                        .strikethrough()
                }.padding(5)
                HStack{
                    Text(self.changes.docent)
                        .font(.caption)
                        .strikethrough()
                }.padding(5)
            }
            .padding(10)
            .background(Constants.backgroundLight)
            .cornerRadius(10.0)
            
        }else{
            VStack(alignment: .leading){
                Text(self.changes.label).font(.headline).padding(5)
                HStack{
                    Text(self.changes.originalDate)
                        .font(.caption)
                        .strikethrough()
                    Spacer()
                    Text(self.changes.alternativeDate)
                        .font(.caption)
                }.padding(5)
                HStack{
                    Text(self.changes.originalTime)
                        .font(.caption)
                        .strikethrough()
                    Spacer()
                    Text(self.changes.alternativeTime)
                        .font(.caption)
                }.padding(5)
                HStack{
                    Text(self.changes.originalRoom)
                        .font(.caption)
                        .strikethrough()
                    Spacer()
                    Text(self.changes.alternativeRoom)
                        .font(.caption)
                }.padding(5)
                HStack{
                    Text(self.changes.docent)
                        .font(.caption)
                        .strikethrough()
                    Spacer()
                    Text(self.changes.docent)
                        .font(.caption)
                }.padding(5)
            }
            .padding(10)
            .background(Constants.backgroundLight)
            .cornerRadius(10.0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
