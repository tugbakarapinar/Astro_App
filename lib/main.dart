import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  
  final apiUrl = dotenv.env['API_URL'];
  assert(apiUrl != null && apiUrl.isNotEmpty, 'API_URL tanımlı değil veya boş!');

  runApp(MyApp(apiUrl: apiUrl!));
}

class MyApp extends StatelessWidget {
  final String apiUrl;
  const MyApp({required this.apiUrl, super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AstroMend',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('tr', 'TR'),
      ],
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(apiUrl: apiUrl),
        '/register': (context) => RegisterScreen(apiUrl: apiUrl),
        '/home': (context) => HomeScreen(apiUrl: apiUrl),
      },
    );
  }
}
