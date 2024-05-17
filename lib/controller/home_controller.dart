import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:footwear_admin/model/product/product.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class HomeController extends GetxController {


  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productsCollection;

  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController productDescriptionCtrl = TextEditingController();
  TextEditingController productImageCtrl = TextEditingController();
  TextEditingController productPriceCtrl = TextEditingController();


  String category = 'general';
  String brand = 'un branded';
  bool offer = false;

  List<Product> products = [];

  @override
  void onInit() async {
    productsCollection = firestore.collection("products");
    await fetchProducts();
    super.onInit();
  }

  addProduct() {
    try {
      DocumentReference doc = productsCollection.doc();
      Product product = Product(
        id: doc.id,
        name: productNameCtrl.text,
        category: category,
        description: productDescriptionCtrl.text,
        price: double.tryParse(productPriceCtrl.text),
        brand: brand,
        image: productImageCtrl.text,
        offer: offer,
      );
      final productJson = product.toJson();
      doc.set(productJson);
      Get.snackbar(
          'Success', 'Product added successfully', colorText: Colors.green);
      setValuesDefault();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    }
  }

  fetchProducts() async {
    try {
      QuerySnapshot productsSnapshot = await productsCollection.get();
      final List<Product> retrievedProducts = productsSnapshot.docs.map((doc) =>
              Product.fromJson(doc.data() as Map<String, dynamic>)).toList();

      products.clear();
      products.assignAll(retrievedProducts);
      Get.snackbar('Success', 'Product fetched successfully', colorText: Colors.green);
    } catch (e) {
      Get.snackbar('Error',e.toString(), colorText: Colors.red);
      print(e);
    }finally{
      update();
    }
  }

  deleteProducts(String id) async{
    try {
      await productsCollection.doc(id).delete();
      fetchProducts();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    }
  }

  setValuesDefault() {
    productNameCtrl.clear();
    productDescriptionCtrl.clear();
    productPriceCtrl.clear();
    productImageCtrl.clear();

    category = 'general';
    brand = 'un branded';
    offer = false;

    update();
  }

}