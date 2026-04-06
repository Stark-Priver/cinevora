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
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: AppColors.divider, width: 0.5),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: currentTab,
              onTap: (i) =>
                  ref.read(currentTabProvider.notifier).state = i,
              backgroundColor: AppColors.surface,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: AppColors.textSecondary,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              selectedLabelStyle: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
              unselectedLabelStyle: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w400,
              ),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined, size: 22),
                  activeIcon: Icon(Icons.home, size: 22),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search_outlined, size: 22),
                  activeIcon: Icon(Icons.search, size: 22),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.grid_view_outlined, size: 22),
                  activeIcon: Icon(Icons.grid_view, size: 22),
                  label: 'Browse',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.menu_book_outlined, size: 22),
                  activeIcon: Icon(Icons.menu_book, size: 22),
                  label: 'Manga',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.music_note_outlined, size: 22),
                  activeIcon: Icon(Icons.music_note, size: 22),
                  label: 'Music',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
