//
//  File.swift
//  
//
//  Created by Markim Shaw on 12/16/21.
//

import Foundation
import UIKit

extension UILayoutGuide {
  public func boxify(forView view: UIView) {
    self.snp.makeConstraints { make in
      make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(64.0)
      make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(64.0)
      make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-64.0)
      make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-64.0)
    }
  }
}
