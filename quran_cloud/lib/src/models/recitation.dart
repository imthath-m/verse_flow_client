import 'package:json_annotation/json_annotation.dart';
import 'ayah.dart';

part 'recitation.g.dart';

/// Represents an audio recitation of Quran text
@JsonSerializable()
class Recitation {
  /// URL to the audio file
  final String audioUrl;
  
  /// Edition identifier used for this recitation
  final String edition;
  
  /// Reciter name
  final String reciter;
  
  /// Audio format (mp3, ogg, etc.)
  final String format;
  
  /// Audio quality (high, medium, low)
  final String quality;
  
  /// Duration in seconds
  final int? duration;
  
  /// File size in bytes
  final int? fileSize;
  
  /// Associated ayah information
  @JsonKey(includeFromJson: false, includeToJson: false)
  final Ayah? ayah;
  
  const Recitation({
    required this.audioUrl,
    required this.edition,
    required this.reciter,
    required this.format,
    required this.quality,
    this.duration,
    this.fileSize,
    this.ayah,
  });
  
  /// Creates a copy of this recitation with updated values
  Recitation copyWith({
    String? audioUrl,
    String? edition,
    String? reciter,
    String? format,
    String? quality,
    int? duration,
    int? fileSize,
    Ayah? ayah,
  }) {
    return Recitation(
      audioUrl: audioUrl ?? this.audioUrl,
      edition: edition ?? this.edition,
      reciter: reciter ?? this.reciter,
      format: format ?? this.format,
      quality: quality ?? this.quality,
      duration: duration ?? this.duration,
      fileSize: fileSize ?? this.fileSize,
      ayah: ayah ?? this.ayah,
    );
  }
  
  /// Checks if this is a high quality recitation
  bool get isHighQuality => quality.toLowerCase() == 'high';
  
  /// Checks if this is an MP3 format
  bool get isMP3 => format.toLowerCase() == 'mp3';
  
  /// Gets formatted duration string
  String get formattedDuration {
    if (duration == null) return 'Unknown';
    final minutes = duration! ~/ 60;
    final seconds = duration! % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }
  
  /// Gets formatted file size
  String get formattedFileSize {
    if (fileSize == null) return 'Unknown';
    if (fileSize! < 1024) return '$fileSize B';
    if (fileSize! < 1024 * 1024) return '${(fileSize! / 1024).toStringAsFixed(1)} KB';
    return '${(fileSize! / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
  
  /// Equality operator
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Recitation &&
        other.audioUrl == audioUrl &&
        other.edition == edition &&
        other.reciter == reciter &&
        other.format == format &&
        other.quality == quality &&
        other.duration == duration &&
        other.fileSize == fileSize &&
        other.ayah == ayah;
  }
  
  /// Hash code
  @override
  int get hashCode {
    return audioUrl.hashCode ^
        edition.hashCode ^
        reciter.hashCode ^
        format.hashCode ^
        quality.hashCode ^
        duration.hashCode ^
        fileSize.hashCode ^
        ayah.hashCode;
  }
  
  /// String representation
  @override
  String toString() {
    return 'Recitation(reciter: $reciter, quality: $quality, format: $format, duration: $formattedDuration)';
  }
  
  /// JSON serialization
  factory Recitation.fromJson(Map<String, dynamic> json) => _$RecitationFromJson(json);
  Map<String, dynamic> toJson() => _$RecitationToJson(this);
}
