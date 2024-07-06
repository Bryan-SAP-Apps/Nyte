import SwiftUI

struct ContentView: View {
    @State private var musicSelection = "Not Selected"
    @State private var selectedView = "NullView"
    @Environment(\.colorScheme) var colorScheme
    @State private var isDarkMode = true // Added state for dark mode toggle
    
    var body: some View {
        VStack {
            Picker("Music Category", selection: $selectedView){
                Text("Atmospheric Noise").tag("AtmosphericNoisesView")
                Text("Nice Songs").tag("NiceSongsView")
            }
            .pickerStyle(.segmented)
            .padding()
            
            if selectedView == "NullView" {
                NullView()
            } else if selectedView == "AtmosphericNoisesView" {
                AtmosphericNoisesView()
            } else if selectedView == "NiceSongsView" {
                NiceSongsView()
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light) // Apply preferred color scheme
    }
}

struct NullView: View {
    var body: some View {
        Spacer()
        Text("Nyte")
            .foregroundColor(.red)
            .font(.largeTitle)
        Spacer()
    }
}

struct AtmosphericNoisesView: View {
    var body: some View {
       AtmosphericNoiseView()
    }
}

struct NiceSongsView: View {
    //    @State private var songTitle = "Generic Song Title"
    //    @State private var songAuthor = "Generic Song Author"
    //    @State private var songSubtitle = "Generic Song Time"
    
    var body: some View {
        BottomSheetView()
    }
}
#Preview(){
    ContentView()
}
