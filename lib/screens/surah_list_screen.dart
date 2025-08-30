import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran_cloud/quran_cloud.dart';
import '../providers/surah_provider.dart';
import '../providers/surah_list_item_view_model_provider.dart';
import '../services/storage_service.dart';
import '../widgets/surah_list_item.dart';
import '../widgets/search_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/loading_widget.dart';
import '../utils/constants.dart';

class SurahListScreen extends StatefulWidget {
  const SurahListScreen({super.key});

  @override
  State<SurahListScreen> createState() => _SurahListScreenState();
}

class _SurahListScreenState extends State<SurahListScreen> {
  late final SurahListItemViewModelProvider _viewModelProvider;

  @override
  void initState() {
    super.initState();
    _viewModelProvider = SurahListItemViewModelProvider(StorageService());
    // Initialize the provider when the screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SurahProvider>().initialize();
    });
  }

  @override
  void dispose() {
    _viewModelProvider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppConstants.appName),
        actions: [
          IconButton(
            onPressed: () {
              // TODO: Navigate to settings screen
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Settings coming soon!')),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: Consumer<SurahProvider>(
        builder: (context, surahProvider, child) {
          return _buildBody(surahProvider);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Navigate to Audio Configuration Modal
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Audio Configuration coming soon!')),
          );
        },
        icon: const Icon(Icons.music_note),
        label: const Text('Audio Config'),
      ),
    );
  }

  Widget _buildBody(SurahProvider surahProvider) {
    final theme = Theme.of(context);

    switch (surahProvider.state) {
      case SurahListState.loading:
        return const LoadingWidget(message: 'Loading surahs...', size: 60.0);

      case SurahListState.error:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: 64,
                color: AppConstants.errorColor,
              ),
              const SizedBox(height: AppConstants.paddingMedium),
              Text('Error loading surahs', style: theme.textTheme.titleMedium),
              const SizedBox(height: AppConstants.paddingSmall),
              Text(
                surahProvider.errorMessage ?? 'Unknown error occurred',
                style: theme.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppConstants.paddingLarge),
              CustomButton(
                text: 'Retry',
                icon: Icons.refresh,
                onPressed: () => surahProvider.refresh(),
              ),
            ],
          ),
        );

      case SurahListState.success:
        return Column(
          children: [
            // Search bar
            SearchBarWidget(
              onChanged: surahProvider.searchSurahs,
              onClear: surahProvider.clearSearch,
            ),

            // Results count
            if (surahProvider.searchQuery.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.paddingMedium,
                ),
                child: Row(
                  children: [
                    Text(
                      '${surahProvider.filteredSurahs.length} results',
                      style: theme.textTheme.bodySmall,
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: surahProvider.clearSearch,
                      child: const Text('Clear'),
                    ),
                  ],
                ),
              ),

            // Surah list
            Expanded(
              child: surahProvider.filteredSurahs.isEmpty
                  ? _buildEmptyState(surahProvider)
                  : _buildSurahList(surahProvider),
            ),
          ],
        );
    }
  }

  Widget _buildEmptyState(SurahProvider surahProvider) {
    final theme = Theme.of(context);

    if (surahProvider.searchQuery.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: theme.iconTheme.color),
            const SizedBox(height: AppConstants.paddingMedium),
            Text('No surahs found', style: theme.textTheme.titleMedium),
            const SizedBox(height: AppConstants.paddingSmall),
            Text(
              'Try searching with different keywords',
              style: theme.textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.book_outlined, size: 64, color: theme.iconTheme.color),
          const SizedBox(height: AppConstants.paddingMedium),
          Text('No surahs available', style: theme.textTheme.titleMedium),
          const SizedBox(height: AppConstants.paddingSmall),
          Text(
            'Please check your data source',
            style: theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildSurahList(SurahProvider surahProvider) {
    return RefreshIndicator(
      onRefresh: surahProvider.refresh,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(
          vertical: AppConstants.paddingSmall,
        ),
        itemCount: surahProvider.filteredSurahs.length,
        itemBuilder: (context, index) {
          final surah = surahProvider.filteredSurahs[index];
          final viewModel = _viewModelProvider.getViewModel(surah);
          return SurahListItem(
            viewModel: viewModel,
            onTap: () => _onSurahTap(surah),
          );
        },
      ),
    );
  }

  void _onSurahTap(Surah surah) {
    // TODO: Navigate to Audio Configuration Modal with selected surah
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected: ${surah.englishName}'),
        action: SnackBarAction(
          label: 'Configure',
          onPressed: () {
            // TODO: Navigate to Audio Configuration Modal
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Audio Configuration coming soon!')),
            );
          },
        ),
      ),
    );
  }
}
