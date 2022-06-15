import 'package:flutter/material.dart';

class RegisterDialog extends StatefulWidget {
  final Function() onRegister;
  final Function(bool?) onSale;
  final TextEditingController storeController;
  final TextEditingController priceController;
  final Function(String) onStoreChange;
  final Function(String) onPriceChange;
  bool isSale;

  RegisterDialog({
    required this.onRegister,
    required this.onSale,
    required this.storeController,
    required this.priceController,
    required this.onStoreChange,
    required this.onPriceChange,
    required this.isSale,
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterDialog> createState() => _RegisterDialogState();
}

class _RegisterDialogState extends State<RegisterDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Column(
        children: [
          const SizedBox(height: 15),
          TextField(
            autofocus: false,
            decoration: const InputDecoration(
              labelText: "店名",
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
            controller: widget.storeController,
            onChanged: widget.onStoreChange,
          ),
          const SizedBox(height: 15),
          TextField(
            autofocus: false,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: '値段',
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
            controller: widget.priceController,
            onChanged: widget.onPriceChange,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('特価'),
              Checkbox(
                value: widget.isSale,
                onChanged: (value) {
                  setState(() {
                    widget.isSale = value!;
                    widget.onSale(value);
                  });
                },
              ),
            ],
          ),
        ],
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'キャンセル',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
            SizedBox(
              width: 100,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(elevation: 0),
                onPressed: widget.onRegister,
                child: const Text('登録'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
