import SwiftUI

struct ImageAndLabels: View {
    private let imageName: String
    private let title: LocalizedStringKey
    private let description: LocalizedStringKey
    
    init(imageName: String, title: LocalizedStringKey, description: LocalizedStringKey) {
        self.imageName = imageName
        self.title = title
        self.description = description
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Image(imageName)
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
                .clipShape(.circle)
            Text(title)
                .bold()
                .font(.title2)
                .multilineTextAlignment(.center)
            Text(description)
                .font(.callout)
                .multilineTextAlignment(.center)
        }
        .padding(50)
    }
}
