import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/classroom_cubit.dart';
import '../cubit/theme_cubit.dart'; // NUEVO IMPORT
import '../widgets/interactive_classroom_image.dart';

class ClassroomScreen extends StatelessWidget {
  const ClassroomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Explorador de Salón',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        actions: [
          // BOTÓN DE TEMA - NUEVO
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, themeState) {
              return IconButton(
                icon: Icon(
                  themeState.isDarkMode 
                      ? Icons.light_mode 
                      : Icons.dark_mode,
                  color: Theme.of(context).appBarTheme.foregroundColor,
                ),
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
                tooltip: themeState.isDarkMode 
                    ? 'Cambiar a tema claro' 
                    : 'Cambiar a tema oscuro',
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ClassroomCubit, ClassroomState>(
        builder: (context, state) {
          if (state is ClassroomInitial) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              context.read<ClassroomCubit>().loadFurniture();
            });
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is ClassroomLoaded) {
            return Column(
              children: [
                // Banner informativo
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.touch_app,
                        color: Theme.of(context).colorScheme.primary,
                        size: 32,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Toca cualquier mueble para ver sus detalles',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                // Imagen interactiva del salón
                Expanded(
                  child: InteractiveClassroomImage(
                    furniture: state.furniture,
                  ),
                ),
              ],
            );
          }

          if (state is ClassroomError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.message,
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}