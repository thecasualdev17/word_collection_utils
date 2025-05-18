class Options {
  const Options({
    this.saveToMemory = true,
    this.hasMetadata = false,
    this.hasHeaders = true,
    this.metadataPath,
  });

  final bool saveToMemory;
  final bool hasMetadata;
  final String? metadataPath;
  final bool hasHeaders;
}
