import SwiftUI
import Kingfisher

struct BouncingView: View {
    @State var bouncy: [Bouncy]
    @AppStorage("gameHardMode") var hardMode: Bool = false

    var body: some View {
        GeometryReader { geometry in
            ForEach(0..<bouncy.count) { index in
                VStack {
                    if let imageUrl = URL(string: "https://kirreth.pockethost.io/api/files/\(bouncy[index].ingredient.collectionId)/\(bouncy[index].ingredient.id)/\(bouncy[index].ingredient.image)") {
                        KFImage(imageUrl)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    } else {
                        Image("appLogo").resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                    }


                    if !hardMode {
                        Text(bouncy[index].ingredient.name)
                            .font(.Bold.regular)
                    }
                }
                .frame(height: 50)
                .position(bouncy[index].position)
                .onAppear {
                    bouncy[index].timer = startTimer(size: geometry.size, index: index)
                }
                .onDisappear {
                    bouncy[index].timer?.invalidate()
                }
            }
        }
    }

    private func startTimer(size: CGSize, index: Int)-> Timer {
        return Timer.scheduledTimer(withTimeInterval: 0.04, repeats: true) { _ in
            updatePosition(for: size, index: index)
        }
    }

    private func updatePosition(for size: CGSize, index: Int) {
        var newPosition = CGPoint(
            x: bouncy[index].position.x + bouncy[index].velocity.width,
            y: bouncy[index].position.y + bouncy[index].velocity.height
        )

        //horizontalEdges
        if newPosition.x < 25 || newPosition.x > size.width - 25 {
            bouncy[index].velocity.width = -bouncy[index].velocity.width
            newPosition.x = max(25, min(newPosition.x, size.width - 25))
        }

        // verticalEdges
        if newPosition.y < 25 || newPosition.y > size.height - 25 {
            bouncy[index].velocity.height = -bouncy[index].velocity.height
            newPosition.y = max(25, min(newPosition.y, size.height - 25))
        }

        withAnimation(.linear(duration: 0.04)) {
            bouncy[index].position = newPosition
        }
    }
}
