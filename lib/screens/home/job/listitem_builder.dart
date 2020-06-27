import 'package:flutter/cupertino.dart';
import 'package:TimeTracker/screens/home/job/empty_content.dart';
import 'package:flutter/material.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemBuilder<T> extends StatelessWidget {
  const ListItemBuilder({this.snapshot, this.itemBuilder});
  final AsyncSnapshot<List<T>> snapshot;
  final ItemWidgetBuilder<T> itemBuilder;
  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData) {
      final List<T> items = snapshot.data;
      if (items.isNotEmpty) {
        return _buildList(items);
      }
      return EmptyContent();
    } else if (snapshot.hasError) {
      return EmptyContent(
        title: 'Loading Error',
        message: 'Something has gone wrong',
      );
    }

    return Center(child: CircularProgressIndicator());
  }

  Widget _buildList(List<T> items) {
    return ListView.separated(
      itemBuilder: (context, index) {
        if (index == 0 || index == items.length + 1) {
          return Container();
        }
        return itemBuilder(context, items[index - 1]);
      },
      itemCount: items.length + 2,
      separatorBuilder: (BuildContext context, int index) => Divider(
        thickness: 1,
        height: 1,
      ),
    );
  }
}
