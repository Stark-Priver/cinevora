// lib/features/player/video_player_screen.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_theme.dart';

class VideoPlayerScreen extends StatefulWidget {
  const VideoPlayerScreen({super.key});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  bool _isPlaying = true;
  bool _showControls = true;
  double _progress = 0.22;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    _startHideTimer();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    super.dispose();
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) setState(() => _showControls = false);
    });
  }

  void _onTap() {
    setState(() => _showControls = !_showControls);
    if (_showControls) _startHideTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: _onTap,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Video placeholder
            Container(
              color: const Color(0xFF0A0A0A),
              child: const Center(
                child: Icon(Icons.movie_outlined,
                    color: Color(0xFF2A2A2A), size: 80),
              ),
            ),

            // Controls overlay
            AnimatedOpacity(
              opacity: _showControls ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: IgnorePointer(
                ignoring: !_showControls,
                child: _Controls(
                  isPlaying: _isPlaying,
                  progress: _progress,
                  onPlayPause: () {
                    setState(() => _isPlaying = !_isPlaying);
                    _startHideTimer();
                  },
                  onSeek: (v) {
                    setState(() => _progress = v);
                    _startHideTimer();
                  },
                  onBack: () => Navigator.pop(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Controls extends StatelessWidget {
  final bool isPlaying;
  final double progress;
  final VoidCallback onPlayPause;
  final ValueChanged<double> onSeek;
  final VoidCallback onBack;

  const _Controls({
    required this.isPlaying,
    required this.progress,
    required this.onPlayPause,
    required this.onSeek,
    required this.onBack,
  });

  String _formatTime(double progress) {
    // Mock: 2h18m total
    const totalSeconds = 8280;
    final current = (progress * totalSeconds).toInt();
    final m = current ~/ 60;
    final s = current % 60;
    return '$m:${s.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Top bar
        Container(
          color: const Color(0xCC000000),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new,
                        color: Colors.white, size: 20),
                    onPressed: onBack,
                  ),
                  const Expanded(
                    child: Text(
                      'Obsidian Dusk',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings_outlined,
                        color: Colors.white70, size: 20),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),

        const Spacer(),

        // Center play/pause
        GestureDetector(
          onTap: onPlayPause,
          child: Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.5),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white30),
            ),
            child: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
              size: 32,
            ),
          ),
        ),

        const Spacer(),

        // Bottom controls
        Container(
          color: const Color(0xCC000000),
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            children: [
              // Seek bar
              SliderTheme(
                data: SliderThemeData(
                  trackHeight: 2,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 6),
                  overlayShape:
                      const RoundSliderOverlayShape(overlayRadius: 14),
                  activeTrackColor: AppColors.primary,
                  inactiveTrackColor: const Color(0x40FFFFFF),
                  thumbColor: Colors.white,
                  overlayColor: AppColors.primary.withValues(alpha: 0.2),
                ),
                child: Slider(
                  value: progress,
                  onChanged: onSeek,
                ),
              ),
              // Time row
              Row(
                children: [
                  Text(
                    _formatTime(progress),
                    style: const TextStyle(
                        color: AppColors.textSecondary, fontSize: 12),
                  ),
                  const Spacer(),
                  // Skip buttons
                  IconButton(
                    icon: const Icon(Icons.replay_10,
                        color: Colors.white, size: 24),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 16),
                  IconButton(
                    icon: const Icon(Icons.forward_30,
                        color: Colors.white, size: 24),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 16),
                  const Text(
                    '2:18:00',
                    style:
                        TextStyle(color: AppColors.textSecondary, fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
