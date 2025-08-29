class ServerException implements Exception {
  final String message;

  ServerException({required this.message});

  @override
  String toString() => message;
}

class CacheException implements Exception {
  final String message;

  CacheException({required this.message});

  @override
  String toString() => message;
}

class NetworkException implements Exception {
  final String message;

  NetworkException({required this.message});

  @override
  String toString() => message;
}

class DataException implements Exception {
  final String message;

  DataException({required this.message});

  @override
  String toString() => message;
}
