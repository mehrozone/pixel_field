import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:equatable/equatable.dart';
import 'package:pixel_field/features/collection/data/models/bottle_model.dart';

part 'collection_state.dart';

class CollectionCubit extends Cubit<CollectionState> {
  CollectionCubit() : super(CollectionLoading());

  Future<void> loadBottles() async {
    emit(CollectionLoading());
    try {
      final String data = await rootBundle.loadString('assets/mock_items.json');

      final List<dynamic> jsonList = json.decode(data);

      final bottles = jsonList.map((e) => BottleModel.fromJson(e)).toList();

      emit(CollectionLoaded(bottles));
    } catch (e) {
      emit(CollectionError('Failed to load bottles: $e'));
    }
  }
}
