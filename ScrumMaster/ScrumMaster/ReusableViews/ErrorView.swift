//
//  ErrorView.swift
//  ScrumMaster
//
//  Created by Burhan Aras on 11.10.2022.
//

import SwiftUI

struct ErrorView: View {

    let errorWrapper: ErrorWrapper
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 16) {
                Text("An error occurred!")
                    .font(.title)
                Text(errorWrapper.error.localizedDescription)
                    .font(.headline)
                    .multilineTextAlignment(.center)
                Text(errorWrapper.guidance)
                    .font(.caption)
                Spacer()
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Dissmiss") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ErrorView_Previews: PreviewProvider {

    enum SampleError: Error {
        case errorRequired
    }

    static var wrapper: ErrorWrapper {
        ErrorWrapper(error: SampleError.errorRequired, guidance: "Thıs ıs just a sample error.")
    }

    static var previews: some View {
        ErrorView(errorWrapper: wrapper)
    }
}
