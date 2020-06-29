import 'package:TimeTracker/screens/entry/allentry_page.dart';
import 'package:TimeTracker/screens/home/account/account_page.dart';
import 'package:TimeTracker/screens/home/cupertino_home_scaffold.dart';
import 'package:TimeTracker/screens/home/entries/entries_page.dart';
import 'package:TimeTracker/screens/home/tab_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'job/job_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.jobs;

  void _select(TabItem value) {
    if (value == _currentTab) {
      navigatorKey[value].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = value);
    }
  }

  Map<TabItem, GlobalKey<NavigatorState>> get navigatorKey {
    return {
      TabItem.jobs: JobPage.navigatorKey,
      TabItem.entries: AllEntryPage.navigatorKey,
      TabItem.account: AccountPage.navigatorKey,
    };
  }

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.jobs: (_) => JobPage(),
      TabItem.entries: (context) => EntriesPage.create(context),
      TabItem.account: (_) => AccountPage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKey[_currentTab].currentState.maybePop(),
      child: CupertinoHomeScaffold(
          currentTab: _currentTab,
          onSelectTab: _select,
          widgetBuilders: widgetBuilders,
          navigatorKey: navigatorKey),
    );
  }
}
