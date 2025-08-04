import 'package:equatable/equatable.dart';
import '../../data/models/card_customization_data.dart';

enum CardCustomizationStatus { initial, loading, success, failure }

class CardCustomizationState extends Equatable {
  final CardCustomizationData data;
  final CardCustomizationStatus status;
  final String? errorMessage;

  const CardCustomizationState({
    required this.data,
    this.status = CardCustomizationStatus.initial,
    this.errorMessage,
  });

  CardCustomizationState copyWith({
    CardCustomizationData? data,
    CardCustomizationStatus? status,
    String? errorMessage,
  }) {
    return CardCustomizationState(
      data: data ?? this.data,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [data, status, errorMessage];
}
