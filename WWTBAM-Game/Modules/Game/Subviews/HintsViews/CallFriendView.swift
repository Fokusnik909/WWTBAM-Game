import SwiftUI

struct CallFriendView: View {
    let answer: String
    @State private var showAnswer = false
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "phone")
                .font(.system(size: 50))
                .foregroundColor(.blue)
            
            Text("Calling friend...")
                .font(.title3)
                .opacity(showAnswer ? 0 : 1)
                .animation(.easeOut(duration: 0.3), value: showAnswer)
            
            if showAnswer {
                VStack(spacing: 10) {
                    Text("Friend thinks the answer is:")
                        .font(.headline)
                        .transition(.opacity)
                    
                    Text(answer)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.green)
                }
            }
        }
        .padding(25)
        .background(Color(.white).opacity(0.8))
        .cornerRadius(20)
        .shadow(radius: 10)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.6)) {
                    showAnswer = true
                }
            }
        }
    }
}

#Preview {
    CallFriendView(answer: "B")
}
