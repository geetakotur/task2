part of 'place_search_bloc.dart';

abstract class PlaceSearchState extends Equatable {
  const PlaceSearchState();

  @override
  List<Object> get props => [];
}

class PlaceSearchInitial extends PlaceSearchState {}

class PlaceSearchLoaded extends PlaceSearchState {
  final List<String> places;

  const PlaceSearchLoaded(this.places);

  @override
  List<Object> get props => [places];
}

class PlaceSearchError extends PlaceSearchState {
  final String message;

  const PlaceSearchError(this.message);

  @override
  List<Object> get props => [message];
}


