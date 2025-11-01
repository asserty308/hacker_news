import 'package:flutter_test/flutter_test.dart';
import 'package:hacker_news/features/home/data/models/story_history_item.dart';

void main() {
  group('StoryHistoryItem', () {
    const testStoryId = 12345;
    final testDate = DateTime(2025, 9, 11, 14, 30, 0);

    group('constructor', () {
      test('should create instance with required parameters', () {
        // Arrange & Act
        final storyHistoryItem = StoryHistoryItem(
          storyId: testStoryId,
          dateAdded: testDate,
        );

        // Assert
        expect(storyHistoryItem.storyId, testStoryId);
        expect(storyHistoryItem.dateAdded, testDate);
      });
    });

    group('fromJSON', () {
      test('should create instance from valid JSON', () {
        // Arrange
        final json = {
          'story_id': testStoryId,
          'date_added': '2025-09-11 14:30',
        };

        // Act
        final storyHistoryItem = StoryHistoryItem.fromJSON(json);

        // Assert
        expect(storyHistoryItem.storyId, testStoryId);
        expect(storyHistoryItem.dateAdded, testDate);
      });

      test('should handle different date formats', () {
        // Arrange
        final json = {
          'story_id': testStoryId,
          'date_added': '2025-09-11T14:30:00.000Z',
        };

        // Act
        final storyHistoryItem = StoryHistoryItem.fromJSON(json);

        // Assert
        expect(storyHistoryItem.storyId, testStoryId);
        expect(
          storyHistoryItem.dateAdded,
          DateTime.parse('2025-09-11T14:30:00.000Z'),
        );
      });

      test('should throw FormatException for invalid date format', () {
        // Arrange
        final json = {'story_id': testStoryId, 'date_added': 'invalid-date'};

        // Act & Assert
        expect(
          () => StoryHistoryItem.fromJSON(json),
          throwsA(isA<FormatException>()),
        );
      });

      test('should throw when story_id is missing', () {
        // Arrange
        final json = {'date_added': '2025-09-11 14:30'};

        // Act & Assert
        expect(
          () => StoryHistoryItem.fromJSON(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('should throw when date_added is missing', () {
        // Arrange
        final json = {'story_id': testStoryId};

        // Act & Assert
        expect(
          () => StoryHistoryItem.fromJSON(json),
          throwsA(isA<TypeError>()),
        );
      });
    });

    group('toJSON', () {
      test('should convert instance to JSON with correct format', () {
        // Arrange
        final storyHistoryItem = StoryHistoryItem(
          storyId: testStoryId,
          dateAdded: testDate,
        );

        // Act
        final json = storyHistoryItem.toJSON();

        // Assert
        expect(json, {
          'story_id': testStoryId,
          'date_added': '2025-09-11 14:30',
        });
      });

      test('should format date correctly for different times', () {
        // Arrange
        final earlyMorning = DateTime(2025, 1, 1, 8, 5, 0);
        final storyHistoryItem = StoryHistoryItem(
          storyId: testStoryId,
          dateAdded: earlyMorning,
        );

        // Act
        final json = storyHistoryItem.toJSON();

        // Assert
        expect(json['date_added'], '2025-01-01 08:05');
      });

      test('should handle midnight correctly', () {
        // Arrange
        final midnight = DateTime(2025, 12, 31, 0, 0, 0);
        final storyHistoryItem = StoryHistoryItem(
          storyId: testStoryId,
          dateAdded: midnight,
        );

        // Act
        final json = storyHistoryItem.toJSON();

        // Assert
        expect(json['date_added'], '2025-12-31 00:00');
      });
    });

    group('JSON serialization round trip', () {
      test(
        'should maintain data integrity through serialization and deserialization',
        () {
          // Arrange
          final originalItem = StoryHistoryItem(
            storyId: testStoryId,
            dateAdded: testDate,
          );

          // Act
          final json = originalItem.toJSON();
          final deserializedItem = StoryHistoryItem.fromJSON(json);

          // Assert
          expect(deserializedItem.storyId, originalItem.storyId);
          expect(deserializedItem.dateAdded, originalItem.dateAdded);
        },
      );

      test('should handle edge case dates correctly', () {
        // Arrange
        final edgeDate = DateTime(1970, 1, 1, 0, 0, 0); // Unix epoch
        final originalItem = StoryHistoryItem(storyId: 1, dateAdded: edgeDate);

        // Act
        final json = originalItem.toJSON();
        final deserializedItem = StoryHistoryItem.fromJSON(json);

        // Assert
        expect(deserializedItem.storyId, originalItem.storyId);
        expect(deserializedItem.dateAdded, originalItem.dateAdded);
      });
    });

    group('equality and properties', () {
      test('should have correct properties', () {
        // Arrange
        final storyHistoryItem = StoryHistoryItem(
          storyId: testStoryId,
          dateAdded: testDate,
        );

        // Act & Assert
        expect(storyHistoryItem.storyId, isA<int>());
        expect(storyHistoryItem.dateAdded, isA<DateTime>());
      });

      test('should handle large story IDs', () {
        // Arrange
        const largeStoryId = 999999999;
        final storyHistoryItem = StoryHistoryItem(
          storyId: largeStoryId,
          dateAdded: testDate,
        );

        // Act & Assert
        expect(storyHistoryItem.storyId, largeStoryId);
      });
    });
  });
}
