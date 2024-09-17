import 'package:flutter/material.dart';

class StreamsBuild extends StatefulWidget {
  const StreamsBuild({super.key});

  @override
  State<StreamsBuild> createState() => _StreamsBuildState();
}

class _StreamsBuildState extends State<StreamsBuild> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Streams'),
        centerTitle: true,
      ),
      body: const Column(
        children: [],
      ),
    );
  }
}
