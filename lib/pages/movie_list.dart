import 'package:flutter/material.dart';
import 'package:minggu_9/pages/movie_detail.dart';
import 'package:minggu_9/services/http_services.dart';

class MovieList extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  int moviesCount;
  List movies;
  HttpService service;
  String imgPath = 'https://image.tmdb.org/t/p/w500/';
  Future initialize() async {
    movies = [];
    movies = await service.getPopularMovies();
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  @override
  void initState() {
    service = HttpService();
    initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
        appBar: AppBar(
          title: Text("Netflix"),
        ),
        body: ListView.builder(
          itemCount: (this.moviesCount == null) ? 0 : this.moviesCount,
          itemBuilder: (context, int position) {
            return Card(
              color: Colors.orange[300],
              elevation: 2.0,
              
            
              child: ListTile(
                leading: Container(
                    width: 40.0,
                    height: 40.0,
                    decoration: new BoxDecoration(
                        
                        image: new DecorationImage(
                          fit: BoxFit.fill,
                          image: new NetworkImage(
                              imgPath + movies[position].posterPath),
                        ))),
                title: Text(movies[position].originalTitle),
                subtitle:
                    Text('Rating = ' + movies[position].voteAverage.toString()),
                onTap: () {
                  MaterialPageRoute route = MaterialPageRoute(
                      builder: (_) => MovieDetail(movies[position]));
                  Navigator.push(context, route);
                },
              ),
            );
          },
        ));
  }
}