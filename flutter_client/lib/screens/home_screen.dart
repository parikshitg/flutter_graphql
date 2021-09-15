import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import './create_screen.dart';
import '../config/query.dart';
import '../config/config.dart';

String getTitle(String title){
  if (title.length > 50) {
    return title.substring(0,50);
  }
  return title;
}

String getBody(String body){
  if (body.length > 80) {
    return body.substring(0,80);
  }
  return body;
}

// dd-mm-yyyy
String getDate(String date){
  return date.toString().substring(8,10) + "-" + date.toString().substring(5,7)+ "-" + date.toString().substring(0,4);
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BLOGS'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateScreen(),
                ),
              );
            },
            icon: Icon(Icons.add),
            iconSize: 24.0,
          ),
        ],
      ),
      body: Query(
        options: QueryOptions(
          document: gql(getBlogs), 
          pollInterval: Duration(seconds: POLL_INTERVAL),
        ),
        builder: (QueryResult result, { VoidCallback refetch, FetchMore fetchMore }) {
          if (result.hasException) {
            print(' Graphql Exception: ${result.exception}');
            return Center(child: Text('No Connection'));
          }

          if (result.isLoading) {
            return CircularProgressIndicator();
          }

          List blogs = result.data['getBlogs'];

          return ListView.builder( 
            itemCount: blogs.length,
            shrinkWrap: true,
            itemBuilder: (context, i){
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical:2.0),
                child: Card(
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Text("${getTitle(blogs[i]['title'])}...", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),),
                        SizedBox(height: 8.0,),
                        Text("${getBody(blogs[i]['body'])}...", style: TextStyle(color: Colors.grey[800])),
                        Padding(
                          padding: const EdgeInsets.only(left:20.0, right:20.0),
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children:[
                                Icon(Icons.person_outline, color:Colors.grey),
                                SizedBox(width:4.0),
                                Text('${blogs[i]['author']}', style: TextStyle(color: Colors.grey[600], fontStyle: FontStyle. italic)),
                              ],
                            ),
                            Row(children:[
                              Icon(Icons.history, color:Colors.grey),
                              SizedBox(width:4.0),
                              Text('${getDate(blogs[i]['date'])}', style: TextStyle(color: Colors.grey[600], fontStyle: FontStyle. italic)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ), 
    );
  }
}
