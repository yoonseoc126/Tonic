//import SwiftUI
//
//struct PullUpView<Content: View>: View {
//    let minHeight: CGFloat
//    let maxHeight: CGFloat
//    let content: Content
//    @Binding var isOpen: Bool
//    @GestureState private var translation: CGFloat = 0
//    
//    private var offset: CGFloat {
//        isOpen ? 0 : maxHeight - minHeight
//    }
//    
//    init(minHeight: CGFloat, maxHeight: CGFloat, isOpen: Binding<Bool>, @ViewBuilder content: () -> Content) {
//        self.minHeight = minHeight
//        self.maxHeight = maxHeight
//        self._isOpen = isOpen
//        self.content = content()
//    }
//    
//    var body: some View {
//        GeometryReader { geometry in
//            VStack(spacing: 0) {
//                // Pull indicator
//                RoundedRectangle(cornerRadius: 3)
//                    .fill(Color.gray.opacity(0.5))
//                    .frame(width: 40, height: 5)
//                    .padding(.top, 8)
//                    .padding(.bottom, 8)
//                
//                // Content
//                content
//                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//            }
//            .frame(height: maxHeight)
//            .frame(maxWidth: .infinity)
//            .background(
//                RoundedRectangle(cornerRadius: 20)
//                    .fill(Color(.systemBackground))
//                    .shadow(radius: 10)
//            )
//            .offset(y: max(offset + translation, 0))
//            .animation(.interactiveSpring(), value: isOpen)
//            .animation(.interactiveSpring(), value: translation)
//            .gesture(
//                DragGesture()
//                    .updating($translation) { value, state, _ in
//                        state = value.translation.height
//                    }
//                    .onEnded { value in
//                        let snapDistance = maxHeight * 0.25
//                        let velocity = CGSize(
//                            width: value.predictedEndLocation.x - value.location.x,
//                            height: value.predictedEndLocation.y - value.location.y
//                        ).height / value.time.timeInterval
//                        
//                        if abs(value.translation.height) > snapDistance || abs(velocity) > 700 {
//                            isOpen = value.translation.height < 0
//                        }
//                    }
//            )
//        }
//    }
//}
//
//
//struct Profile: View {
//    @State private var isSheetOpen = false
//    
//    var body: some View {
//        ZStack {
//            // Main content
//            Color.blue.opacity(0.3)
//                .ignoresSafeArea()
//            
//            VStack {
//                Spacer()
//                
//                Button("Toggle Sheet") {
//                    withAnimation {
//                        isSheetOpen.toggle()
//                    }
//                }
//                .padding()
//                .background(Color.white)
//                .cornerRadius(10)
//                
//                Spacer()
//                    .frame(height: 100)
//            }
//            
//            // Pull-up sheet
//            VStack {
//                Spacer()
//                PullUpView(
//                    minHeight: 100,
//                    maxHeight: UIScreen.main.bounds.height * 0.7,
//                    isOpen: $isSheetOpen
//                ) {
//                    VStack {
//                        Text("Pull Up Sheet")
//                            .font(.title)
//                            .padding()
//                        
//                        ScrollView {
//                            VStack(spacing: 20) {
//                                ForEach(0..<20) { index in
//                                    Text("Item \(index)")
//                                        .frame(maxWidth: .infinity)
//                                        .padding()
//                                        .background(Color.gray.opacity(0.1))
//                                        .cornerRadius(10)
//                                }
//                            }
//                            .padding()
//                        }
//                    }
//                }
//            }
//            .ignoresSafeArea(edges: .bottom)
//        }
//    }
//}
//
//// Preview
//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        Profile()
//    }
//}
