class Book {
  /// ID
  late int id;

  /// 本の名前
  late String bookTitle;

  //本の巻数
  late int bookCount;

  /// 作成日時
  late String createDate;

  Book(
    this.id,
    this.bookTitle,
    this.bookCount,
    this.createDate,
  );

  Map toJson() {
    return {
      'id': id,
      'bookTitle': bookTitle,
      'bookCount': bookCount,
      'createDate': createDate,
    };
  }

  Book.fromJson(Map json) {
    id = json['id'];
    bookTitle = json['bookTitle'];
    bookCount = json['bookCount'];
    createDate = json['createDate'];
  }
}
