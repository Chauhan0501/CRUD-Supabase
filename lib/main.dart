import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'injection_container.dart' as di;
import 'presentation/bindings/app_bindings.dart';
import 'presentation/pages/onboard_page.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  
  // Initialize Supabase
  await Supabase.initialize(
    url: 'https://eelghlydfzjoxdvsiahq.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImVlbGdobHlkZnpqb3hkdnNpYWhxIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzI0NDI2NzUsImV4cCI6MjA4ODAxODY3NX0.LoA77UbApQGo1aC1yHUJsab1V3AV1G5HtVB8yKp-n18',
  );

  // Initialize Dependency Injection
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Supabase CRUD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: '/onboard',
      getPages: [
        GetPage(
          name: '/onboard',
          page: () => const OnboardPage(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginPage(),
          binding: AuthBinding(),
        ),
        GetPage(
          name: '/home',
          page: () => HomePage(),
          binding: HomeBinding(),
        ),
      ],
    );
  }
}
