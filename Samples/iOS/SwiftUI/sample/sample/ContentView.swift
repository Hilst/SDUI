import SwiftUI
import SDUI

struct ContentView: View {
    var body: some View {
        VStack {
					Text(SDUI().text)
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
