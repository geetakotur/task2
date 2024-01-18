import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task2/places_api.dart';


part 'place_search_state.dart';

class PlaceSearchCubit extends Cubit<PlaceSearchState> {
  final PlacesApi _placesApi = PlacesApi();

  PlaceSearchCubit() : super(PlaceSearchInitial());

  void searchPlaces(String query) async {
    try {
      final places = await _placesApi.searchPlaces(query);
      emit(PlaceSearchLoaded(places));
    } catch (e) {
      emit(PlaceSearchError(e.toString()));
    }
  }
}