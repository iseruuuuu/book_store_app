import 'package:book_store_app/model/book.dart';
import 'package:book_store_app/model/book_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class BookListStore {
  final String _saveKey = "Todo";
  List<Book> _list = [];
  List<BookDetail> _cardList = [];
  static final BookListStore _instance = BookListStore._internal();
  bool isSearchEmpty = false;
  bool isEmpty = false;
  bool isCardEmpty = false;

  BookListStore._internal();

  factory BookListStore() {
    return _instance;
  }

  int count() {
    return _list.length;
  }

  int cardCount() {
    return _cardList.length;
  }

  Book findByIndex(int index) {
    return _list[index];
  }

  List<Book> getTodo() {
    return _list;
  }

  List<BookDetail> getCard() {
    return _cardList;
  }

  BookDetail findCardByIndex(int index) {
    return _cardList[index];
  }

  void checkListEmpty() {
    if (_list.isEmpty) {
      isEmpty = true;
    } else {
      isEmpty = false;
    }
  }

  void checkCardEmpty() {
    if (_cardList.isEmpty) {
      isCardEmpty = true;
    } else {
      isCardEmpty = false;
    }
  }

  String getDateTime() {
    var format = DateFormat("yyyy/MM/dd HH:mm");
    var dateTime = format.format(DateTime.now());
    return dateTime;
  }

  String getDate() {
    var format = DateFormat("yyyy/MM/dd");
    var dateTime = format.format(DateTime.now());
    return dateTime;
  }

  void add(String title, int bookCount) {
    var id = count() == 0 ? 1 : _list.last.id + 1;
    var dateTime = getDateTime();
    var todo = Book(id, title, bookCount, dateTime);
    _list.add(todo);
    save();
    checkListEmpty();

    for (int i = 0; i < bookCount; i++) {
      var cardList = BookDetail(i, i + 1, false);
      _cardList.add(cardList);
    }
    //saveしてあげる
    saveCard(id.toString());
    print(_cardList); //[Instance of 'BookDetail', Instance of 'BookDetail']
  }

  void addCard(String shopName, int price, int bookCount, bool isHave, int id) {
    var id = cardCount() == 0 ? 1 : _cardList.last.id + 1;
    var createDate = getDate();
    var card = BookDetail(id, bookCount, isHave);
    _cardList.add(card);
    saveCard(id.toString());
    checkCardEmpty();
  }

  void update(Book book, [String? title]) {
    if (title != null) {
      book.bookTitle = title;
    }
    save();
  }

  void updateBook({required BookDetail bookDetail, required int id, required bool isHave}) {
    bookDetail.isHave = isHave;
    saveCard(id.toString());
  }

  void delete({required Book book}) {
    deleteAllCard(index: book.id);
    _list.remove(book);
    save();
    checkListEmpty();
  }

  void deleteAllCard({required int index}) {
    _cardList.clear();
    saveCard(index.toString());
    checkCardEmpty();
  }

  void deleteCard(BookDetail bookDetail, String saveKey) {
    _cardList.remove(bookDetail);
    saveCard(saveKey);
    checkCardEmpty();
  }

  void save() async {
    var prefs = await SharedPreferences.getInstance();
    var saveTargetList = _list.map((a) => json.encode(a.toJson())).toList();

    print(saveTargetList);
    prefs.setStringList(_saveKey, saveTargetList);
  }

  void saveCard(String password) async {
    var prefs = await SharedPreferences.getInstance();
    var saveTargetList = _cardList.map((a) => json.encode(a.toJson())).toList();
    print(saveTargetList);
    prefs.setStringList(password, saveTargetList);
  }

  void load() async {
    var prefs = await SharedPreferences.getInstance();
    var loadTargetList = prefs.getStringList(_saveKey) ?? [];
    _list = loadTargetList.map((a) => Book.fromJson(json.decode(a))).toList();
    checkListEmpty();
  }

  void loadCard(String? password) async {
    var prefs = await SharedPreferences.getInstance();
    var loadTargetList = prefs.getStringList(password ?? '') ?? [];
    _cardList =
        loadTargetList.map((a) => BookDetail.fromJson(json.decode(a))).toList();
    checkCardEmpty();
  }

  void onReorder(List<Book> book, int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    book.insert(newIndex, book.removeAt(oldIndex));
    save();
  }
}
