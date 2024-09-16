import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ResetEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResetApiEvent extends ResetEvent {
  final BuildContext context;
  ResetApiEvent(this.context);
}
