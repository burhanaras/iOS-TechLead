//
//  MeetingTimerView.swift
//  ScrumMaster
//
//  Created by Burhan Aras on 12.10.2022.
//

import SwiftUI

struct MeetingTimerView: View {

    let speakers: [ScrumTimer.Speaker]
    let theme: Theme
    let isRecording: Bool

    var currentSpeaker: String {
        speakers.first(where:  { !$0.isCompleted })?.name ?? "Nobody"
    }

    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack(spacing: 6) {
                    Text(currentSpeaker)
                        .font(.title)
                    Text("is speaking")
                    Image(systemName: isRecording ? "mic" : "mic.slash")
                        .font(.title)
                }
                .accessibilityElement(children: .combine)
                .foregroundStyle(theme.accentColor)
            }
            .overlay  {
                ForEach(speakers) { speaker in
                    if speaker.isCompleted, let index = speakers.firstIndex(where: { $0.id == speaker.id }) {
                        SpeakerArc(speakerIndex: index, totalSpeakers: speakers.count)
                            .rotation(Angle(degrees: -90))
                            .stroke(theme.mainColor, lineWidth: 12)

                    }
                }
            }
            .padding(.horizontal)
    }
}

struct MeetingTimerView_Previews: PreviewProvider {

    static var speakers: [ScrumTimer.Speaker] {
        [ScrumTimer.Speaker(name: "Bill", isCompleted: true),
         ScrumTimer.Speaker(name: "Cathy", isCompleted: false)]
    }

    static var previews: some View {
        MeetingTimerView(speakers: speakers, theme: Theme.purple, isRecording: true)
    }
}
