import 'package:flutter/material.dart';
import 'package:vocab/screens/vocab_write.dart';
import 'vocab_list.dart';
import '../config.dart';

class MyHome extends StatelessWidget {
  const MyHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 10, right: 10),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const VocabWrite()));
          },
          backgroundColor: const Color(0xff62466B),
          child: const Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        title: const Text("My Vocab"),
        backgroundColor: const Color(Config.appBarColor),
        elevation: 0,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 0,
                  child: Text("About"),
                )
              ];
            },
            onSelected: (value) {
              if (value == 0) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text("Made in Flutter"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Ok"),
                        )
                      ],
                    );
                  },
                );
              }
            },
          )
        ],
      ),
      body: SafeArea(
        child: Container(
            decoration: const BoxDecoration(color: Color(Config.bodyColor)),
            padding: const EdgeInsets.all(10),
            child: const VocabList()),
      ),
    );
  }
}
