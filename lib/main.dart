import 'package:flutter/material.dart';
import 'package:flutterprovider04/Products.dart';
import 'package:flutterprovider04/productsprovider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    print("build called");
    final provider = Provider.of<ProductsProvider>(context);
    provider.fetchproducts();
    var plist=provider.listproducts ;
    return Scaffold(
        appBar: AppBar(),
        body:ListView.builder(
          shrinkWrap: true,
          itemCount:plist.length == null ? 0 : plist.length,
          itemBuilder: (BuildContext context, int index) {
            Products st = plist[index];
            return Card(
              child: Row(
                children: <Widget>[
                  Image.network('${plist[index].thumbnail}',fit:BoxFit.cover,height: 100,width: 100,),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      child: Column(
                        children: <Widget>[
                          Text('id: ${st.id}'),
                          Container(width: MediaQuery.of(context).size.width-300,
                              child: Text('product: ${st.title}',maxLines: 3,)),
                          Text('description: ${st.description}'),
                          Text('price: ${st.price}'),
                          Text('discountPercentage: ${st.discountPercentage}'),
                          Text('rating: ${st.rating}'),
                          Text('stock: ${st.stock}'),
                          Text('brand: ${st.brand}'),
                          Text('category: ${st.category}'),
                          Text('thumbnail ${st.thumbnail}'),
                          Text('images: ${st.images}'),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        )
    );
  }
}

