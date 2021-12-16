//
//  NoView.swift
//  ChristmasGift
//
//  Created by Markim Shaw on 12/14/21.
//

import Foundation
import UIKit
import SnapKit

public final class NoView: UIView {
  private var label: UILabel
  
  public init() {
    label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    
    
    super.init(frame: .zero)
    self.translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .systemBackground
    
    addSubview(label)
    
    label.text = "No view has been set"
    label.font = .preferredFont(forTextStyle: .headline)
    label.textColor = .label
    createLabelConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func createLabelConstraints() {
    label.snp.makeConstraints { make in
      make.centerX.equalTo(self.snp.centerX)
      make.centerY.equalTo(self.snp.centerY)
    }
  }
}
