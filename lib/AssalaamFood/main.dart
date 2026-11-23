import 'package:flutter/material.dart';
import 'package:flutter_galang_12rpl1/AssalaamFood/detail_screen.dart';


void main() {
  runApp(const AssalaamFoodApp());
}

class AssalaamFoodApp extends StatelessWidget {
  const AssalaamFoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Assalaam Food',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF176B87),
        scaffoldBackgroundColor: const Color(0xFFF3F7F9),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF176B87),
          primary: const Color(0xFF176B87),
          secondary: const Color(0xFF7CA982),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF18323D),
          surfaceTintColor: Colors.transparent,
        ),
      ),
      home: const CatalogScreen(),
    );
  }
}

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  static const List<String> categories = [
    'Semua',
    'Makanan',
    'Minuman',
    'Camilan',
  ];

  static const List<Map<String, dynamic>> menuList = [
    {
      'name': 'Nasi Goreng Spesial',
      'category': 'Makanan Utama',
      'price': 12000,
      'image': 'https://images.unsplash.com/photo-1603133872878-684f208fb84b?w=800&h=450&fit=crop',
      'description': 'Nasi goreng gurih khas kantin dengan suwiran ayam, telur mata sapi, dan kerupuk renyah.',
    },
    {
      'name': 'Mie Ayam Bakso',
      'category': 'Makanan Utama',
      'price': 10000,
      'image':
          'https://images.unsplash.com/photo-1569718212165-3a8278d5f624?w=500',
      'description': 'Mie kenyal dengan topping ayam cincang gurih, kuah kaldu hangat, dan dua buah bakso sapi.',
    },
    {
      'name': 'Ayam Geprek Nasi',
      'category': 'Makanan Utama',
      'price': 13000,
      'image': 'https://images.unsplash.com/photo-1626082927389-6cd097cdc6ec?w=800&h=450&fit=crop',
      'description': 'Ayam crispy digeprek dengan sambal bawang pedas nikmat disajikan bersama nasi hangat.',
    },
    {
      'name': 'Es Teh Manis',
      'category': 'Minuman',
      'price': 3000,
      'image':
          'https://images.unsplash.com/photo-1556679343-c7306c1976bc?w=500',
      'description': 'Teh melati segar pilihan dengan es batu kristal yang menyegarkan dahaga.',
    },
    {
      'name': 'Aneka Gorengan',
      'category': 'Camilan',
      'price': 1500,
      'image': 'https://images.unsplash.com/photo-1601050690597-df0568f70950?w=800&h=450&fit=crop',
      'description': 'Pilihan gorengan renyah: bakwan, tahu isi, dan risol hangat siap santap.',
    },
  ];

  String selectedCategory = 'Semua';
  final List<CartEntry> cartItems = [];

  void _addToCart(Map<String, dynamic> item, int quantity) {
    final existingIndex = cartItems.indexWhere(
      (entry) => entry.itemData['name'] == item['name'],
    );
    setState(() {
      if (existingIndex == -1) {
        cartItems.add(CartEntry(itemData: item, quantity: quantity));
      } else {
        cartItems[existingIndex].quantity += quantity;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('${item['name']} ditambahkan ke keranjang.')),
    );
  }

  int get _cartQuantity =>
      cartItems.fold(0, (total, entry) => total + entry.quantity);

  Future<void> _openCart() async {
    await Navigator.push<void>(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(
          items: cartItems,
          onOrderComplete: () => setState(cartItems.clear),
        ),
      ),
    );
    if (mounted) setState(() {});
  }

  String _categoryType(Map<String, dynamic> item) {
    final category = item['category'] as String;
    if (category == 'Minuman' || category == 'Camilan') return category;
    return 'Makanan';
  }

  @override
  Widget build(BuildContext context) {
    final visibleMenu = selectedCategory == 'Semua'
        ? menuList
        : menuList
              .where((item) => _categoryType(item) == selectedCategory)
              .toList();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xFFE6F2F5),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.storefront_rounded,
                color: Color(0xFF176B87),
                size: 22,
              ),
            ),
            const SizedBox(width: 10),
            const Text(
              'Assalaam Food',
              style: TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Keranjang',
            onPressed: _openCart,
            icon: Badge(
              isLabelVisible: _cartQuantity > 0,
              label: Text('$_cartQuantity'),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
            tooltip: 'Notifikasi',
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF124B63), Color(0xFF2786A3)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -5,
                    bottom: -12,
                    child: Icon(
                      Icons.ramen_dining_rounded,
                      color: Colors.white.withValues(alpha: 0.12),
                      size: 112,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Waktunya isi tenaga',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Pilih menu kantin favoritmu, tanpa perlu antre.',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.86),
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 11,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.16),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text(
                                'MENU HARI INI',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: 0.8,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 52),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Jelajahi menu',
                      style: TextStyle(
                        color: Color(0xFF18323D),
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Pilih sesuai seleramu',
                      style: TextStyle(color: Color(0xFF71828A), fontSize: 13),
                    ),
                  ],
                ),
                Text(
                  '${visibleMenu.length} menu',
                  style: const TextStyle(
                    color: Color(0xFF176B87),
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 42,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final category = categories[index];
                  final isSelected = selectedCategory == category;
                  return ChoiceChip(
                    label: Text(category),
                    selected: isSelected,
                    showCheckmark: false,
                    onSelected: (_) {
                      setState(() => selectedCategory = category);
                    },
                    labelStyle: TextStyle(
                      color: isSelected
                          ? Colors.white
                          : const Color(0xFF526871),
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    ),
                    selectedColor: const Color(0xFF176B87),
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: isSelected
                          ? const Color(0xFF176B87)
                          : const Color(0xFFDCE6E9),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(22),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            if (visibleMenu.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 48),
                child: Center(
                  child: Text('Belum ada menu untuk kategori ini.'),
                ),
              )
            else
              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth >= 640 ? 3 : 2;
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: visibleMenu.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 14,
                      mainAxisExtent: 260,
                    ),
                    itemBuilder: (context, index) {
                      final item = visibleMenu[index];
                      return Material(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  itemData: item,
                                  onAddToCart: _addToCart,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 170,
                                width: double.infinity,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.network(
                                      item['image'] as String,
                                      fit: BoxFit.cover,
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              const ColoredBox(
                                                color: Color(0xFFE6F2F5),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.restaurant,
                                                    color: Color(0xFF176B87),
                                                    size: 36,
                                                  ),
                                                ),
                                              ),
                                    ),
                                    Positioned(
                                      top: 9,
                                      left: 9,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 9,
                                          vertical: 5,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withValues(
                                            alpha: 0.94,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),
                                        child: Text(
                                          _categoryType(item),
                                          style: const TextStyle(
                                            color: Color(0xFF176B87),
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  11,
                                  10,
                                  11,
                                  11,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'] as String,
                                      style: const TextStyle(
                                        color: Color(0xFF18323D),
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Rp ${item['price']}',
                                          style: const TextStyle(
                                            color: Color(0xFF176B87),
                                            fontWeight: FontWeight.w800,
                                            fontSize: 13,
                                          ),
                                        ),
                                        Container(
                                          width: 27,
                                          height: 27,
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF176B87),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.add,
                                            color: Colors.white,
                                            size: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
