//
//  ContentView.swift
//  PokemonSwiftUI
//
//  Created by Ege Eke on 13.01.2021.
//

import SwiftUI

struct ContentView: View {
    
    #if os(iOS)
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    #endif
    
    var body: some View {
        #if os(iOS)
        if horizontalSizeClass == .compact {
            AppTabNavigation()
        } else {
            AppSideNavigation()
        }
        #else
        //For macOS (Not Implemented Yet)
        AppSideNavigation()
        #endif
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
