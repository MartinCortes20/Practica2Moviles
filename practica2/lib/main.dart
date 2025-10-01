import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/features/classroom/presentation/cubit/classroom_cubit.dart';
import 'core/features/classroom/presentation/cubit/theme_cubit.dart';
import 'core/features/classroom/presentation/screens/classroom_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ClassroomCubit()),
        BlocProvider(create: (context) => ThemeCubit()..loadTheme()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            title: 'Explorador de Salón',
            debugShowCheckedModeBanner: false,
            theme: _buildTheme(themeState.isDarkMode),
            home: const ClassroomScreen(),
          );
        },
      ),
    );
  }

  /// Construye el tema basado en el modo oscuro/claro
  ThemeData _buildTheme(bool isDarkMode) {
    final baseTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF3498DB),
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      useMaterial3: true,
    );

    return baseTheme.copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(baseTheme.textTheme),
      scaffoldBackgroundColor: isDarkMode 
          ? const Color(0xFF121212) 
          : const Color(0xFFF5F5F5),
      appBarTheme: AppBarTheme(
        backgroundColor: isDarkMode 
            ? const Color(0xFF1E1E1E) 
            : Colors.white,
        foregroundColor: isDarkMode 
            ? Colors.white 
            : const Color(0xFF2C3E50),
        elevation: 0,
      ),
      cardTheme: CardThemeData( // CAMBIADO: CardThemeData en lugar de CardTheme
        color: isDarkMode 
            ? const Color(0xFF1E1E1E) 
            : Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        surfaceTintColor: Colors.transparent, // Agregado para mejor compatibilidad
      ),
    );
  }
}