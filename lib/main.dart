import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  

  await dotenv.load(fileName: ".env");

 
  debugPrint(" API_URL_WEB: ${dotenv.env['API_URL_WEB']}");
  debugPrint(" API_URL_ANDROID: ${dotenv.env['API_URL_ANDROID']}");
  debugPrint(" API_URL_IOS: ${dotenv.env['API_URL_IOS']}");

  
  assert(dotenv.env['API_URL_WEB'] != null && dotenv.env['API_URL_WEB']!.isNotEmpty,
      ' API_URL_WEB tanımlı değil veya boş!');
  assert(dotenv.env['API_URL_ANDROID'] != null && dotenv.env['API_URL_ANDROID']!.isNotEmpty,
      ' API_URL_ANDROID tanımlı değil veya boş!');
  assert(dotenv.env['API_URL_IOS'] != null && dotenv.env['API_URL_IOS']!.isNotEmpty,
      ' API_URL_IOS tanımlı değil veya boş!');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        '/': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}
