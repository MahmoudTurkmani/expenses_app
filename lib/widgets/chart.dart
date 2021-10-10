import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get getRecentTransaction {
    return List.generate(
      7,
      (index) {
        final weekday = DateTime.now().subtract(Duration(days: index));
        double totalSum = 0.0;

        for (int i = 0; i < recentTransactions.length; i++) {
          if (recentTransactions[i].date!.day == weekday.day &&
              recentTransactions[i].date!.month == weekday.month &&
              recentTransactions[i].date!.year == weekday.year) {
            totalSum += recentTransactions[i].amount!;
          }
        }

        return {
          'day': DateFormat.E().format(weekday),
          'amount': totalSum,
        };
      },
    );
  }

  double get totalSum {
    return recentTransactions.fold(0.0, (sum, tx) {
      return sum + tx.amount!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: getRecentTransaction.map((tx) {
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: tx['day'] as String,
                  amount: tx['amount'] as double,
                  amountAsPctOfTotal: tx['amount'] == 0
                      ? 0.0
                      : (tx['amount'] as double) / totalSum,
                ),
              );
            }).toList()),
      ),
      elevation: 6,
    );
  }
}
