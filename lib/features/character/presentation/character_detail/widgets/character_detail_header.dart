import 'package:flutter/material.dart';
import '../../../../../core/constants/app_constants.dart';

class CharacterDetailHeader extends StatelessWidget {
  const CharacterDetailHeader({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  final String imageUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.detailHeaderHeight,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;

              return const ColoredBox(
                color: AppColors.imagePlaceholder,
                child: Center(
                  child: CircularProgressIndicator(strokeWidth: AppSizes.strokeSmall),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const ColoredBox(
                color: AppColors.imagePlaceholder,
                child: Center(
                  child: Icon(Icons.broken_image_outlined),
                ),
              );
            },
          ),
          // Degradado inferior para que el texto siempre sea legible
          // sin importar el brillo de la imagen.
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  AppColors.black.withValues(alpha: AppDesignValues.gradientAlpha),
                ],
                stops: const [0.5, 1],
              ),
            ),
          ),
          Positioned(
            top: AppSpacing.headerTop,
            left: AppSpacing.headerLeft,
            child: SafeArea(
              bottom: false,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.white),
                onPressed: () => Navigator.of(context).maybePop(),
              ),
            ),
          ),
          Positioned(
            left: AppSpacing.headerPadding,
            bottom: AppSpacing.headerPadding,
            right: AppSpacing.headerPadding,
            child: Text(
              name,
              style: const TextStyle(
                color: AppColors.white,
                fontSize: AppFontSize.headlineLarge,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
