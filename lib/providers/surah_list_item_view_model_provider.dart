import 'package:flutter/foundation.dart';
import 'package:quran_cloud/quran_cloud.dart';
import '../services/storage_service.dart';
import '../viewmodels/surah_list_item_viewmodel.dart';

class SurahListItemViewModelProvider extends ChangeNotifier {
  final StorageService _storageService;
  final Map<int, SurahListItemViewModel> _viewModels = {};

  SurahListItemViewModelProvider(this._storageService);

  SurahListItemViewModel getViewModel(Surah surah) {
    return _viewModels.putIfAbsent(
      surah.number,
      () => SurahListItemViewModel(surah, _storageService),
    );
  }

  @override
  void dispose() {
    _viewModels.clear();
    super.dispose();
  }
}
