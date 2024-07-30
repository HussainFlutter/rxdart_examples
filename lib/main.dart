import 'package:flutter/material.dart';
import 'package:rxdart_examples/loading_example.dart';

void main() {
  runApp(const HomePage());
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage2(),
    );
  }
}

class HomePage2 extends StatelessWidget {
  const HomePage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text("Rx dart Practice"),
      ),
      body: Center(
        child: GestureDetector(
          onTap: () async {
            final loading = Loading(context: context);
            final changeDescription = loading.behaviorSubject.sink;
            loading.showOverlay(
              text: "Loading...",
            );
            await Future.delayed(const Duration(seconds: 3));
            changeDescription.add("Loading Account details...");
            await Future.delayed(const Duration(seconds: 3));
            changeDescription.add("Just there");
            await Future.delayed(const Duration(seconds: 3));
            loading.removeOverlay();
            loading.dispose();
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(50),
            ),
            height: MediaQuery.of(context).size.height * 0.1,
            width: MediaQuery.of(context).size.height * 0.3,
            child: const Center(
                child: Text(
              "Press me",
              style: TextStyle(color: Colors.white),
            )),
          ),
        ),
      ),
    );
  }
}
