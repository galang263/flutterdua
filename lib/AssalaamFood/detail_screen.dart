import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'receipt_screen.dart';

class CartEntry {
  CartEntry({required this.itemData, this.quantity = 1});

  final Map<String, dynamic> itemData;
  int quantity;

  int get subtotal => (itemData['price'] as int) * quantity;
}

class DetailScreen extends StatefulWidget {
  final Map<String, dynamic> itemData;
  final void Function(Map<String, dynamic> item, int quantity) onAddToCart;

  const DetailScreen({
    super.key,
    required this.itemData,
    required this.onAddToCart,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  int quantity = 1;
  String selectedPayment = 'Cash';
  final TextEditingController paymentAmountController = TextEditingController();
  String? paymentError;

  @override
  void dispose() {
    paymentAmountController.dispose();
    super.dispose();
  }

  void _submitPayment(int totalPrice) {
    final amountPaid = int.tryParse(paymentAmountController.text.trim());
    if (selectedPayment == 'Cash' &&
        (amountPaid == null || amountPaid < totalPrice)) {
      setState(() {
        paymentError = amountPaid == null
            ? 'Masukkan nominal pembayaran.'
            : 'Pembayaran kurang Rp ${totalPrice - amountPaid}.';
      });
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReceiptScreen(
          itemName: widget.itemData['name'],
          quantity: quantity,
          totalPrice: totalPrice,
          paymentMethod: selectedPayment,
          amountPaid: selectedPayment == 'Cash' ? amountPaid : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final int price = widget.itemData['price'] as int;
    final int totalPrice = price * quantity;
    final qrisData = jsonEncode({
      'merchant': 'Assalaam Food',
      'item': widget.itemData['name'],
      'amount': totalPrice,
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black87,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Detail Pesanan',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF176B87).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.itemData['image'] as String,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Center(
                      child: Icon(
                        Icons.restaurant,
                        color: Color(0xFF176B87),
                        size: 48,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.itemData['name'],
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
                Text(
                  'Rp $price',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF176B87),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.itemData['category'],
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
            ),
            const SizedBox(height: 16),
            const Text(
              'Deskripsi',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 6),
            Text(
              widget.itemData['description'],
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 13,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Jumlah Porsi',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        if (quantity > 1) {
                          setState(() {
                            quantity--;
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.remove, size: 18),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        '$quantity',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          quantity++;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF176B87),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Metode Pembayaran',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPayment = 'Cash';
                        paymentError = null;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: selectedPayment == 'Cash'
                            ? const Color(0xFF176B87).withValues(alpha: 0.1)
                            : Colors.white,
                        border: Border.all(
                          color: selectedPayment == 'Cash'
                              ? const Color(0xFF176B87)
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.money,
                            color: selectedPayment == 'Cash'
                                ? const Color(0xFF176B87)
                                : Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'Tunai (Cash)',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: selectedPayment == 'Cash'
                                    ? const Color(0xFF176B87)
                                    : Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedPayment = 'QRIS';
                        paymentError = null;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: selectedPayment == 'QRIS'
                            ? const Color(0xFF176B87).withValues(alpha: 0.1)
                            : Colors.white,
                        border: Border.all(
                          color: selectedPayment == 'QRIS'
                              ? const Color(0xFF176B87)
                              : Colors.grey.shade300,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.qr_code_2,
                            color: selectedPayment == 'QRIS'
                                ? const Color(0xFF176B87)
                                : Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              'QRIS',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: selectedPayment == 'QRIS'
                                    ? const Color(0xFF176B87)
                                    : Colors.black87,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (selectedPayment == 'Cash') ...[
              const SizedBox(height: 16),
              TextField(
                controller: paymentAmountController,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  labelText: 'Nominal pembayaran',
                  prefixText: 'Rp ',
                  hintText: '$totalPrice',
                  errorText: paymentError,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (value) {
                  final amount = int.tryParse(value);
                  setState(() {
                    paymentError =
                        value.isEmpty || amount == null || amount >= totalPrice
                        ? null
                        : 'Pembayaran kurang Rp ${totalPrice - amount}.';
                  });
                },
              ),
            ],
            if (selectedPayment == 'QRIS') ...[
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Column(
                  children: [
                    const Text(
                      'QR pembayaran (simulasi)',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    QrImageView(
                      data: qrisData,
                      size: 190,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Total: Rp $totalPrice',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'QR ini hanya berisi informasi pesanan, belum terhubung ke QRIS merchant.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 30),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () {
                  widget.onAddToCart(widget.itemData, quantity);
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.add_shopping_cart),
                label: const Text('Tambah ke Keranjang'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFF176B87),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  side: const BorderSide(color: Color(0xFF176B87)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total Pembayaran',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                    Text(
                      'Rp $totalPrice',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF176B87),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF176B87),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 14,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () => _submitPayment(totalPrice),
                    child: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Bayar Sekarang',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CartScreen extends StatefulWidget {
  const CartScreen({
    super.key,
    required this.items,
    required this.onOrderComplete,
  });

  final List<CartEntry> items;
  final VoidCallback onOrderComplete;

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String selectedPayment = 'Cash';
  final TextEditingController paymentAmountController = TextEditingController();
  String? paymentError;

  int get totalPrice =>
      widget.items.fold(0, (total, entry) => total + entry.subtotal);

  @override
  void dispose() {
    paymentAmountController.dispose();
    super.dispose();
  }

  void _checkout() {
    final amountPaid = int.tryParse(paymentAmountController.text.trim());
    if (selectedPayment == 'Cash' &&
        (amountPaid == null || amountPaid < totalPrice)) {
      setState(() {
        paymentError = amountPaid == null
            ? 'Masukkan nominal pembayaran.'
            : 'Pembayaran kurang Rp ${totalPrice - amountPaid}.';
      });
      return;
    }

    final orderItems = widget.items
        .map(
          (entry) => {
            'name': entry.itemData['name'] as String,
            'quantity': entry.quantity,
            'subtotal': entry.subtotal,
          },
        )
        .toList();
    final totalQuantity = widget.items.fold(
      0,
      (total, entry) => total + entry.quantity,
    );
    final orderTotal = totalPrice;

    widget.onOrderComplete();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReceiptScreen(
          itemName: 'Pesanan Keranjang',
          quantity: totalQuantity,
          totalPrice: orderTotal,
          paymentMethod: selectedPayment,
          amountPaid: selectedPayment == 'Cash' ? amountPaid : null,
          orderItems: orderItems,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final qrisData = jsonEncode({
      'merchant': 'Assalaam Food',
      'items': widget.items
          .map(
            (entry) => {
              'name': entry.itemData['name'],
              'quantity': entry.quantity,
            },
          )
          .toList(),
      'amount': totalPrice,
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Keranjang',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: widget.items.isEmpty
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 64,
                    color: Color(0xFF9AAAB0),
                  ),
                  SizedBox(height: 12),
                  Text('Keranjang masih kosong.'),
                ],
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...widget.items.map(_buildCartItem),
                  const SizedBox(height: 16),
                  const Text(
                    'Metode Pembayaran',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _paymentOption('Cash', Icons.money, 'Tunai (Cash)'),
                      const SizedBox(width: 10),
                      _paymentOption('QRIS', Icons.qr_code_2, 'QRIS'),
                    ],
                  ),
                  if (selectedPayment == 'Cash') ...[
                    const SizedBox(height: 16),
                    TextField(
                      controller: paymentAmountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        labelText: 'Nominal pembayaran',
                        prefixText: 'Rp ',
                        hintText: '$totalPrice',
                        errorText: paymentError,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (value) {
                        final amount = int.tryParse(value);
                        setState(() {
                          paymentError =
                              value.isEmpty ||
                                  amount == null ||
                                  amount >= totalPrice
                              ? null
                              : 'Pembayaran kurang Rp ${totalPrice - amount}.';
                        });
                      },
                    ),
                  ],
                  if (selectedPayment == 'QRIS') ...[
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'QR pembayaran (simulasi)',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 12),
                          QrImageView(
                            data: qrisData,
                            size: 190,
                            backgroundColor: Colors.white,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Total: Rp $totalPrice',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'QR ini hanya berisi informasi pesanan, belum terhubung ke QRIS merchant.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
      bottomNavigationBar: widget.items.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.all(16),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Total Pembayaran',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        Text(
                          'Rp $totalPrice',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF176B87),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _checkout,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF176B87),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 14,
                      ),
                    ),
                    child: const Text('Checkout'),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildCartItem(CartEntry entry) {
    final itemName = entry.itemData['name'] as String;
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    itemName,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Rp ${entry.itemData['price']} x ${entry.quantity} = Rp ${entry.subtotal}',
                    style: const TextStyle(color: Color(0xFF176B87)),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Kurangi jumlah',
              onPressed: () {
                setState(() {
                  if (entry.quantity > 1) {
                    entry.quantity--;
                  } else {
                    widget.items.remove(entry);
                  }
                });
              },
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Text('${entry.quantity}'),
            IconButton(
              tooltip: 'Tambah jumlah',
              onPressed: () => setState(() => entry.quantity++),
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
      ),
    );
  }

  Widget _paymentOption(String method, IconData icon, String label) {
    final isSelected = selectedPayment == method;
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            selectedPayment = method;
            paymentError = null;
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 14),
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF176B87).withValues(alpha: 0.1)
                : Colors.white,
            border: Border.all(
              color: isSelected
                  ? const Color(0xFF176B87)
                  : Colors.grey.shade300,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? const Color(0xFF176B87) : Colors.grey,
              ),
              const SizedBox(width: 6),
              Flexible(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? const Color(0xFF176B87)
                        : Colors.black87,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
