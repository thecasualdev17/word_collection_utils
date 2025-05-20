import 'file_loader_base.dart';

/// Stub implementation of [FileLoaderBase] for platforms where file loading is not supported,
/// such as web or wasm.
///
/// Throws [UnimplementedError] when attempting to load a file.
class FileLoader extends FileLoaderBase {
  @override
  Future<Stream<String>> getFileStream(String path) async {
    throw UnimplementedError('File loading not implemented for web.');
  }
}
