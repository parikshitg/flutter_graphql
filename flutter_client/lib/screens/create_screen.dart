import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../config/mutation.dart';

class CreateScreen extends StatefulWidget {
  @override
  _CreateScreenState createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final _formKey = GlobalKey<FormState>();

  String _body;
  String _title;
  String _author;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CREATE BLOG'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: (){
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                print('title: $_title');
                print('title: $_author');
                print('title: $_body');
              }
            },
          ),
        ],
      ),
      body: Mutation(
        // options: MutationOptions(gql(createBlog)),
        options: MutationOptions(
          document: gql(createBlog), // this is the mutation string you just created
          // you can update the cache based on results
          update: (GraphQLDataProxy cache, QueryResult result) {
            return cache;
          },
          // or do something with the result.data on completion
          onCompleted: (dynamic resultData) {
            print('00000000000000 $resultData');
          },
        ),
        builder:(runMutation,result){
          return SingleChildScrollView(
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
                        TextButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              _formKey.currentState.save();
                                runMutation({
                                "input": {
                                  "title": _title,
                                  "author": _author,
                                  "date": "2021-04-20T12:21:28.636Z",
                                  "body":_body,
                                }
                              });
                            }
                          },
                          child: const Text('Create Post'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
