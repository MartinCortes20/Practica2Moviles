import '../../domain/entities/furniture_entity.dart';

/// Modelo de datos para muebles (implementa la entidad)
class FurnitureModel extends FurnitureEntity {
  const FurnitureModel({
    required super.id,
    required super.name,
    required super.description,
    required super.material,
    required super.size,
    required super.category,
    required super.imagePath,
    required super.positionX,
    required super.positionY,
  });

  /// Datos mock del salón de clases
  static List<FurnitureModel> getMockFurniture() {
    return [
      // Mesa 1
      const FurnitureModel(
        id: 'mesa_1',
        name: 'Mesa de Trabajo',
        description: 'Mesa de trabajo moderna con superficie amplia, ideal para actividades grupales y estudio colaborativo.',
        material: 'Tablero de melamina blanca con estructura de acero negro',
        size: '120cm x 60cm x 75cm (largo x ancho x alto)',
        category: 'Mesa',
        imagePath: 'assets/images/furniture/mesa.jpg', // ← CAMBIADO a .jpg
        positionX: 0.45,
        positionY: 0.65,
      ),
      
      // Mesa 2
      const FurnitureModel(
        id: 'mesa_2',
        name: 'Mesa de Trabajo',
        description: 'Mesa de trabajo moderna con superficie amplia, perfecta para trabajo individual o en pareja.',
        material: 'Tablero de melamina blanca con estructura de acero negro',
        size: '120cm x 60cm x 75cm (largo x ancho x alto)',
        category: 'Mesa',
        imagePath: 'assets/images/furniture/mesa.jpg', // ← CAMBIADO a .jpg
        positionX: 0.25,
        positionY: 0.60,
      ),
      
      // Silla Roja 1
      const FurnitureModel(
        id: 'silla_1',
        name: 'Silla Escolar',
        description: 'Silla ergonómica de uso escolar con respaldo y asiento contorneado para mayor comodidad durante largas jornadas de estudio.',
        material: 'Polipropileno rojo resistente con estructura de acero negro',
        size: '45cm x 45cm x 80cm (ancho x profundidad x alto)',
        category: 'Silla',
        imagePath: 'assets/images/furniture/silla.jpg', // ← CAMBIADO a .jpg
        positionX: 0.35,
        positionY: 0.70,
      ),
      
      // Silla Roja 2
      const FurnitureModel(
        id: 'silla_2',
        name: 'Silla Escolar',
        description: 'Silla ergonómica diseñada para espacios educativos, con acabado duradero y fácil limpieza.',
        material: 'Polipropileno rojo resistente con estructura de acero negro',
        size: '45cm x 45cm x 80cm (ancho x profundidad x alto)',
        category: 'Silla',
        imagePath: 'assets/images/furniture/silla.jpg', // ← CAMBIADO a .jpg
        positionX: 0.55,
        positionY: 0.75,
      ),
      
      // Silla Roja 3
      const FurnitureModel(
        id: 'silla_3',
        name: 'Silla Escolar',
        description: 'Silla apilable y resistente, perfecta para espacios educativos modernos.',
        material: 'Polipropileno rojo resistente con estructura de acero negro',
        size: '45cm x 45cm x 80cm (ancho x profundidad x alto)',
        category: 'Silla',
        imagePath: 'assets/images/furniture/silla.jpg', // ← CAMBIADO a .jpg
        positionX: 0.15,
        positionY: 0.75,
      ),
      
      // Pizarrón
      const FurnitureModel(
        id: 'pizarron_1',
        name: 'Pizarrón Blanco',
        description: 'Pizarrón blanco de gran formato montado en pared, con superficie de escritura suave y fácil borrado. Incluye bandeja para marcadores.',
        material: 'Panel de melamina blanca con marco de aluminio',
        size: '180cm x 120cm (ancho x alto)',
        category: 'Pizarrón',
        imagePath: 'assets/images/furniture/pizarron.jpg', // ← CAMBIADO a .jpg
        positionX: 0.50,
        positionY: 0.25,
      ),
      
      // Lámpara Fluorescente 1
      const FurnitureModel(
        id: 'lampara_1',
        name: 'Luminaria LED',
        description: 'Luminaria empotrada de tecnología LED para techo modular, proporciona iluminación uniforme y eficiente al espacio educativo.',
        material: 'Carcasa de aluminio con difusor acrílico y tubos LED',
        size: '120cm x 30cm x 8cm (largo x ancho x alto)',
        category: 'Iluminación',
        imagePath: 'assets/images/furniture/lampara.jpg', // ← CAMBIADO a .jpg
        positionX: 0.35,
        positionY: 0.15,
      ),
      
      // Lámpara Fluorescente 2
      const FurnitureModel(
        id: 'lampara_2',
        name: 'Luminaria LED',
        description: 'Sistema de iluminación LED empotrado, diseñado para techos modulares con excelente rendimiento lumínico.',
        material: 'Carcasa de aluminio con difusor acrílico y tubos LED',
        size: '120cm x 30cm x 8cm (largo x ancho x alto)',
        category: 'Iluminación',
        imagePath: 'assets/images/furniture/lampara.jpg', // ← CAMBIADO a .jpg
        positionX: 0.65,
        positionY: 0.15,
      ),
    ];
  }
}