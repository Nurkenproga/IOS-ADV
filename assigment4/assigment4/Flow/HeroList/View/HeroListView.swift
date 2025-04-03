import SwiftUI

struct HeroListView: View {
    @StateObject var viewModel: HeroListViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.filteredHeroes) { model in
                    heroCard(model: model)
                }
            }
            .navigationTitle("Heroes")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $viewModel.searchText, prompt: "Search heroes")
            .task {
                await viewModel.fetchHeroes()
            }
        }
    }
}

extension HeroListView {
    @ViewBuilder
    private func heroCard(model: HeroListModel) -> some View {
        HStack {
            AsyncImage(url: model.heroImage) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.trailing, 12)
                default:
                    Color.gray
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(.trailing, 12)
                }
            }

            VStack(alignment: .leading) {
                Text(model.title)
                    .font(.headline)
                Text(model.description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
        }
        .padding(.vertical, 4)
        .contentShape(Rectangle())
        .onTapGesture {
            viewModel.routeToDetail(by: model.id)
        }
    }
}
