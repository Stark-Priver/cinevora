// lib/features/manga/manga_reader_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_theme.dart';
import '../../data/providers.dart';

class MangaReaderScreen extends ConsumerStatefulWidget {
  const MangaReaderScreen({super.key});

  @override
  ConsumerState<MangaReaderScreen> createState() => _MangaReaderScreenState();
}

class _MangaReaderScreenState extends ConsumerState<MangaReaderScreen> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  void dispose() {
    _pageController.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final readerState = ref.watch(mangaReaderProvider);
    final manga = readerState.manga;
    if (manga == null) return const SizedBox.shrink();

    final chapter = manga.chapterList.isNotEmpty
        ? manga.chapterList[readerState.currentChapter.clamp(
            0, manga.chapterList.length - 1)]
        : null;

    final pages = chapter?.pages ?? [];

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () =>
            ref.read(mangaReaderProvider.notifier).toggleUI(),
        child: Stack(
          children: [
            // Reader
            readerState.isScrollMode
                ? _VerticalScrollReader(pages: pages)
                : _PageSwipeReader(
                    pages: pages,
                    controller: _pageController,
                    currentPage: readerState.currentPage,
                    onPageChanged: (p) =>
                        ref.read(mangaReaderProvider.notifier).setPage(p),
                  ),

            // UI overlay
            AnimatedOpacity(
              opacity: readerState.showUI ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: IgnorePointer(
                ignoring: !readerState.showUI,
                child: Column(
                  children: [
                    // Top bar
                    _TopBar(
                      title: manga.title,
                      chapterTitle: chapter?.title ?? '',
                      isScrollMode: readerState.isScrollMode,
                      onToggleMode: () => ref
                          .read(mangaReaderProvider.notifier)
                          .toggleScrollMode(),
                    ),
                    const Spacer(),
                    // Bottom bar
                    if (!readerState.isScrollMode)
                      _BottomPageIndicator(
                        currentPage: readerState.currentPage,
                        totalPages: pages.length,
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _VerticalScrollReader extends StatelessWidget {
  final List<String> pages;

  const _VerticalScrollReader({required this.pages});

  @override
  Widget build(BuildContext context) {
    if (pages.isEmpty) {
      return const Center(
        child: Text('No pages available',
            style: TextStyle(color: AppColors.textSecondary)),
      );
    }
    return ListView.builder(
      itemCount: pages.length,
      itemBuilder: (context, i) => CachedNetworkImage(
        imageUrl: pages[i],
        width: double.infinity,
        fit: BoxFit.fitWidth,
        placeholder: (_, __) => Container(
          height: 400,
          color: AppColors.surface,
          child: const Center(
            child: CircularProgressIndicator(
                color: AppColors.primary, strokeWidth: 2),
          ),
        ),
      ),
    );
  }
}

class _PageSwipeReader extends StatelessWidget {
  final List<String> pages;
  final PageController controller;
  final int currentPage;
  final ValueChanged<int> onPageChanged;

  const _PageSwipeReader({
    required this.pages,
    required this.controller,
    required this.currentPage,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (pages.isEmpty) {
      return const Center(
        child: Text('No pages available',
            style: TextStyle(color: AppColors.textSecondary)),
      );
    }
    return PageView.builder(
      controller: controller,
      onPageChanged: onPageChanged,
      itemCount: pages.length,
      itemBuilder: (context, i) => InteractiveViewer(
        child: CachedNetworkImage(
          imageUrl: pages[i],
          fit: BoxFit.contain,
          placeholder: (_, __) => const Center(
            child: CircularProgressIndicator(
                color: AppColors.primary, strokeWidth: 2),
          ),
        ),
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final String title;
  final String chapterTitle;
  final bool isScrollMode;
  final VoidCallback onToggleMode;

  const _TopBar({
    required this.title,
    required this.chapterTitle,
    required this.isScrollMode,
    required this.onToggleMode,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xCC000000),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back_ios_new,
                    color: Colors.white, size: 20),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 15)),
                    if (chapterTitle.isNotEmpty)
                      Text(chapterTitle,
                          style: const TextStyle(
                              color: AppColors.textSecondary, fontSize: 12)),
                  ],
                ),
              ),
              IconButton(
                tooltip: isScrollMode ? 'Switch to Page mode' : 'Switch to Scroll mode',
                icon: Icon(
                  isScrollMode ? Icons.view_day_outlined : Icons.view_carousel_outlined,
                  color: Colors.white,
                  size: 22,
                ),
                onPressed: onToggleMode,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomPageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const _BottomPageIndicator(
      {required this.currentPage, required this.totalPages});

  @override
  Widget build(BuildContext context) {
    if (totalPages == 0) return const SizedBox.shrink();
    return Container(
      color: const Color(0xCC000000),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(
            value: totalPages > 1 ? currentPage / (totalPages - 1) : 0,
            backgroundColor: const Color(0x40FFFFFF),
            valueColor:
                const AlwaysStoppedAnimation<Color>(AppColors.primary),
            minHeight: 2,
          ),
          const SizedBox(height: 8),
          Text(
            '${currentPage + 1} / $totalPages',
            style: const TextStyle(
                color: AppColors.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
