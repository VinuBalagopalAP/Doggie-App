import 'dart:convert';

import 'package:flutter/material.dart';
import "package:http/http.dart" as http;

class DogImage extends StatefulWidget {
  const DogImage({Key? key}) : super(key: key);

  @override
  State<DogImage> createState() => _DogImageState();
}

class _DogImageState extends State<DogImage> {
  String url = 'https://dog.ceo/api/breeds/image/random';

  Map? map;

  Future<void> fetchData() async {
    final uri = Uri.parse(url);

    var response = await http.get(uri);
    var json = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        map = json;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.grey,
                Colors.black,
              ],
            ),
          ),
          child: const Text("I'm a pet lover"),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        child: map == null
            ? const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.black,
                  color: Colors.grey,
                ),
              )
            : Stack(
                children: [
                  Center(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(map!['message']),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        onPrimary: Colors.black,
                        primary: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          fetchData();
                        });
                      },
                      child: const Text("I wanna see next one"),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
