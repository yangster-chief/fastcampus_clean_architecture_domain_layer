import 'package:clean_architecture_layer_exam/domain/entity/dog_image.dart';
import 'package:json_annotation/json_annotation.dart';

///
/// clean_architecture_layer_exam
/// File Name: image_response
/// Created by sujangmac
///
/// Description:
///
part 'image_response.g.dart';

@JsonSerializable()
class ImageResponse {
  final List<BreedResponse> breeds;
  final String id;
  final String url;
  final int width;
  final int height;

  const ImageResponse({
    required this.breeds,
    required this.id,
    required this.url,
    this.width = 0,
    this.height = 0,
  });

  factory ImageResponse.fromJson(Map<String, dynamic> json) =>
      _$ImageResponseFromJson(json);
}

@JsonSerializable()
class BreedResponse {
  final SystemOfMeasurementResponse weight;
  final SystemOfMeasurementResponse height;
  final int id;
  final String name;
  @JsonKey(name: 'bred_for')
  final String? bredFor;
  @JsonKey(name: 'breed_group')
  final String? breedGroup;
  @JsonKey(name: 'life_span')
  final String? lifeSpan;
  final String? temperament;
  final String? origin;
  @JsonKey(name: 'reference_image_id')
  final String? referenceImageId;

  const BreedResponse({
    required this.weight,
    required this.height,
    required this.id,
    required this.name,
    this.bredFor,
    this.breedGroup,
    this.lifeSpan,
    this.temperament,
    this.origin,
    this.referenceImageId,
  });

  factory BreedResponse.fromJson(Map<String, dynamic> json) =>
      _$BreedResponseFromJson(json);
}

@JsonSerializable()
class SystemOfMeasurementResponse {
  final String imperial;
  final String metric;

  const SystemOfMeasurementResponse({
    required this.imperial,
    required this.metric,
  });

  factory SystemOfMeasurementResponse.fromJson(Map<String, dynamic> json) =>
      _$SystemOfMeasurementResponseFromJson(json);
}

extension ImageResponseExtension on ImageResponse {
  DogImage toEntity() => DogImage(
        id: id,
        url: url,
        width: width,
        height: height,
        breeds: breeds.map((e) => e.toEntity()).toList(),
      );
}

extension ImageResponsesExtension on List<ImageResponse> {
  List<DogImage> toEntities() => map((e) => e.toEntity()).toList();
}

extension BreedResponseExtension on BreedResponse {
  Breed toEntity() => Breed(
        weight: weight.toEntity(),
        height: height.toEntity(),
        id: id,
        name: name,
        bredFor: bredFor,
        breedGroup: breedGroup,
        lifeSpan: lifeSpan,
        temperament: temperament,
        origin: origin,
        referenceImageId: referenceImageId,
      );
}

extension SystemOfMeasurementResponseExtension on SystemOfMeasurementResponse {
  SystemOfMeasurement toEntity() => SystemOfMeasurement(
        imperial: imperial,
        metric: metric,
      );
}
