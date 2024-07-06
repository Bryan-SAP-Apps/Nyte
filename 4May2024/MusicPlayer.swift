import SwiftUI
import AVFoundation

class MusicPlayer {
    private var isPlaying = false
    private var stopRequested = false
    private var player: AVAudioPlayer?
    private let queue = DispatchQueue(label: "com.example.MusicPlayerQueue")
    @AppStorage ("Sound") private var savedSound = "Swaying%20Heartbeats"
    @AppStorage ("progres") private var progress = 0.0
    func loopSongs() {
        queue.async {
            var currentIndex = 0
            self.isPlaying = true

            while self.isPlaying {
                let song = BottomSheetView.songs[currentIndex]
                
               
                if let url = Bundle.main.url(forResource: song.title, withExtension: "mp3") {
                    do {
                        self.player = try AVAudioPlayer(contentsOf: url)
                        self.player?.play()
                        print("Playing: \(song.title)")
                        self.savedSound = song.title

                        // Wait for the current song to finish playing or until stop is requested
                        while self.player?.isPlaying == true && !self.stopRequested {
                            Thread.sleep(forTimeInterval: 0.1)
                        }
                        print(self.stopRequested)
                        // Check if stop was requested
                        if self.stopRequested {
                            self.player?.stop()
                            self.isPlaying = false
                            self.stopRequested = false
                            break
                        }

                        // Increment index to play the next song
                        self.progress -= self.progress
                        currentIndex = (currentIndex + 1) % BottomSheetView.songs.count
                    } catch {
                        print("Error playing audio for \(song.title): \(error.localizedDescription)")
                    }
                } else {
                    print("Audio file not found for \(song.title)")
                }
            }
        }
    }

    func stop() {
        print("stop here")
       
            self.stopRequested = true
       
    }
}

