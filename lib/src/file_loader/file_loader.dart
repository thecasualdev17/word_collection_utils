export 'file_loader_stub.dart'
    if (dart.library.io) 'file_loader_io.dart' // for native platforms
    if (dart.library.html) 'file_loader_web.dart'; // for web/wasm
