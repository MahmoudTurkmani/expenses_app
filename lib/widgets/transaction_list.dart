import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Container(
        child: transactions.isEmpty
            ? Column(
                children: <Widget>[
                  Text(
                    "How about you add some data?",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    "assets/images/annas.png",
                    fit: BoxFit.cover,
                    height: constraints.maxHeight * 0.7,
                  ),
                ],
              )
            : ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (ctx, index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 5),
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        leading: CircleAvatar(
                          child: FittedBox(
                            child: Text(
                              '${transactions[index].amount}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            fit: BoxFit.scaleDown,
                          ),
                          radius: 30,
                        ),
                        title: Text(
                          '${transactions[index].title}',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                        subtitle: Text(
                          '${DateFormat('dd MMM yyyy').format(transactions[index].date!)}',
                        ),
                        trailing: (constraints.maxWidth > 450
                            ? TextButton.icon(
                                onPressed: () =>
                                    deleteTx(transactions[index].id),
                                icon: Icon(
                                  Icons.delete,
                                  color: Theme.of(ctx).errorColor,
                                ),
                                label: Text(
                                  'Remove',
                                  style: TextStyle(
                                      color: Theme.of(ctx).errorColor),
                                ),
                              )
                            : IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Theme.of(context).errorColor,
                                ),
                                onPressed: () {
                                  deleteTx(transactions[index].id);
                                },
                              )),
                      ),
                    ),
                  );
                },
              ),
      );
    });
  }
}
