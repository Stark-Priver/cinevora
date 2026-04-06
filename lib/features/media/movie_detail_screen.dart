// lib/features/media/movie_detail_screen.dart
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_theme.dart';
import '../../models/models.dart';
import '../../widgets/shared_widgets.dart';
import '../player/video_player_screen.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Backdrop
          SliverAppBar(
            expandedHeight: 320,
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
                    imageUrl: movie.backdropUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, __) =>
                        Container(color: AppColors.surface),
                  ),
                  Container(color: const Color(0x55000000)),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    height: 120,
                    child: Container(color: const Color(0xCC0B0F1A)),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Title
                Text(movie.title,
                    style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(height: 8),
                // Meta row
                Row(
                  children: [
                    RatingBadge(rating: movie.rating),
                    const SizedBox(width: 12),
                    Text(movie.year,
                        style: Theme.of(context).textTheme.bodySmall),
                    const SizedBox(width: 12),
                    Text(movie.duration,
                        style: Theme.of(context).textTheme.bodySmall),
                  ],
                ),
                const SizedBox(height: 12),
                // Genres
                Wrap(
                  spacing: 8,
                  runSpacing: 6,
                  children: movie.genres
                      .map((g) => GenreTag(label: g))
                      .toList(),
                ),
                const SizedBox(height: 16),
                // Description
                Text(movie.description,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(height: 1.6)),
                const SizedBox(height: 24),
                // Actions
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    const VideoPlayerScreen()),
                          );
                        },
                        icon: const Icon(Icons.play_arrow, size: 20),
                        label: const Text('Watch Now'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          padding:
                              const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                          textStyle: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                        side: const BorderSide(color: AppColors.divider),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Icon(Icons.add, size: 22),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.textPrimary,
                        side: const BorderSide(color: AppColors.divider),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 14),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: const Icon(Icons.download_outlined, size: 22),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                // More like this
                Text('More Like This',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                const _RelatedGrid(),
                const SizedBox(height: 24),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _RelatedGrid extends StatelessWidget {
  const _RelatedGrid();

  static const _items = [
    (
      'The Last Harbor',
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400&q=80',
      '8.1'
    ),
    (
      'Iron Veil',
      'https://images.unsplash.com/photo-1478720568477-152d9b164e26?w=400&q=80',
      '7.6'
    ),
    (
      'Soft Architecture',
      'https://images.unsplash.com/photo-1545324418-cc1a3fa10c00?w=400&q=80',
      '8.7'
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) => MediaCard(
          imageUrl: _items[i].$2,
          title: _items[i].$1,
          badge: RatingBadge(rating: double.parse(_items[i].$3)),
        ),
      ),
    );
  }
}
