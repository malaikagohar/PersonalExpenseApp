import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transactions.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key? key,
    required this.transaction,
    required this.mediaQuery,
    required this.deleteTx,
  }) : super(key: key);

  final Transaction transaction;
  final MediaQueryData mediaQuery;
  final Function? deleteTx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                '\$${transaction.amount.toStringAsFixed(2)}',
              ),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(DateFormat.yMMMd().format(transaction.date)),
        trailing: mediaQuery.size.width > 460
            ? TextButton.icon(
                icon: const Icon(Icons.delete),
                label: const Text(
                  "Delete",
                  style: TextStyle(fontSize: 16),
                ),
                onPressed: () => deleteTx!(transaction.id),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => deleteTx!(transaction.id),
                color: Theme.of(context).primaryColorDark,
              ),
      ),
    );
  }
}
