import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'category_setting.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Settings'),
      ),
      body:  Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '  Customize', 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 5,),
            CustomContainer(
              onTap1: () => Get.to(() => CategorySetting()),
              firstTitle: 'Category', 
              firstIcon: Icons.apps,
              firstSubtitle: '',
              secondTitle: 'Notification',
              secondIcon: Icons.notifications,
              secondSubtitle: 'off',
            ),
            SizedBox(height: 20,),
            Text(
              '  Date & Time', 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 5,),
            CustomContainer(
              firstTitle: 'Date Format', 
              firstIcon: Icons.date_range,
              firstSubtitle: 'yyyy/mm/dd',
              secondTitle: 'Time Formula',
              secondIcon: Icons.timer,
              secondSubtitle: '24 hours',
            ),
            SizedBox(height: 20,),
            Text(
              '  About', 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 5,),
            CustomContainer(
              firstSubtitle: '',
              firstTitle: 'Rate Us', 
              firstIcon: Icons.thumb_up,
              secondTitle: 'Share The App',
              secondIcon: Icons.share,
              secondSubtitle: '',
            ),
          ],
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key, 
    required this.firstTitle, 
    required this.firstIcon,
    required this.secondTitle, 
    required this.secondIcon,
    required this.firstSubtitle,
    required this.secondSubtitle,
    this.onTap1,
    this.onTap2
  });

  final String firstTitle, secondTitle, firstSubtitle, secondSubtitle;
  final IconData firstIcon, secondIcon;
  final Function()? onTap1;
  final Function()? onTap2;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green[200],
        borderRadius: BorderRadius.circular(20)
      ),
      child: Column(
        children: [
          customTile(firstTitle, firstIcon, firstSubtitle, onTap1),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            child: Divider(thickness: 1,),
          ),
          customTile(secondTitle, secondIcon, secondSubtitle, onTap2),
        ],
      ),
    );
  }

  Widget customTile(String title, IconData icon, String subtitle, Function()? onTap){
    return ListTile(
      onTap: onTap,
      minLeadingWidth: 10,
      title: Text(title),
      leading: Icon(icon),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(subtitle,),
          const SizedBox(width: 4,),
          const Icon(Icons.arrow_forward_ios, size: 16,),
        ],
      ),
    );
  }
}