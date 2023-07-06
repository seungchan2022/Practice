import Foundation
import Domain

public struct RemoteClient {
  let session: URLSession
  
  public init(session: URLSession = .shared) {
    self.session = session
  }
}

extension RemoteClient {
  func send(url: URL?) async throws -> Data {
    guard let url else { throw CompositeError.invalidTypeCast }
    
    let (data, response) = try await session.data(from: url)
    
    guard let status = (response as? HTTPURLResponse)?.statusCode
    else { throw CompositeError.invalidTypeCast }
    
    guard (200...299).contains(status) else { throw CompositeError.remoteError }
    return data
  }
}
