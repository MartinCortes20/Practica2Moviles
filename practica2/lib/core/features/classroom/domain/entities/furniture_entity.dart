import 'package:equatable/equatable.dart';

/// Entidad que representa un mueble del salón
class FurnitureEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String material;
  final String size;
  final String category;
  final String imagePath;
  final double positionX; // Posición en la imagen (0-1)
  final double positionY; // Posición en la imagen (0-1)

  const FurnitureEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.material,
    required this.size,
    required this.category,
    required this.imagePath,
    required this.positionX,
    required this.positionY,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        material,
        size,
        category,
        imagePath,
        positionX,
        positionY,
      ];
}