import Foundation

public protocol SearchUseCaseDomain {
  var search: (SearchEntity.Request.Keyword) async throws -> SearchEntity.Response.Result { get }
}
