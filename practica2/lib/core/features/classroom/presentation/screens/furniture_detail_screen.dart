import 'package:flutter/material.dart';
import '../../domain/entities/furniture_entity.dart';

/// Pantalla de detalle del mueble seleccionado
class FurnitureDetailScreen extends StatefulWidget {
  final FurnitureEntity furniture;

  const FurnitureDetailScreen({
    super.key,
    required this.furniture,
  });

  @override
  State<FurnitureDetailScreen> createState() => _FurnitureDetailScreenState();
}

class _FurnitureDetailScreenState extends State<FurnitureDetailScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: _getColorForCategory(widget.furniture.category)
          .withOpacity(isDarkMode ? 0.08 : 0.1),
      body: SafeArea(
        child: Column(
          children: [
            // Header con botón de regreso
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    onPressed: () => Navigator.pop(context),
                    style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).cardTheme.color,
                      foregroundColor: _getColorForCategory(widget.furniture.category),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      widget.furniture.category,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: _getColorForCategory(widget.furniture.category),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Contenido principal
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    // Imagen del mueble con Hero animation
                    Hero(
                      tag: widget.furniture.id,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        height: 300,
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardTheme.color,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: _getColorForCategory(widget.furniture.category)
                                  .withOpacity(isDarkMode ? 0.2 : 0.3),
                              blurRadius: 30,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            widget.furniture.imagePath,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
                                child: Icon(
                                  _getIconForCategory(widget.furniture.category),
                                  size: 120,
                                  color: _getColorForCategory(widget.furniture.category),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Card de información con animación
                    SlideTransition(
                      position: _slideAnimation,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardTheme.color,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(isDarkMode ? 0.2 : 0.1),
                                blurRadius: 20,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Título
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      color: _getColorForCategory(widget.furniture.category)
                                          .withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Icon(
                                      _getIconForCategory(widget.furniture.category),
                                      color: _getColorForCategory(widget.furniture.category),
                                      size: 28,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      widget.furniture.name,
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              // Descripción
                              _InfoSection(
                                icon: Icons.description,
                                title: 'Descripción',
                                content: widget.furniture.description,
                                color: _getColorForCategory(widget.furniture.category),
                              ),

                              const SizedBox(height: 16),

                              // Material
                              _InfoSection(
                                icon: Icons.texture,
                                title: 'Material',
                                content: widget.furniture.material,
                                color: _getColorForCategory(widget.furniture.category),
                              ),

                              const SizedBox(height: 16),

                              // Tamaño
                              _InfoSection(
                                icon: Icons.straighten,
                                title: 'Dimensiones',
                                content: widget.furniture.size,
                                color: _getColorForCategory(widget.furniture.category),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
        ),
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

/// Widget para mostrar una sección de información
class _InfoSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  final Color color;

  const _InfoSection({
    required this.icon,
    required this.title,
    required this.content,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(isDarkMode ? 0.08 : 0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: color.withOpacity(isDarkMode ? 0.15 : 0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: color,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 15,
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}