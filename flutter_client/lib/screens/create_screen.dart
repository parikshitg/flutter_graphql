import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../config/mutation.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

String golangTime(){
  return DateTime.now().toIso8601String().toString().substring(0,23)+'Z';    
}

class _CreateScreenState extends State<CreateScreen> {
  final _formKey = GlobalKey<FormState>();
  String _body;
  String _title;
  String _author;

  @override
  Widget build(BuildContext context) {
    return Mutation(
      options: MutationOptions(
      document: gql(createBlog), // mutation string
      update: (GraphQLDataProxy cache, QueryResult result) {
        return cache;
      },
      onCompleted: (dynamic resultData) {
          print('let\'s just print the response: $resultData');
        },
      ),
      builder:(runMutation,result){
        return Scaffold(
          appBar: AppBar(
          title: Text('CREATE BLOG'),
          actions: [
            IconButton(
              icon: Icon(Icons.check),
              onPressed: (){
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();

                  // let's call our mutation function here
                  runMutation({
                    "input": {
                      "title": _title,
                      "author": _author,
                      "date": golangTime(), // gives current time in ISO8601 format
                      "body":_body,
                    }
                  });

                  // lets move back to home screen
                  Navigator.pop(context);
                }
              },
            ),
            ],
          ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Title',
                              hintText: 'Enter Title',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          validator: (input) => input.length < 1
                            ? 'title can not be empty'
                            : null,
                          onSaved: (input) => _title = input,
                        ),
                      ),
                      SizedBox(height:8.0),
                      Container(
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Author',
                              hintText: 'Enter author\'s name',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          validator: (input) => input.length < 1
                            ? 'author name can not be empty'
                            : null,
                          onSaved: (input) => _author = input,
                        ),
                      ),
                      SizedBox(height:8.0),
                      Container(
                        child: TextFormField(
                          maxLines: 24,
                          decoration:InputDecoration(
                              hintText: 'Write blog here...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          validator: (input) => input.length < 1
                            ? 'body can not be empty'
                            : null,                          
                          onSaved: (input) => _body = input,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ),
        );
      },
    );
  }
}
