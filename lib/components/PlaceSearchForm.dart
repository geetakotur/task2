import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task2/main.dart';
import 'package:task2/place_search_bloc.dart';

class PlaceSearchForm extends StatefulWidget {
  @override
  _PlaceSearchFormState createState() => _PlaceSearchFormState();
}

class _PlaceSearchFormState extends State<PlaceSearchForm> {
  late TextEditingController _textController;

  final List<String> suggestedLocations = [
    'Suggested',
  ];

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _textController,
          onChanged: (query) {
            context.read<PlaceSearchCubit>().searchPlaces(query);
          },
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white54),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.white),
            ),
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            filled: true,
            fillColor: Colors.black,
          ),
        ),
        SizedBox(height: 8),
        if (_textController.text.isEmpty)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  print('Detect my Location');
                },
                child: Row(
                  children: [
                    Icon(Icons.near_me, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Detect my Location', style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Text('Suggested', style: TextStyle(color: Colors.white)),
              SizedBox(height: 8),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    SmallContainer(imagePath: 'assets/b.jpg', text: 'Bangalore'),
                    SmallContainer(imagePath: 'assets/b.jpg', text: 'Mumbai'),
                    SmallContainer(imagePath: 'assets/b.jpg', text: 'Delhi'),
                    SmallContainer(imagePath: 'assets/b.jpg', text: 'Hyderabad'),
                  ],
                ),
              ),
            ],
          ),
        if (_textController.text.isNotEmpty)
          Container(
            height: 200,
            child: Builder(
              builder: (context) {
                return BlocBuilder<PlaceSearchCubit, PlaceSearchState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        if (state is PlaceSearchLoaded && state.places.isNotEmpty)
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.places.length,
                              itemBuilder: (context, index) {
                                final place = state.places[index];

                                return ListTile(
                                  title: Text(place, style: TextStyle(color: Colors.white)),
                                  onTap: () {
                                    // Handle the selection here
                                    print('Selected Place: $place');


                                  },
                                );
                              },
                            ),
                          ),
                        if (state is PlaceSearchError) Text('Error: ${state.message}'),
                      ],
                    );
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
