import SwiftUI

struct ContentView: View {
    @EnvironmentObject var router: Router
    @State private var scale: CGFloat = 4.0
    
    var body: some View {
        VStack (alignment: .center, spacing: 150) {
            Spacer()
            Label("PillBox", image: "")
                .foregroundStyle(LinearGradient(colors: [.gray, .black],
                                                startPoint: .leading, endPoint: .trailing))
                .frame(width: 300, height: 150)
                .scaleEffect(scale)
                .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                .background(Image("iconPillBox")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.5))
                .cornerRadius(32)
                .onAppear {
                    let baseAnimation = Animation.easeInOut(duration: 1.0)
                    let repeated = baseAnimation.repeatForever(autoreverses: true)
                    withAnimation(repeated) {
                        scale = 5
                    }
                }
            
            CustomButton(title: "Start") {
                router.navigate(to: .userTableView)
            }
            
            VStack {
                NavigationLink(String(localized: "Link")) {
                    InformationView(url: getURL())
                }
                .foregroundStyle(.black)
                .bold()
                .font(.system(size: 10))
            }
        }
    }
    
    private func getURL() -> URL {
        if Locale.current.language.languageCode?.identifier == "es" {
            return Bundle.main.url(forResource: "Privacidad", withExtension: "pdf")!
        } else {
            return Bundle.main.url(forResource: "Privacy", withExtension: "pdf")!
        }
    }
}

#Preview {
    ContentView()
}
