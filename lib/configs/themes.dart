import 'package:flutter/material.dart';

final boxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: const BorderRadius.all(Radius.circular(5)),
  boxShadow: [
      BoxShadow(
      offset: const Offset(4, 4),
      blurRadius: 10,
      color: Colors.grey.withOpacity(.2),
    ),
    BoxShadow(
      offset: const Offset(-3, 0),
      blurRadius: 15,
      color: Colors.grey.withOpacity(.1),
    )
  ],
);

final matchDecoration = BoxDecoration(
  color: Colors.green.withOpacity(0.45),
  border: Border.all(color: Colors.green),
  borderRadius: const BorderRadius.all(Radius.circular(5)),
  boxShadow: [
      BoxShadow(
      offset: const Offset(4, 4),
      blurRadius: 10,
      color: Colors.grey.withOpacity(.2),
    ),
    BoxShadow(
      offset: const Offset(-3, 0),
      blurRadius: 15,
      color: Colors.grey.withOpacity(.1),
    )
  ],
);

