//
//  InfoView.swift
//  Slot
//
//  Created by Kato Steven Mubiru on 25/01/2023.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        
        VStack(alignment: .center, spacing: 10) {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "xmark.circle")
                    .font(.title)
                    
            })
            .foregroundColor(.red)
           

            
            
           LocalView()
            
            Spacer()
            
            Form {
                Section(header: Text("About the application")){
                    ExtractedView(firstItem: "Application", secondItem: "Slot")
                    ExtractedView(firstItem: "Platforms", secondItem: "Ipad, Iphone")
                    ExtractedView(firstItem: "Developer", secondItem: "K.S.M")
                    ExtractedView(firstItem: "Music", secondItem: "European")
                    ExtractedView(firstItem: "Website", secondItem: "katostevenmubiru.com")
                    ExtractedView(firstItem: "Copyright", secondItem: "@2023 All rights reserved")
                    ExtractedView(firstItem: "Version", secondItem: "1.0")
                    
                    // hstack
                }// section
            }//form
            .fontDesign(.rounded)
            .font(.body)
            
        }//Vstack
      .padding(.top, 30)
      //.overlay(
        
     // )
    }
}
struct ExtractedView: View {
    var firstItem: String
    var secondItem: String
    
    var body: some View {
        HStack{
            
            Text(firstItem).foregroundColor(.gray)
            Spacer()
            Text(secondItem)
            
            
        }
    }
}
//preview
struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}


