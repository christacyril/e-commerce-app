import 'package:flutter/material.dart';
import 'package:footwear_admin/controller/home_controller.dart';
import 'package:footwear_admin/widgets/drop_down_button.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Add Product",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child: SizedBox(
              width: double.maxFinite,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Add New Product",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigoAccent,
                    ),
                  ),
                  TextField(
                    controller: ctrl.productNameCtrl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: Text("Product Name"),
                        hintText: "Enter your product name."),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: ctrl.productDescriptionCtrl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: Text("Product Description"),
                        hintText: "Enter your product description."),
                    maxLines: 4,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: ctrl.productImageCtrl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: Text("Image URL"),
                        hintText: "Enter your image URL."),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: ctrl.productPriceCtrl,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        label: Text("Product Price"),
                        hintText: "Enter your product price."),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Flexible(
                          child: DropDownButton(
                        items: ['Boots', 'Shoes', 'Beach Shoes', 'High Heels'],
                        selectedItemText: ctrl.category,
                        onSelected: (selectedValue) {
                          ctrl.category = selectedValue ?? 'general';
                          ctrl.update();
                        },
                      )),
                      Flexible(
                          child: DropDownButton(
                        items: ['Puma', 'Skechers', 'Adidas', 'Nike'],
                        selectedItemText: ctrl.brand,
                        onSelected: (selectedValue) {
                          ctrl.brand = selectedValue ?? 'un branded';
                          ctrl.update();
                        },
                      )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Offer Product?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  DropDownButton(
                    items: ['true', 'false'],
                    selectedItemText: ctrl.offer.toString(),
                    onSelected: (selectedValue) {
                      ctrl.offer = bool.tryParse(selectedValue ?? 'false') ?? false;
                      ctrl.update();
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigoAccent,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        ctrl.addProduct();
                      },
                      child: Text("Add Product"))
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
