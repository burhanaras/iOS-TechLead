//
//  MeetingFooterView.swift
//  ScrumMaster
//
//  Created by Burhan Aras on 1.10.2022.
//

import SwiftUI

struct MeetingFooterView: View {

    let speakers: [ScrumTimer.Speaker]
    var skipAction: () -> Void

    private var speakerNumber: Int? {
        let index = speakers.firstIndex { !$0.isCompleted }
        if let index = index {
            return index + 1
        }
        return nil
    }

    private var isLastSpeaker: Bool {
        speakers.dropLast().allSatisfy { $0.isCompleted }
    }

    private var speakerText: String {
        guard let speakerNumber = speakerNumber else { return "No more speakers" }
        return "Speaker \(speakerNumber) of \(speakers.count)"
    }

    var body: some View {
        VStack {
            HStack {
                if isLastSpeaker {
                    Text("Last speaker")
                } else {
                    Text("Speaker \(speakerNumber ?? 0) of \(speakers.count)")
                    Spacer()
                    Button {
                        skipAction()
                    } label: {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next speaker")
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}

struct MeetingFooterView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingFooterView(speakers: DailyScrum.sampleData[0].attendees.speakers,
                          skipAction: { })
    }
}
