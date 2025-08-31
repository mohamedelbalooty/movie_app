import 'package:movie_app/src/features/popular_people/domain/entities/image_entity.dart';

class ImageModel extends Image {
  final double? aspectRatio;
  final int? height;
  final dynamic iso6391;
  final double? voteAverage;
  final int? voteCount;
  final int? width;

  const ImageModel({
    super.filePath,
    this.aspectRatio,
    this.height,
    this.iso6391,
    this.voteAverage,
    this.voteCount,
    this.width,
  });

  factory ImageModel.fromMap(Map<String, dynamic> json) => ImageModel(
    aspectRatio: json['aspect_ratio']?.toDouble(),
    height: json['height'],
    iso6391: json['iso_639_1'],
    filePath: json['file_path'],
    voteAverage: json['vote_average']?.toDouble(),
    voteCount: json['vote_count'],
    width: json['width'],
  );

  Map<String, dynamic> toMap() => {
    'aspect_ratio': aspectRatio,
    'height': height,
    'iso_639_1': iso6391,
    'file_path': filePath,
    'vote_average': voteAverage,
    'vote_count': voteCount,
    'width': width,
  };
}
