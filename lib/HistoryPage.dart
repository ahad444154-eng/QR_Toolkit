
import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  static const Color blue = Color(0xFF2864E8);
  static const Color background = Color(0xFFF7F8FC);
  static const Color dark = Color(0xFF111827);
  static const Color muted = Color(0xFF8993A4);

  final TextEditingController searchController =
  TextEditingController();

// Actual scan records can be added here later.
  final List<Map<String, String>> historyItems = [];

  String searchQuery = '';
  String selectedFilter = 'All';

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<Map<String, String>> get filteredItems {
    return historyItems.where((item) {
      final title = (item['title'] ?? '').toLowerCase();
      final subtitle = (item['subtitle'] ?? '').toLowerCase();
      final query = searchQuery.toLowerCase();

      final matchesSearch =
          title.contains(query) || subtitle.contains(query);

      final matchesFilter = selectedFilter == 'All' ||
          item['type'] == selectedFilter;

      return matchesSearch && matchesFilter;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'History',
          style: TextStyle(
            color: dark,
            fontSize: 26,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Your recent QR activity',
                    style: TextStyle(
                      color: muted,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 20),

// Search bar
                  TextField(
                    controller: searchController,
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search history...',
                      hintStyle: const TextStyle(color: muted),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: muted,
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 16,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

// Filter buttons
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        filterChip('All'),
                        const SizedBox(width: 9),
                        filterChip('Scanned'),
                        const SizedBox(width: 9),
                        filterChip('Created'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Divider(
              height: 1,
              color: Color(0xFFECEEF3),
            ),

            Expanded(
              child: filteredItems.isEmpty
                  ? buildEmptyState()
                  : ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: filteredItems.length,
                separatorBuilder: (context, index) =>
                const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final item = filteredItems[index];

                  return historyCard(item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget filterChip(String label) {
    final isSelected = selectedFilter == label;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 11,
        ),
        decoration: BoxDecoration(
          color: isSelected ? blue : Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: isSelected
                ? blue
                : const Color(0xFFE6E9F0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : muted,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFEDF3FF),
                borderRadius: BorderRadius.circular(30),
              ),
              child: const Icon(
                Icons.history_rounded,
                color: blue,
                size: 48,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'No history yet',
              style: TextStyle(
                color: dark,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              searchQuery.isNotEmpty
                  ? 'No results found for "$searchQuery".'
                  : 'QR codes you scan or create will appear here.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: muted,
                fontSize: 14,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget historyCard(Map<String, String> item) {
    final isWifi = item['type'] == 'Wi-Fi';

    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isWifi
                  ? const Color(0xFFE8FAFD)
                  : const Color(0xFFEDF3FF),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              isWifi
                  ? Icons.wifi_rounded
                  : Icons.qr_code_2_rounded,
              color: isWifi
                  ? const Color(0xFF20A8C9)
                  : blue,
              size: 26,
            ),
          ),
          const SizedBox(width: 13),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'] ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: dark,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  item['subtitle'] ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: muted,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  item['time'] ?? '',
                  style: const TextStyle(
                    color: muted,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}