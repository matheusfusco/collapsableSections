//
//  CollapsibleTableViewCell.swift
//  ios-swift-collapsible-table-section
//
//  Created by Matheus Fusco on 11/10/18.
//  Copyright © 2018 Matheus Fusco. All rights reserved.
//

import UIKit

class CollapsibleTableViewCell: UITableViewCell {
    
    let webView = UIWebView()
    var contentSize: CGFloat = 0
    var heightConstraint: NSLayoutConstraint!
    var isSectionCollapsed: Bool = true
    
    // MARK: Initalizers
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let marginGuide = contentView.layoutMarginsGuide
        webView.delegate = self
//        webView.alpha = isSectionCollapsed ? 0 : 1
        contentView.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        heightConstraint = webView.heightAnchor.constraint(equalToConstant: contentSize)
        heightConstraint.isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.25) {
            self.webView.removeConstraint(self.heightConstraint)
            self.heightConstraint = self.webView.heightAnchor.constraint(equalToConstant: self.contentSize)
            self.heightConstraint.isActive = true
        }
    }
}

extension CollapsibleTableViewCell : UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        webView.frame.size.height = 1
        self.contentSize = webView.scrollView.contentSize.height
        self.webView.alpha = isSectionCollapsed ? 0 : 1
        print("webViewDidFinishLoad contentSize \(webView.scrollView.contentSize)")
        print("webViewDidFinishLoad sectionCollapsed: \(isSectionCollapsed) - Alpha: \(self.webView.alpha)")
        self.layoutSubviews()
    }
    
//    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
//        return true
//    }
}
