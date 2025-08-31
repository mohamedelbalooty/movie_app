import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/src/core/network/download_service.dart';
import 'package:movie_app/src/core/utils/app_colors.dart';

class DownloadButton extends StatefulWidget {
  final String imageUrl;
  final String? fileName;

  const DownloadButton({Key? key, required this.imageUrl, this.fileName})
    : super(key: key);

  @override
  _DownloadButtonState createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton> {
  bool _isDownloading = false;

  void _downloadImage() async {
    setState(() {
      _isDownloading = true;
    });

    final taskId = await DownloadService.downloadImageSimple(
      widget.imageUrl,
      widget.fileName,
    );

    setState(() {
      _isDownloading = false;
    });

    if (taskId != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('download_success'.tr())));
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('download_failed'.tr())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: const ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor),
      ),
      onPressed: _isDownloading ? null : _downloadImage,
      child: _isDownloading
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                const SizedBox(width: 8),
                Text('${'downloading'.tr()}...'),
              ],
            )
          : Text(
              'download'.tr(),
              style: const TextStyle(color: AppColors.whiteColor, fontSize: 16),
            ),
    );
  }
}
