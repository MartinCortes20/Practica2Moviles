import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Estados del tema
abstract class ThemeState extends Equatable {
  final bool isDarkMode;

  const ThemeState(this.isDarkMode);

  @override
  List<Object?> get props => [isDarkMode];
}

class ThemeInitial extends ThemeState {
  const ThemeInitial() : super(false);
}

class ThemeLoaded extends ThemeState {
  const ThemeLoaded(bool isDarkMode) : super(isDarkMode);
}

// Cubit para manejar el tema
class ThemeCubit extends Cubit<ThemeState> {
  static const String _themeKey = 'isDarkMode';

  ThemeCubit() : super(ThemeInitial());

  /// Carga el tema guardado de SharedPreferences
  Future<void> loadTheme() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final isDarkMode = prefs.getBool(_themeKey) ?? false;
      emit(ThemeLoaded(isDarkMode));
      print('✅ Tema cargado: ${isDarkMode ? 'Oscuro' : 'Claro'}');
    } catch (e) {
      print('❌ Error cargando tema: $e');
      emit(ThemeLoaded(false)); // Tema claro por defecto
    }
  }

  /// Cambia el tema y guarda la preferencia
  Future<void> toggleTheme() async {
    try {
      final newTheme = !state.isDarkMode;
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themeKey, newTheme);
      emit(ThemeLoaded(newTheme));
      print('🎨 Tema cambiado a: ${newTheme ? 'Oscuro' : 'Claro'}');
    } catch (e) {
      print('❌ Error guardando tema: $e');
    }
  }

  /// Establece un tema específico
  Future<void> setTheme(bool isDarkMode) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_themeKey, isDarkMode);
      emit(ThemeLoaded(isDarkMode));
    } catch (e) {
      print('❌ Error estableciendo tema: $e');
    }
  }
}