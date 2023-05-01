
import SwiftUI

@main
struct HoloApp: App {
    
    @StateObject var vm = ViewModel(api: ChatGPTAPI(apiKey: "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"))
    @State var isShowingTokenizer = false
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView(vm: vm)
                    .toolbar {
                        ToolbarItem {
                            Button("Clear") {
                                vm.clearMessages()
                            }
                            .disabled(vm.isInteractingWithChatGPT)
                        }
                        
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Tokenizer") {
                                self.isShowingTokenizer = true
                            }
                            .disabled(vm.isInteractingWithChatGPT)
                        }
                    }
            }
            .fullScreenCover(isPresented: $isShowingTokenizer) {
                NavigationTokenView()
            }
        }
    }
}


struct NavigationTokenView: View {
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            TokenizerView()
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Close") {
                            dismiss()
                        }
                    }
                }
        }
        .interactiveDismissDisabled()
    }
}


