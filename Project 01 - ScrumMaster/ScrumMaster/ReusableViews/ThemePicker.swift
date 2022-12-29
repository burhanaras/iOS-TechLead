//
//  ThemePicker.swift
//  ScrumMaster
//
//  Created by Burhan Aras on 28.09.2022.
//

import SwiftUI

struct ThemePicker: View {

    @Binding var selection: Theme

    var body: some View {
        Picker("Theme", selection: $selection) {
            ForEach(Theme.allCases) { theme in
                ThemeView(theme: theme)
                    .tag(theme)
            }
        }
    }
}

struct ThemePicker_Previews: PreviewProvider {

    static var previews: some View {
        ThemePicker(selection: .constant(.purple))
    }
}