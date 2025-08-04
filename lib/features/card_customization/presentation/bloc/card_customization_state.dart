import 'package:equatable/equatable.dart';
import '../../data/models/card_customization_data.dart';

class CardCustomizationState extends Equatable {
  final CardCustomizationData data;

  const CardCustomizationState(this.data);

  @override
  List<Object?> get props => [data];
}
