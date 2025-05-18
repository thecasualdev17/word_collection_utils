import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:word_collection_utils/src/io/word_collection_io.dart';
import 'package:word_collection_utils/src/models/file_contents.dart';

class MockWordCollectionIo extends Mock implements WordCollectionIo {}

void main() {
  late MockWordCollectionIo mockWordCollectionIo;

  setUp(() {
    mockWordCollectionIo = MockWordCollectionIo();
  });

  group('init Tests', () {
    test('Successful init', () {
      when(
        () => mockWordCollectionIo.init(
          collectionPath: any(named: 'collectionPath'),
          metadataPath: any(named: 'metadataPath'),
          saveToMemory: any(named: 'saveToMemory'),
        ),
      ).thenReturn(true);

      final result = mockWordCollectionIo.init(collectionPath: 'test/path');
      expect(result, isTrue);
    });

    test('Failed init', () {
      when(
        () => mockWordCollectionIo.init(
          collectionPath: any(named: 'collectionPath'),
          metadataPath: any(named: 'metadataPath'),
          saveToMemory: any(named: 'saveToMemory'),
        ),
      ).thenReturn(false);

      final result = mockWordCollectionIo.init(collectionPath: '');
      expect(result, isFalse);
    });
  });

  group('readFile Tests', () {
    test('Init Failed', () async {
      when(() => mockWordCollectionIo.isInitialized).thenReturn(false);
      when(
        () => mockWordCollectionIo.readFile(any()),
      ).thenAnswer((_) async => throw Exception('Not Initialized'));

      expect(
        () async => await mockWordCollectionIo.readFile('test/path'),
        throwsA(isA<Exception>()),
      );
    });

    test('Successful Read', () async {
      when(() => mockWordCollectionIo.isInitialized).thenReturn(true);
      when(() => mockWordCollectionIo.readFile(any())).thenAnswer(
        (_) async =>
            FileContents(lines: ['line1', 'line2'], headers: 'header1,header2'),
      );

      final result = await mockWordCollectionIo.readFile('test/path');
      expect(result.lines, ['line1', 'line2']);
      expect(result.headers, 'header1,header2');
    });

    test('Failed Read', () async {
      when(() => mockWordCollectionIo.isInitialized).thenReturn(true);
      when(
        () => mockWordCollectionIo.readFile(any()),
      ).thenThrow(Exception('File read error'));

      expect(
        () async => await mockWordCollectionIo.readFile('test/path'),
        throwsA(isA<Exception>()),
      );
    });
  });

  group('getWordCollection Tests', () {
    test('Init Failed', () async {
      when(() => mockWordCollectionIo.isInitialized).thenReturn(false);
      when(
        () => mockWordCollectionIo.getWordCollection(),
      ).thenAnswer((_) async => throw Exception('Not Initialized'));

      expect(
        () async => await mockWordCollectionIo.getWordCollection(),
        throwsA(isA<Exception>()),
      );
    });

    test('Non Existing Collection', () async {
      when(() => mockWordCollectionIo.isInitialized).thenReturn(true);
      when(() => mockWordCollectionIo.getCollectionFromMemory).thenReturn(null);
      when(() => mockWordCollectionIo.getWordCollection()).thenAnswer(
        (_) async => FileContents(lines: ['line1'], headers: 'header1'),
      );

      final result = await mockWordCollectionIo.getWordCollection();
      expect(result.lines, ['line1']);
      expect(result.headers, 'header1');
    });

    test('Existing Collection', () async {
      when(() => mockWordCollectionIo.isInitialized).thenReturn(true);
      when(
        () => mockWordCollectionIo.getCollectionFromMemory,
      ).thenReturn(FileContents(lines: ['line1'], headers: 'header1'));
      when(() => mockWordCollectionIo.getWordCollection()).thenAnswer(
        (_) async => FileContents(lines: ['line1'], headers: 'header1'),
      );

      final result = await mockWordCollectionIo.getWordCollection();
      expect(result.lines, ['line1']);
      expect(result.headers, 'header1');
    });
  });

  group('getCharacterMetadata Tests', () {
    test('Init Failed', () async {
      when(() => mockWordCollectionIo.isInitialized).thenReturn(false);
      when(
        () => mockWordCollectionIo.getCharacterMetadata(),
      ).thenAnswer((_) async => throw Exception('Not Initialized'));

      expect(
        () async => await mockWordCollectionIo.getCharacterMetadata(),
        throwsA(isA<Exception>()),
      );
    });

    test('Non Existing Metadata', () async {
      when(() => mockWordCollectionIo.isInitialized).thenReturn(true);
      when(() => mockWordCollectionIo.getMetadataFromMemory).thenReturn(null);
      when(() => mockWordCollectionIo.getCharacterMetadata()).thenAnswer(
        (_) async => FileContents(lines: ['meta1'], headers: 'header1'),
      );

      final result = await mockWordCollectionIo.getCharacterMetadata();
      expect(result.lines, ['meta1']);
      expect(result.headers, 'header1');
    });

    test('Existing Metadata', () async {
      when(() => mockWordCollectionIo.isInitialized).thenReturn(true);
      when(
        () => mockWordCollectionIo.getMetadataFromMemory,
      ).thenReturn(FileContents(lines: ['meta1'], headers: 'header1'));
      when(() => mockWordCollectionIo.getCharacterMetadata()).thenAnswer(
        (_) async => FileContents(lines: ['meta1'], headers: 'header1'),
      );

      final result = await mockWordCollectionIo.getCharacterMetadata();
      expect(result.lines, ['meta1']);
      expect(result.headers, 'header1');
    });
  });
}
