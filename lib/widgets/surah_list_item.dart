import 'package:flutter/material.dart';
import '../models/surah.dart';
import '../utils/constants.dart';

class SurahListItem extends StatelessWidget {
  final Surah surah;
  final VoidCallback? onTap;
  final VoidCallback? onFavoriteToggle;
  final bool showDownloadStatus;

  const SurahListItem({
    super.key,
    required this.surah,
    this.onTap,
    this.onFavoriteToggle,
    this.showDownloadStatus = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Row(
            children: [

              // Surah details
              Expanded(
                child: Column(
                  spacing: AppConstants.paddingSmall,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // English and Arabic names
                    Row(
                      spacing: AppConstants.paddingSmall,
                      children: [
                        Expanded(
                          child: Text(
                            '${surah.number}. ${surah.englishName}',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          surah.name,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Noto Naskh Arabic',
                          ),
                          textDirection: TextDirection.rtl,
                        ),
                      ],
                    ),

                    // Additional info (transliteration, verses count and revelation type)
                    Row(
                      spacing: AppConstants.paddingSmall,
                      children: [
                        Text(
                          surah.englishNameTranslation,
                          style: theme.textTheme.labelSmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text('•', style: theme.textTheme.labelSmall),
                        Text(
                          '${surah.numberOfAyahs} verses',
                          style: theme.textTheme.labelSmall,
                        ),
                        Text('•', style: theme.textTheme.labelSmall),
                        Text(
                          surah.revelationType,
                          style: theme.textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(width: AppConstants.paddingMedium),

              // Action buttons
              Column(
                children: [
                  // Download status indicator
                  if (showDownloadStatus)
                    Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: surah.isDownloaded
                            ? AppConstants.successColor.withValues(alpha: 0.1)
                            : theme.iconTheme.color?.withValues(alpha: 0.1) ??
                                  Colors.grey.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        surah.isDownloaded
                            ? Icons.download_done
                            : Icons.download_outlined,
                        size: AppConstants.iconSizeSmall,
                        color: surah.isDownloaded
                            ? AppConstants.successColor
                            : theme.iconTheme.color ?? Colors.grey,
                      ),
                    ),

                  if (showDownloadStatus)
                    const SizedBox(height: AppConstants.paddingSmall),

                  // Favorite button
                  GestureDetector(
                    onTap: onFavoriteToggle,
                    child: Container(
                      width: 24,
                      height: 24,
                      decoration: BoxDecoration(
                        color: surah.isFavorite
                            ? AppConstants.errorColor.withValues(alpha: 0.1)
                            : theme.iconTheme.color?.withValues(alpha: 0.1) ??
                                  Colors.grey.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        surah.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: AppConstants.iconSizeSmall,
                        color: surah.isFavorite
                            ? AppConstants.errorColor
                            : theme.iconTheme.color ?? Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
