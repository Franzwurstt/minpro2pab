import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/katalog.dart';

class FormPage extends StatefulWidget {
  final Katalog? katalog;

  const FormPage({super.key, this.katalog});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final supabase = Supabase.instance.client;

  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  final tahunController = TextEditingController();
  final gambarController = TextEditingController();
  final spesifikasiController = TextEditingController();

  bool isLoading = false;

  String formatRibuan(String angkaAsli) {
    String angkaSaja = angkaAsli.replaceAll(RegExp(r'[^0-9]'), '');
    if (angkaSaja.isEmpty) return '';
    String hasil = '';
    for (int i = angkaSaja.length - 1; i >= 0; i--) {
      if ((angkaSaja.length - 1 - i) % 3 == 0 && i != angkaSaja.length - 1) {
        hasil = '.$hasil';
      }
      hasil = angkaSaja[i] + hasil;
    }
    return hasil;
  }

  @override
  void initState() {
    super.initState();

    if (widget.katalog != null) {
      namaController.text = widget.katalog!.nama;
      hargaController.text = formatRibuan(widget.katalog!.harga.toString());
      tahunController.text = widget.katalog!.tahun.toString();
      gambarController.text = widget.katalog!.gambar;
      spesifikasiController.text = widget.katalog!.spesifikasi;
    }
  }

  @override
  void dispose() {
    namaController.dispose();
    hargaController.dispose();
    tahunController.dispose();
    gambarController.dispose();
    spesifikasiController.dispose();
    super.dispose();
  }

  Future<void> saveData() async {
    if (namaController.text.isEmpty ||
        hargaController.text.isEmpty ||
        tahunController.text.isEmpty ||
        gambarController.text.isEmpty ||
        spesifikasiController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Semua field wajib diisi")),
      );
      return;
    }

    String hargaTanpaTitik = hargaController.text.replaceAll('.', '');
    
    final parsedHarga = int.tryParse(hargaTanpaTitik);
    final parsedTahun = int.tryParse(tahunController.text);

    if (parsedHarga == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Format Harga salah! Pastikan hanya berisi angka."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (parsedTahun == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Format Tahun salah! Pastikan hanya berisi angka."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final data = {
        'nama': namaController.text,
        'harga': parsedHarga, 
        'tahun': parsedTahun,
        'gambar': gambarController.text,
        'spesifikasi': spesifikasiController.text,
      };

      if (widget.katalog == null) {
        await supabase.from('katalog').insert(data);
      } else {
        await supabase
            .from('katalog')
            .update(data)
            .eq('id', widget.katalog!.id!);
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Data berhasil disimpan"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Gagal menyimpan: $e"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.katalog != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? "Edit Katalog" : "Tambah Katalog"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: namaController,
              decoration: const InputDecoration(
                labelText: "Nama HP",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: hargaController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, 
                CurrencyFormat(),
              ],
              decoration: const InputDecoration(
                labelText: "Harga",
                prefixText: "Rp ",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: tahunController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                labelText: "Tahun",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: gambarController,
              decoration: const InputDecoration(
                labelText: "URL Gambar",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            TextField(
              controller: spesifikasiController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Spesifikasi",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: saveData,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                      backgroundColor: const Color(0xFF1428A0),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(
                      isEdit ? "Update" : "Simpan",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class CurrencyFormat extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    String numericOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (numericOnly.isEmpty) {
      return newValue.copyWith(text: '');
    }

    String formatted = '';
    for (int i = numericOnly.length - 1; i >= 0; i--) {
      if ((numericOnly.length - 1 - i) % 3 == 0 && i != numericOnly.length - 1) {
        formatted = '.$formatted';
      }
      formatted = numericOnly[i] + formatted;
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}