import SwiftUI

struct LocationCardView: View {
    let location: GreenLocation

    var body: some View {

        VStack(alignment: .leading, spacing: 0) {

            AsyncImage(url: URL(string: location.imageURL)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()

                default:
                    Image("cottage")
                        .resizable()
                        .scaledToFill()
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

//                Text(location.category)
//                    .font(.subheadline)
//                    .fontWeight(.semibold)
//                    .foregroundColor(.green)
            }
            .padding(16)
        }
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.08), radius: 8, x: 0, y: 4)
        .padding(.horizontal)
    }
}
