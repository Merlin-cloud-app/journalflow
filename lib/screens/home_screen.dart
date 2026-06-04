import 'package:flutter/material.dart';
import 'entry_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

    @override
      Widget build(BuildContext context) {
          return Scaffold(
                appBar: AppBar(
                        title: const Text('JournalFlow'),
                              ),
                                    body: const Center(
                                            child: Text('No journal entries yet'),
                                                  ),
                                                        floatingActionButton: FloatingActionButton(
                                                                child: const Icon(Icons.add),
                                                                        onPressed: () {
                                                                                  Navigator.push(
                                                                                              context,
                                                                                                          MaterialPageRoute(
                                                                                                                        builder: (_) => const EntryScreen(),
                                                                                                                                    ),
                                                                                                                                              );
                                                                                                                                                      },
                                                                                                                                                            ),
                                                                                                                                                                );
                                                                                                                                                                  }
                                                                                                                                                                  }