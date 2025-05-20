/// Represents configuration options for handling word collection files,
/// including memory caching, metadata usage, header presence, and metadata file path.
class Options {
  /// Creates an [Options] instance with the given settings.
  ///
  /// [saveToMemory] determines if file contents should be cached in memory (default: true).
  /// [hasMetadata] specifies if a metadata file is present (default: false).
  /// [hasHeaders] indicates if the files have header rows (default: true).
  /// [metadataPath] is the optional path to the metadata file.
  const Options({
    this.saveToMemory = true,
    this.hasMetadata = false,
    this.hasHeaders = true,
    this.metadataPath,
  });

  /// Whether file contents should be cached in memory after reading.
  final bool saveToMemory;

  /// Whether a metadata file is present.
  final bool hasMetadata;

  /// The file path to the metadata file, if any.
  final String? metadataPath;

  /// Whether the files are expected to have header rows.
  final bool hasHeaders;
}
