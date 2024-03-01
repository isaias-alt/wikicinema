import 'package:wikicinema/domain/entities/video.dart';
import 'package:wikicinema/infrastructure/models/moviedb/moviedb_videos.dart';

class VideoMapper {
  static Video moviedbToEntity(Result moviedbVideo) => Video(
        id: moviedbVideo.id,
        name: moviedbVideo.name,
        youtubeKey: moviedbVideo.key,
        publishedAt: moviedbVideo.publishedAt,
      );
}
