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
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.radiusMedium),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Row(
            children: [
              // Surah number circle
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppConstants.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: AppConstants.primaryColor.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Center(
                  child: Text(
                    surah.number.toString(),
                    style: AppConstants.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppConstants.primaryColor,
                    ),
                  ),
                ),
              ),
              
              const SizedBox(width: AppConstants.paddingMedium),
              
              // Surah details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Arabic name
                    Text(
                      surah.name,
                      style: AppConstants.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Noto Naskh Arabic',
                      ),
                      textDirection: TextDirection.rtl,
                    ),
                    
                    const SizedBox(height: 4),
                    
                    // English name and translation
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            surah.englishName,
                            style: AppConstants.bodyMedium.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: AppConstants.paddingSmall),
                        Text(
                          '•',
                          style: AppConstants.bodySmall,
                        ),
                        const SizedBox(width: AppConstants.paddingSmall),
                        Expanded(
                          child: Text(
                            surah.englishNameTranslation,
                            style: AppConstants.bodySmall,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 4),
                    
                    // Additional info
                    Row(
                      children: [
                        Text(
                          '${surah.numberOfAyahs} verses',
                          style: AppConstants.caption,
                        ),
                        const SizedBox(width: AppConstants.paddingSmall),
                        Text(
                          '•',
                          style: AppConstants.caption,
                        ),
                        const SizedBox(width: AppConstants.paddingSmall),
                        Text(
                          surah.revelationType,
                          style: AppConstants.caption,
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
                            : AppConstants.textSecondaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        surah.isDownloaded 
                            ? Icons.download_done
                            : Icons.download_outlined,
                        size: AppConstants.iconSizeSmall,
                        color: surah.isDownloaded 
                            ? AppConstants.successColor
                            : AppConstants.textSecondaryColor,
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
                            : AppConstants.textSecondaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        surah.isFavorite 
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: AppConstants.iconSizeSmall,
                        color: surah.isFavorite 
                            ? AppConstants.errorColor
                            : AppConstants.textSecondaryColor,
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
