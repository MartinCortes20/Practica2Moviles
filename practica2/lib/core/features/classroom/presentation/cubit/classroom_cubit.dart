import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../ data/models/furniture_model.dart'; // ← QUITA EL ESPACIO de " data"
import '../../domain/entities/furniture_entity.dart';

// Estados
abstract class ClassroomState extends Equatable {
  const ClassroomState();

  @override
  List<Object?> get props => [];
}

class ClassroomInitial extends ClassroomState {}

class ClassroomLoaded extends ClassroomState {
  final List<FurnitureEntity> furniture;

  const ClassroomLoaded(this.furniture);

  @override
  List<Object?> get props => [furniture];
}

class ClassroomError extends ClassroomState {
  final String message;

  const ClassroomError(this.message);

  @override
  List<Object?> get props => [message];
}

// Cubit
class ClassroomCubit extends Cubit<ClassroomState> {
  ClassroomCubit() : super(ClassroomInitial());

  /// Carga los muebles del salón
  void loadFurniture() {
    try {
      print('🔄 Cubit: Cargando muebles...');
      final furniture = FurnitureModel.getMockFurniture();
      print('✅ Cubit: ${furniture.length} muebles cargados');
      emit(ClassroomLoaded(furniture));
    } catch (e) {
      print('❌ Cubit Error: $e');
      emit(ClassroomError('Error al cargar los muebles: $e'));
    }
  }
}