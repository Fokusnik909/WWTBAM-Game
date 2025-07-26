import SwiftUI

struct AudienceHelpView: View {
    let answers: [(letter: String, percentage: Int)]
    @State private var animateGraphs = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Audience Answers")
                .font(.system(size: 20, weight: .bold))
            
            HStack(alignment: .bottom, spacing: 20) {
                ForEach(answers, id: \.letter) { item in
                    VStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.blue)
                            .frame(
                                width: 40,
                                height: animateGraphs ? CGFloat(item.percentage * 2) : 0
                            )
                            .animation(
                                .spring(duration: 0.7, bounce: 0.3).delay(0.02 * Double(item.percentage)),
                                value: animateGraphs
                            )
                        
                        Text(item.letter)
                            .font(.headline)
                        
                        Text("\(item.percentage)%")
                            .font(.caption)
                    }
                }
            }
            .frame(height: 200)
            .padding(.horizontal)
            
            Text("Most voted: \(answers.max(by: { $0.percentage < $1.percentage })?.letter ?? "")")
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
    AudienceHelpView(answers: [
        ("A", 15),
        ("B", 70),
        ("C", 10),
        ("D", 5)
    ])
    .padding()
}
