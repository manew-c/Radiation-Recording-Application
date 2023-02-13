import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Model/Transaction.dart';
import '../Provider/Transaction_provider.dart';

//provider
class surveyData extends StatelessWidget {
  const surveyData({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (Buildcontext) {
        return Transaction_provider();
      })
    ]);
  }
}

class survey extends StatefulWidget {
  const survey({super.key});

  @override
  State<survey> createState() => _surveyState();
}

class _surveyState extends State<survey> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('ข้อมูล')),
        body: Consumer(
          builder: (context, Transaction_provider provider, child) {
            return ListView.builder(
                itemCount: provider.transactions.length,
                itemBuilder: (context, int index) {
                  Transaction data = provider.transactions[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.all(8.0),
                    child: ListTile(
                        leading: CircleAvatar(
                            radius: 30,
                            child: FittedBox(
                                child: Text(data.userlocation.toString()))),
                        title: Text(data.dose.toString()),
                        subtitle: Text(data.date.toString())),
                  );
                });
          },
        ));
  }
}
