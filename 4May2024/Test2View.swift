import Foundation

class TimerState: ObservableObject {
    @Published var timerSeconds: Int {
        didSet {
            UserDefaults.standard.set(timerSeconds, forKey: "timerSeconds")
        }
    }
    @Published var isTimerRunning: Bool {
        didSet {
            UserDefaults.standard.set(isTimerRunning, forKey: "isTimerRunning")
        }
    }
    
    init() {
        self.timerSeconds = UserDefaults.standard.integer(forKey: "timerSeconds")
        self.isTimerRunning = UserDefaults.standard.bool(forKey: "isTimerRunning")
    }
    
    func reset() {
        timerSeconds = 0
        isTimerRunning = false
        UserDefaults.standard.removeObject(forKey: "timerSeconds")
        UserDefaults.standard.removeObject(forKey: "isTimerRunning")
    }
}
