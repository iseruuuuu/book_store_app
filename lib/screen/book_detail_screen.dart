import 'package:book_store_app/model/book.dart';
import 'package:book_store_app/parts/border_item.dart';
import 'package:book_store_app/parts/empty_card_screen.dart';
import 'package:book_store_app/state/book_list_store.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookDetailScreen extends StatefulWidget {
  final Book? book;

  const BookDetailScreen({
    Key? key,
    this.book,
  }) : super(key: key);

  @override
  State<BookDetailScreen> createState() => _BookDetailScreenState();
}

class _BookDetailScreenState extends State<BookDetailScreen> {
  final BookListStore _store = BookListStore();
  bool isSearch = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(widget.book!.bookTitle),
        elevation: 0,
      ),
      body: Center(
        child: _store.isCardEmpty
            ? const EmptyCardScreen()
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: _store.isSearchEmpty
                        ? const EmptyCardScreen()
                        : ListView.builder(
                            itemCount: _store.cardCount(),
                            itemBuilder: (context, index) {
                              var item = _store.findCardByIndex(index);
                              return Container(
                                decoration: BoxDecoration(
                                  border: index == 0
                                      ? BorderItem.borderFirst()
                                      : BorderItem.borderOther(),
                                ),
                                child: ListTile(
                                  key: ValueKey(index),
                                  title: Text(
                                    '${item.bookCount} 巻',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                  trailing: Switch(
                                    value: item.isHave,
                                    onChanged: (isHave) {
                                      setState(() {
                                        _store.updateBook(
                                          id: widget.book!.id,
                                          isHave: isHave,
                                          bookDetail: item,
                                        );
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                  )
                ],
              ),
      ),
    );
  }
}
