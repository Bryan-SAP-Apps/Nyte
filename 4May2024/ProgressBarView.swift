import SwiftUI
import Combine

struct ProgressBarView: View {
  @State private var progress: CGFloat = 0.0
    @State private var time = 0.0
    @State private var startingval = 0.0
  let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()

  var body: some View {
    ZStack(alignment: .leading) {
        RoundedRectangle(cornerRadius: 10.0)
        .frame(width: 300, height: 10)
        .opacity(0.3)
        .foregroundColor(.red)
        .position(x:195,y:380)


        RoundedRectangle(cornerRadius: 10.0)
        .frame(width: progress * 300 + startingval, height: 10)
        .foregroundColor(.red)
        .animation(.easeInOut, value: progress)
        .mask(
            RoundedRectangle(cornerRadius: 10.0)
                .frame(width: 300, height: 10)
            )
        .offset(x:45)


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
            progress += 0.003
      }
    }
  }
}
#Preview {
    ProgressBarView()
}
