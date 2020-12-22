//
//  ChangesView.swift
//  StundenplanApp
//
//  Created by Eric Münch on 03.11.20.
//

import SwiftUI

struct ChangesView : View {
    @ObservedObject var viewModel : ChangesViewModel
    
    var body: some View {
        VStack{
            if(viewModel.dataIsAvailable){
                ScrollView(){
                    ForEach(viewModel.allChanges){ change in
                        ChangesRow(changes: change)
                    }
                }
                .padding(10)
            }
            else{
                Text("Keine Änderungen vorhanden")
            }
        }.onAppear{
            viewModel.getChanges()
        }
    }
}


struct ChangesRow: View {
    let changes : Change
    var body: some View{
        if self.changes.alternative.time == "" && self.changes.alternative.date == "" {
            VStack(alignment: .leading){
                HStack{
                    Text(self.changes.label)
                        .font(.headline)
                    Text("(" + self.changes.reason + ")").font(.subheadline)
                    Spacer()
                }.padding(5)
                HStack{
                    Text(self.changes.original.date)
                        .font(.caption)
                        .strikethrough()
                }.padding(5)
                HStack{
                    Text(self.changes.original.time)
                        .font(.caption)
                        .strikethrough()
                }.padding(5)
                HStack{
                    Text(self.changes.original.room)
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
            .background(ColorConstants.primaryLight)
            .cornerRadius(10.0)
            
        }else{
            VStack(alignment: .leading){
                Text(self.changes.label).font(.headline).padding(5)
                HStack{
                    Text(self.changes.original.date)
                        .font(.caption)
                        .strikethrough()
                    Spacer()
                    Text(self.changes.alternative.date)
                        .font(.caption)
                }.padding(5)
                HStack{
                    Text(self.changes.original.time)
                        .font(.caption)
                        .strikethrough()
                    Spacer()
                    Text(self.changes.alternative.time)
                        .font(.caption)
                }.padding(5)
                HStack{
                    Text(self.changes.original.room)
                        .font(.caption)
                        .strikethrough()
                    Spacer()
                    Text(self.changes.alternative.room)
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
            .background(ColorConstants.primaryLight)
            .cornerRadius(10.0)
        }
    }
}

