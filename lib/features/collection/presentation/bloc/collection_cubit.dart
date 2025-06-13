import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:equatable/equatable.dart';
import '../../../../models/bottle_model.dart';

part 'collection_state.dart';

class CollectionCubit extends Cubit<CollectionState> {
  CollectionCubit() : super(CollectionLoading());

  Future<void> loadBottles() async {
    print('[CollectionCubit] Starting to load bottles');
    emit(CollectionLoading());
    try {
      final String data = await rootBundle.loadString('assets/mock_items.json');
      print('[CollectionCubit] Loaded JSON data: $data');

      final List<dynamic> jsonList = json.decode(data);
      print('[CollectionCubit] Decoded ${jsonList.length} bottles');

      final bottles = jsonList.map((e) => BottleModel.fromJson(e)).toList();
      print(
        '[CollectionCubit] Parsed bottles: ${bottles.map((b) => '${b.name} (${b.bottleIndex})').join(', ')}',
      );

      emit(CollectionLoaded(bottles));
      print('[CollectionCubit] Emitted CollectionLoaded state');
    } catch (e, stackTrace) {
      print('[CollectionCubit] Error loading bottles: $e');
      print('[CollectionCubit] Stack trace: $stackTrace');
      emit(CollectionError('Failed to load bottles: $e'));
    }
  }
}
