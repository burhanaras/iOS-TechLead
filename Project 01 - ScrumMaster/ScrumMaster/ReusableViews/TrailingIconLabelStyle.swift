//
//  TrailingIconLabelStyle.swift
//  ScrumMaster
//
//  Created by Burhan Aras on 25.09.2022.
//

import SwiftUI

struct TrailingIconLabelStyle: LabelStyle {

    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

extension LabelStyle where Self == TrailingIconLabelStyle {

    static var trailingIcon: Self { Self() }
}
