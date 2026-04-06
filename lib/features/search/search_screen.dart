// lib/features/search/search_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/theme/app_theme.dart';
import '../../data/providers.dart';
import '../../models/models.dart';
import '../../widgets/shared_widgets.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final search = ref.watch(searchProvider);
    final filters = ['All', 'Movies', 'Anime', 'Manga', 'Music'];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Text(
                'Search',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 16),
            // Search bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CinevoraSearchBar(
                controller: _controller,
                onChanged: (q) =>
                    ref.read(searchProvider.notifier).search(q),
              ),
            ),
            const SizedBox(height: 16),
            // Filter chips
            ChipFilter(
              filters: filters,
              selected: search.activeFilter,
              onSelected: (f) =>
                  ref.read(searchProvider.notifier).setFilter(f),
            ),
            const SizedBox(height: 16),
            // Results or default
            Expanded(
              child: search.query.isEmpty
                  ? _DefaultSearchView()
                  : _SearchResults(
                      results: search.results,
                      filter: search.activeFilter,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DefaultSearchView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trending = [
      'Riftborn',
      'Obsidian Dusk',
      'Null Protocol',
      'The Quiet Fracture',
      'Iron Folklore',
      'Pale Meridian',
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Trending Searches',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          ...trending.map((t) => _TrendingItem(title: t)),
          const SizedBox(height: 24),
          Text('Browse Categories',
              style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          _CategoriesGrid(),
        ],
      ),
    );
  }
}

class _TrendingItem extends StatelessWidget {
  final String title;
  const _TrendingItem({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 1),
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        leading: const Icon(Icons.trending_up,
            color: AppColors.textSecondary, size: 18),
        title: Text(title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.textPrimary)),
        trailing: const Icon(Icons.north_west,
            color: AppColors.textSecondary, size: 16),
        onTap: () {},
      ),
    );
  }
}

class _CategoriesGrid extends StatelessWidget {
  final _cats = const [
    ('Movies', Icons.movie_outlined),
    ('Anime', Icons.animation_outlined),
    ('Manga', Icons.menu_book_outlined),
    ('Music', Icons.music_note_outlined),
    ('Animation', Icons.theaters_outlined),
    ('Trending', Icons.whatshot_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2.4,
      children: _cats.map((c) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.divider),
          ),
          child: Row(
            children: [
              const SizedBox(width: 16),
              Icon(c.$2, color: AppColors.primary, size: 22),
              const SizedBox(width: 12),
              Text(c.$1,
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall
                      ?.copyWith(color: AppColors.textPrimary)),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _SearchResults extends StatelessWidget {
  final List results;
  final String filter;

  const _SearchResults({required this.results, required this.filter});

  @override
  Widget build(BuildContext context) {
    final filtered = filter == 'All'
        ? results
        : results.where((r) {
            if (filter == 'Movies') return r is Movie;
            if (filter == 'Anime') return r is Anime;
            if (filter == 'Manga') return r is Manga;
            if (filter == 'Music') return r is MusicTrack;
            return true;
          }).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off, color: AppColors.textSecondary, size: 48),
            const SizedBox(height: 12),
            Text('No results found',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.65,
      ),
      itemCount: filtered.length,
      itemBuilder: (context, i) {
        final item = filtered[i];
        String imageUrl = '';
        String title = '';
        String subtitle = '';

        if (item is Movie) {
          imageUrl = item.imageUrl;
          title = item.title;
          subtitle = item.year;
        } else if (item is Anime) {
          imageUrl = item.imageUrl;
          title = item.title;
          subtitle = '${item.episodes} eps';
        } else if (item is Manga) {
          imageUrl = item.coverUrl;
          title = item.title;
          subtitle = item.author;
        } else if (item is MusicTrack) {
          imageUrl = item.albumArt;
          title = item.title;
          subtitle = item.artist;
        }

        return _ResultCard(
          imageUrl: imageUrl,
          title: title,
          subtitle: subtitle,
        );
      },
    );
  }
}

class _ResultCard extends StatefulWidget {
  final String imageUrl;
  final String title;
  final String subtitle;

  const _ResultCard({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
  });

  @override
  State<_ResultCard> createState() => _ResultCardState();
}

class _ResultCardState extends State<_ResultCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 150));
    _scale = Tween<double>(begin: 1.0, end: 1.03).animate(_ctrl);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: GestureDetector(
        onTapDown: (_) => _ctrl.forward(),
        onTapUp: (_) => _ctrl.reverse(),
        onTapCancel: () => _ctrl.reverse(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: widget.imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (_, __) =>
                      Container(color: AppColors.surface),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(widget.title,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w500),
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
            Text(widget.subtitle,
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
