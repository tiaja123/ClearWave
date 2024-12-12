import 'package:flutter/material.dart';
import 'category_screen.dart'; // Import halaman kategori
import 'cart_screen.dart'; // Import halaman keranjang

void main() {
  runApp(ClearWaveApp());
}

class ClearWaveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Daftar halaman yang dapat dinavigasi
  final List<Widget> _screens = [
    MainScreenContent(), // Halaman utama
    CategoryScreen(), // Halaman kategori
    CartScreen(), // Halaman keranjang
  ];

  // Logika untuk berpindah antar tab
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Menampilkan halaman sesuai indeks
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue, // Warna tab aktif sesuai tema
        unselectedItemColor: Colors.grey, // Warna tab tidak aktif
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Kategori',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart), // Ikon keranjang
            label: 'Keranjang', // Label diperbarui
          ),
        ],
      ),
    );
  }
}

class MainScreenContent extends StatefulWidget {
  @override
  _MainScreenContentState createState() => _MainScreenContentState();
}

class _MainScreenContentState extends State<MainScreenContent> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _products = [
    {"name": "Le Mineral", "price": "Rp. 21,000", "image": "assets/lemineral.png"},
    {"name": "Aqua", "price": "Rp. 20,000", "image": "assets/aqua.png"},
    {"name": "Vit", "price": "Rp. 19,000", "image": "assets/vit.png"},
  ];

  List<Map<String, String>> _filteredProducts = [];

  @override
  void initState() {
    super.initState();
    _filteredProducts = List.from(_products); // Default tampilkan semua produk
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredProducts = List.from(_products);
      } else {
        _filteredProducts = _products
            .where((product) => product["name"]!.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Gambar header penuh
            Image.asset(
              'assets/Clear.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            // Kolom pencarian
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Cari disini',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            // Daftar produk hasil pencarian
            if (_filteredProducts.isNotEmpty)
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _filteredProducts.length,
                itemBuilder: (context, index) {
                  final product = _filteredProducts[index];
                  return WaterItem(
                    imagePath: product["image"]!,
                    name: product["name"]!,
                    price: product["price"]!,
                  );
                },
              )
            else
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Produk yang Anda cari tidak ada.",
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
          ],
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
            // Aksi menambahkan item
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('$name ditambahkan ke keranjang')),
            );
          },
        ),
      ),
    );
  }
}