import SwiftUI
  
struct ContentView: View {
    @ObservedObject private var viewModel = BusViewModel()

    var body: some View {
        NavigationView {
            VStack {
                List(viewModel.busLines) { busLine in
                    NavigationLink(destination: BusStopsView(busLine: busLine)) {
                        VStack(alignment: .leading) {
                            Text("\(busLine.number)").font(.title)
                        }
                    }
                }
                .navigationBarTitle("Bus Lines 🚌")
                .onAppear() {
                    self.viewModel.fetchData()
                }

                Spacer()
                
                Text("Choose your bus number")
                    .font(.title)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 20)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
                    .frame(maxWidth: .infinity) 
            }
        }
    }
}



















