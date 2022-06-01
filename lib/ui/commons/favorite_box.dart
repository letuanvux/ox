import 'package:flutter/material.dart';

class FavoriteBox extends StatelessWidget {
  const FavoriteBox({ Key? key, this.bgColor = Colors.white, this.color = Colors.white, this.onTap, this.isFavorited = false,
  this.borderColor = Colors.transparent, this.radius = 50, this.size = 20}) : super(key: key);
  final Color color;
  final Color borderColor;
  final Color? bgColor;
  final bool isFavorited;
  final double radius;
  final double size;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(          
          color: bgColor?.withOpacity(0.2),
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: borderColor),
          // boxShadow: [
          //   BoxShadow(
          //     color: Theme.of(context).shadowColor.withOpacity(0.1),
          //     spreadRadius: 1,
          //     blurRadius: 1,
          //     offset: const Offset(0, 1), // changes position of shadow
          //   ),
          // ],
        ),
        child: isFavorited ?
        Icon(Icons.favorite, color: bgColor, size: size,)
        :
        Icon(Icons.favorite_border, color: color, size: size,)
      ),
    );
  }
}
