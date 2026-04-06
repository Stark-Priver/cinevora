// lib/features/music/full_player_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_theme.dart';
import '../../data/providers.dart';

class FullPlayerScreen extends ConsumerWidget {
  const FullPlayerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final player = ref.watch(playerProvider);
    final track = player.currentTrack;

    if (track == null) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: Text('No track selected')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: AppColors.textPrimary, size: 28),
                    onPressed: () => Navigator.pop(context),
                    padding: EdgeInsets.zero,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text('NOW PLAYING',
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(
                                  letterSpacing: 1.5,
                                  fontSize: 10,
                                  color: AppColors.textSecondary,
                                )),
                        Text(track.album,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert,
                        color: AppColors.textSecondary),
                    onPressed: () => _showQueueSheet(context, ref),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
            ),

            // Album art
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Center(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl: track.albumArt,
                        fit: BoxFit.cover,
                        placeholder: (_, __) =>
                            Container(color: AppColors.surface),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Info + controls
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
              child: Column(
                children: [
                  // Title & artist
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(track.title,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis),
                            const SizedBox(height: 4),
                            Text(track.artist,
                                style: Theme.of(context).textTheme.bodyMedium),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.favorite_outline,
                            color: AppColors.textSecondary),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Progress bar
                  Column(
                    children: [
                      SliderTheme(
                        data: SliderThemeData(
                          trackHeight: 2,
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 6),
                          overlayShape: const RoundSliderOverlayShape(
                              overlayRadius: 14),
                          activeTrackColor: AppColors.primary,
                          inactiveTrackColor: AppColors.divider,
                          thumbColor: AppColors.textPrimary,
                          overlayColor: AppColors.primary.withOpacity(0.2),
                        ),
                        child: Slider(
                          value: player.progress,
                          onChanged: (v) =>
                              ref.read(playerProvider.notifier).setProgress(v),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _formatTime((player.progress *
                                      track.durationSeconds)
                                  .toInt()),
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            Text(track.duration,
                                style: Theme.of(context).textTheme.bodySmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Controls
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.shuffle,
                            color: AppColors.textSecondary, size: 22),
                        onPressed: () {},
                      ),
                      IconButton(
                        iconSize: 36,
                        icon: const Icon(Icons.skip_previous,
                            color: AppColors.textPrimary),
                        onPressed: () =>
                            ref.read(playerProvider.notifier).previous(),
                      ),
                      GestureDetector(
                        onTap: () =>
                            ref.read(playerProvider.notifier).togglePlay(),
                        child: Container(
                          width: 64,
                          height: 64,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            player.isPlaying ? Icons.pause : Icons.play_arrow,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ),
                      IconButton(
                        iconSize: 36,
                        icon: const Icon(Icons.skip_next,
                            color: AppColors.textPrimary),
                        onPressed: () =>
                            ref.read(playerProvider.notifier).next(),
                      ),
                      IconButton(
                        icon: const Icon(Icons.repeat,
                            color: AppColors.textSecondary, size: 22),
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(int seconds) {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  void _showQueueSheet(BuildContext context, WidgetRef ref) {
    final tracks = ref.read(tracksProvider);
    final player = ref.read(playerProvider);

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 36,
            height: 3,
            decoration: BoxDecoration(
              color: AppColors.divider,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text('Queue',
                style: Theme.of(context).textTheme.titleLarge),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: tracks.length,
              itemBuilder: (ctx, i) {
                final t = tracks[i];
                final isActive = player.currentTrack?.id == t.id;
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: CachedNetworkImage(
                      imageUrl: t.albumArt,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(t.title,
                      style: TextStyle(
                        color: isActive
                            ? AppColors.primary
                            : AppColors.textPrimary,
                        fontWeight: isActive
                            ? FontWeight.w600
                            : FontWeight.w400,
                        fontSize: 14,
                      )),
                  subtitle: Text(t.artist,
                      style: const TextStyle(
                          color: AppColors.textSecondary, fontSize: 12)),
                  trailing: isActive
                      ? const Icon(Icons.equalizer,
                          color: AppColors.primary, size: 18)
                      : null,
                  onTap: () {
                    ref.read(playerProvider.notifier).playTrack(t, i);
                    Navigator.pop(ctx);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
