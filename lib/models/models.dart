// lib/models/models.dart

class Movie {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String backdropUrl;
  final String year;
  final String duration;
  final double rating;
  final List<String> genres;

  const Movie({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.backdropUrl,
    required this.year,
    required this.duration,
    required this.rating,
    required this.genres,
  });
}

class Anime {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String backdropUrl;
  final String year;
  final int episodes;
  final double rating;
  final List<String> genres;
  final String status;

  const Anime({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.backdropUrl,
    required this.year,
    required this.episodes,
    required this.rating,
    required this.genres,
    required this.status,
  });
}

class MusicTrack {
  final String id;
  final String title;
  final String artist;
  final String album;
  final String albumArt;
  final String duration;
  final int durationSeconds;

  const MusicTrack({
    required this.id,
    required this.title,
    required this.artist,
    required this.album,
    required this.albumArt,
    required this.duration,
    required this.durationSeconds,
  });
}

class MangaChapter {
  final int number;
  final String title;
  final List<String> pages;

  const MangaChapter({
    required this.number,
    required this.title,
    required this.pages,
  });
}

class Manga {
  final String id;
  final String title;
  final String description;
  final String coverUrl;
  final String author;
  final List<String> genres;
  final int chapters;
  final double rating;
  final List<MangaChapter> chapterList;

  const Manga({
    required this.id,
    required this.title,
    required this.description,
    required this.coverUrl,
    required this.author,
    required this.genres,
    required this.chapters,
    required this.rating,
    required this.chapterList,
  });
}

class YouTubeVideo {
  final String id;
  final String title;
  final String channel;
  final String thumbnailUrl;
  final String duration;
  final String views;
  final String uploadedAgo;

  const YouTubeVideo({
    required this.id,
    required this.title,
    required this.channel,
    required this.thumbnailUrl,
    required this.duration,
    required this.views,
    required this.uploadedAgo,
  });
}

class ContinueWatching {
  final String id;
  final String title;
  final String imageUrl;
  final double progress; // 0.0 to 1.0
  final String type; // movie, anime, etc.
  final String subtitle;

  const ContinueWatching({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.progress,
    required this.type,
    required this.subtitle,
  });
}
