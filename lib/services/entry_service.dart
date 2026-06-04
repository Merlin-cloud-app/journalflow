import 'package:sqflite/sqflite.dart';

import '../models/journal_entry.dart';
import 'database_service.dart';

class EntryService {
  Future<int> createEntry(JournalEntry entry) async {
      final Database db = await DatabaseService.instance.database;

          return db.insert(
                'entries',
                      entry.toMap(),
                          );
                            }

                              Future<List<JournalEntry>> getEntries() async {
                                  final Database db = await DatabaseService.instance.database;

                                      final result = await db.query(
                                            'entries',
                                                  orderBy: 'createdAt DESC',
                                                      );

                                                          return result
                                                                  .map((e) => JournalEntry.fromMap(e))
                                                                          .toList();
                                                                            }

                                                                              Future<int> updateEntry(JournalEntry entry) async {
                                                                                  final Database db = await DatabaseService.instance.database;

                                                                                      return db.update(
                                                                                            'entries',
                                                                                                  entry.toMap(),
                                                                                                        where: 'id = ?',
                                                                                                              whereArgs: [entry.id],
                                                                                                                  );
                                                                                                                    }

                                                                                                                      Future<int> deleteEntry(int id) async {
                                                                                                                          final Database db = await DatabaseService.instance.database;

                                                                                                                              return db.delete(
                                                                                                                                    'entries',
                                                                                                                                          where: 'id = ?',
                                                                                                                                                whereArgs: [id],
                                                                                                                                                    );
                                                                                                                                                      }
                                                                                                                                                      }