class BookDetail {
  /// ID
  late int id;

  /// 巻数
  late int bookCount;

  //持っているかどうか
  late bool isHave;

  BookDetail(
    this.id,
    this.bookCount,
    this.isHave,
  );

  Map toJson() {
    return {
      'id': id,
      'bookCount': bookCount,
      'isHave': isHave,
    };
  }

  BookDetail.fromJson(Map json) {
    id = json['id'];
    bookCount = json['bookCount'];
    isHave = json['isHave'];
  }
}
