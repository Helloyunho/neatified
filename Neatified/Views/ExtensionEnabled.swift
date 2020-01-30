//
//  ExtensionEnabled.swift
//  Neatified
//
//  Created by Helloyunho on 2020/01/30.
//  Copyright © 2020 Helloyunho. All rights reserved.
//

import SwiftUI

struct ExtensionEnabled: View {
    var userDefaults: UserDefaults?
    
    @State private var pickedIndex = (UserDefaults(suiteName: "32Z9KZZ4PU.Neatified") != nil) ?
        UserDefaults(suiteName: "32Z9KZZ4PU.Neatified")!.integer(forKey: "level") != 0 ? UserDefaults(suiteName: "32Z9KZZ4PU.Neatified")!.integer(forKey: "level") :
            1 :
        1
    
    var body: some View {
        let picked = Binding<Int>(get: {
            return self.pickedIndex
        }, set: {
            self.pickedIndex = $0
            
            if self.userDefaults != nil {
                self.userDefaults!.set($0, forKey: "level")
            }
        })
        
        return VStack {
            Text("Neatified")
                .font(.title)
                .padding()
            Picker(selection: picked, label: EmptyView()) {
                Text("Nothing").tag(1)
                Text("Balanced").tag(2)
                Text("Strict").tag(3)
            }.pickerStyle(SegmentedPickerStyle())
                .fixedSize()
                .padding(.all, 40)
            Text("Nothing")
                .fontWeight(.semibold)
                .padding(.bottom, 5)
            Text("Neatified will do nothing\nwhen a new website loaded.")
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
            Text("Balanced")
                .fontWeight(.semibold)
                .padding(.bottom, 5)
            Text("Remove copy or right-click restriction\nfrom most of the sites.")
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
            Text("Strict")
                .fontWeight(.semibold)
                .padding(.bottom, 5)
            Text("Remove copy or right-click restriction\nfrom almost of the sites.\n(The site may not work correctly.)")
                .multilineTextAlignment(.center)
                .padding(.bottom, 10)
            Text("Copyright 2019-2020 Seia-Soto and Helloyunho.\nAll rights reserved.")
                .fontWeight(.thin)
                .padding(.top, 50)
                
        }.frame(minWidth: 275, minHeight: 535)
    }
}

struct ExtensionEnabled_Previews: PreviewProvider {
    static var previews: some View {
        ExtensionEnabled(userDefaults: UserDefaults(suiteName: "32Z9KZZ4PU.Neatified"))
    }
}
