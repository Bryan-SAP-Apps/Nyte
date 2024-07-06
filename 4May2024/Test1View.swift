import SwiftUI
import UIKit
import AVFoundation

struct TimerView: View {
    @AppStorage ("progres2") private var progress2 = 0.0
    @State private var userInput: String = ""
    @AppStorage ("timerSecond") private var timerSeconds: Int = UserDefaults.standard.integer(forKey: "timerSeconds")
    @State private var isTimerRunning: Bool = UserDefaults.standard.bool(forKey: "isTimerRunning")
    @State private var timer: Timer?
    @State private var backgroundTaskID: UIBackgroundTaskIdentifier = .invalid
    @State private var audioPlayer: AVAudioPlayer?

    var body: some View {
        VStack {
            TextField("Enter time in seconds", text: $userInput)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Text("Timer: \(formattedTime(timerSeconds))")
                .font(.largeTitle)
                .padding()
            
            HStack {
                Button("Start") {
                    startTimer()
                }
                .padding()
                
                Button("Pause") {
                    pauseTimer()
                }
                .padding()
                
                Button("Reset") {
                    resetTimer()
                }
                .padding()
            }
        }
        .onAppear {
            if self.isTimerRunning {
                self.resumeTimer()
            }
        }
        .onDisappear {
            if self.isTimerRunning {
                self.saveTimerState()
            }
        }
    }
    
    func startTimer() {
        guard let timeInput = Int(userInput), timeInput > 0 else { return }
        
        timerSeconds = timeInput
        isTimerRunning = true
        saveTimerState()
        
        // Start the background task
        backgroundTaskID = UIApplication.shared.beginBackgroundTask { [self] in
            self.endBackgroundTask()
        }
        
        // Start the timer
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.timerSeconds > 0 && self.isTimerRunning {
                self.timerSeconds -= 1
                self.saveTimerState()
            } else {
                self.timer?.invalidate()
                self.timer = nil
                self.isTimerRunning = false
                self.saveTimerState()
                self.stopSound()
                self.endBackgroundTask()
            }
        }
    }
    
    func pauseTimer() {
        isTimerRunning = false
        timer?.invalidate()
        timer = nil
        saveTimerState()
    }
    
    func resetTimer() {
        isTimerRunning = false
        timerSeconds = 0
        userInput = ""
        timer?.invalidate()
        timer = nil
        endBackgroundTask()
        UserDefaults.standard.removeObject(forKey: "timerSeconds")
        UserDefaults.standard.removeObject(forKey: "isTimerRunning")
    }
    
    func resumeTimer() {
        if isTimerRunning && timerSeconds > 0 {
            // Start the background task
            backgroundTaskID = UIApplication.shared.beginBackgroundTask { [self] in
                self.endBackgroundTask()
            }
            
            // Start the timer
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                if self.timerSeconds > 0 && self.isTimerRunning {
                    self.timerSeconds -= 1
                    self.saveTimerState()
                } else {
                    self.timer?.invalidate()
                    self.timer = nil
                    self.isTimerRunning = false
                    self.saveTimerState()
                    self.stopSound()
                    self.endBackgroundTask()
                }
            }
        }
    }
    
    func saveTimerState() {
        UserDefaults.standard.set(timerSeconds, forKey: "timerSeconds")
        UserDefaults.standard.set(isTimerRunning, forKey: "isTimerRunning")
    }
    
    func endBackgroundTask() {
        DispatchQueue.main.async {
            if self.backgroundTaskID != .invalid {
                UIApplication.shared.endBackgroundTask(self.backgroundTaskID)
                self.backgroundTaskID = .invalid
            }
        }
    }
    
    func formattedTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let remainingSeconds = seconds % 60
        return String(format: "%02d:%02d", minutes, remainingSeconds)
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm", withExtension: "mp3") else {
            print("Sound file not found")
            return
        }

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    func stopSound(){
        player.stop()
        musicPlayer.stop()
        progress2 = 0
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
