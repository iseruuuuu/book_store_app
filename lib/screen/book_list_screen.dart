import 'package:book_store_app/model/book.dart';
import 'package:book_store_app/parts/border_item.dart';
import 'package:book_store_app/parts/delete_dialog.dart';
import 'package:book_store_app/parts/empty_screen.dart';
import 'package:book_store_app/screen/book_detail_screen.dart';
import 'package:book_store_app/screen/book_input_screen.dart';
import 'package:book_store_app/state/book_list_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:new_version/new_version.dart';

class BookListScreen extends StatefulWidget {
  const BookListScreen({Key? key}) : super(key: key);

  @override
  State<BookListScreen> createState() => _BookListScreenState();
}

class _BookListScreenState extends State<BookListScreen> {
  final BookListStore _store = BookListStore();

  void _pushTodoInputPage([Book? book]) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return BookInputScreen(book: book);
        },
      ),
    );
    setState(() {});
  }

  void _pushTodoDetailPage([Book? book]) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return BookDetailScreen(book: book);
        },
      ),
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // final newVersion = NewVersion(
    //   androidId: 'com.pokemon_card_price_app',
    //   iOSId: 'com.pokemonCardPriceApp',
    //   iOSAppStoreCountry: 'JP',
    // );
    // openUpdateDialog(newVersion);
    loadStore();
    _store.getTodo();
  }

  void loadStore() {
    Future.delayed(Duration.zero, () {
      setState(() {
        _store.load();
      });
    });
  }

  void openUpdateDialog(NewVersion newVersion) async {
    final status = await newVersion.getVersionStatus();
    if (status != null && status.canUpdate) {
      String storeVersion = status.storeVersion;
      String releaseNote = status.releaseNotes.toString();
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        dialogTitle: 'アップデートが必要です。',
        dialogText:
            'Ver.$storeVersionが公開されています。\n最新バージョンにアップデートをお願いします。\n\nバージョンアップ内容は以下の通りです。\n$releaseNote',
        updateButtonText: 'アップデート',
        allowDismissal: false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 0,
      ),
      body: _store.isEmpty
          ? const EmptyScreen()
          : ReorderableListView.builder(
              onReorder: (int oldIndex, int newIndex) {
                _store.onReorder(_store.getTodo(), oldIndex, newIndex);
              },
              itemCount: _store.count(),
              itemBuilder: (context, index) {
                var item = _store.findByIndex(index);
                return Slidable(
                  key: ValueKey(index),
                  startActionPane: ActionPane(
                    key: ValueKey(index),
                    motion: const ScrollMotion(),
                    extentRatio: 0.25,
                    children: [
                      SlidableAction(
                        key: ValueKey(index),
                        onPressed: (context) {
                          _pushTodoInputPage(item);
                          _store.loadCard(item.id.toString());
                        },
                        backgroundColor: Colors.yellow,
                        icon: Icons.edit,
                        label: '編集',
                      ),
                    ],
                  ),
                  endActionPane: ActionPane(
                    key: ValueKey(index),
                    motion: const ScrollMotion(),
                    extentRatio: 0.25,
                    children: [
                      SlidableAction(
                        key: ValueKey(index),
                        onPressed: (context) {
                          _store.loadCard(item.id.toString());
                          showDialog<void>(
                            context: context,
                            builder: (_) {
                              return DeleteDialog(
                                onDelete: () {
                                  setState(() {
                                    _store.delete(
                                      book: item,
                                    );
                                  });
                                },
                              );
                            },
                          );
                        },
                        backgroundColor: Colors.red,
                        icon: Icons.edit,
                        label: '削除',
                      ),
                    ],
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: index == 0
                          ? BorderItem.borderFirst()
                          : BorderItem.borderOther(),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        _pushTodoDetailPage(item);
                        _store.loadCard(item.id.toString());
                      },
                      child: ListTile(
                        contentPadding: const EdgeInsets.only(
                          left: 15,
                          right: 10,
                          top: 5,
                          bottom: 5,
                        ),
                        key: ValueKey(index),
                        title: Row(
                          children: [
                            const SizedBox(width: 15),
                            Text(
                              item.bookTitle,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        trailing: const Icon(
                          Icons.list,
                          size: 35,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: SizedBox(
        width: 85,
        height: 85,
        child: FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: _pushTodoInputPage,
          child: const Icon(
            Icons.add,
            size: 60,
          ),
        ),
      ),
    );
  }
}
