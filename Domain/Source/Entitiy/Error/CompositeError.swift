import Foundation

public enum CompositeError: Error {
  case invalidTypeCast
  case networkOffline
  case remoteError
}
