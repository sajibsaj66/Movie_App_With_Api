import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

void main() => runApp(
    MaterialApp(debugShowCheckedModeBanner: false, home: MovieFromApi()));

class MovieFromApi extends StatefulWidget {
  const MovieFromApi({Key? key}) : super(key: key);

  @override
  _MovieFromApiState createState() => _MovieFromApiState();
}

class _MovieFromApiState extends State<MovieFromApi> {
  var response;

  fetchMovies() async {
    var res = await http.get(Uri.parse(//all data res here
        "https://api.themoviedb.org/3/movie/now_playing?api_key=1500496dcaf1512b62894bd98ba83f9d&language=en-US"));
    setState(() {
      response = json.decode(res.body)["results"];
    }); // result obj
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMovies();
  }

  @override
  Widget build(BuildContext context) {
    print("Response Result : $response");

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[900],
        title: Center(child: Text("Movie List With Description ")),
      ),
      // body: FutureBuilder(
      //   future: fetchMovies(),
      //   builder: (BuildContext context, AsyncSnapshot snapshot) {
      //     if (snapshot.hasError) {
      //       return Text(snapshot.error.toString());
      //     }
      //     if (snapshot.hasData) {
      //       return ListView.builder(
      //           shrinkWrap: true,
      //           itemCount: snapshot.data.length,
      //           itemBuilder: (BuildContext context, index) {
      //             return Row(
      //               children: [
      //                 Container(
      //                   height: 250,
      //                   alignment: Alignment.centerLeft,
      //                   child: Card(
      //                     child: Image.network(
      //                         "https://image.tmdb.org/t/p/w500" +
      //                             snapshot.data[index]["poster_path"]),
      //                   ),
      //                 ),
      //                 Expanded(
      //                   child: Container(
      //                     child: Column(
      //                       children: [
      //                         Text(snapshot.data[index]["release_date"]
      //                             .toString()),
      //                         Text(snapshot.data[index]["overview"].toString()),
      //                         Text(snapshot.data[index]["title"].toString()),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //               ],
      //             );
      //           });
      //     }
      //     return Center(
      //       child: CircularProgressIndicator(),
      //     );
      //   },
      // ),
      body: ListView(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            color: Colors.teal,
            child: ListView.builder(
                itemCount: response.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                            trailing: Text(response[index]['release_date']),
                            title: Text(
                              response[index]['title'],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            subtitle: Text(
                              response[index]['overview'],
                              style: TextStyle(color: Colors.grey.shade900),
                            ),
                            leading: Image.network(
                              "https://image.tmdb.org/t/p/w500${response[index]['backdrop_path']}",
                              height: 300,
                            )
                            // Text(response[index]["popularity"].toString()),
                            ),
                        // Text(
                        //   response[index]["popularity"].toString(),
                        //   style: TextStyle(fontSize: 16),
                        // ),
                      ],
                    ),
                  );
                }),
            // Text(response.toString()), // all Data Show Mobile By this Code
          ),
        ],
      ),
    );
  }
}

// class HomePage extends StatelessWidget {
//   fetchMovies() async {
//     var url;
//     url = await http.get(Uri.parse(
//         "https://api.themoviedb.org/3/movie/now_playing?api_key=1500496dcaf1512b62894bd98ba83f9d&language=en-US"));
//     return json.decode(url.body)['results'];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xff191826),
//       appBar: AppBar(
//         centerTitle: false,
//         title: Text(
//           'MOVIES',
//           style: TextStyle(fontSize: 25.0, color: Color(0xfff43370)),
//         ),
//         elevation: 0.0,
//         backgroundColor: Color(0xff191826),
//       ),
//       body: FutureBuilder(
//           future: fetchMovies(),
//           builder: (BuildContext context, AsyncSnapshot snapshot) {
//             if (snapshot.hasError) {
//               return Center(
//                 child: Text(snapshot.error.toString()),
//               );
//             }
//             if (snapshot.hasData) {
//               return ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: snapshot.data.length,
//                 padding: EdgeInsets.all(8),
//                 itemBuilder: (BuildContext context, int index) {
//                   return Row(
//                     children: [
//                       Container(
//                         height: 250,
//                         alignment: Alignment.centerLeft,
//                         child: Card(
//                           child: Image.network(
//                               "https://image.tmdb.org/t/p/w500" +
//                                   snapshot.data[index]['poster_path']),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 20,
//                       ),
//                       Expanded(
//                         child: Container(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(
//                                 height: 20.0,
//                               ),
//                               Text(
//                                 snapshot.data[index]["original_title"],
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Text(
//                                 snapshot.data[index]["release_date"],
//                                 style: TextStyle(color: Color(0xff868597)),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Container(
//                                 height: 100,
//                                 child: Text(
//                                   snapshot.data[index]["overview"],
//                                   style: TextStyle(color: Color(0xff868597)),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   );
//                 },
//               );
//             }
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }),
//     );
//   }
// }
