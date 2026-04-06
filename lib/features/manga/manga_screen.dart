// lib/features/manga/manga_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../data/providers.dart';
import '../../widgets/shared_widgets.dart';
import 'manga_reader_screen.dart';

class MangaScreen extends ConsumerWidget {
  const MangaScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mangaList = ref.watch(mangaListProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              sliver: SliverToBoxAdapter(
                child: Text('Manga',
                    style: Theme.of(context).textTheme.headlineMedium),
              ),
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 16)),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.6,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    final m = mangaList[i];
                    return MediaCard(
                      imageUrl: m.coverUrl,
                      title: m.title,
                      subtitle: '${m.chapters} chapters  •  ${m.author}',
                      badge: RatingBadge(rating: m.rating),
                      width: double.infinity,
                      onTap: () {
                        ref
                            .read(mangaReaderProvider.notifier)
                            .openManga(m);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const MangaReaderScreen()),
                        );
                      },
                    );
                  },
                  childCount: mangaList.length,
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
