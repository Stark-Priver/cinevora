// lib/features/browse/browse_screen.dart
import 'package:flutter/material.dart';
import '../../core/theme/app_theme.dart';

class BrowseScreen extends StatelessWidget {
  const BrowseScreen({super.key});

  static const _categories = [
    _Category('Movies', Icons.movie_outlined, 'Thousands of titles'),
    _Category('Anime', Icons.animation_outlined, 'Japanese animation'),
    _Category('Manga', Icons.menu_book_outlined, 'Read digital manga'),
    _Category('Animation', Icons.theaters_outlined, 'Western & world animation'),
    _Category('Trending', Icons.whatshot_outlined, 'What\'s popular now'),
    _Category('New Releases', Icons.fiber_new_outlined, 'Recently added'),
    _Category('Music', Icons.music_note_outlined, 'Tracks & albums'),
    _Category('YouTube', Icons.play_circle_outline, 'Video content'),
    _Category('Top Rated', Icons.star_outline, 'Critically acclaimed'),
    _Category('Documentaries', Icons.camera_outlined, 'Real stories'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Text(
                'Browse',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.6,
                ),
                itemCount: _categories.length,
                itemBuilder: (context, i) =>
                    _CategoryCard(category: _categories[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Category {
  final String name;
  final IconData icon;
  final String subtitle;

  const _Category(this.name, this.icon, this.subtitle);
}

class _CategoryCard extends StatefulWidget {
  final _Category category;

  const _CategoryCard({super.key, required this.category});

  @override
  State<_CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<_CategoryCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 180));
    _scale = Tween<double>(begin: 1.0, end: 1.03).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) => _ctrl.reverse(),
      onTapCancel: () => _ctrl.reverse(),
      child: ScaleTransition(
        scale: _scale,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.divider),
          ),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(widget.category.icon,
                  color: AppColors.primary, size: 28),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.category.name,
                    style:
                        Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    widget.category.subtitle,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
