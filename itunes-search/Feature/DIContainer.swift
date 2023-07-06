import Foundation
import Domain
import Platform

struct DIContainer {
  private let remoteClient: RemoteClient
  
  init(remoteClient: RemoteClient = .init()) {
    self.remoteClient = remoteClient
  }
}

extension DIContainer {
  var searchUseCase: SearchUseCaseDomain {
    SearchUseCasePlatform(remoteClient: remoteClient)
  }
}
