class Katalog {
  String? id; 
  String nama;
  String harga;
  String tahun;
  String gambar;
  String spesifikasi;

  Katalog({
    this.id,
    required this.nama,
    required this.harga,
    required this.tahun,
    required this.gambar,
    required this.spesifikasi,
  });

  factory Katalog.fromJson(Map<String, dynamic> json) {
    return Katalog(
      id: json['id'],
      nama: json['nama'],
      harga: json['harga'],
      tahun: json['tahun'],
      gambar: json['gambar'],
      spesifikasi: json['spesifikasi'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'nama': nama,
      'harga': harga,
      'tahun': tahun,
      'gambar': gambar,
      'spesifikasi': spesifikasi,
    };
  }
}