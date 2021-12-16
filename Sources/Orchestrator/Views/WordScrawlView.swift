//
//  WordScrawlView.swift
//  ChristmasGift
//
//  Created by Markim Shaw on 12/15/21.
//

import Foundation
import UIKit

public final class WordScrawlView: UIView {
  
  lazy var boxedLayoutGuide: UILayoutGuide = {
    let guide = UILayoutGuide()
    return guide
  }()
  
  lazy var sv: UIStackView = {
    let sv = UIStackView()
    sv.translatesAutoresizingMaskIntoConstraints = false
    sv.axis = .vertical
    sv.alignment = .center
    sv.distribution = .equalSpacing
    return sv
  }()
  
  public init(words: [String]) {
    super.init(frame: .zero)
    self.translatesAutoresizingMaskIntoConstraints = false
    self.backgroundColor = .systemBackground
    
    addLayoutGuide(boxedLayoutGuide)
    boxedLayoutGuide.boxify(forView: self)
    addSubview(sv)
    
    sv.snp.makeConstraints { make in
      make.leading.equalTo(boxedLayoutGuide.snp.leading)
      make.top.equalTo(boxedLayoutGuide.snp.top)
      make.bottom.equalTo(boxedLayoutGuide.snp.bottom)
      make.trailing.equalTo(boxedLayoutGuide.snp.trailing)
    }
    
    createViews(forWords: words)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  private func createViews(forWords words: [String]) {
    for word in words {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.text = word
      label.font = .preferredFont(forTextStyle: .title3)
      label.textColor = .label
      label.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
      label.layer.opacity = 0.0
      sv.addArrangedSubview(label)
    }
  }
}

extension WordScrawlView: OrchestratorViewDelegate {
  public var injectibleView: UIView {
    self
  }
  
  public func orchestratorView(controller: OrchestratorDelegate?, willBeginAnimation: Bool) {
    let duration: TimeInterval = 1.25
    let delay: TimeInterval = 0.25
    
    for (index, value) in sv.arrangedSubviews.enumerated() {
      if index == sv.arrangedSubviews.count - 1 {
        UIView.animate(withDuration: duration, delay: delay * CGFloat(index), usingSpringWithDamping: 0.6, initialSpringVelocity: 0.25, options: .curveEaseInOut, animations: {
          value.transform = .identity
          value.layer.opacity = 1.0
        }) { success in
          print("done")
          controller?.orchestrator(playNextViewController: true)
        }
      } else {
        UIView.animate(withDuration: duration, delay: delay * CGFloat(index), usingSpringWithDamping: 0.6, initialSpringVelocity: 0.25, options: .curveEaseInOut) {
          value.transform = .identity
          value.layer.opacity = 1.0
        }
      }
    }
  }
}
