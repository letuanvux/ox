import 'package:flutter/widgets.dart';

@immutable
abstract class Entity<TKey> {
  final TKey id;

  Entity(this.id);

  Map<String, dynamic> toMap() {
    return {
      'id': id
    };
  }

  @override
  List<Object> get props => [];
}
