// lib/data/providers.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/models.dart';
import 'mock_data.dart';

// Navigation
final currentTabProvider = StateProvider<int>((ref) => 0);

// Music player state
class PlayerState {
  final MusicTrack? currentTrack;
  final bool isPlaying;
  final double progress; // 0.0 to 1.0
  final int currentIndex;

  const PlayerState({
    this.currentTrack,
    this.isPlaying = false,
    this.progress = 0.0,
    this.currentIndex = 0,
  });

  PlayerState copyWith({
    MusicTrack? currentTrack,
    bool? isPlaying,
    double? progress,
    int? currentIndex,
  }) {
    return PlayerState(
      currentTrack: currentTrack ?? this.currentTrack,
      isPlaying: isPlaying ?? this.isPlaying,
      progress: progress ?? this.progress,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }
}

class PlayerNotifier extends StateNotifier<PlayerState> {
  PlayerNotifier() : super(const PlayerState());

  void playTrack(MusicTrack track, int index) {
    state = state.copyWith(
      currentTrack: track,
      isPlaying: true,
      currentIndex: index,
      progress: 0.0,
    );
  }

  void togglePlay() {
    state = state.copyWith(isPlaying: !state.isPlaying);
  }

  void next() {
    const tracks = MockData.tracks;
    final nextIndex = (state.currentIndex + 1) % tracks.length;
    playTrack(tracks[nextIndex], nextIndex);
  }

  void previous() {
    const tracks = MockData.tracks;
    final prevIndex = (state.currentIndex - 1 + tracks.length) % tracks.length;
    playTrack(tracks[prevIndex], prevIndex);
  }

  void setProgress(double value) {
    state = state.copyWith(progress: value);
  }
}

final playerProvider = StateNotifierProvider<PlayerNotifier, PlayerState>(
  (ref) => PlayerNotifier(),
);

// Search
class SearchState {
  final String query;
  final String activeFilter;
  final List<dynamic> results;

  const SearchState({
    this.query = '',
    this.activeFilter = 'All',
    this.results = const [],
  });

  SearchState copyWith({
    String? query,
    String? activeFilter,
    List<dynamic>? results,
  }) {
    return SearchState(
      query: query ?? this.query,
      activeFilter: activeFilter ?? this.activeFilter,
      results: results ?? this.results,
    );
  }
}

class SearchNotifier extends StateNotifier<SearchState> {
  SearchNotifier() : super(const SearchState());

  void search(String query) {
    if (query.isEmpty) {
      state = state.copyWith(query: query, results: []);
      return;
    }
    final q = query.toLowerCase();
    final List<dynamic> results = [
      ...MockData.movies.where((m) => m.title.toLowerCase().contains(q)),
      ...MockData.animeList.where((a) => a.title.toLowerCase().contains(q)),
      ...MockData.mangaList.where((m) => m.title.toLowerCase().contains(q)),
      ...MockData.tracks.where((t) =>
          t.title.toLowerCase().contains(q) ||
          t.artist.toLowerCase().contains(q)),
    ];
    state = state.copyWith(query: query, results: results);
  }

  void setFilter(String filter) {
    state = state.copyWith(activeFilter: filter);
  }
}

final searchProvider = StateNotifierProvider<SearchNotifier, SearchState>(
  (ref) => SearchNotifier(),
);

// Data providers
final moviesProvider = Provider<List<Movie>>((ref) => MockData.movies);
final animeProvider = Provider<List<Anime>>((ref) => MockData.animeList);
final tracksProvider = Provider<List<MusicTrack>>((ref) => MockData.tracks);
final mangaListProvider = Provider<List<Manga>>((ref) => MockData.mangaList);
final youtubeVideosProvider =
    Provider<List<YouTubeVideo>>((ref) => MockData.youtubeVideos);
final continueWatchingProvider =
    Provider<List<ContinueWatching>>((ref) => MockData.continueWatching);

// Manga reader state
class MangaReaderState {
  final Manga? manga;
  final int currentChapter;
  final int currentPage;
  final bool isScrollMode; // false = swipe mode
  final bool showUI;

  const MangaReaderState({
    this.manga,
    this.currentChapter = 0,
    this.currentPage = 0,
    this.isScrollMode = true,
    this.showUI = true,
  });

  MangaReaderState copyWith({
    Manga? manga,
    int? currentChapter,
    int? currentPage,
    bool? isScrollMode,
    bool? showUI,
  }) {
    return MangaReaderState(
      manga: manga ?? this.manga,
      currentChapter: currentChapter ?? this.currentChapter,
      currentPage: currentPage ?? this.currentPage,
      isScrollMode: isScrollMode ?? this.isScrollMode,
      showUI: showUI ?? this.showUI,
    );
  }
}

class MangaReaderNotifier extends StateNotifier<MangaReaderState> {
  MangaReaderNotifier() : super(const MangaReaderState());

  void openManga(Manga manga) {
    state = state.copyWith(manga: manga, currentChapter: 0, currentPage: 0);
  }

  void toggleScrollMode() {
    state = state.copyWith(isScrollMode: !state.isScrollMode);
  }

  void toggleUI() {
    state = state.copyWith(showUI: !state.showUI);
  }

  void setPage(int page) {
    state = state.copyWith(currentPage: page);
  }

  void setChapter(int chapter) {
    state = state.copyWith(currentChapter: chapter, currentPage: 0);
  }
}

final mangaReaderProvider =
    StateNotifierProvider<MangaReaderNotifier, MangaReaderState>(
  (ref) => MangaReaderNotifier(),
);
