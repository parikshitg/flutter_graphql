import 'package:flutter/material.dart';

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
                        onSaved: (input) => _author = input,
                      ),
                    ),
                    SizedBox(height:8.0),
                    Container(
                      child: TextFormField(
                        maxLines: 25,
                        decoration:InputDecoration(
                            hintText: 'Write blog here...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        onSaved: (input) => _body = input,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}