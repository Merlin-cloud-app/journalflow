import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class PhotoService {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickFromGallery() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image == null) return null;

    return _copyToJournalStorage(
      File(image.path),
    );
  }

  Future<File?> takePhoto() async {
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
    );

    if (image == null) return null;

    return _copyToJournalStorage(
      File(image.path),
    );
  }

  Future<File> _copyToJournalStorage(
    File sourceFile,
  ) async {
    final appDir =
        await getApplicationDocumentsDirectory();

    final photosDir = Directory(
      p.join(appDir.path, 'photos'),
    );

    if (!await photosDir.exists()) {
      await photosDir.create(
        recursive: true,
      );
    }

    final timestamp =
        DateTime.now().millisecondsSinceEpoch;

    final extension =
        p.extension(sourceFile.path);

    final destinationPath = p.join(
      photosDir.path,
      'journal_$timestamp$extension',
    );

    return sourceFile.copy(
      destinationPath,
    );
  }
}