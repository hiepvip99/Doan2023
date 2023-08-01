import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<String> products = [
    'Giày 1',
    'Giày 2',
    'Giày 3',
  ];

  void addProduct(String productName) {
    setState(() {
      products.add(productName);
    });
  }

  void deleteProduct(int index) {
    setState(() {
      products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách sản phẩm giày'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product),
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                deleteProduct(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddProductDialog(
                onAddProduct: addProduct,
              );
            },
          );
        },
      ),
    );
  }
}

class AddProductDialog extends StatefulWidget {
  final Function(String) onAddProduct;

  const AddProductDialog({super.key, required this.onAddProduct});

  @override
  State createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  TextEditingController _productNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Thêm sản phẩm'),
      content: TextField(
        controller: _productNameController,
        decoration: const InputDecoration(
          labelText: 'Tên sản phẩm',
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Hủy'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: const Text('Thêm'),
          onPressed: () {
            final productName = _productNameController.text;
            widget.onAddProduct(productName);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _productNameController.dispose();
    super.dispose();
  }
}
