@objc public protocol NSRaveDelegate {
    public func onSuccess(_ data: Any, _ response: Any)
    public func onError(_ data: Any, _ response: Any)
}