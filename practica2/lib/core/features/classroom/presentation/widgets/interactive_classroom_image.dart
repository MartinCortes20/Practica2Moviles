import 'package:flutter/material.dart';
import '../../domain/entities/furniture_entity.dart';
import '../screens/furniture_detail_screen.dart';

class InteractiveClassroomImage extends StatefulWidget {
  final List<FurnitureEntity> furniture;

  const InteractiveClassroomImage({
    super.key,
    required this.furniture,
  });

  @override
  State<InteractiveClassroomImage> createState() =>
      _InteractiveClassroomImageState();
}

class _InteractiveClassroomImageState extends State<InteractiveClassroomImage>
    with SingleTickerProviderStateMixin {
  String? hoveredId;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color, // ADAPTADO AL TEMA
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                // IMAGEN SIMPLIFICADA - sin sistemas de carga duplicados
                _buildClassroomImage(),

                // Overlay oscuro sutil - ADAPTADO AL TEMA
                Container(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black.withOpacity(0.3)
                      : Colors.black.withOpacity(0.1),
                ),

                // Puntos interactivos
                ...widget.furniture.map((item) => _buildInteractivePoint(item, constraints)),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildClassroomImage() {
    return Hero(
      tag: 'classroom_image',
      child: Image.asset(
        'assets/images/classroom.jpg',
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
          // Muestra un loading mientras carga - ADAPTADO AL TEMA
          if (frame == null) {
            return Container(
              color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
              child: Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            );
          }
          return child;
        },
        errorBuilder: (context, error, stackTrace) {
          print('🚨 Error cargando classroom.jpg: $error');
          return _buildErrorPlaceholder();
        },
      ),
    );
  }

  Widget _buildErrorPlaceholder() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.surface.withOpacity(0.7),
            Theme.of(context).colorScheme.surface.withOpacity(0.9),
          ],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image_not_supported,
            size: 80,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
          ),
          const SizedBox(height: 16),
          Text(
            'No se pudo cargar la imagen',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Verifica que classroom.jpg esté en assets/images/',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildInteractivePoint(FurnitureEntity item, BoxConstraints constraints) {
    final isHovered = hoveredId == item.id;

    return Positioned(
      left: constraints.maxWidth * item.positionX - 25,
      top: constraints.maxHeight * item.positionY - 25,
      child: GestureDetector(
        onTap: () => _navigateToDetail(context, item),
        onTapDown: (_) => setState(() => hoveredId = item.id),
        onTapUp: (_) => setState(() => hoveredId = null),
        onTapCancel: () => setState(() => hoveredId = null),
        child: MouseRegion(
          onEnter: (_) => setState(() => hoveredId = item.id),
          onExit: (_) => setState(() => hoveredId = null),
          child: AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              return Transform.scale(
                scale: isHovered
                    ? 1.3
                    : 1.0 + (_pulseController.value * 0.1),
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _getColorForCategory(item.category).withOpacity(0.9),
                    border: Border.all(
                      color: _getBorderColorForTheme(context),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: _getColorForCategory(item.category).withOpacity(0.5),
                        blurRadius: isHovered ? 20 : 10,
                        spreadRadius: isHovered ? 2 : 0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    _getIconForCategory(item.category),
                    color: _getIconColorForTheme(context),
                    size: 24,
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  /// Obtiene el color del borde basado en el tema
  Color _getBorderColorForTheme(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[800]!
        : Colors.white;
  }

  /// Obtiene el color del ícono basado en el tema
  Color _getIconColorForTheme(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.white;
  }

  void _navigateToDetail(BuildContext context, FurnitureEntity furniture) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            FurnitureDetailScreen(furniture: furniture),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset.zero;
          const curve = Curves.easeInOutCubic;

          var tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: curve),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 600),
      ),
    );
  }

  Color _getColorForCategory(String category) {
    switch (category) {
      case 'Mesa':
        return const Color(0xFF3498DB);
      case 'Silla':
        return const Color(0xFFE74C3C);
      case 'Pizarrón':
        return const Color(0xFF2ECC71);
      case 'Iluminación':
        return const Color(0xFFF39C12);
      default:
        return const Color(0xFF95A5A6);
    }
  }

  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'Mesa':
        return Icons.table_restaurant;
      case 'Silla':
        return Icons.chair;
      case 'Pizarrón':
        return Icons.dashboard;
      case 'Iluminación':
        return Icons.lightbulb;
      default:
        return Icons.help_outline;
    }
  }
}