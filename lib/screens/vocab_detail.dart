import 'package:flutter/material.dart';
import '../config.dart';
import '../models/words.dart';

class VocabDetail extends StatelessWidget {
  const VocabDetail({super.key, required this.word});

  final Word word;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Vocab"),
        backgroundColor: const Color(Config.appBarColor),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(color: Color(Config.bodyColor)),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(color: Color(Config.contentColor)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  word.word,
                  style: const TextStyle(
                      fontSize: 36, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  word.meaning,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
