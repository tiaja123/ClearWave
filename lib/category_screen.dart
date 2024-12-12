import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue, // Warna header biru
        title: Text(
          'Kategori', // Teks header
          style: TextStyle(
            color: Colors.white, // Warna teks putih
            fontWeight: FontWeight.bold, // Teks bold
          ),
        ),
        centerTitle: true, // Teks di tengah
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // List produk dalam kategori
              ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  WaterItem(
                    imagePath: 'assets/aqua.png',
                    name: 'Aqua',
                    price: 'Rp. 20,000',
                  ),
                  WaterItem(
                    imagePath: 'assets/vit.png',
                    name: 'Vit',
                    price: 'Rp. 19,000',
                  ),
                  WaterItem(
                    imagePath: 'assets/lemineral.png',
                    name: 'Le Mineral',
                    price: 'Rp. 21,000',
                  ),
                  WaterItem(
                    imagePath: 'assets/jenisAir1.png',
                    name: 'Air Hexa',
                    price: 'Rp. 8,000',
                  ),
                  WaterItem(
                    imagePath: 'assets/jenisAir2.png',
                    name: 'Air R.O',
                    price: 'Rp. 5,000',
                  ),
                  WaterItem(
                    imagePath: 'assets/jenisAir3.png',
                    name: 'Air Mineral',
                    price: 'Rp. 5,000',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WaterItem extends StatelessWidget {
  final String imagePath;
  final String name;
  final String price;

  const WaterItem({
    required this.imagePath,
    required this.name,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Image.asset(imagePath, width: 50, height: 50),
        title: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(price),
        trailing: IconButton(
          icon: Icon(Icons.add, color: Colors.blue),
          onPressed: () {
            // Aksi menambahkan item ke keranjang
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$name berhasil ditambahkan ke keranjang!'),
              ),
            );
          },
        ),
      ),
    );
  }
}