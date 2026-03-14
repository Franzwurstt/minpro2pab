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
          const SnackBar(content: Text('Data berhasil dihapus'), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghapus: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }
  
  void showDetailDialog(BuildContext context, Katalog item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(item.nama),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tahun Rilis: ${item.tahun}", style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text("Spesifikasi:", style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(item.spesifikasi),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup", style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final bgColor = isDarkMode ? const Color(0xFF121212) : const Color(0xFFF7F7F7);
    final cardColor = isDarkMode ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: cardColor,
        title: Text(
          "Samsung Smartphone",
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 18),
        ),
        actions: [
          ValueListenableBuilder<ThemeMode>(
            valueListenable: themeNotifier,
            builder: (_, ThemeMode currentMode, __) {
              return IconButton(
                icon: Icon(
                  currentMode == ThemeMode.light ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                  color: textColor,
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
            icon: Icon(Icons.logout, color: textColor),
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
                  Icon(Icons.inventory_2_outlined, size: 70, color: Colors.grey),
                  SizedBox(height: 10),
                  Text("Tambah Dulu", style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            );
          }

          final data = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 320, 
                mainAxisExtent: 480,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = Katalog.fromJson(data[index]);

                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Center(
                            child: SizedBox(
                              height: 180,
                              child: Image.network(
                                item.gambar,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons.broken_image, size: 80, color: Colors.grey),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Row(
                              children: [
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: const Icon(Icons.edit_outlined, color: Colors.grey, size: 20),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (_) => FormPage(katalog: item)));
                                  },
                                ),
                                const SizedBox(width: 8),
                                IconButton(
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  icon: const Icon(Icons.delete_outline, color: Colors.grey, size: 20),
                                  onPressed: () => deleteData(item.id!),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        item.nama,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                          const SizedBox(width: 4),
                          Text("5", style: TextStyle(fontSize: 12, color: textColor)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          CircleAvatar(radius: 8, backgroundColor: Colors.grey.shade300),
                          const SizedBox(width: 6),
                          const CircleAvatar(radius: 8, backgroundColor: Colors.black87),
                          const SizedBox(width: 6),
                          const CircleAvatar(radius: 8, backgroundColor: Colors.blueGrey),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade400),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text("512 GB", style: TextStyle(fontSize: 10, color: textColor)),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.transparent),
                            ),
                            child: Text("256 GB", style: TextStyle(fontSize: 10, color: Colors.grey.shade600)),
                          ),
                        ],
                      ),
                      const Spacer(),

                      Text(
                        "Rp${formatRupiah(item.harga.toString())}",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
                      ),
                      const SizedBox(height: 16),

                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: OutlinedButton(
                          onPressed: () => showDetailDialog(context, item),
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(color: isDarkMode ? Colors.white : Colors.black, width: 1.5),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20), 
                            ),
                            foregroundColor: textColor,
                          ),
                          child: const Text("Lebih detail", style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const FormPage()));
        },
        backgroundColor: isDarkMode ? Colors.white : Colors.black,
        foregroundColor: isDarkMode ? Colors.black : Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }
}
