import SwiftUI
import SafariServices

struct SignInView: View {
    @State private var showWebView = false
    @State private var showSignInWebView = false  // New state for sign in button
    
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // App Logo/Title
                Image(systemName: "lock.shield")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                    .padding(.bottom, 20)
                
                Text("TONIC")
                    .font(.title)
                    .bold()
                
                // Google Sign In Button
                Button(action: {
                    showSignInWebView = true  // Show sign in web view
                }) {
                    HStack {
                        Image(systemName: "globe")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("Sign in with Google")
                            .font(.headline)
                    }
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white)
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
                        .foregroundColor(.blue)
                }
                .padding(.top, 10)
            }
        }
        // Sheet for sign up
        .sheet(isPresented: $showWebView) {
            SafariView(url: URL(string: "https://support.google.com/mail/answer/56256?hl=en")!)
        }
        // Sheet for sign in
        .sheet(isPresented: $showSignInWebView) {
            SafariView(url: URL(string: "https://accounts.google.com/signin")!)
        }
    }
}

// Keep your SafariView struct the same
struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
