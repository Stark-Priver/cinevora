// lib/features/media/anime_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_theme.dart';
import '../../models/models.dart';
import '../../widgets/shared_widgets.dart';
import '../player/video_player_screen.dart';

class AnimeDetailScreen extends StatelessWidget {
  final Anime anime;

  const AnimeDetailScreen({super.key, required this.anime});

  @override
  Widget build(BuildContext context) {
    // Mock episodes
    final episodes = List.generate(
      anime.episodes.clamp(0, 12),
      (i) => _MockEpisode(
        number: i + 1,
        title: 'Episode ${i + 1}',
        duration: '24 min',
        thumbnail:
            'https://images.unsplash.com/photo-1578632767115-351597cf2477?w=300&q=80',
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.background,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new,
                  color: Colors.white, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
                    imageUrl: anime.backdropUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, __) =>
                        Container(color: AppColors.surface),
                  ),
                  Container(color: const Color(0x55000000)),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 100,
                    child: Container(color: const Color(0xCC0B0F1A)),
                  ),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Text(anime.title,
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 8),
                Row(
                  children: [
                    RatingBadge(rating: anime.rating),
                    const SizedBox(width: 12),
                    Text(anime.year,
                        style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: anime.status == 'Ongoing'
                            ? AppColors.primary.withOpacity(0.15)
                            : AppColors.surface,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: anime.status == 'Ongoing'
                                ? AppColors.primary.withOpacity(0.4)
                                : AppColors.divider),
                      ),
                      child: Text(
                        anime.status,
                        style: TextStyle(
                          color: anime.status == 'Ongoing'
                              ? AppColors.primary
                              : AppColors.textSecondary,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: anime.genres
                      .map((g) => GenreTag(label: g))
                      .toList(),
                ),
                const SizedBox(height: 16),
                Text(anime.description,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(height: 1.6)),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const VideoPlayerScreen()),
                    );
                  },
                  icon: const Icon(Icons.play_arrow, size: 20),
                  label: const Text('Play Episode 1'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 0,
                    minimumSize: const Size(double.infinity, 0),
                    textStyle: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15),
                  ),
                ),
                const SizedBox(height: 32),
                Text('Episodes (${anime.episodes})',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                ...episodes.map((ep) => _EpisodeRow(episode: ep)),
                const SizedBox(height: 24),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _MockEpisode {
  final int number;
  final String title;
  final String duration;
  final String thumbnail;

  const _MockEpisode({
    required this.number,
    required this.title,
    required this.duration,
    required this.thumbnail,
  });
}

class _EpisodeRow extends StatelessWidget {
  final _MockEpisode episode;

  const _EpisodeRow({super.key, required this.episode});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const VideoPlayerScreen()),
        );
      },
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: episode.thumbnail,
                width: 100,
                height: 60,
                fit: BoxFit.cover,
                placeholder: (_, __) =>
                    Container(color: AppColors.surface, width: 100, height: 60),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ep. ${episode.number}  ${episode.title}',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(episode.duration,
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ),
            const Icon(Icons.play_circle_outline,
                color: AppColors.textSecondary, size: 24),
          ],
        ),
      ),
    );
  }
}
