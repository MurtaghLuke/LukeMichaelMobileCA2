import SwiftUI

struct LocationCardView: View {
    let location: GreenLocation

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            AsyncImage(url: URL(string: location.imageURL)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Rectangle()
                    .fill(Color.green.opacity(0.15))
                    .overlay(ProgressView())
            }
            .frame(height: 230)
            .clipped()

            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text(location.title)
                        .font(.headline)

                    Spacer()

                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .foregroundColor(.yellow)

                        Text(location.rating)
                            .font(.subheadline)
                    }
                }

                Text("\(location.county), Ireland")
                    .foregroundColor(.gray)

                Text(location.category)
                    .font(.subheadline)
                    .foregroundColor(.green)
            }
            .padding()
            .background(Color.white)
        }
        .background(Color.white)
        .cornerRadius(18)
        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
        .padding(.horizontal)
    }
}
