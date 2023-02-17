//
//  Modifiers.swift
//  Slot
//
//  Created by Kato Steven Mubiru on 28/12/2022.
//

import SwiftUI


struct shadowModifier : ViewModifier{
    
    
    func body(content: Content) -> some View {
        content
            .shadow(color: Color("ColorBlack"), radius: 0, x :0 , y : 6)
    }
}
struct  buttonModifier : ViewModifier{
    
    func body(content: Content) -> some View {
        content
            .font(.title)
            .accentColor(Color.white)
        
    }
}
