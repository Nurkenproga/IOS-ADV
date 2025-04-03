import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ImagesViewModel()

    var body: some View {
        VStack(spacing: 16) {
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(viewModel.images) { model in
                        model.image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(12)
                            .shadow(radius: 5) 
                            .padding(.horizontal)
                    }
                }
                .padding(.top, 8)
            }
            .onAppear{
                viewModel.getImages()
            }
            .scrollIndicators(.hidden)

            Button(action: {
                viewModel.getImages()
            }) {
                Text("Load Random Images")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
}

// MARK: - Preview
#Preview {
    ContentView()
}
