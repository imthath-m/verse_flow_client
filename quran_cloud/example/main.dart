import 'package:flutter/material.dart';
import 'package:quran_cloud/quran_cloud.dart';

void main() {
  runApp(const QuranCloudExampleApp());
}

class QuranCloudExampleApp extends StatelessWidget {
  const QuranCloudExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quran Cloud Example',
      theme: ThemeData(primarySwatch: Colors.green, useMaterial3: true),
      home: const QuranCloudExamplePage(),
    );
  }
}

class QuranCloudExamplePage extends StatefulWidget {
  const QuranCloudExamplePage({super.key});

  @override
  State<QuranCloudExamplePage> createState() => _QuranCloudExamplePageState();
}

class _QuranCloudExamplePageState extends State<QuranCloudExamplePage> {
  final QuranService _quranService = QuranService();
  final TranslationService _translationService = TranslationService();
  final AudioService _recitationService = AudioService();

  List<Surah> _surahs = [];
  String _status = 'Loading...';
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      setState(() {
        _status = 'Loading surahs...';
        _error = null;
      });

      final surahs = await _quranService.getAllSurahs();

      setState(() {
        _surahs = surahs;
        _status = 'Loaded ${surahs.length} surahs';
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _status = 'Error loading data';
      });
    }
  }

  @override
  void dispose() {
    _quranService.close();
    _translationService.close();
    _recitationService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quran Cloud Example'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(_status, style: Theme.of(context).textTheme.headlineSmall),
            if (_error != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.red.shade100,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Error: $_error',
                  style: TextStyle(color: Colors.red.shade800),
                ),
              ),
            ],
            const SizedBox(height: 16),
            Expanded(
              child: _surahs.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: _surahs.length,
                      itemBuilder: (context, index) {
                        final surah = _surahs[index];
                        return Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              child: Text(surah.number.toString()),
                            ),
                            title: Text(surah.englishName),
                            subtitle: Text(surah.englishNameTranslation),
                            trailing: Text('${surah.numberOfAyahs} ayahs'),
                            onTap: () => _showSurahDetails(surah),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadData,
        tooltip: 'Reload',
        child: const Icon(Icons.refresh),
      ),
    );
  }

  void _showSurahDetails(Surah surah) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(surah.englishName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Arabic Name: ${surah.name}'),
            Text('Translation: ${surah.englishNameTranslation}'),
            Text('Number of Ayahs: ${surah.numberOfAyahs}'),
            Text('Revelation Type: ${surah.revelationType}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
