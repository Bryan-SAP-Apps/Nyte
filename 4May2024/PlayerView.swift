import SwiftUI
import UIKit
import AVFoundation

struct Music: Identifiable, Hashable {
    let title: String
    let id = UUID()
    let artist: String
}


var player: AVAudioPlayer!
let musicPlayer = MusicPlayer()

struct BottomSheetView: View {
    @State private var loop = "repeat"
    @State private var ifLoop = false
    @State private var timerSeconds2 = 0
    @AppStorage ("timerSecond") private var timerSeconds: Int = UserDefaults.standard.integer(forKey: "timerSeconds")
    @AppStorage ("playingMusic") private var isPlayingMusic = false
    @AppStorage ("progres") private var progress = 0.0
    //    @State private var progress: CGFloat = 0.0
    @AppStorage ("progres2") private var progress2 = 0.0
    @State private var time = 0.0
    @State private var startingval = 0.0
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    @Environment(\.colorScheme) var colorScheme
    @State private var isDarkMode = false
    @State private var shuffledSongs: [Music] = []
    @State private var currentIndex: Int = 0
    @State private var coordinator: Coordinator?
    @AppStorage ("Sound") private var savedSound = "Swaying%20Heartbeats"
    var rgb = Color(red:4.6, green: 0.1, blue: 0.3)
    var rgb2 = Color(red: 0.08, green: 0.1, blue: 0.11)
    
    @State private var showSheet = false
    static var songs = [Music(title:"SwayingHeartbeats", artist: "Samuel"),Music(title:"BossNow!", artist: "Samuel"), Music(title: "superchill", artist: "Samuel")]
    
    
    let firstSong = songs.first
    func playAllSongs() {
                // Iterate over each song in the array and play audio
        
                    if let url = Bundle.main.url(forResource: savedSound, withExtension: "mp3") {
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
    func playNextSong() {
        let nextIndex = (currentIndex + 1) % BottomSheetView.songs.count
        
        let song = BottomSheetView.songs[nextIndex]
        
        if let url = Bundle.main.url(forResource: song.title, withExtension: "mp3") {
            do {
                // Create AVAudioPlayer instance and play the audio
                player = try AVAudioPlayer(contentsOf: url)
                player.play()
                savedSound = song.title
                print("Playing: \(song.title)")
                
                // Update currentIndex to the next song index
                currentIndex = nextIndex
            } catch {
                print("Error playing audio for \(song.title): \(error.localizedDescription)")
            }
        } else {
            print("Audio file not found for \(song.title)")
        }
    }
    func playPreviousSong() {
            let previousIndex = (currentIndex - 1 + BottomSheetView.songs.count) % BottomSheetView.songs.count
            
            let song = BottomSheetView.songs[previousIndex]
            
            if let url = Bundle.main.url(forResource: song.title, withExtension: "mp3") {
                do {
                    // Initialize the AVAudioPlayer instance and play the audio
                    player = try AVAudioPlayer(contentsOf: url)
                    player?.play()
                    savedSound = song.title
                    print("Playing: \(song.title)")
                    
                    // Update currentIndex to the previous song index
                    currentIndex = previousIndex
                } catch {
                    print("Error playing audio for \(song.title): \(error.localizedDescription)")
                }
            } else {
                print("Audio file not found for \(song.title)")
            }
        }
    // This plays each songs individually
    func loopSongs() {
        var currentIndex = 0
        
        // Create an infinite loop using while true
        while true {
            let song = BottomSheetView.songs[currentIndex]
            
            if let url = Bundle.main.url(forResource: song.title, withExtension: "mp3") {
                do {
                    // Create AVAudioPlayer instance and play the audio
                    let player = try AVAudioPlayer(contentsOf: url)
                    player.play()
                    print("Playing: \(song.title)")
                    
                    // Wait for the current song to finish playing
                    Thread.sleep(forTimeInterval: player.duration)
                    
                    // Increment index to play the next song
                    currentIndex = (currentIndex + 1) % BottomSheetView.songs.count
                } catch {
                    print("Error playing audio for \(song.title): \(error.localizedDescription)")
                }
            } else {
                print("Audio file not found for \(song.title)")
            }
        }
    }
    func startShufflePlay() {
        // Shuffle the songs array
        
        shuffledSongs = BottomSheetView.songs.shuffled()
        
        // Start playing the first song
        playSong(at: currentIndex)
    }
    func playSong(at index: Int) {
        guard index < shuffledSongs.count else {
            // All songs have been played, stop playback
            return
        }
        
        let song = shuffledSongs[index]
        
        if let url = Bundle.main.url(forResource: song.title, withExtension: "mp3") {
            do {
                // Create AVAudioPlayer instance and play the audio
                player = try AVAudioPlayer(contentsOf: url)
                player?.delegate = coordinator // Set AVAudioPlayer delegate for playback completion
                player?.play()
                print("Playing: \(song.title)")
                savedSound = song.title
                // Update currentIndex to play the next song after current song finishes
                currentIndex += 1
            } catch {
                print("Error playing audio for \(song.title): \(error.localizedDescription)")
            }
        } else {
            print("Audio file not found for \(song.title)")
        }
    }
    func formattedTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
    class Coordinator: NSObject, AVAudioPlayerDelegate {
        var view: BottomSheetView
        
        init(view: BottomSheetView) {
            self.view = view
        }
        
        func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
            // Play the next song when current song finishes
            view.playSong(at: view.currentIndex)
        }
    }
    
    var body: some View {
        VStack{
            
            
            VStack{
                ZStack{
                    VStack{
                        superchill()
                        SwayingHeartbeats()
                        BossNow()
                    }.padding()
                }
            }
            
            //            ZStack(alignment: .bottom){
            //                /*@START_MENU_TOKEN@*/Text("Placeholder")/*@END_MENU_TOKEN@*/
            //            }
            //            Text("hello")
            //            Text("hello")
            VStack{
                ZStack{
                    rgb2
                    VStack{
                        
                        Spacer()
                        HStack{
                            Spacer()
                            Button{
                                showSheet = true
                            }label:{
                                HStack{
                                    Image(systemName: "timer")
                                        .frame(width: 30, height: 30)
                                   
                                    Text("\(formattedTime(timerSeconds))")
                                        .padding(_:5)
                                }
                               
                                
                            }
                            
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .position(x:325)

                        }
                        .padding()
                        .sheet(isPresented: $showSheet) {
                            TimerView()
                                .presentationDetents([.medium, .large])
                        }
                        Text(savedSound)
                            .foregroundColor(.red)
                            .font(.system(size: 40, weight: .bold))
                            .bold(true)
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 10.0)
                                .frame(width: 300, height: 10)
                                .opacity(0.3)
                                .foregroundColor(.red)
                                .background {
                                    Color.red.opacity(0.3)
                                        .ignoresSafeArea()
                                }
                                .position(x:200,y:380)
                            
                            
                            RoundedRectangle(cornerRadius: 10.0)
                                .frame(width: progress * 300 + startingval, height: 15)
                                .foregroundColor(.red)
                                .animation(.easeInOut, value: progress)
                                .mask(
                                    RoundedRectangle(cornerRadius: 10.0)
                                        .frame(width: 300, height: 100)
                                )
                                .offset(x:54)
                            
                            
                        }
                        .onReceive(timer) { _ in
                            if progress < 10.0{
                                startingval = 10.0
                            }
                            if progress < 1.0 {
                                var movement = 1/1000*time
                                //for movement in time{
                                //  progress += 0.001
                                //}
                                progress += progress2
                            }
                        }
                        
                        //                        Button{
                        //                            startShufflePlay()
                        //                            print("\(firstSong?.title)")
                        //                            progress2 = 0.003
                        //                        }label:{
                        //                            Text("shuffle play")
                        //                        }.onAppear {
                        //                            coordinator = Coordinator(view: self)
                        //                        }

                        VStack{
                            
                            HStack{
                                Button{
                                    musicPlayer.stop()
                                    ifLoop = false
                                    isPlayingMusic = true
                                    progress -= progress
                                    progress2 = 0.003
                                    startShufflePlay()
                                }label:{
                                    Image(systemName: "shuffle")
                                        .font(.largeTitle) // Adjust the size of the icon
                                        .foregroundColor(.red) // Change the color of the icon
                                         
                                        .padding()
                                        
//                                        .frame(width: 25, height: 30)
                                }
                                Button{
                                    ifLoop = false
                                    musicPlayer.stop()
                                    progress -= progress
                                    progress2 = 0.003
                                    
                                    playPreviousSong()
                                }label:{
                                    Image(systemName: "backward.fill")
                                                    .font(.largeTitle) // Adjust the size of the icon
                                                    .foregroundColor(.red) // Change the color of the icon
                                                     // Rotate the triangle to point left
                                                    .padding()
                                        
//                                        .frame(width: 25, height: 30)
                                }
                                Button{
                                    musicPlayer.stop()
                                    playingMusic()
                                }label: {
                                    ZStack {
                                                   Circle()
                                                       .fill(Color.red) // Background circle color
                                                       .frame(width: 50, height: 50)
                                                       // Adjust the size of the circle
                                                   
                                                   Image(systemName: isPlayingMusic ? "stop.fill" : "play.fill")
                                                       .font(.system(size: 35)) // Adjust the size of the icon
                                                       .foregroundColor(.white)// Icon color
                                               }
                                }.onAppear {
                                    coordinator = Coordinator(view: self)
                                }
                                           
                               
                                Button{
                                    ifLoop = false
                                    musicPlayer.stop()
                                    progress -= progress
                                    progress2 = 0.003
                                    
                                    playNextSong()
                                }label:{
                                    Image(systemName: "forward.fill")
                                                    .font(.largeTitle) // Adjust the size of the icon
                                                    .foregroundColor(.red) // Change the color of the icon
                                                     // Rotate the triangle to point left
                                                    .padding()
//
                                }
                                Button{
                                    isPlayingMusic = true
                                    player?.stop()
                                    progress -= progress
                                    progress2 = 0.003
                                    musicPlayer.loopSongs()
                                    ifLoop = true
                                   
                                }label:{
                                    
                                    Image(systemName: loop)
                                        .font(.largeTitle) // Adjust the size of the icon
                                        .foregroundColor(.red) // Change the color of the icon
                                    
                                        .padding()
//
//                                        .frame(width: 25, height: 30)
                                }
                                
                                
                            }.padding()
                            Spacer()
                            Text("WE ARE MEWING DABYS")
                                .foregroundColor(Color(red: 0.08, green: 0.1, blue: 0.11))
                        }
                        
                        //                        Button{
                        //                            player.stop()
                        //                            musicPlayer.stop()
                        //                            progress2 = 0.0
                        //                            print("hello stop button")
                        //                        }label:{
                        //                            Text("stop")
                    }
                    
                    Spacer()
                    //                        Spacer()
                }
            }
            
        }
    }
    //    }
    
    private func playingMusic() {
        if isPlayingMusic {
            player?.stop()
            musicPlayer.stop()
            progress2 = 0.0
            ifLoop = false
            isPlayingMusic = false // Uncommented to maintain the state
        } else {
            if let songTitle = firstSong?.title {
                print(songTitle)
                progress2 = 0.003
                isPlayingMusic = true
                playAllSongs()// Uncommented to maintain the state
            } else {
                print("No song available to play.")
                // Handle the case where firstSong is nil
            }
        }
    }
}
#Preview{
    BottomSheetView()
}
