import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/katalog.dart';
import 'form_page.dart';
import 'login_page.dart';
import '../main.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final supabase = Supabase.instance.client;

  late final Stream<List<Map<String, dynamic>>> stream;

  @override
  void initState() {
    super.initState();
    stream = supabase
        .from('katalog')
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false);
  }

  String formatRupiah(String hargaAsli) {
    String angkaSaja = hargaAsli.replaceAll(RegExp(r'[^0-9]'), '');
    if (angkaSaja.isEmpty) return '0';

    String hasil = '';
    for (int i = angkaSaja.length - 1; i >= 0; i--) {
      if ((angkaSaja.length - 1 - i) % 3 == 0 && i != angkaSaja.length - 1) {
        hasil = '.$hasil';
      }
      hasil = angkaSaja[i] + hasil;
    }
    return hasil;
  }

  void deleteData(String id) async {
    try {
      await supabase.from('katalog').delete().eq('id', id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Data berhasil dihapus')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghapus: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text(
          "Katalog Samsung",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1428A0), Colors.blue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeNotifier,
            builder: (_, ThemeMode currentMode, __) {
              return IconButton(
                icon: Icon(
                  currentMode == ThemeMode.light 
                      ? Icons.dark_mode 
                      : Icons.light_mode,
                  color: Colors.white,
                ),
                onPressed: () {
                  themeNotifier.value = currentMode == ThemeMode.light
                      ? ThemeMode.dark
                      : ThemeMode.light;
                },
              );
            },
          ),

          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () async {
              await supabase.auth.signOut();
              if (mounted) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                );
              }
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.phone_android, size: 70, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("Tambah Dulu", style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            );
          }

          final data = snapshot.data!;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: data.map((json) {
                  final item = Katalog.fromJson(json);
                  return SizedBox(
                    width: 280,
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height: 180,
                              width: double.infinity,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isDarkMode ? Colors.white : Colors.transparent, 
                                borderRadius: BorderRadius.circular(8),
                              ),

                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  item.gambar,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.broken_image, size: 50, color: Colors.grey);
                                  },
                                ),
                              ),
                            ),

                            const SizedBox(height: 12),
                            Text(
                              item.nama,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),

                            const SizedBox(height: 4),
                            Text(
                              "Rp ${formatRupiah(item.harga)}",
                              style: TextStyle(
                                color: isDarkMode ? Colors.lightBlueAccent : const Color(0xFF1428A0),
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),

                            Text(
                              "Rilis: ${item.tahun}",
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),

                            const SizedBox(height: 12), 
                            Text(
                              item.spesifikasi,
                              style: const TextStyle(fontSize: 12, height: 1.4), 
                            ),

                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.orange, size: 20),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) => FormPage(katalog: item),
                                      ),
                                    );
                                  },
                                ),

                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                                  onPressed: () {
                                    deleteData(item.id!);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const FormPage(),
            ),
          );
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text("Tambah", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blueAccent,
      ),
    );
  }
}