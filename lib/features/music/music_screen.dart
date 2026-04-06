// lib/features/music/music_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_theme.dart';
import '../../data/providers.dart';
import '../../models/models.dart';
import 'full_player_screen.dart';

class MusicScreen extends ConsumerWidget {
  const MusicScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tracks = ref.watch(tracksProvider);
    final player = ref.watch(playerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              sliver: SliverToBoxAdapter(
                child: Text('Music',
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 8)),
            // Now Playing card
            if (player.currentTrack != null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: _NowPlayingCard(
                    track: player.currentTrack!,
                    isPlaying: player.isPlaying,
                    progress: player.progress,
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) =>
                              const FullPlayerScreen(),
                          transitionsBuilder: (_, animation, __, child) =>
                              SlideTransition(
                            position: animation.drive(
                              Tween(
                                      begin: const Offset(0, 1),
                                      end: Offset.zero)
                                  .chain(CurveTween(curve: Curves.easeOut)),
                            ),
                            child: child,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            // Track list
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => _TrackRow(
                    track: tracks[i],
                    index: i,
                    isActive: player.currentTrack?.id == tracks[i].id,
                    isPlaying:
                        player.currentTrack?.id == tracks[i].id &&
                            player.isPlaying,
                  ),
                  childCount: tracks.length,
                ),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

class _NowPlayingCard extends StatelessWidget {
  final MusicTrack track;
  final bool isPlaying;
  final double progress;
  final VoidCallback onTap;

  const _NowPlayingCard({
    required this.track,
    required this.isPlaying,
    required this.progress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 4,
                  height: 4,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6),
                Text('NOW PLAYING',
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.primary,
                          letterSpacing: 1.2,
                          fontSize: 10,
                        )),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: track.albumArt,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    placeholder: (_, __) =>
                        Container(color: AppColors.background),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(track.title,
                          style:
                              Theme.of(context).textTheme.titleMedium),
                      Text(track.artist,
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                Icon(
                  isPlaying
                      ? Icons.pause_circle_outline
                      : Icons.play_circle_outline,
                  color: AppColors.primary,
                  size: 36,
                ),
              ],
            ),
            const SizedBox(height: 12),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: AppColors.divider,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.primary),
              minHeight: 2,
            ),
          ],
        ),
      ),
    );
  }
}

class _TrackRow extends ConsumerWidget {
  final MusicTrack track;
  final int index;
  final bool isActive;
  final bool isPlaying;

  const _TrackRow({
    required this.track,
    required this.index,
    required this.isActive,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return InkWell(
      onTap: () {
        ref.read(playerProvider.notifier).playTrack(track, index);
      },
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            // Album art
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: track.albumArt,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
                placeholder: (_, __) =>
                    Container(color: AppColors.surface),
              ),
            ),
            const SizedBox(width: 14),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    track.title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isActive
                              ? AppColors.primary
                              : AppColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    '${track.artist}  •  ${track.album}',
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Duration / playing icon
            if (isPlaying)
              const Icon(Icons.equalizer, color: AppColors.primary, size: 18)
            else
              Text(track.duration,
                  style: Theme.of(context).textTheme.bodySmall),
          ],
        ),
      ),
    );
  }
}
