// lib/app_shell.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'data/providers.dart';
import 'features/home/home_screen.dart';
import 'features/search/search_screen.dart';
import 'features/browse/browse_screen.dart';
import 'features/manga/manga_screen.dart';
import 'features/music/music_screen.dart';
import 'widgets/mini_player.dart';
import 'widgets/liquid_glass_nav.dart';

class AppShell extends ConsumerWidget {
  const AppShell({super.key});

  static const _screens = [
    HomeScreen(),
    SearchScreen(),
    BrowseScreen(),
    MangaScreen(),
    MusicScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(currentTabProvider);
    final player = ref.watch(playerProvider);
    final hasPlayer = player.currentTrack != null;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: currentTab,
        children: _screens,
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (hasPlayer) const MiniPlayer(),
          LiquidGlassNav(
            currentIndex: currentTab,
            onTap: (i) => ref.read(currentTabProvider.notifier).state = i,
            items: [
              NavItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Home',
              ),
              NavItem(
                icon: Icons.search_outlined,
                activeIcon: Icons.search,
                label: 'Search',
              ),
              NavItem(
                icon: Icons.grid_view_outlined,
                activeIcon: Icons.grid_view,
                label: 'Browse',
              ),
              NavItem(
                icon: Icons.menu_book_outlined,
                activeIcon: Icons.menu_book,
                label: 'Manga',
              ),
              NavItem(
                icon: Icons.music_note_outlined,
                activeIcon: Icons.music_note,
                label: 'Music',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
