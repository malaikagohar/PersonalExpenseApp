import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transactions.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function? deleteTx;
  const TransactionList(this.transactions, this.deleteTx, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    return transactions.isEmpty
        ? LayoutBuilder(builder: ((context, constraints) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (!isLandscape)
                  SizedBox(
                    height: constraints.maxHeight * 0.08,
                  ),
                const Text("No Transactions Added Yet!"),
                SizedBox(
                  height: !isLandscape ? 40 : 30,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.5,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.cover,
                  ),
                )
              ],
            );
          }))
        : ListView.builder(
            itemBuilder: (context, index) {
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
                          '\$${transactions[index].amount.toStringAsFixed(2)}',
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  subtitle:
                      Text(DateFormat.yMMMd().format(transactions[index].date)),
                  trailing: mediaQuery.size.width > 460
                      ? TextButton.icon(
                          icon: const Icon(Icons.delete),
                          label: const Text(
                            "Delete",
                            style: TextStyle(fontSize: 16),
                          ),
                          onPressed: () => deleteTx!(transactions[index].id),
                        )
                      : IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => deleteTx!(transactions[index].id),
                          color: Theme.of(context).primaryColorDark,
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
