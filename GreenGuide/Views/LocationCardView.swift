import SwiftUI

struct LocationCardView: View {
    let location: GreenLocation

    ////Turn the saved image text into a url for async image
    private var remoteImageURL: URL? {
        URL(string: location.imageURL)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ////try to load the attraction image from the CSV URL
            AsyncImage(url: remoteImageURL) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()

                case .failure, .empty:
                    // Show a placeholder if the image is missing
                    ZStack {
                        Color(.systemGray5)

                        Image(systemName: "photo")
                            .font(.system(size: 36))
                            .foregroundColor(.gray)
                    }

                @unknown default:
                    EmptyView()
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 220)
            .clipped()

            VStack(alignment: .leading, spacing: 10) {
                HStack(alignment: .top) {
                    Text(location.title)
                        .font(.headline)
                        .lineLimit(2)

                    Spacer()

                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)

                        Text(location.rating)
                            .font(.subheadline)
                    }
                }

                Text("\(location.county), Ireland")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)

                Text(location.category)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.green)
            }
            .padding(16)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
        .padding(.horizontal)
    }
}
