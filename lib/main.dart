import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pages/login_page.dart';

final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'url',
    anonKey: 'anon',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeNotifier,
      builder: (_, ThemeMode currentMode, __) {
        return MaterialApp(
          title: 'Katalog Samsung',
          debugShowCheckedModeBanner: false,
          themeMode: currentMode,
          theme: ThemeData.light(useMaterial3: true).copyWith(
            primaryColor: const Color(0xFF1428A0),
            textTheme: GoogleFonts.outfitTextTheme(ThemeData.light().textTheme),
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF1428A0),
              foregroundColor: Colors.white,
            ),
          ),

          darkTheme: ThemeData.dark(useMaterial3: true).copyWith(
            textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
          ),
          
          home: const LoginPage(),
        );
      },
    );
  }
}
