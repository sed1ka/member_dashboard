import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hdi_mini_test/core/local_secure_storage/local_secure_storage.dart';
import 'package:hdi_mini_test/core/local_secure_storage/local_secure_storage_impl.dart';
import 'package:mocktail/mocktail.dart';

class MockFlutterSecureStorage extends Mock implements FlutterSecureStorage {}

void main() {
  late MockFlutterSecureStorage mockStorage;
  late LocalSecureStorage localSecureStorage;

  setUp(() {
    mockStorage = MockFlutterSecureStorage();
    localSecureStorage = LocalSecureStorageImpl(mockStorage);
  });

  group('LocalSecureStorageImpl', () {
    const key = 'test_key';
    const value = 'test_value';

    test('should call write with correct parameters', () async {
      // arrange
      when(
        () => mockStorage.write(
          key: any(named: 'key'),
          value: any(named: 'value'),
        ),
      ).thenAnswer((_) async => {});

      // act
      await localSecureStorage.write(key: key, value: value);

      // assert
      verify(() => mockStorage.write(key: key, value: value)).called(1);
    });

    test('should call read and return value when key exists', () async {
      // arrange
      when(
        () => mockStorage.read(
          key: any(named: 'key'),
        ),
      ).thenAnswer((_) async => value);

      // act
      final result = await localSecureStorage.read(key: key);

      // assert
      expect(result, value);
      verify(() => mockStorage.read(key: key)).called(1);
    });

    test('should return null when reading key that does not exist', () async {
      // arrange
      const nonExistentKey = 'non_existent_key';
      when(
        () => mockStorage.read(
          key: nonExistentKey,
        ),
      ).thenAnswer((_) async => null);

      // act
      final result = await localSecureStorage.read(key: nonExistentKey);

      // assert
      expect(result, null);
      verify(() => mockStorage.read(key: nonExistentKey)).called(1);
    });

    test('should call delete with correct parameters', () async {
      // arrange
      when(
        () => mockStorage.delete(key: any(named: 'key')),
      ).thenAnswer((_) async => {});

      // act
      await localSecureStorage.delete(key: key);

      // assert
      verify(() => mockStorage.delete(key: key)).called(1);
    });

    test('should call deleteAll', () async {
      // arrange
      when(() => mockStorage.deleteAll()).thenAnswer((_) async => {});

      // act
      await localSecureStorage.deleteAll();

      // assert
      verify(() => mockStorage.deleteAll()).called(1);
    });

    test('should call containsKey and return true when key exists', () async {
      // arrange
      when(
        () => mockStorage.containsKey(key: any(named: 'key')),
      ).thenAnswer((_) async => true);

      // act
      final result = await localSecureStorage.containsKey(key: key);

      // assert
      expect(result, true);
      verify(() => mockStorage.containsKey(key: key)).called(1);
    });

    test(
      'should call containsKey and return false when key does not exist',
      () async {
        // arrange
        when(
          () => mockStorage.containsKey(key: any(named: 'key')),
        ).thenAnswer((_) async => false);

        // act
        final result = await localSecureStorage.containsKey(key: key);

        // assert
        expect(result, false);
        verify(() => mockStorage.containsKey(key: key)).called(1);
      },
    );
  });
}
