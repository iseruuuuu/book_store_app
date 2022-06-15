import 'package:book_store_app/model/book.dart';
import 'package:book_store_app/state/book_list_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

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

  void openDialog() {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: MediaQuery.of(context).size.height / 3,
          padding: EdgeInsets.zero,
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: CupertinoPicker(
              itemExtent: 40,
              onSelectedItemChanged: (int selectedItem) {
                setState(() {
                  _bookCount = selectedItem;
                });
              },
              children: List<Widget>.generate(
                205,
                (int index) {
                  return Center(
                    child: Text(
                      index.toString(),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void shackBar() {
    showTopSnackBar(
      context,
      const CustomSnackBar.error(
        message: "本の名前 or 巻数の入力をしてください",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isCreateBook ? '本の追加' : '本の更新'),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            SingleChildScrollView(
              child: TextField(
                maxLength: 12,
                autocorrect: false,
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
            ),
            GestureDetector(
              onTap: () {
                openDialog();
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                child: Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(Icons.arrow_drop_down, size: 60),
                      ],
                    ),
                    Center(
                      child: Text(
                        '$_bookCount',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  if (_isCreateBook) {
                    if (_bookCount == 0) {
                      shackBar();
                    } else {
                      _store.add(
                        _bookTitle,
                        _bookCount,
                      );
                      Navigator.of(context).pop();
                    }
                  } else {
                    _store.update(widget.book!, _bookTitle);
                    Navigator.of(context).pop();
                  }
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
          ],
        ),
      ),
    );
  }
}
