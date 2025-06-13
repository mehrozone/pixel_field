part of 'collection_cubit.dart';

abstract class CollectionState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CollectionLoading extends CollectionState {}

class CollectionLoaded extends CollectionState {
  final List<BottleModel> bottles;
  CollectionLoaded(this.bottles);
  @override
  List<Object?> get props => [bottles];
}

class CollectionError extends CollectionState {
  final String message;
  CollectionError(this.message);
  @override
  List<Object?> get props => [message];
}
