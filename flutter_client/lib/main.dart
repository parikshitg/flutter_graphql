import 'package:flutter/material.dart';
import 'package:flutter_client/config/config.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import './screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: HttpLink('$BASE_URL'),
        cache:GraphQLCache(store: InMemoryStore()),
      ),
    );

    return GraphQLProvider(
      client: client,
      child: MaterialApp(
      title: 'Flutter Graphql Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        home: HomeScreen(),
      )
    );
  }
}
