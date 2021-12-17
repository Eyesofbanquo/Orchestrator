//
//  File.swift
//  
//
//  Created by Markim Shaw on 12/17/21.
//

import Foundation
import UIKit
import SwiftUI
import SnapKit

public final class OrchestratedRepresentedController<T: View & OrchestratableSwiftUI>: UIViewController, Orchestratable {
  
  public var orchestratorDelegate: OrchestratorDelegate? {
    didSet(oldValue) {
      remove()
      createView(orchestratorDelegate)
    }
  }
  
  private var currentHostingController: UIHostingController<T>?
  public var controller: UIViewController {
    self
  }
  
  // MARK: - Init -
  public init() {
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifecycle -
  
  public override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  private func createView(_ delegate: OrchestratorDelegate?) {
    let hostingController = UIHostingController(rootView: T.init(orchestratorDelegate: delegate))
    hostingController.view.translatesAutoresizingMaskIntoConstraints = false
    addChild(hostingController)
    view.addSubview(hostingController.view)
    NSLayoutConstraint.activate([
      hostingController.view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
      hostingController.view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
      hostingController.view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
      hostingController.view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
    ])
    hostingController.didMove(toParent: self)
    self.currentHostingController = hostingController
  }
  
  private func remove() {
    currentHostingController?.willMove(toParent: nil)
    currentHostingController?.view.removeFromSuperview()
    currentHostingController?.removeFromParent()
  }
}
