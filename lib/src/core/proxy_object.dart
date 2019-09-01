/// Base class for all Proxy Objects
abstract class ProxyBaseObject {
  const ProxyBaseObject();

  /// Is this object Valid
  ///
  /// Checks the business rules etc.
  bool isValid();

  /// Validate the Object (Only for development).
  ///
  /// isValid doesn't point to the problem. Hence this method.
  void assertValid();
}
