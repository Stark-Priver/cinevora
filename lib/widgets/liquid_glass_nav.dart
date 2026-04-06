import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../core/theme/app_theme.dart';

class LiquidGlassNav extends StatefulWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<NavItem> items;

  const LiquidGlassNav({
    required this.currentIndex,
    required this.onTap,
    required this.items,
  });

  @override
  State<LiquidGlassNav> createState() => _LiquidGlassNavState();
}

class NavItem {
  final IconData icon;
  final IconData activeIcon;
  final String label;

  NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });
}

class _LiquidGlassNavState extends State<LiquidGlassNav>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _labelAnimations;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _controllers = List.generate(widget.items.length, (i) {
      return AnimationController(
        duration: const Duration(milliseconds: 500),
        vsync: this,
      );
    });

    _labelAnimations = _controllers
        .map((controller) => Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(parent: controller, curve: Curves.easeInOutCubic),
            ))
        .toList();

    _controllers[widget.currentIndex].forward();
  }

  @override
  void didUpdateWidget(LiquidGlassNav oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _controllers[oldWidget.currentIndex].reverse();
      _controllers[widget.currentIndex].forward();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface.withValues(alpha: 0.7),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.glass,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 20,
                spreadRadius: 0,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              widget.items.length,
              (index) => Flexible(
                child: _buildNavItem(index),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final isActive = index == widget.currentIndex;
    final animation = _labelAnimations[index];

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        // Calculate container width with proper padding buffer
        // Icon (22) + padding (24) + animated label space (68) + buffer (4)
        final baseWidth = 46.0; // icon (22) + horizontal padding (24)
        final labelSpace = 68.0; // label (60) + spacing (8)
        final buffer = 4.0; // buffer for rendering precision
        final containerWidth =
            baseWidth + (labelSpace * animation.value) + buffer;

        return GestureDetector(
          onTap: () => widget.onTap(index),
          child: SizedBox(
            width: containerWidth,
            height: 50,
            child: Container(
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.primary.withValues(alpha: 0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isActive
                      ? AppColors.primary.withValues(alpha: 0.3)
                      : Colors.transparent,
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              child: ClipRect(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      isActive
                          ? widget.items[index].activeIcon
                          : widget.items[index].icon,
                      size: 22,
                      color: isActive
                          ? AppColors.primary
                          : AppColors.textSecondary,
                    ),
                    // Animated label space
                    if (animation.value > 0)
                      SizedBox(
                        width: 8 * animation.value,
                      ),
                    // Animated label
                    if (animation.value > 0)
                      Flexible(
                        child: Opacity(
                          opacity: animation.value,
                          child: Text(
                            widget.items[index].label,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
