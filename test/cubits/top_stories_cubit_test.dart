import 'package:flutter_test/flutter_test.dart';
import 'package:hacker_news/data/models/item_model.dart';
import 'package:hacker_news/data/repositories/hackernews_repository.dart';
import 'package:hacker_news/state/top_stories/top_stories_cubit.dart';
import 'package:mockito/mockito.dart';

class MockHackernewsRepository extends Mock implements HackernewsRepository {}

void main() {
  MockHackernewsRepository repository;
  TopStoriesCubit cubit;

  final stories = <ItemModel>[];

  setUp(() {
    repository = MockHackernewsRepository();

    when(repository.getTopstories(10)).thenAnswer((realInvocation) async => stories);

    cubit = TopStoriesCubit(repository);
  });

  test('Emits stories when repository answers correctly', () async {
    await expectLater(cubit, emits(TopStoriesLoaded(stories)));
  });
}