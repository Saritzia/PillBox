import SwiftUI

struct ContentView: View {
    @EnvironmentObject var router: Router
    @State private var scale: CGFloat = 4.0
    
    var body: some View {
        VStack (alignment: .center, spacing: 150) {
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
        }
    }
}

#Preview {
    ContentView()
}
