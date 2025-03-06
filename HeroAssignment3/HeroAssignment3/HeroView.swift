//
//  HeroView.swift
//  HeroAssignment3
//
//  Created by Nurken on 05.03.2025.
//

import SwiftUI

struct HeroView: View {
    @ObservedObject var viewModel: HeroViewModel

    var body: some View {
        VStack {
            AsyncImage(url: viewModel.selectedHero?.imageUrl) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 300, height: 300)
                case .success(let image):
                    image
                        .resizable()
                        .frame(height: 300)
                case .failure(let error):
                    Color.red
                        .frame(height: 300)
                }
            }
            .padding(32)

            Spacer()
            
            Group{
                Text(viewModel.selectedHero?.name ?? "Unknown")
                Text(viewModel.selectedHero?.appearance?.gender ?? "Unknown")
                Text(viewModel.selectedHero?.appearance?.race ?? "Unknown")
                Text(viewModel.selectedHero?.biography?.fullName ?? "Unknown")
                Text(viewModel.selectedHero?.biography?.placeOfBirth ?? "Unknown")
                Text(viewModel.selectedHero?.biography?.publisher ?? "Unknown")
            }
            .font(.title)
            .multilineTextAlignment(.center)
            
            Spacer()

            Button {
                Task {
                    await viewModel.fetchHero()
                }
            } label: {
                Text("Roll Hero")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }

        }
    }
}

#Preview {
    var viewModel = HeroViewModel()
    HeroView(viewModel: viewModel)
}
