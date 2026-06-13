import 'dart:io';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../models/journal_entry.dart';
import '../services/entry_service.dart';
import '../services/photo_service.dart';

class EntryScreen extends StatefulWidget {
  final JournalEntry? existingEntry;

  const EntryScreen({
    super.key,
    this.existingEntry,
  });

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  final SpeechToText speech = SpeechToText();
  final EntryService entryService = EntryService();
  final PhotoService photoService = PhotoService();

  File? selectedImage;

  bool listening = false;

  @override
  void initState() {
    super.initState();

    if (widget.existingEntry != null) {
      titleController.text = widget.existingEntry!.title;
      contentController.text = widget.existingEntry!.content;

      if (widget.existingEntry!.imagePath != null) {
        selectedImage = File(
          widget.existingEntry!.imagePath!,
        );
      }
    }
  }

  Future<void> saveEntry() async {
    if (titleController.text.isEmpty &&
        contentController.text.isEmpty) {
      return;
    }

    if (widget.existingEntry == null) {
      await entryService.createEntry(
        JournalEntry(
          title: titleController.text,
          content: contentController.text,
          imagePath: selectedImage?.path,
          createdAt: DateTime.now(),
        ),
      );
    } else {
      await entryService.updateEntry(
        JournalEntry(
          id: widget.existingEntry!.id,
          title: titleController.text,
          content: contentController.text,
          imagePath: selectedImage?.path,
          createdAt: widget.existingEntry!.createdAt,
        ),
      );
    }

    if (mounted) {
      Navigator.pop(context);
    }
  }

  Future<void> pickFromGallery() async {
    final image = await photoService.pickFromGallery();

    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    }
  }

  Future<void> takePhoto() async {
    final image = await photoService.takePhoto();

    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    }
  }

  Future<void> startListening() async {
    bool available = await speech.initialize();

    if (available) {
      setState(() => listening = true);

      speech.listen(
        onResult: (result) {
          contentController.text = result.recognizedWords;

          setState(() {});
        },
      );
    }
  }

  void stopListening() {
    speech.stop();

    setState(() {
      listening = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal Entry'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: saveEntry,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 12),

            if (selectedImage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Image.file(
                  selectedImage!,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),

            Expanded(
              child: TextField(
                controller: contentController,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  labelText: 'Write your thoughts...',
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "gallery",
            onPressed: pickFromGallery,
            child: const Icon(Icons.photo),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: "camera",
            onPressed: takePhoto,
            child: const Icon(Icons.camera_alt),
          ),
          const SizedBox(height: 12),
          FloatingActionButton(
            heroTag: "voice",
            onPressed: () {
              listening
                  ? stopListening()
                  : startListening();
            },
            child: Icon(
              listening
                  ? Icons.mic_off
                  : Icons.mic,
            ),
          ),
        ],
      ),
    );
  }
}