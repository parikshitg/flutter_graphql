# FLUTTER GRAPHQL

![Banner](https://github.com/parikshitg/flutter_graphql/blob/master/flutter_client/assets/images/flutter_graphql.png)

This projects demonstrates the ideal way to call graphql queries and mutations. The app consists of creating a blog post and displaying the list of blog posts. The project-repo consist of two directories, flutter_client (our frontend client app written in flutter) and go-gql-server backend server written in golang. The go-gql-server is a graphql server with minimal go code and is a  written using "github.com/99designs/gqlgen" package. 
 
### REQUIREMENTS
*  Computer
*  Golang 
*  Flutter

### RUN
To run golang backend server:

```
cd flutter_graphql/go-gql-server
make run or go run server.go  
```

To run flutter app:
 
```
cd flutter_graphql/flutter_client
flutter pub get
flutter run
```

#### [Note]

*You can see the graphql schema define in 'go-gql-server/graph/schema.graphqls'.

*The sample query and mutation are there in 'flutterclient/lib/config/muation.dart' and 'query.dart'.
