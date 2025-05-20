/// Represents the contents of a file, including its lines and optional headers.
class FileContents {
  /// Creates a [FileContents] instance with the given [lines] and optional [headers].
  FileContents({required this.lines, this.headers});

  /// The header row of the file, if present.
  final String? headers;

  /// The lines of the file (excluding headers, if any).
  final List<String> lines;
}
