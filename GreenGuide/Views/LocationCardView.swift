import SwiftUI

struct LocationCardView: View {
    let location: Location

    var body: some View {
        VStack(alignment: .leading) {
            Image(location.imageName)
                .resizable()
                .scaledToFill()
                .frame(height: 180)
                .clipped()

            Text(location.name)
                .font(.headline)
                .padding()
        }
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 4)
        .padding(.horizontal)
    }
}
