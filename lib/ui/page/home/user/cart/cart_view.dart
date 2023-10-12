import 'package:flutter/material.dart';

class ShoppingCartScreen extends StatelessWidget {
  static const route = '/ShoppingCartScreen';

  const ShoppingCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    width: 60,
                    height: 60,
                    color: Colors.grey,
                    child: const Center(child: Text('Image')),
                  ),
                  title: Text('Product ${index + 1}'),
                  subtitle: const Text('Price: \$10'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            shape: const CircleBorder()),
                        child: const Text('-'),
                      ),
                      const Text('quantity'),
                      ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                              shape: const CircleBorder()),
                          child: const Text('+')),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Checkout'),
            ),
          ),
        ],
      ),
    );
  }
}
