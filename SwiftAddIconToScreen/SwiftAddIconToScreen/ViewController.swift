//
//  ViewController.swift
//  SwiftAddIconToScreen
//
//  Created by chenyu on 2021/7/29.
//

import UIKit
import Swifter
class ViewController: UIViewController {
    var server = HttpServer()
    override func viewDidLoad() {
        super.viewDidLoad()
        let btn = UIButton.init(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        btn.addTarget(self, action: #selector(AddIconToScreen), for: .touchUpInside)
        btn.backgroundColor = .red
        self.view.addSubview(btn)
    }

    @objc func AddIconToScreen() {
        let schemeStr = "AddIconToScreen://"

        let imgData = UIImage(named: "emoji_2")?.jpegData(compressionQuality: 0.5)
        let title = "添加到桌面啦"
        guard  let schemeURL = URL(string: schemeStr),
               let shortcutImageStr = imgData?.base64EncodedString() else {
            return
        }
        
        let htmlStr = replaceHtmlContent(title: title, urlToRedirect: schemeURL.absoluteString, icon: shortcutImageStr)
        guard let base64 = htmlStr.data(using: .utf8)?.base64EncodedString() else { return }
        
        if let shortcutUrl = URL(string: "http://localhost:8080/redirect") {
            server["/redirect"] = { request in
                return .movedPermanently("data:text/html;base64,\(base64)");
            }
            try? server.start()
        UIApplication.shared.open(shortcutUrl, options: [:], completionHandler: nil)
        }

    }
    
    func replaceHtmlContent(title: String, urlToRedirect: String, icon: String) -> String {
        let shortcutsPath = Bundle.main.path(forResource: "template_us", ofType: "html")
        
        var shortcutsContent = try! String(contentsOfFile: shortcutsPath!) as String
        shortcutsContent = shortcutsContent.replacingOccurrences(of: "\\(titleplaceholder)", with: title)
        shortcutsContent = shortcutsContent.replacingOccurrences(of: "\\(urlToRedirect.absoluteString)", with: urlToRedirect)
        shortcutsContent = shortcutsContent.replacingOccurrences(of: "\\(feature_icon)", with: icon)
        return shortcutsContent
    }

}

