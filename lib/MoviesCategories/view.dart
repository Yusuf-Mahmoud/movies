import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;



class MoviesCategories extends StatefulWidget {
  const MoviesCategories({super.key});

  @override
  State<MoviesCategories> createState() => _MoviesCategoriesState();
}

class _MoviesCategoriesState extends State<MoviesCategories> {
   List<dynamic> _genres = [];

  @override
  void initState() {
    super.initState();
    _fetchGenres();
  }

  Future<void> _fetchGenres() async {
    final String apiKey = '98d0841b7103c4b1ab9356b8a4071fe0';
    final String apiUrl =
        'https://api.themoviedb.org/3/genre/movie/list?api_key=$apiKey';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          _genres = json.decode(response.body)['genres'];
        });
      } else {
        throw Exception('Failed to load genres');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(12.0),
          child: ListView.builder(
            itemCount: _genres.length,
            itemBuilder: (context, index) {
              final genre = _genres[index];
              return GestureDetector(
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
      //                image: DecorationImage(
      //   image: NetworkImage('https://image.tmdb.org/t/p/w500${genre['poster_path']}'), 
      //   fit: BoxFit.cover, 
      // ),
                  ),
                  child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(width: 20),
                      Text(
                        genre['name'],
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
    );
  }
}
