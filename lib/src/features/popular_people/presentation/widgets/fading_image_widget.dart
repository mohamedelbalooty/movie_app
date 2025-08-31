import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FadingImageWidget extends StatelessWidget {
  final String imageUrl;
  final Widget? placeholder;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const FadingImageWidget({
    super.key,
    required this.imageUrl,
    this.placeholder,
    this.width,
    this.height,
    this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: width,
      height: height,
      fit: fit,
      placeholder: (context, url) =>
          placeholder ??
          const Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
      imageBuilder: (context, imageProvider) => AnimatedOpacity(
        opacity: 1.0,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        child: Image(
          image: imageProvider,
          width: width,
          height: height,
          fit: fit,
        ),
      ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        color: Colors.red[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error, color: Colors.red, size: 40),
            const SizedBox(height: 8),
            Text(
              'Error loading image',
              style: TextStyle(color: Colors.red[700]),
            ),
          ],
        ),
      ),
    );
  }
}
