//
//  RealView.swift
//  Slot
//
//  Created by Kato Steven Mubiru on 24/01/2023.
//

import SwiftUI

struct RealView: View {
    var body: some View {
       Image("gfx-reel")
            .resizable()
            .scaledToFit()
            .frame(minWidth: 140, idealWidth: 200, maxWidth: 220, minHeight: 130, idealHeight: 190, maxHeight: 200, alignment: .center)
    }
}

struct RealView_Previews: PreviewProvider {
    static var previews: some View {
        RealView()
    }
}
