import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakeibo/history.dart';
import 'package:kakeibo/model/history_category.dart';

class HistoryInputDialog extends StatefulWidget {
  const HistoryInputDialog({Key? key, required this.walletKey})
      : super(key: key);

  final String walletKey;

  @override
  State<HistoryInputDialog> createState() => _HistoryInputDialogState();
}

class _HistoryInputDialogState extends State<HistoryInputDialog> {
  String? dropdownValue;
  final _nameEditingController = TextEditingController();
  final _amountEditingController = TextEditingController();
  final _nonFocusNode = FocusNode();
  final _amountFocusNode = FocusNode();
  final _amoutFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameEditingController.dispose();
    _amountEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _nonFocusNode,
      child: GestureDetector(
        onTap: _nonFocusNode.requestFocus,
        child: AlertDialog(
          title: const Text('利用した金額を入力'),
          content: Form(
            key: _amoutFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                DropdownButtonFormField<String>(
                  value: dropdownValue,
                  hint: const Text('カテゴリ'),
                  icon: const Icon(Icons.expand_more),
                  elevation: 8,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownValue = newValue!;
                    });
                  },
                  items: HistoryCategory.values
                      .map<DropdownMenuItem<String>>((HistoryCategory value) {
                    return DropdownMenuItem<String>(
                      value: value.toString().split(".").last,
                      child: Text(value.japaneseName),
                    );
                  }).toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) return 'カテゴリを選択してください。';
                    return null;
                  },
                ),
                TextFormField(
                  controller: _nameEditingController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: '支出の名前を入力',
                  ),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(_amountFocusNode);
                  },
                ),
                TextFormField(
                  focusNode: _amountFocusNode,
                  controller: _amountEditingController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: '金額を入力',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) return '金額を入力してください。';
                    if (int.parse(value) == 0) return '0円の金額は入力できません。';
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('キャンセル'),
            ),
            TextButton(
              onPressed: () {
                if (_amoutFormKey.currentState!.validate()) {
                  String? name = _nameEditingController.text;
                  int amount = int.parse(_amountEditingController.text);
                  Navigator.pop<History>(
                      context,
                      History(
                        category: dropdownValue!,
                        name: name,
                        amount: amount,
                        walletKey: widget.walletKey,
                      ));
                }
              },
              child: const Text('追加'),
            ),
          ],
        ),
      ),
    );
  }
}
