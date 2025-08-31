import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadService {
  static final Map<String, Function(int)> _progressCallbacks = {};
  static final Map<String, Function(DownloadTaskStatus)> _statusCallbacks = {};

  static Future<void> initialize() async {
    await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
    FlutterDownloader.registerCallback(
      DownloadService.downloadCallback as DownloadCallback,
    );
  }

  @pragma('vm:entry-point')
  static void downloadCallback(
    String id,
    DownloadTaskStatus status,
    int progress,
  ) {
    if (_progressCallbacks.containsKey(id)) {
      _progressCallbacks[id]!(progress);
    }

    if (_statusCallbacks.containsKey(id)) {
      _statusCallbacks[id]!(status);
    }

    if (status == DownloadTaskStatus.complete ||
        status == DownloadTaskStatus.failed ||
        status == DownloadTaskStatus.canceled) {
      _progressCallbacks.remove(id);
      _statusCallbacks.remove(id);
    }
  }

  static Future<String?> downloadImage({
    required String url,
    String? fileName,
    Function(int progress)? onProgress,
    Function(DownloadTaskStatus status)? onStatusChange,
    Function(String message)? onError,
  }) async {
    try {
      bool hasPermission = await _checkPermissions();
      if (!hasPermission) {
        onError?.call('Storage permission denied');
        return null;
      }
      final downloadDir = await _getDownloadDirectory();
      fileName ??= 'image_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: downloadDir,
        fileName: fileName,
        showNotification: true,
        openFileFromNotification: true,
        saveInPublicStorage: Platform.isAndroid,
      );
      if (onProgress != null) {
        _progressCallbacks[taskId!] = onProgress;
      }
      if (onStatusChange != null) {
        _statusCallbacks[taskId!] = onStatusChange;
      }

      return taskId;
    } catch (e) {
      onError?.call('Download failed: $e');
      return null;
    }
  }

  static Future<String?> downloadImageSimple(
    String url, [
    String? fileName,
  ]) async {
    return await downloadImage(url: url, fileName: fileName);
  }

  static Future<void> pauseDownload(String taskId) async =>
      await FlutterDownloader.pause(taskId: taskId);

  static Future<String?> resumeDownload(String taskId) async =>
      await FlutterDownloader.resume(taskId: taskId);

  static Future<void> cancelDownload(String taskId) async {
    await FlutterDownloader.cancel(taskId: taskId);
    _progressCallbacks.remove(taskId);
    _statusCallbacks.remove(taskId);
  }

  static Future<List<DownloadTask>?> getAllDownloads() async {
    return await FlutterDownloader.loadTasks();
  }

  static Future<void> removeDownload(String taskId) async {
    await FlutterDownloader.remove(taskId: taskId, shouldDeleteContent: true);
  }

  static Future<bool> _checkPermissions() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        var status = await Permission.photos.status;
        if (!status.isGranted) {
          status = await Permission.photos.request();
        }
        return status.isGranted;
      } else if (androidInfo.version.sdkInt >= 30) {
        var status = await Permission.manageExternalStorage.status;
        if (!status.isGranted) {
          status = await Permission.manageExternalStorage.request();
        }
        return status.isGranted;
      } else {
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          status = await Permission.storage.request();
        }
        return status.isGranted;
      }
    } else if (Platform.isIOS) {
      var status = await Permission.photos.status;
      if (!status.isGranted) {
        status = await Permission.photos.request();
      }
      return status.isGranted;
    }
    return false;
  }

  static Future<String> _getDownloadDirectory() async {
    Directory? directory;
    if (Platform.isAndroid) {
      directory = await getExternalStorageDirectory();
      String downloadsPath = '${directory!.path}/Downloads';
      await Directory(downloadsPath).create(recursive: true);
      return downloadsPath;
    } else {
      directory = await getApplicationDocumentsDirectory();
      return directory.path;
    }
  }
}
