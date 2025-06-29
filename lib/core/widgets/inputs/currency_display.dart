import 'package:flutter/material.dart';
import '../../../features/trainer_products/domain/entities/trainer_product.dart';

class CurrencyDisplay extends StatelessWidget {
  final double amount;
  final Currency currency;
  final TextStyle? style;
  final bool showDecimals;

  const CurrencyDisplay({
    super.key,
    required this.amount,
    required this.currency,
    this.style,
    this.showDecimals = false,
  });

  @override
  Widget build(BuildContext context) {
    final formattedAmount =
        showDecimals ? amount.toStringAsFixed(2) : amount.toStringAsFixed(0);

    return Text(
      '${currency.symbol}$formattedAmount',
      style: style,
    );
  }
}
