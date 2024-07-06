//
//  ItemView.swift
//  4May2024
//
//  Created by Bryan Nguyen on 11/5/24.
//
import AVFoundation
import SwiftUI

struct dutchcountryside: View {
    @AppStorage ("playingMusic") private var isPlayingMusic = false
    @AppStorage ("Sound") private var savedSound = "Swaying%20Heartbeats"
    @AppStorage ("progres") private var progress = 0.0
    @AppStorage ("progres2") private var progress2 = 0.0
    var rgb2 = Color(red: 0.08, green: 0.1, blue: 0.11)
    func playAllSongs() {
                // Iterate over each song in the array and play audio
        
                    if let url = Bundle.main.url(forResource: "dutchcountryside", withExtension: "mp3") {
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
        ZStack{
            rgb2
            HStack{
                Button{
                    playAllSongs()
                    savedSound = "dutchcountryside"
                    progress -= progress
                    progress2 = 0.003
                    isPlayingMusic = true
                }label:{
                    Text("dutchcountryside")
                        .foregroundColor(.red)
                        .font(.title)
                        .padding()
                }
                Spacer()
                Text("0:30")
                    .padding()
            }
        }
    }
}

#Preview {
    superchill()
}
