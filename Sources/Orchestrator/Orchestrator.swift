//
//  Orchestrator.swift
//  ChristmasGift
//
//  Created by Markim Shaw on 12/14/21.
//

import Foundation
import UIKit

public protocol Orchestratable {
  var orchestratorDelegate: OrchestratorDelegate? { get set }
  var controller: UIViewController { get }
}
public protocol OrchestratorDelegate: AnyObject {
  func orchestrator(playNextViewController: Bool)
}

public protocol OrchestratorViewDelegate: AnyObject {
  var injectibleView: UIView { get }
  func orchestratorView(controller: OrchestratorDelegate?, willBeginAnimation: Bool)
}

public final class Orchestrator: UIViewController, OrchestratorDelegate {
  public func orchestrator(playNextViewController: Bool) {
    /* Go to the next thing */
    if playNextViewController {
      if currentOrchestratableIndex != controllers.count - 1 {
        remove()
      }
      
      next {
        self.add(orchestrable: &self.controllers[self.currentOrchestratableIndex])
      }
    }
  }
  
  var controllers: [Orchestratable] = []
  lazy var currentOrchestratableIndex: Int = 0
  
  public init(controllers: [Orchestratable] = []) {
    super.init(nibName: nil, bundle: nil)
    self.controllers = controllers
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    
    guard var initialController = controllers.first else { return }
    
    add(orchestrable: &initialController)
  }
  
  private func next(onCompletion: @escaping () -> Void) {
    guard currentOrchestratableIndex < controllers.count - 1 else {
      currentOrchestratableIndex = 0
      return
    }
    
    currentOrchestratableIndex += 1
    onCompletion()
  }
  
  private func add(orchestrable: inout Orchestratable) {
    let controller = orchestrable.controller
    orchestrable.orchestratorDelegate = self
    
    addChild(controller)
    view.addSubview(controller.view)
    controller.view.snp.makeConstraints { make in
      make.leading.equalTo(self.view)
      make.trailing.equalTo(self.view)
      make.bottom.equalTo(self.view)
      make.top.equalTo(self.view)
    }
    controller.didMove(toParent: self)
  }
  
  private func remove() {
    var orchestrable = controllers[currentOrchestratableIndex]
    orchestrable.orchestratorDelegate = nil
    let controller = orchestrable.controller
    
    controller.willMove(toParent: nil)
    controller.view.removeFromSuperview()
    controller.removeFromParent()
  }
}
