import SwiftUI

struct AudienceHelpView: View {
    let answers: [Int]
    @State private var animateGraphs = false
    private let letters = ["A", "B", "C", "D"]
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Audience Answers")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
            
            HStack(alignment: .bottom, spacing: 20) {
                ForEach(0..<4, id: \.self) { index in
                    VStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.blue)
                            .frame(
                                width: 40,
                                height: animateGraphs ? CGFloat(answers[index] * 2) : 0
                            )
                            .animation(
                                .spring(duration: 0.7, bounce: 0.3)
                                    .delay(0.02 * Double(answers[index])),
                                value: animateGraphs
                            )
                        
                        Text(letters[index])
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.black)
                        
                        Text("\(answers[index])%")
                            .font(.caption)
                            .foregroundColor(.black)
                    }
                }
            }
            .frame(height: 200)
            .padding(.horizontal)
            
            let maxIndex = answers.enumerated()
                .max(by: { $0.element < $1.element })?
                .offset ?? 0
            
            Text("Most voted: \(letters[maxIndex])")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.black)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(20)
        .shadow(radius: 10)
        .onAppear {
            animateGraphs = true
        }
    }
}

#Preview {
    AudienceHelpView(answers: [15, 70, 10, 5])
        .padding()
}
