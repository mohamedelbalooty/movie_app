import 'package:equatable/equatable.dart';

class Image extends Equatable {
  final String? filePath;

  const Image({this.filePath});

  @override
  List<Object?> get props => [filePath];
}
