import 'package:flutter/material.dart';
import 'package:vocab/database/database_repository.dart';
import 'package:vocab/provider/database_listener.dart';
import '../config.dart';
import '../models/words.dart';
import 'package:provider/provider.dart';

class VocabWrite extends StatefulWidget {
  const VocabWrite({super.key, this.word});

  final Word? word;

  @override
  State<VocabWrite> createState() => _VocabWriteState();
}

class _VocabWriteState extends State<VocabWrite> {
  int id = -1;
  final TextEditingController wordCon = TextEditingController();
  final TextEditingController meanCon = TextEditingController();

  @override
  void initState() {
    if (widget.word != null) {
      id = widget.word!.id!;
      wordCon.text = widget.word!.word;
      meanCon.text = widget.word!.meaning;
    }
    super.initState();
  }

  Future saveWord() async {
    if (widget.word == null) {
      Word newWord = Word(word: wordCon.text, meaning: meanCon.text);
      await DatabaseRepository.instance.insertWord(word: newWord);
    } else {
      Word newWord =
          Word(id: widget.word!.id, word: wordCon.text, meaning: meanCon.text);
      await DatabaseRepository.instance.updateWord(newWord);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Vocab"),
        backgroundColor: const Color(Config.appBarColor),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(color: Color(Config.bodyColor)),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(color: Color(Config.contentColor)),
            child: Column(
              children: [
                TextField(
                  controller: wordCon,
                  decoration: const InputDecoration(hintText: "Word"),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: meanCon,
                  decoration: const InputDecoration(hintText: "Meaning"),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    // print("Hello World");
                    saveWord().whenComplete(() {
                      Provider.of<DatabaseListener>(context, listen: false)
                          .dbUpdated();
                      Navigator.pop(context);
                    });
                    // Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(Config.floatingActionButtonColor),
                      minimumSize: const Size.fromHeight(50)),
                  child: const Text("Save"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
