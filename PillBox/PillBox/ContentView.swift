import SwiftUI

struct ContentView: View {
    //MARK: -Properties
    let letters = Array("Pillbox")
    @State private var rotation: Double = 0
    @State private var isSliding: Bool = false
    let slideGently = Animation.easeOut(duration: 1).delay(2).repeatForever(autoreverses: false).delay(-0.67)
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("iconPillBox")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .opacity(0.5)
                VStack (alignment: .center, spacing: 50){
                    HStack(spacing: 0) {
                        ForEach(0..<letters.count, id: \.self) { slide in
                            Text(String(letters[slide]))
                                .foregroundStyle(LinearGradient(colors: [.gray, .black], startPoint: .leading, endPoint: .trailing))
                                .font(.system(size: 100))
                                .bold()
                                .scaleEffect(isSliding ? 0.25 : 1)
                                .rotation3DEffect(.degrees(rotation), axis: (x: 0, y: -1, z: 0))
                                .opacity(isSliding ? 0 : 1)
                                .hueRotation(.degrees(isSliding ? 320 : 0))
                                .animation(.easeOut(duration: 1).delay(2).repeatForever(autoreverses: false).delay(Double(-slide) / 20), value: isSliding)
                            
                        }
                    }
                    .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                    .cornerRadius(32)
                    
                    NavigationLink {
                        UserTableView(userTableViewModel: UserTableViewModel())
                    } label: {
                        Text("Comenzar")
                            .font(.system(size: 25))
                            .bold()
                            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                            .foregroundColor(.white)
                            .background(.black)
                            .cornerRadius(30)
                    }
                }
                .onAppear {
                    isSliding = true
                    rotation = 360
                }
            }
        }
    }
}
#Preview {
    ContentView()
}
