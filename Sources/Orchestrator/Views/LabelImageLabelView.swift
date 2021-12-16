//
//  WordScrawlView.swift
//  ChristmasGift
//
//  Created by Markim Shaw on 12/15/21.
//

import Foundation
import UIKit

public final class LabelImageLabelView: UIView {
  
  typealias InitParams = (header: String, imageName: String, footer: String)
  
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
  
  private var imageOnlyMode: Bool
  
  public init(header: String, imageName: String, footer: String, imageOnly: Bool) {
    imageOnlyMode = imageOnly

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
    
    createViews(params: (header, imageName, footer))
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  private func createViews(params: InitParams) {
    let (header, imageName, footer) = params
    
    if !header.isEmpty || imageOnlyMode {
      let headerLabel = UILabel()
      headerLabel.translatesAutoresizingMaskIntoConstraints = false
      headerLabel.text = header
      headerLabel.font = .preferredFont(forTextStyle: .title1)
      headerLabel.textColor = .label
      headerLabel.layer.opacity = 0.0
      headerLabel.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
      sv.addArrangedSubview(headerLabel)
    }

    
    if !imageName.isEmpty, let uiImage = UIImage(named: imageName) {
      let imageView = UIImageView(image: uiImage)
      imageView.translatesAutoresizingMaskIntoConstraints = false
      imageView.contentMode = .scaleAspectFit
      imageView.layer.opacity = 0.0
      imageView.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
      sv.addArrangedSubview(imageView)
    }
    
    if !footer.isEmpty {
      let footerLabel = UILabel()
      footerLabel.translatesAutoresizingMaskIntoConstraints = false
      footerLabel.text = footer
      footerLabel.font = .preferredFont(forTextStyle: .title1)
      footerLabel.textColor = .label
      footerLabel.layer.opacity = 0.0
      footerLabel.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
      sv.addArrangedSubview(footerLabel)
    }
  }
}

extension LabelImageLabelView: OrchestratorViewDelegate {
  public var injectibleView: UIView {
    self
  }
  
  public func orchestratorView(controller: OrchestratorDelegate?, willBeginAnimation: Bool) {
    let duration: TimeInterval = 1.5
    let delay: TimeInterval = 0.75
    
    
    guard !imageOnlyMode else {
      UIView.animate(withDuration: 3.0, delay: 0.25, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.0, options: .curveEaseInOut, animations: {
        self.sv.arrangedSubviews[0].transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
        self.sv.arrangedSubviews[0].layer.opacity = 1.0
      }) { success in
        print("done")
        controller?.orchestrator(playNextViewController: true)
      }
      return
    }
    
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
