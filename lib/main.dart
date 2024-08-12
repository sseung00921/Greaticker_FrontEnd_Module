import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:greaticker/common/constants/widget_keys.dart';
import 'package:greaticker/common/layout/default_layout.dart';
import 'package:greaticker/common/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();  // 1번코드
  await dotenv.load(fileName: ".env");
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {

  const MyApp({
    super.key
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}


