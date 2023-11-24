import 'package:edu_assignment/provider/bookmark_provider.dart';
import 'package:edu_assignment/provider/filter_provider.dart';
import 'package:edu_assignment/provider/source_provider.dart';
import 'package:edu_assignment/screens/bookmark.dart';
import 'package:edu_assignment/screens/home.dart';
import 'package:edu_assignment/screens/news_detail.dart';
import 'package:edu_assignment/screens/top_h.dart';
import 'package:edu_assignment/screens/web_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// import 'flutterPlugins';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) => TopHeadLineFilterProvider()),
        ChangeNotifierProvider(create: (context) => EverythingFilter()),
        ChangeNotifierProvider(create: (context) => SourceProvider()),
        ChangeNotifierProvider(create: (context) => BookmarkProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: TextTheme(
            titleLarge: GoogleFonts.palanquin(
                fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        home: HomeScreen(),
        routes: {
          MoreTopHeadLines.routeName: (context) => MoreTopHeadLines(),
          BookmarkScreen.routeName: (context) => BookmarkScreen(),
          NewsDetail.routeName: (context) => NewsDetail(),
          WebViewerScreen.routeName: (context) => WebViewerScreen(),
        },
      ),
    );
  }
}
