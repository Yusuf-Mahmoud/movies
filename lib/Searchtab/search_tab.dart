import 'package:flutter/material.dart';

class SearchTab extends StatefulWidget {
  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  TextEditingController _searchController = TextEditingController();
  List<String> _movies = []; 
  List<String> _searchResult = [];

  _search(String query) {
    _searchResult.clear();
    if (query.isNotEmpty) {
      _movies.forEach((movie) {
        if (movie.toLowerCase().contains(query.toLowerCase())) {
          _searchResult.add(movie);
        }
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        children: <Widget>[
          TextField(
            controller: _searchController,
            onChanged: (value) {
              _search(value);
            },
            decoration: InputDecoration(
              labelText: "Search",
              hintText: "Search for a movie",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResult.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_searchResult[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}