import 'package:flutter/material.dart';

class HistoryList extends StatelessWidget {
  const HistoryList(
      {Key? key,
      required this.histories,
      required this.scrollAreaHeight,
      required this.dismissibleFunc})
      : super(key: key);

  final List histories;
  final double scrollAreaHeight;
  final Function dismissibleFunc;
  static const double historyHeaderAreaHeight = 30;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: historyHeaderAreaHeight,
          child: Text('一覧'),
        ),
        SizedBox(
          height: scrollAreaHeight - historyHeaderAreaHeight,
          child: Scrollbar(
            child: ListView.builder(
              itemCount: histories.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  child: Card(
                    child: ListTile(
                      title: Text(
                          '${histories[index].category}, ${histories[index].amount}'),
                    ),
                  ),
                  onDismissed: (direction) {
                    dismissibleFunc(index);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
