//
//  LetterViewController.swift
//  ChristmasGift
//
//  Created by Markim Shaw on 12/15/21.
//

import Foundation
import UIKit
import SnapKit

final class LetterView: UIView {
  lazy var boxedLayoutGuide: UILayoutGuide = {
    let guide = UILayoutGuide()
    return guide
  }()
  
  lazy var continueButton: UIButton = {
    let button = UIButton(type: .system)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Continue", for: .normal)
    button.tintColor = .label
    
    return button
  }()
  
  lazy var scrollView: UIScrollView = {
    let scrollView = UIScrollView()
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.isScrollEnabled = true
    
    return scrollView
  }()
  
  let contentView = UIView()
  
  lazy var textLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.lineBreakMode = .byWordWrapping
    label.numberOfLines = 0
    label.font = .preferredFont(forTextStyle: .body)
    label.textColor = .label
    return label
  }()
  
  init(body: String) {
    super.init(frame: .zero)
    self.translatesAutoresizingMaskIntoConstraints = false
    
    contentView.translatesAutoresizingMaskIntoConstraints = false
    
    if let markdown = try? AttributedString(markdown: body) {
      textLabel.attributedText = NSAttributedString.init(markdown)
    } else {
      textLabel.text = body
    }
   
    
    addSubview(scrollView)
    
    scrollView.frameLayoutGuide.snp.makeConstraints { make in
      make.trailing.equalTo(self.snp.trailing)
      make.leading.equalTo(self.snp.leading)
      make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(8.0)
      make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-8.0)
    }
    scrollView.addSubview(contentView)
    
    scrollView.contentLayoutGuide.snp.makeConstraints { make in
      make.width.equalTo(self.snp.width)
      make.height.equalTo(self.snp.height)
    }
    
    contentView.snp.makeConstraints { make in
      make.trailing.leading.equalTo(self)
      make.width.height.top.bottom.equalTo(scrollView.contentLayoutGuide)
    }
    
    contentView.addSubview(textLabel)
    textLabel.snp.makeConstraints { make in
      make.leading.equalTo(contentView.snp.leading)
      make.top.equalTo(contentView.snp.top)
      make.trailing.equalTo(contentView.snp.trailing)
      make.bottom.equalTo(contentView.snp.bottom)
    }
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
}

extension LetterView: OrchestratorViewDelegate {
  var injectibleView: UIView {
    self
  }
  
  func orchestratorView(controller: OrchestratorDelegate?, willBeginAnimation: Bool) {
    
  }
}
