import 'package:flutter/material.dart';
import 'package:product_supawat/model/product_model.dart';
import 'package:product_supawat/service/database.dart';
import 'package:product_supawat/widgets/product_popup.dart';


class ProductItem extends StatelessWidget {
  final ProductModel product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    Database db = Database.myInstance; // เรียกใช้ Database

    return ListTile(
      leading: Text(
        product.productName,
        style: const TextStyle(
          fontSize: 18, 
          fontWeight: FontWeight.bold, // ทำให้ตัวหนา
        ),
      ),
      title: Text(
        product.price.toStringAsFixed(2),
        textAlign: TextAlign.right,

      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
           icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => ProductPopup(product: product),
              );
               _confirmDelete(context, db);
            },
            
          ),
         
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, Database db) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("ลบสินค้า"),
        content: Text("คุณต้องการลบ '${product.productName}' ใช่หรือไม่?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("ยกเลิก"),
          ),
          TextButton(
            onPressed: () {
              db.deleteProduct(product: product);
              Navigator.pop(context);
            },
            child: const Text("ลบ", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
