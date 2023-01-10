import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kakeibo/model/history_category.dart';

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
    var numberFormatter = NumberFormat("#,###");
    var datetimeFormatter = DateFormat('yyyy/MM/dd');
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
                      leading: Icon(HistoryCategory.values
                          .byName(histories[index].category)
                          .icon),
                      title: Text('${histories[index].name}'),
                      subtitle: Text(datetimeFormatter.format(DateTime.parse(
                          histories[index].createdAt.toDate().toString()))),
                      trailing: Text(
                          '¥${numberFormatter.format(histories[index].amount)}'),
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
