import 'package:dio/dio.dart';

class PlacesApi {
  final Dio _dio = Dio();

  Future<List<String>> searchPlaces(String query) async {
    try {
      final response = await _dio.get(
        'https://maps.googleapis.com/maps/api/place/textsearch/json',
        queryParameters: {
          'query': query,
          'key': 'AIzaSyCjOWuul-db69IzI90Wk2VH1t0z1FeFI0s',
        },
      );

      return List<String>.from(
        response.data['results'].map((result) => result['name'] as String),
      );
    } catch (e) {
      throw Exception('Failed to load places: $e');
    }
  }
}

