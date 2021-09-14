import 'package:flutter/material.dart';

import './create_screen.dart';

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
      body: SingleChildScrollView(
        child: ListView.builder( 
          itemCount: 2,
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
                      Text("This is my Title", style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),),
                      SizedBox(height: 8.0,),
                      Text("Here goes my very long long long long body content... goes my very long long long long body content...", style: TextStyle(color: Colors.grey[800])),
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
                              Text('Parikshit Gothwal', style: TextStyle(color: Colors.grey[600])),
                            ],
                          ),
                          Row(children:[
                            Icon(Icons.history, color:Colors.grey),
                            SizedBox(width:4.0),
                            Text('26 Feb 1997', style: TextStyle(color: Colors.grey[600])),
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
        )
      ),
    );
  }
}