import 'dart:async';

import 'package:flutter/material.dart';
import 'package:future_app/future_builder.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class Futures extends StatefulWidget {
  const Futures({super.key});

  @override
  State<Futures> createState() => _FuturesState();
}

class _FuturesState extends State<Futures> {
  Logger logger = Logger();
  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() {
    const url = "https://jsonplaceholder.typicode.com/users";
    //Uri-naming url-protocol(https://)
    //http.get(Uri.parse(url)); //this will return Future<instance/response>
    //There are two ways:
    //1st way :-
    // http.get(Uri.parse(url)).then((value) {//"then" keyword will take (value) and give response
    //   return logger.d(value.body);
    // }).catchError((err) {
    //   return logger.d(err.toString());
    // });
    //the reason we are not using this method cuz of the nesting

    // Next method try async
  }

  void getUser() async {
    //now this shld convert from void to future<void> if we are returning a string then Future<String>
    const url = "https://jsonplaceholder.typicode.com/users";

    // Next method try async
    // http.Response res = await http.get(Uri.parse(
    //     url));            //we will get an error because we are using async func to solve this use await
    // logger.d(res);        //it is giving us instance of response

    try {
      http.Response res = await http.get(Uri.parse(url));
      logger.d(res.body);
    } catch (err) {
      logger.d(err.toString());
    }
  }

  void delay() async {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const FutureBuilderWidget(),
          ));
    });
  }

  Future future = Future(
    () {},
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Center(
          child: Text(
            'Futures',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Center(
              child: IconButton(
                onPressed: () async {
                  delay();
                },
                icon: const Icon(Icons.next_plan_rounded),
              ),
            ),
          ),
          const Text('Indraj'),
        ],
      ),
    );
  }
}
