import UIKit
import SwiftUI
import WebKit

@main
struct mercedesSimApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        WebView(url: "index.html")
            .ignoresSafeArea()
    }
}

struct WebView: UIViewRepresentable {
    let url: String
    
    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.uiDelegate = context.coordinator
        return webView
    }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        if let htmlPath = Bundle.main.path(forResource: url, ofType: nil) {
            let baseURL = URL(fileURLWithPath: htmlPath.deletingLastPathComponent())
            webView.loadFileURL(baseURL, allowingReadAccessTo: baseURL)
        }
    }
    
    func makeCoordinator() -> Coordinator { Coordinator() }
    
    class Coordinator: NSObject, WKUIDelegate {}
}
