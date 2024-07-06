//
//  ItemView.swift
//  4May2024
//
//  Created by Bryan Nguyen on 11/5/24.
//
import AVFoundation
import SwiftUI

struct brewingcoffee: View {
    @AppStorage ("Sound") private var savedSound = "Swaying%20Heartbeats"
    func playAllSongs() {
                // Iterate over each song in the array and play audio
        
                    if let url = Bundle.main.url(forResource: "brewingcoffee", withExtension: "mp3") {
                        do {
                            // Create AVAudioPlayer instance and play the audio
                            player = try AVAudioPlayer(contentsOf: url)
                            player?.play()
                            print("Playing: SC ")
                        } catch {
                            print("Error playing audio for : \(error.localizedDescription)")
                        }
                    } else {
                        print("Audio file not found for ")
                    }
            }
    var body: some View {
        HStack{
            Button{
                playAllSongs()
                savedSound = "brewingcoffee"
            }label:{
                Text("brewingcoffee")
                    .font(.title)
                    .padding()
            }
            Spacer()
            Text("0:30")
                .padding()
        }
    }
}

#Preview {
    superchill()
}
