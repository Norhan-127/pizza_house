import 'package:flutter/material.dart';
import 'blocs/provider.dart';

class PizzaHouse extends StatelessWidget {
  var pizzaName = "";

  PizzaHouse({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pizza House"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[menu1(bloc), menu2(bloc), orderOffice(bloc)],
      ),
    );
  }

  menu1(Bloc bloc) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ElevatedButton(
              child: const Text("Neapolitan"),
              onPressed: () {
                bloc.orderItem("Neapolitan");
                pizzaName = "Neapolitan";
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 2.0, right: 2.0),
          ),
          Expanded(
            child: ElevatedButton(
              child: const Text("California-style"),
              onPressed: () {
                bloc.orderItem("California-style");
                pizzaName = "California-style";
              },
            ),
          )
        ],
      ),
    );
  }

  menu2(Bloc bloc) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ElevatedButton(
              child: const Text("Sushi"),
              onPressed: () {
                bloc.orderItem("Sushi");
                pizzaName = "Sushi";
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 2.0, right: 2.0),
          ),
          Expanded(
            child: ElevatedButton(
              child: const Text("Marinara"),
              onPressed: () {
                bloc.orderItem("Marinara");
                pizzaName = "Marinara";
              },
            ),
          )
        ],
      ),
    );
  }

  orderOffice(Bloc bloc) {
    return StreamBuilder(
      stream: bloc.orderOffice,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(
                snapshot.data!,
                fit: BoxFit.fill,
              ),
              Container(
                margin: const EdgeInsets.only(top: 8.0),
              ),
              Text("Yay! Collect your $pizzaName pizza")
            ],
          );
        } else if (snapshot.hasError) {
          return Column(
            children: <Widget>[
              Image.network(
                  "http://megatron.co.il/en/wp-content/uploads/sites/2/2017/11/out-of-stock.jpg",
                  fit: BoxFit.fill),
              Text(
                snapshot.error as String,
                style: const TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ],
          );
        }
        return const Text("No item in collect office");
      },
    );
  }
}
