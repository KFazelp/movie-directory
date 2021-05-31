import 'package:flutter/material.dart';
import 'package:moviedirectory/MovieCard.dart';
import 'package:moviedirectory/fetchApi.dart';

class MovieDirectory extends StatefulWidget {
  @override
  _MovieDirectoryState createState() => _MovieDirectoryState();
}

class _MovieDirectoryState extends State<MovieDirectory> {
  TextEditingController movieNameController = new TextEditingController();
  bool isLoading = false;
  bool movieFound = false;
  String movieId = '';
  String logText = '';
  Map<String, String> previewData = {
    'background': '',
    'image': '',
    'year': '',
    'title': '',
    'rank': '',
    'actors': ''
  };

  Future getMovieData(dynamic input) async {
    setState(() {
      movieFound = false;
      isLoading = true;
    });
    ApiResponse movieName = await fetchApi('search', input);
    if (movieName.status == 200 &&
        movieName.body['d'] != null &&
        movieName.body['d'][0] != null &&
        movieName.body['d'][0]['v'] != null &&
        movieName.body['d'][0]['s'] != null &&
        movieName.body['d'][0]['rank'] != null &&
        movieName.body['d'][0]['y'] != null &&
        movieName.body['d'][0]['i'] != null) {
      Map<dynamic, dynamic> _movie = movieName.body['d'][0];

      setState(() {
        movieNameController.text = '';
        movieId = _movie['id'];
        previewData = {
          'background': _movie['v'][0]['i']['imageUrl'],
          'image': _movie['i']['imageUrl'],
          'year': _movie['y'].toString(),
          'title': _movie['l'],
          'rank': _movie['rank'].toString(),
          'actors': _movie['s']
        };
        movieFound = true;
        isLoading = false;
      });
    } else {
      setState(() {
        logText = "somethings went wrong! can't find this movie";
        isLoading = false;
      });
    }
  }

  Future createDirectory() async {
    setState(() {
      isLoading = true;
      movieFound = false;
    });

    ApiResponse movieData = await fetchApi('select', movieId);
    if (movieData.status == 200) {
      String year = movieData.body['Year'];
      String title = movieData.body['Title'];
      String genres = movieData.body['Genre'];
      genres = '(' + genres.replaceAll(', ', ')(') + ')';

      setState(() {
        logText = '$year - $title - $genres';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size appSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            movieFound
                ? MovieCard(data: previewData, callback: createDirectory)
                : Container(
                    height: 360,
                    width: 650,
                    child: Center(
                        child: isLoading
                            ? CircularProgressIndicator()
                            : Text(
                                'Movie Preview',
                                style: TextStyle(
                                  color: Color(0xff3f3f3f),
                                  fontSize: 18,
                                ),
                              )),
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff3f3f3f)),
                    ),
                  ),
            SizedBox(height: 20),
            Container(
              width: appSize.width / 1.5,
              decoration: BoxDecoration(
                color: Color(0xFF1d1d1d),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: TextField(
                controller: movieNameController,
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xffc4c4c4),
                ),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Movie Title + release year (optional)',
                    hintStyle: TextStyle(
                      color: Color(0xff3f3f3f),
                      fontSize: 20,
                    )),
              ),
            ),
            SizedBox(height: 10),
            MaterialButton(
              height: 50,
              minWidth: 160,
              mouseCursor: SystemMouseCursors.click,
              onPressed: () => getMovieData(movieNameController.text),
              child: Text(
                'Search Movie',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              color: Color(0xff333333),
              textColor: Color(0xffe8eaed),
            ),
            SizedBox(height: 20),
            Text(
              logText,
              style: TextStyle(
                color: Color(0xfff53c56),
              ),
            )
          ],
        ),
      ),
    );
  }
}
