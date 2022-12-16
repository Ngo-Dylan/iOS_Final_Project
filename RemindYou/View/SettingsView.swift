//
//  SettingsView.swift
//  RemindYou
//
//  Created by Dylan Ngo on 12/16/22.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack{
            Text("Contact us:")
                .font(.system(size: 30))
                .bold()
            Divider()
            Text("dngo97@csu.fullerton.edu")
                .font(.system(size: 20))
                .bold()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
