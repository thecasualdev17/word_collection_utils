/// Abstract interface for loading file contents as a stream of lines.
///
/// Implementations should provide platform-specific logic for loading file data,
/// such as reading from the local file system (native) or fetching from the network (web/wasm).
abstract class FileLoaderBase {
  /// Loads the contents of the file at the given [path] as a stream of lines.
  ///
  /// Returns a [Stream] of [String] lines from the file.
  Future<Stream<String>> getFileStream(String path);
}
