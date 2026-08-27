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
        MercedesWebView()
            .ignoresSafeArea()
    }
}

struct MercedesWebView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator { Coordinator() }

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.uiDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = false

        // index.html 及其引用图片都在 Bundle 的 Resources/ 子目录
        if let htmlURL = Bundle.main.url(forResource: "index", withExtension: "html", subdirectory: "Resources") {
            webView.loadFileURL(htmlURL, allowingReadAccessTo: htmlURL.deletingLastPathComponent())
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}

    final class Coordinator: NSObject, WKUIDelegate {
        // 允许在 App 内下载/保存等交互
        func webView(_ webView: WKWebView,
                     createWebViewWith configuration: WKWebViewConfiguration,
                     for navigationAction: WKNavigationAction,
                     windowFeatures: WKWindowFeatures?) -> WKWebView? {
            webView.load(navigationAction.request)
            return nil
        }
    }
}
