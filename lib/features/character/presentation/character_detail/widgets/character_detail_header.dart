import 'package:flutter/material.dart';

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
      height: 360,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            imageUrl,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;

              return const ColoredBox(
                color: Color(0xFFE3E3E3),
                child: Center(
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return const ColoredBox(
                color: Color(0xFFE3E3E3),
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
                  Colors.black.withValues(alpha: 0.75),
                ],
                stops: const [0.5, 1],
              ),
            ),
          ),
          Positioned(
            top: 12,
            left: 8,
            child: SafeArea(
              bottom: false,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).maybePop(),
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 20,
            right: 20,
            child: Text(
              name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
