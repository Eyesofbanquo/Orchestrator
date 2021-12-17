//
//  File.swift
//  
//
//  Created by Markim Shaw on 12/17/21.
//

import Foundation
import SwiftUI

public struct OrchestratedSwiftUIView: View, OrchestratableSwiftUI {
  
  @State var localOrchestratorDelegate: OrchestratorDelegate?
  
  public init(orchestratorDelegate: OrchestratorDelegate?) {
    self._localOrchestratorDelegate = State.init(wrappedValue: orchestratorDelegate)
  }
  
  public var body: some View {
    Text("Hi")
      .onAppear {
        Task {
          DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            localOrchestratorDelegate?.orchestrator(playNextViewController: true)
        }
      }
    }
  }
}
