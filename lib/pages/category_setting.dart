
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vita_app/models/get_model.dart';

class CategorySetting extends StatefulWidget {
  const CategorySetting({super.key});

  @override
  State<CategorySetting> createState() => _CategorySettingState();
}

  CategoryModel controller = Get.put(CategoryModel());

class _CategorySettingState extends State<CategorySetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0,),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemCount: controller.dropdownItems.length,
          itemBuilder: (context, index) {
            String value = controller.dropdownItems[index].value.toString();
            return ListTile(
              title: Text(value),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    controller.deleteCategory(controller.dropdownItems[index]);
                  });
                } 
              ),
            );
          },
        ),
      ),
    );
  }
}