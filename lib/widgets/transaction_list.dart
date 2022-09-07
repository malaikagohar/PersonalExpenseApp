import 'package:flutter/material.dart';
import 'package:personal_expenses_app/models/transactions.dart';
import 'transaction_item.dart';

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
              return TransactionItem(
                  transaction: transactions[index],
                  mediaQuery: mediaQuery,
                  deleteTx: deleteTx);
            },
            itemCount: transactions.length,
          );
  }
}
