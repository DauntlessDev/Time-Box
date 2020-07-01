import 'dart:async';

import 'package:TimeTracker/screens/home/home_page.dart';
import 'package:TimeTracker/screens/landing_page.dart';
import 'package:TimeTracker/screens/login/login_page.dart';
import 'package:TimeTracker/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'package:TimeTracker/utils/constants.dart';

class MockAuth extends Mock implements AuthBase {}

void main() {
  MockAuth mockAuth;
  StreamController<User> onAuthStateChangedController;

  setUp(() {
    mockAuth = MockAuth();
    onAuthStateChangedController = StreamController<User>();
  });

  tearDown(() {
    onAuthStateChangedController.close();
  });

  Future<void> pumpLandingPage(WidgetTester tester) async {
    await tester.pumpWidget(
      Provider<AuthBase>(
        create: (_) => mockAuth,
        child: MaterialApp(
          home: Constants(child: LandingPage()),
        ),
      ),
    );

    await tester.pump();
  }

  void stubOnAuthStateChangedYields(Iterable<User> onAuthStateChanged) {
    onAuthStateChangedController
        .addStream(Stream<User>.fromIterable(onAuthStateChanged));
    when(mockAuth.onAuthStateChanged).thenAnswer(
      (realInvocation) => onAuthStateChangedController.stream,
    );
  }

  testWidgets(
    'stream waiting',
    (WidgetTester tester) async {
      stubOnAuthStateChangedYields([]);
      await pumpLandingPage(tester);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

  testWidgets(
    'null user',
    (WidgetTester tester) async {
      stubOnAuthStateChangedYields([null]);
      await pumpLandingPage(tester);

      expect(find.byType(LoginPage), findsOneWidget);
    },
  );
  testWidgets(
    'non-null user',
    (WidgetTester tester) async {
      stubOnAuthStateChangedYields([User(uid: '123', displayName: 'brave', photoUrl: 'yes')]);
      await pumpLandingPage(tester);

      expect(find.byType(HomePage), findsOneWidget);
    },
  );
}
