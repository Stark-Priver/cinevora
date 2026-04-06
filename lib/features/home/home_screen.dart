// lib/features/home/home_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_theme.dart';
import '../../data/mock_data.dart';
import '../../data/providers.dart';
import '../../widgets/shared_widgets.dart';
import '../player/video_player_screen.dart';
import '../media/movie_detail_screen.dart';
import '../media/anime_detail_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(moviesProvider);
    final animeList = ref.watch(animeProvider);
    final tracks = ref.watch(tracksProvider);
    final mangaList = ref.watch(mangaListProvider);
    final youtubeVideos = ref.watch(youtubeVideosProvider);
    final continueList = ref.watch(continueWatchingProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            pinned: false,
            floating: true,
            title: Row(
              children: [
                Text(
                  'CINEVORA',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: AppColors.primary,
                        letterSpacing: 2,
                        fontSize: 18,
                      ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined,
                    color: AppColors.textSecondary),
                onPressed: () {},
              ),
              const SizedBox(width: 4),
            ],
          ),

          // Content
          SliverList(
            delegate: SliverChildListDelegate([
              // Featured Banner
              _FeaturedBanner(),
              const SizedBox(height: 32),

              // Continue Watching
              HorizontalSection(
                title: 'Continue Watching',
                height: 170,
                items: continueList
                    .map((item) => ContinueWatchingCard(
                          item: item,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const VideoPlayerScreen()),
                            );
                          },
                        ))
                    .toList(),
              ),
              const SizedBox(height: 32),

              // Movies
              HorizontalSection(
                title: 'Movies',
                actionLabel: 'See all',
                height: 220,
                items: movies
                    .map((m) => MediaCard(
                          imageUrl: m.imageUrl,
                          title: m.title,
                          subtitle: '${m.year}  ${m.duration}',
                          badge: RatingBadge(rating: m.rating),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => MovieDetailScreen(movie: m)),
                            );
                          },
                        ))
                    .toList(),
              ),
              const SizedBox(height: 32),

              // Anime
              HorizontalSection(
                title: 'Anime',
                actionLabel: 'See all',
                height: 220,
                items: animeList
                    .map((a) => MediaCard(
                          imageUrl: a.imageUrl,
                          title: a.title,
                          subtitle: '${a.episodes} eps  ${a.status}',
                          badge: RatingBadge(rating: a.rating),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AnimeDetailScreen(anime: a)),
                            );
                          },
                        ))
                    .toList(),
              ),
              const SizedBox(height: 32),

              // YouTube
              _YouTubeSection(videos: youtubeVideos),
              const SizedBox(height: 32),

              // Music
              HorizontalSection(
                title: 'Music',
                actionLabel: 'See all',
                height: 190,
                items: tracks
                    .map((t) => MediaCard(
                          imageUrl: t.albumArt,
                          title: t.title,
                          subtitle: t.artist,
                          width: 140,
                          aspectRatio: 1,
                          onTap: () {
                            final idx = tracks.indexOf(t);
                            ref.read(playerProvider.notifier).playTrack(t, idx);
                          },
                        ))
                    .toList(),
              ),
              const SizedBox(height: 32),

              // Manga
              HorizontalSection(
                title: 'Manga',
                actionLabel: 'See all',
                height: 220,
                items: mangaList
                    .map((m) => MediaCard(
                          imageUrl: m.coverUrl,
                          title: m.title,
                          subtitle: '${m.chapters} chapters',
                          badge: RatingBadge(rating: m.rating),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 40),
            ]),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Featured Banner
// ─────────────────────────────────────────────
class _FeaturedBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const VideoPlayerScreen()),
        );
      },
      child: SizedBox(
        height: 420,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: MockData.featuredBackdrop,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: AppColors.surface),
            ),
            // Flat dark overlay (no gradient)
            Container(color: const Color(0x55000000)),
            // Bottom overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              height: 200,
              child: Container(color: const Color(0xCC0B0F1A)),
            ),
            // Content
            Positioned(
              bottom: 24,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'FEATURED',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    MockData.featuredTitle,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w800,
                          letterSpacing: -0.5,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    MockData.featuredDescription,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _WatchButton(),
                      const SizedBox(width: 12),
                      _AddButton(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WatchButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const VideoPlayerScreen()),
        );
      },
      icon: const Icon(Icons.play_arrow, size: 18),
      label: const Text('Watch Now'),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
        textStyle: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () {},
      icon: const Icon(Icons.add, size: 18),
      label: const Text('My List'),
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.textPrimary,
        side: const BorderSide(color: AppColors.divider),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        textStyle: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// YouTube Section
// ─────────────────────────────────────────────
class _YouTubeSection extends StatelessWidget {
  final List videos;

  const _YouTubeSection({required this.videos});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(title: 'YouTube', actionLabel: 'Open'),
        const SizedBox(height: 12),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: videos.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (_, i) {
              final v = videos[i];
              return SizedBox(
                width: 240,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: v.thumbnailUrl,
                              fit: BoxFit.cover,
                              placeholder: (_, __) =>
                                  Container(color: AppColors.surface),
                            ),
                            Container(color: const Color(0x30000000)),
                            Positioned(
                              bottom: 6,
                              right: 6,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xCC000000),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  v.duration,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Flexible(
                      child: Text(
                        v.title,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Flexible(
                      child: Text(
                        '${v.channel}  •  ${v.views}',
                        style: Theme.of(context).textTheme.bodySmall,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
