//
//  CountryView.swift
//  ChristmasGift
//
//  Created by Markim Shaw on 12/14/21.
//

import Foundation
import UIKit
import SnapKit

public final class CountryView: UIView {
  
  lazy var boxedLayoutGuide: UILayoutGuide = {
    let guide = UILayoutGuide()
    return guide
  }()
  
  private var fromLabel: UILabel
  private var countryImageView: UIImageView
  private var toLabel: UILabel
  
  public init(fromLabelText: String? = nil,
       countryImageName: String? = nil,
       toLabelText: String? = nil) {
    fromLabel = UILabel()
    fromLabel.translatesAutoresizingMaskIntoConstraints = false
    
    countryImageView = UIImageView()
    countryImageView.translatesAutoresizingMaskIntoConstraints = false
    countryImageView.contentMode = .scaleAspectFit
    
    toLabel = UILabel()
    toLabel.translatesAutoresizingMaskIntoConstraints = false
    
    super.init(frame: .zero)
    
    backgroundColor = .systemBackground
    translatesAutoresizingMaskIntoConstraints = false
    
    addLayoutGuide(boxedLayoutGuide)
    boxedLayoutGuide.boxify(forView: self)
    addSubviews()
    
    fromLabel.text = fromLabelText
    fromLabel.font = .preferredFont(forTextStyle: .largeTitle)
    toLabel.text = toLabelText
    toLabel.font = .preferredFont(forTextStyle: .largeTitle)
    
    if let countryName = countryImageName,
       !countryName.isEmpty,
       let countryImage = UIImage(named: countryName) {
      countryImageView.image = countryImage
    }
    
    createConstraints()
    
    fromLabel.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
    toLabel.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func addSubviews() {
    addSubview(fromLabel)
    addSubview(countryImageView)
    addSubview(toLabel)
  }
  
  private func createConstraints() {
    fromLabel.snp.makeConstraints { make in
      make.leading.equalTo(boxedLayoutGuide.snp.leading)
      make.top.equalTo(boxedLayoutGuide.snp.top)
    }
    
    toLabel.snp.makeConstraints { make in
      make.trailing.equalTo(boxedLayoutGuide.snp.trailing)
      make.bottom.equalTo(boxedLayoutGuide.snp.bottom)
    }
  }
}

extension CountryView: OrchestratorViewDelegate {
  public var injectibleView: UIView {
    self
  }
  
  public func orchestratorView(controller: OrchestratorDelegate?, willBeginAnimation: Bool) {
    if (willBeginAnimation) {
      UIView.animate(withDuration: 2.0, delay: 0.0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0.0, options: .curveEaseInOut) {
        self.fromLabel.transform = .identity
      }

      UIView.animate(withDuration: 2.0, delay: 1.0, usingSpringWithDamping: 0.35, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
        self.toLabel.transform = .identity
      }) { success in
        /* This will cause everything to progress */
        controller?.orchestrator(playNextViewController: true)
      }
    }
  }
}
