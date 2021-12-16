//
//  WordScrawlViewController.swift
//  ChristmasGift
//
//  Created by Markim Shaw on 12/15/21.
//

import Foundation
import UIKit

public final class GenericOrchestratedController: UIViewController {
  private var delegate: OrchestratorViewDelegate?
  
  weak public var orchestratorDelegate: OrchestratorDelegate?
  
  // MARK: - Init -
  public init(delegate: OrchestratorViewDelegate? = nil) {
    super.init(nibName: nil, bundle: nil)
    
    self.delegate = delegate
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  // MARK: - Lifecycle -
  public override func loadView() {
    guard let view = delegate?.injectibleView else {
      view = NoView()
      return
    }
    
    self.view = view
  }
  
  public override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.delegate?.orchestratorView(controller: self.orchestratorDelegate, willBeginAnimation: true)
  }
}

extension GenericOrchestratedController: Orchestratable {
  public var controller: UIViewController {
    self
  }
}
