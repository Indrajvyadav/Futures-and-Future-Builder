import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FutureBuilderWidget extends StatefulWidget {
  const FutureBuilderWidget({super.key});

  @override
  State<FutureBuilderWidget> createState() => _FutureBuilderWidgetState();
}

//initState is not used cuz of chrome window resizing issues(future in continously running)
class _FutureBuilderWidgetState extends State<FutureBuilderWidget> {
  List names = []; //if you have List<map<object,String>>

  Future<List<dynamic>> getData() async {
    //You need to mention Future<List<dnamic>> for using FutureBuilder
    const uri = "https://jsonplaceholder.typicode.com/users";
    http.Response res =
        await http.get(Uri.parse(uri)); //Response can take time so use await
    var result = jsonDecode(res.body);
    for (var name in result) {
      // To extract item from List<map> use For-loop
      names.add(name['name']);
    }
    return names;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Center(
              child: Text(
            'Future_Builder',
            style: TextStyle(color: Colors.white),
          ))),
      body: Center(
        child: Column(
          children: [
            FutureBuilder(
              initialData: const [], //this data can be shown until future is completed,but not show when future is completed
              future: getData(), //add your future
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                //snapshot subscribes to your future that has access to your future data/returns

                //ConnectionState is a property of snapshot it has 4 properties used to avoid null check warning
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return Expanded(
                      //wrap expanded to avoid overflow
                      child: ListView.builder(
                        itemCount: snapshot.data!
                            .length, //data can be null(empty too) hence null check operator is used
                        itemBuilder: (context, index) {
                          final data = snapshot.data![index];
                          return ListTile(
                            title: Text(data),
                            leading: Text('${index + 1}'),
                          );
                        },
                      ),
                    );
                  }
                } else if (snapshot.hasError) {
                  var error = snapshot
                      .error; // make an variable to access error from snapshot
                  return Center(child: Text('Error Occurred\n $error'));
                } //if Waiting(data not loaded) or null
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
