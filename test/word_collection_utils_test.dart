import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:word_collection_utils/src/io/word_collection_io.dart';
import 'package:word_collection_utils/src/models/file_contents.dart';
import 'package:word_collection_utils/src/utils/word_collection_utils.dart';

class MockWordCollectionIo extends Mock implements WordCollectionIo {}

void main() {
  late MockWordCollectionIo mockWordCollectionIo;
  late WordCollectionUtils wordCollectionUtils;

  setUp(() {
    mockWordCollectionIo = MockWordCollectionIo();
    wordCollectionUtils = WordCollectionUtils(collectionPath: 'test/path');
    wordCollectionUtils.wordCollectionIo = mockWordCollectionIo;
  });

  group('Initialization Tests', () {
    test('Successful Initialization', () {
      when(
        () => mockWordCollectionIo.init(
          collectionPath: any(named: 'collectionPath'),
          metadataPath: any(named: 'metadataPath'),
          saveToMemory: any(named: 'saveToMemory'),
          hasHeaders: any(named: 'hasHeaders'),
        ),
      ).thenReturn(true);

      expect(() => wordCollectionUtils.init(), returnsNormally);
    });

    test('Failed Initialization', () {
      when(
        () => mockWordCollectionIo.init(
          collectionPath: any(named: 'collectionPath'),
          metadataPath: any(named: 'metadataPath'),
          saveToMemory: any(named: 'saveToMemory'),
          hasHeaders: any(named: 'hasHeaders'),
        ),
      ).thenReturn(false);

      expect(() => wordCollectionUtils.init(), throwsA(isA<Exception>()));
    });
  });

  group('getWord Tests', () {
    test('Retrieve Word by Index', () async {
      when(() => mockWordCollectionIo.getWordCollection()).thenAnswer(
        (_) async => FileContents(lines: ['word1,1', 'word2,2', 'word3,3']),
      );

      final word = await wordCollectionUtils.getWord(1);
      expect(word.value, 'word2');
    });

    test('Index Out of Range', () async {
      when(() => mockWordCollectionIo.getWordCollection()).thenAnswer(
        (_) async => FileContents(lines: ['word1,1', 'word2,2', 'word3,3']),
      );

      expect(() => wordCollectionUtils.getWord(5), throwsA(isA<RangeError>()));
    });
  });

  group('getRandomWord Tests', () {
    test('Retrieve Random Word', () async {
      when(() => mockWordCollectionIo.getWordCollection()).thenAnswer(
        (_) async => FileContents(lines: ['word1,1', 'word2,2', 'word3,3']),
      );

      final word = await wordCollectionUtils.getRandomWord();
      expect(['word1', 'word2', 'word3'], contains(word.value));
    });
  });

  group('getWordsByRangeIndex Tests', () {
    test('Retrieve Words by Range', () async {
      when(() => mockWordCollectionIo.getWordCollection()).thenAnswer(
        (_) async =>
            FileContents(lines: ['word1,1', 'word2,2', 'word3,3', 'word4,4']),
      );

      final words = await wordCollectionUtils.getWordsByRangeIndex(1, 2);
      expect(words.map((w) => w.value).toList(), ['word2', 'word3']);
    });

    test('Invalid Range Throws Error', () async {
      when(() => mockWordCollectionIo.getWordCollection()).thenAnswer(
        (_) async =>
            FileContents(lines: ['word1,1', 'word2,2', 'word3,3', 'word4,4']),
      );

      expect(
        () => wordCollectionUtils.getWordsByRangeIndex(3, 1),
        throwsA(isA<RangeError>()),
      );
    });
  });
}
