//
//  File.swift
//  
//
//  Created by Markim Shaw on 12/17/21.
//

import Foundation
import SwiftUI

/// This type is a requirement for `SwiftUI` views so that they can be used with the `Orchestrator`.
public protocol OrchestratableSwiftUI {
  init(orchestratorDelegate: OrchestratorDelegate?)
}
