import 'dart:io';

class ImageUploadStateBase {
  const ImageUploadStateBase();
}

class ImageUploadInitial extends ImageUploadStateBase {}

class ImageUploadSuccess extends ImageUploadStateBase {
  final File image;

  const ImageUploadSuccess(this.image);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ImageUploadSuccess &&
          runtimeType == other.runtimeType &&
          image == other.image;

  @override
  int get hashCode => image.hashCode;
}
