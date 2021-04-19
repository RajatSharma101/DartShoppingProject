import 'dart:io';
import "package:test/cart.dart";
import "package:test/product.dart";

const allProducts = [
  Product(id: 1, name: 'apple iPhone 8+', price: 400),
  Product(id: 2, name: 'blackberry qwerty phone', price: 200),
  Product(id: 3, name: 'charging cable', price: 10.5),
  Product(id: 4, name: 'google pixel', price: 250),
  Product(id: 5, name: 'music player iPod', price: 80),
  Product(id: 6, name: 'samsung Galaxy Note 21', price: 1500),
  Product(id: 7, name: 'laptop macbook pro', price: 1000),
  Product(id: 8, name: 'intel i7 Laptop with 16gb Ram', price: 1250)
];

void main() {
  final cart = Cart();
  while (true) {
    stdout.write(
        '\nWhat do you want to do? \nPress V to view cart \nPress A to see the list of items \nPress C to checkout and proceed to payment: ');
    final line = stdin.readLineSync();
    if (line == 'a' || line == 'A') {
      final product = chooseProduct();
      if (product != null) {
        cart.addProduct(product);
        print(cart);
      }
    } else if (line == 'v' || line == 'V') {
      print(cart);
    } else if (line == 'c' || line == 'C') {
      if (checkout(cart)) {
        break;
      }
    } else
      (print("\n Please Enter the correct input from above"));
  }
}

Product? chooseProduct() {
  final productsList =
      allProducts.map((product) => product.displayName).join('\n');
  stdout.write('Available products:\n$productsList\n Enter Your choice: ');
  final line = stdin.readLineSync();
  for (var product in allProducts) {
    if (product.initial == line) {
      return product;
    }
  }
  print("""
\n Product Not found in the list. select from the list above""");
  return null;
}

bool checkout(Cart cart) {
  if (cart.isEmpty) {
    print('Cart is empty');
    return false;
  }
  final total = cart.total();
  print('Total: \$$total');
  stdout.write('Enter the total Amount of payment being done : ');
  final line = stdin.readLineSync();
  if (line == null || line.isEmpty) {
    return false;
  }
  final paid = double.tryParse(line);
  if (paid == null) {
    return false;
  }
  if (paid >= total) {
    final change = paid - total;
    print("""Your Change: \$${change.toStringAsFixed(2)} 
    \n---------Thank you for shopping---------\n
    """);
    return true;
  } else {
    print('Not enough money. Please pay the full amount.');
    return false;
  }
}
