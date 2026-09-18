import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/design_system/madar_ui.dart';
import '../domain/search_providers.dart';
class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});
  @override ConsumerState<SearchPage> createState() => _SearchState();
}
class _SearchState extends ConsumerState<SearchPage> {
  final controller = TextEditingController();
  String query = '';
  @override void dispose() { controller.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => MadarPage(
    title: 'البحث الشامل',
    child: ListView(padding: const EdgeInsets.all(18), children: [
      TextField(controller: controller, textInputAction: TextInputAction.search, onSubmitted: (v) => setState(() => query = v.trim()), decoration: InputDecoration(prefixIcon: const Icon(Icons.search_rounded), hintText: 'ابحث في مَدار', suffixIcon: IconButton(onPressed: () => setState(() => query = controller.text.trim()), icon: const Icon(Icons.search)), border: const OutlineInputBorder())),
      const SizedBox(height: 18),
      if (query.isEmpty) const MadarGlassCard(child: ListTile(leading: Icon(Icons.offline_bolt_rounded), title: Text('بحث محلي'), subtitle: Text('ابحث في المحتوى المثبت على جهازك.')))
      else ref.watch(localSearchProvider(query)).when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Text('تعذر البحث: ' + e.toString()),
        data: (items) {
          if (items.isEmpty) return const Text('لا توجد نتائج في المحتوى المثبت.');
          return Column(children: items.map((r) => Card(child: ListTile(title: Text(r.title), subtitle: Text(r.snippet, maxLines: 3, overflow: TextOverflow.ellipsis), leading: Text(r.type)))).toList());
        },
      ),
    ]),
  );
}
