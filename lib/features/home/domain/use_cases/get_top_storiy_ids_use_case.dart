import 'package:hacker_news/features/home/data/repositories/hackernews_repo.dart';

class GetTopStoriyIdsUseCase {
  GetTopStoriyIdsUseCase({required this.newsRepo});

  final HackernewsRepo newsRepo;

  Future<List<int>> execute() => newsRepo.getTopstories();
}
