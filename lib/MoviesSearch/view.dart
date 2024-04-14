import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoviesSearch extends StatefulWidget {
  const MoviesSearch({super.key});

  @override
  State<MoviesSearch> createState() => _MoviesSearchState();
}

class _MoviesSearchState extends State<MoviesSearch> {
  List<dynamic> _results = [];
  final TextEditingController _controller = TextEditingController();

  Future<void> _searchMovies(String query) async {
    final String apiKey = '98d0841b7103c4b1ab9356b8a4071fe0';
    final String apiUrl =
        'https://api.themoviedb.org/3/search/movie?api_key=$apiKey&query=$query';
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          _results = json.decode(response.body)['results'];
        });
      } else {
        throw Exception('Failed to load search results');
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
        child: Column(
          children: [
            TextField(
              controller: _controller,
              onSubmitted: _searchMovies,
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Search for movies',
                prefixIcon: IconButton(
                  onPressed: () => _searchMovies(_controller.text),
                  icon: Icon(Icons.search),
                ),
                border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(25.0)), borderSide: BorderSide(color: Colors.white)
    )
              ),
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            Expanded(
              child: _results.isEmpty
                  ? Center(child: Text('No results'))
                  : ListView.builder(
                      itemCount: _results.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: _results[index]['poster_path'] != null
                              ? Image.network(
                                  'https://image.tmdb.org/t/p/w500${_results[index]['poster_path']}')
                              : null,
                          title: Text(_results[index]['title'],
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.white)),
                          subtitle: Text('${_results[index]['release_date']}',
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.white)),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
