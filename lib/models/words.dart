class Word {
  final int? id;
  final String word;
  final String meaning;

  Word({
    this.id,
    required this.word,
    required this.meaning,
  });

  factory Word.fromJson(Map<String, dynamic> map) {
    return Word(id: map['id'], word: map['word'], meaning: map['meaning']);
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'word': word, 'meaning': meaning};
  }
}
