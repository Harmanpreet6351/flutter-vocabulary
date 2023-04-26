import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocab/provider/database_listener.dart';
import 'package:vocab/screens/vocab_detail.dart';
import 'package:vocab/screens/vocab_write.dart';
import '../config.dart';
import '../models/words.dart';
import '../database/database_repository.dart';

class VocabList extends StatefulWidget {
  const VocabList({super.key});

  @override
  State<VocabList> createState() => _VocabListState();
}

class _VocabListState extends State<VocabList> {
  List<Word> words = [];

  void initDb() async {
    DatabaseRepository.instance.database;
  }

  String truncateSentence({required String sentence, int chars = 10}) {
    if (sentence.length >= chars) {
      return "${sentence.substring(0, chars)}...";
    }
    return sentence;
  }

  void loadVocab() {
    setState(() {});
  }

  @override
  void initState() {
    initDb();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseListener>(builder: (context, data, child) {
      return FutureBuilder<List<Word>>(
          future: DatabaseRepository.instance.getAllWords(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data!.isEmpty) {
              return const Center(
                child: Text("No Words yet"),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    margin: const EdgeInsets.only(bottom: 10),
                    decoration: const BoxDecoration(
                      color: Color(Config.contentColor),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VocabDetail(
                                      word: snapshot.data![index],
                                    )));
                      },
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data![index].word,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(truncateSentence(
                                    sentence: snapshot.data![index].meaning,
                                    chars: 40))
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VocabWrite(
                                            word: snapshot.data![index],
                                          )));
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              DatabaseRepository.instance
                                  .deleteWord(snapshot.data![index])
                                  .then((value) {
                                setState(() {});
                              });
                            },
                            icon: const Icon(Icons.delete),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return const Center(
              child: Text("Some error occured"),
            );
          });
    });
  }
}
