import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vita_app/pages/registration/check_register.dart';
import 'package:vita_app/widgets/button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green[100],
        body: Center(
          child: Column(
            children: [
              SizedBox(height: height * 0.05,),
              const Text('Welcome to ', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
              SizedBox(height: height * 0.01,),
              SizedBox(
                height: 200,
                width: 270,
                child: Image.asset('assets/images/startup.png'),
              ),
              SizedBox(height: height * 0.04,),
              CustomRow(
                width: width, height: height,
                title: 'Create tasks quickly and easily',
                subTitle: 'Categories include main tasks and sub-tasks',
                icon: Icons.library_add_check_outlined,
                size: 70,
              ),
              SizedBox(height: height * 0.07,),
              CustomRow(
                width: width, height: height,
                title: 'Determine priority',
                subTitle: 'Prioritize your tasks easily',
                icon: Icons.list,
                size: 80,
              ),
              const Spacer(),
              Button(
                text: 'Continue', 
                onPressed: () => Get.off(() => const CheckRegister()),
              ),
              const Spacer(),
            ],
          ),
        )
      ),
    );
  }
}

class CustomRow extends StatelessWidget {
  const CustomRow({
    super.key,
    required this.width,
    required this.height,
    required this.title,
    required this.subTitle,
    required this.icon,
    required this.size,
  });

  final double width;
  final double height;
  final String title;
  final String subTitle;
  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(icon, size: size,),
        Column(
          children: [
            Text(
              title, 
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: height * 0.01,),
            SizedBox(
              width: width * 0.6,
              child: Text(
                subTitle, 
                style: const TextStyle(fontSize: 18),
                maxLines: 3,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ],
    );
  }
}