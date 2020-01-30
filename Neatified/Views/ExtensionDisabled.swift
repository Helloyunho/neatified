//
//  ExtensionDisabled.swift
//  Neatified
//
//  Created by Helloyunho on 2020/01/30.
//  Copyright © 2020 Helloyunho. All rights reserved.
//

import SwiftUI

struct ExtensionDisabled: View {
    var body: some View {
        Text("Please enable the extension in Safari -> Preference -> Extensions.").multilineTextAlignment(.center).frame(width: 275, height: 535)
    }
}

struct ExtensionDisabled_Previews: PreviewProvider {
    static var previews: some View {
        ExtensionDisabled()
    }
}
