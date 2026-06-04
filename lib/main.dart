import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const JournalFlowApp());
  }

  class JournalFlowApp extends StatelessWidget {
    const JournalFlowApp({super.key});

      @override
        Widget build(BuildContext context) {
            return MaterialApp(
                  title: 'JournalFlow',
                        debugShowCheckedModeBanner: false,
                              theme: ThemeData.dark(),
                                    home: const HomeScreen(),
                                        );
                                          }
                                          }