import SwiftUI
import SafariServices

// Color extension for hex values
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}

struct LoginScreen: View {
    @State private var showWebView = false
    @State private var showSignInWebView = false
    @State private var navigateToIntro = false
        
    var body: some View {
        NavigationStack() {
            ZStack {
                Image("background-image")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
                
                VStack() {
                    // Google Sign In Button
                    Button(action: {
                        showSignInWebView = true
                        
                    }) {
                        HStack {
                            Image("White Google")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("Continue with Google")
                                .font(.headline)
                        }
                        .foregroundColor(.white)  // Changed to white for better contrast
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(hex: "FC8F21"))  // Changed to your hex color
                        .cornerRadius(8)
                        .shadow(radius: 2)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                        )
                    }
                    .padding(.horizontal, 40)
                    
                    // Sign up text with in-app web popup
                    Button(action: {
                        showWebView = true
                    }) {
                        Text("Don't have a Google account? Sign Up")
                            .foregroundColor(Color(hex: "FC8F21"))  // Also updated this to match
                    }
                    .padding(.top, 10)
                }
                .offset(y: 190)
            }
            // Sheet for sign up
            .sheet(isPresented: $showWebView) {
                SafariView(url: URL(string: "https://support.google.com/mail/answer/56256?hl=en")!)
            }
            // Sheet for sign in
            .sheet(isPresented: $showSignInWebView, onDismiss: {
                navigateToIntro = true
            }) {
                SafariView(url: URL(string: "https://accounts.google.com/signin")!)
            }
            .navigationDestination(isPresented: $navigateToIntro) {
                IntroduceScreenOne(user: nil)
            }
        }
        
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
