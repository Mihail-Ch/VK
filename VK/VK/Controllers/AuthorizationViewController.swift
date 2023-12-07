//
//  AuthorizationViewController.swift
//  VK
//
//  Created by Михаил Чертов on 21.11.2023.
//

import UIKit
import WebKit

class AuthorizationViewController: UIViewController {
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        return webView
    }()
    
    private let tabBar: UITabBarController = {
        let tabBar = UITabBarController()
        return tabBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
      //  view.backgroundColor = Theme.currentTheme.backgroundColor
        setupTabBar()
        openScreenAuthorization()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    private func openScreenAuthorization() {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7727721"), //👉 - AppId
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "270342"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.199")
        ]
        
        guard let url = urlComponents.url else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    private func setupTabBar() {
        tabBar.navigationItem.hidesBackButton = true
  
        let friendsController = UINavigationController(rootViewController: FriendsViewController())
        let groupsController = UINavigationController(rootViewController: GroupsViewController())
        let photoController = UINavigationController(rootViewController: PhotosViewController())
        
        friendsController.title = "Друзья"
        groupsController.title = "Группы"
        photoController.title = "Фото"
        
        tabBar.modalPresentationStyle = .fullScreen
        
        tabBar.setViewControllers([friendsController, groupsController, photoController], animated: true)
        
        guard let items = tabBar.tabBar.items else { return }
        let images = ["person.2", "person.3", "photo.stack"]
        
        for x in 0..<images.count {
            items[x].image = UIImage(systemName: images[x])
        }

    }

}


extension AuthorizationViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        guard let url = navigationResponse.response.url,
              url.path == "/blank.html",
              let fragment = url.fragment else {
            decisionHandler(.allow)
            return
        }
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=")}
            .reduce([String: String] ()) {result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
            }
        let token = params["access_token"]
        let userId = params["user_id"]
        
       
        
        guard let token = token else { return }
        guard let userId = userId else { return }
        guard let userId = Int(userId) else { return }
        
        print("👋 token: \(token as Any)")
        print("👋 userId: \(userId as Any)")

        
        Session.shared.token = token
        Session.shared.userId = userId
        
        present(tabBar, animated: true)
        
        decisionHandler(.cancel)
        webView.removeFromSuperview()
    }
}
