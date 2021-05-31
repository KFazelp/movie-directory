import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final Function callback;
  MovieCard({this.data = const {}, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 360,
      width: 650,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff3f3f3f)),
        color: Colors.black,
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: new ColorFilter.mode(
              Colors.black.withOpacity(0.2), BlendMode.dstATop),
          image: NetworkImage(data['background']),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 360,
            width: 220,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(data['image']),
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['year'],
                      style: TextStyle(
                        color: Color(0xffc4c4c4),
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      data['title'],
                      style: TextStyle(
                        color: Color(0xffe8eaed),
                        fontSize: 48,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'IMDb #${data['rank']}',
                      style: TextStyle(
                        color: Color(0xfff9bb11),
                        fontSize: 24,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      data['actors'],
                      style: TextStyle(
                        color: Color(0xffc4c4c4),
                        fontSize: 20,
                      ),
                    )
                  ],
                ),
                MaterialButton(
                  height: 40,
                  mouseCursor: SystemMouseCursors.click,
                  onPressed: () {
                    callback();
                  },
                  child: Text(
                    'Create Directory',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  color: Color(0xff1c9d11),
                  textColor: Colors.white,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
