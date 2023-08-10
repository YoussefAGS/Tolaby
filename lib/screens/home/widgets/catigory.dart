import 'package:flutter/material.dart';

class CategoryComponent extends StatelessWidget {
  String categoryTitle;
  Color categoryBackgroundColor;
  VoidCallback categoryOnTap;
  Icon categoryIcon;
  CategoryComponent({super.key, required this.categoryIcon,required this.categoryOnTap,required this.categoryTitle, required this.categoryBackgroundColor});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: categoryOnTap,
      child: Container(
        margin: const EdgeInsets.only(top: 8,bottom:8,right: 8,left: 8),
        padding: const EdgeInsets.only(bottom: 32,top: 32),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white,width: 3),
          gradient: const LinearGradient(
            colors: [Colors.purple, Colors.blue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(categoryIcon.icon,size: 40,color: Colors.white,),
            const SizedBox(height: 16,),
            Text(categoryTitle,style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )),
          ],
        ),
      ),
    );
  }
}
