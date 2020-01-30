//
//  ContentView.swift
//  Neatified
//
//  Created by Helloyunho on 2020/01/29.
//  Copyright © 2020 Helloyunho. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    let userDefaults = UserDefaults(suiteName: "32Z9KZZ4PU.Neatified")
    
    @EnvironmentObject var state: UserState
    
    var body: some View {
        VStack {
            if state.extensionEnabled {
                ExtensionEnabled(userDefaults: userDefaults)
            } else {
                ExtensionDisabled()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
