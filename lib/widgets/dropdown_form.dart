// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vita_app/models/get_model.dart';


class DropdownFrom extends StatelessWidget {
  const DropdownFrom({super.key,});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: GetBuilder<CategoryModel>(
        init: CategoryModel(),
        builder: (controller) {
          return DropdownButtonFormField(
            value: controller.selectedCategory,
            items: controller.dropdownItems,
            hint: const Text('Category'),
            style: const TextStyle(fontSize: 14, color: Colors.black),
            dropdownColor: Colors.green[50],
            onChanged: ((value) => controller.setCategory(value!)),
            validator: ((city) =>
              city == null || city.isEmpty
              ? '*'
              : null
            ),
          );
        }
      ),
    );
  }
}