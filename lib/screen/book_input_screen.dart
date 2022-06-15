import 'package:book_store_app/model/book.dart';
import 'package:book_store_app/state/book_list_store.dart';
import 'package:flutter/material.dart';

class BookInputScreen extends StatefulWidget {
  final Book? book;

  const BookInputScreen({Key? key, this.book}) : super(key: key);

  @override
  State<BookInputScreen> createState() => _BookInputScreenState();
}

class _BookInputScreenState extends State<BookInputScreen> {
  final BookListStore _store = BookListStore();

  late bool _isCreateBook;
  late String _bookTitle;
  late int _bookCount;
  late String _createDate;

  @override
  void initState() {
    super.initState();
    var book = widget.book;
    _bookTitle = book?.bookTitle ?? "";
    _createDate = book?.createDate ?? "";
    _bookCount = book?.bookCount ?? 0;
    _isCreateBook = book == null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(_isCreateBook ? '本の追加' : '本の更新'),
        elevation: 0,
      ),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  TextField(
                    maxLength: 12,
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: "本の名前",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    controller: TextEditingController(text: _bookTitle),
                    onChanged: (String value) {
                      _bookTitle = value;
                    },
                  ),
                  TextField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: "巻数",
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                    controller: TextEditingController(text: _bookCount.toString()),
                    onChanged: (value) {
                      _bookCount = int.parse(value);
                    },
                  ),
                  Column(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_isCreateBook) {
                              _store.add(
                                _bookTitle,
                                _bookCount,
                              );
                            } else {
                              _store.update(widget.book!, _bookTitle);
                            }
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            '追加',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 50),
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            side: const BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          child: const Text(
                            "キャンセル",
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
