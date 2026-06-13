import 'dart:io';

import 'package:flutter/material.dart';

import '../models/journal_entry.dart';

class JournalCard extends StatelessWidget {
  final JournalEntry entry;
    final VoidCallback? onTap;

      const JournalCard({
          super.key,
              required this.entry,
                  this.onTap,
                    });

                      @override
                        Widget build(BuildContext context) {
                            return Card(
                                  margin: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                                  vertical: 6,
                                                        ),
                                                              child: ListTile(
                                                                      leading: entry.imagePath != null
                                                                                  ? Image.file(
                                                                                                  File(entry.imagePath!),
                                                                                                                  width: 50,
                                                                                                                                  height: 50,
                                                                                                                                                  fit: BoxFit.cover,
                                                                                                                                                                )
                                                                                                                                                                            : const Icon(Icons.book),
                                                                                                                                                                                    title: Text(entry.title),
                                                                                                                                                                                            subtitle: Text(
                                                                                                                                                                                                      entry.content,
                                                                                                                                                                                                                maxLines: 2,
                                                                                                                                                                                                                          overflow: TextOverflow.ellipsis,
                                                                                                                                                                                                                                  ),
                                                                                                                                                                                                                                          onTap: onTap,
                                                                                                                                                                                                                                                ),
                                                                                                                                                                                                                                                    );
                                                                                                                                                                                                                                                      }
                                                                                                                                                                                                                                                      }