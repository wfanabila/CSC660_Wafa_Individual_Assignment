import 'package:flutter/material.dart';
import 'sql_helper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'theme_provider.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(appThemeStateNotifier);

    return _HomePageBody(ref: ref, theme: theme);
  }
}

class _HomePageBody extends StatefulWidget {
  final WidgetRef ref;
  final ThemeData theme;

  const _HomePageBody({
    required this.ref,
    required this.theme,
  });

  @override
  State<_HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<_HomePageBody> {
  List<Map<String, dynamic>> _diaries = [];
  bool _isLoading = true;

  final TextEditingController _feelingController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _refreshDiaries();
  }

  void _refreshDiaries() async {
    final data = await SQLHelper.getDiaries();
    setState(() {
      _diaries = data;
      _isLoading = false;
    });
  }

  Future<void> _addDiary() async {
    await SQLHelper.createDiary(
      _feelingController.text,
      _descriptionController.text,
    );
    _refreshDiaries();
  }

  Future<void> _updateDiary(int id) async {
    await SQLHelper.updateDiary(
      id,
      _feelingController.text,
      _descriptionController.text,
    );
    _refreshDiaries();
  }

  Future<void> _deleteDiary(int id) async {
    await SQLHelper.deleteDiary(id);
    _refreshDiaries();
  }

  void _showForm(int? id) {
    if (id != null) {
      final diary = _diaries.firstWhere((e) => e['id'] == id);
      _feelingController.text = diary['feeling'];
      _descriptionController.text = diary['description'];
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => Padding(
        padding: EdgeInsets.only(
          top: 15,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom + 120,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _feelingController,
              decoration: const InputDecoration(hintText: 'Feeling'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(hintText: 'Description'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (id == null) {
                  await _addDiary();
                } else {
                  await _updateDiary(id);
                }
                Navigator.pop(context);
              },
              child: Text(id == null ? 'Create' : 'Update'),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        title: const Text("Wafa's Diary"),
        actions: [
          IconButton(
            icon: Icon(
              widget.theme.brightness == Brightness.dark
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: () {
              widget.ref.read(appThemeStateNotifier.notifier).toggleTheme();
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          )
        ],
      ),

      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _diaries.length,
              itemBuilder: (context, index) => Card(
                color: Theme.of(context).cardColor,
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  leading: const Icon(Icons.mood),
                  title: Text(_diaries[index]['feeling']),
                  subtitle: Text(
                    "${_diaries[index]['description']}\n\n${_diaries[index]['createdAt']}",
                  ),
                  trailing: PopupMenuButton(
                    onSelected: (value) {
                      if (value == 'edit') {
                        _showForm(_diaries[index]['id']);
                      } else {
                        _deleteDiary(_diaries[index]['id']);
                      }
                    },
                    itemBuilder: (context) => const [
                      PopupMenuItem(value: 'edit', child: Text('Edit')),
                      PopupMenuItem(value: 'delete', child: Text('Delete')),
                    ],
                  ),
                ),
              ),
            ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(null),
        child: const Icon(Icons.add),
      ),
    );
  }
}