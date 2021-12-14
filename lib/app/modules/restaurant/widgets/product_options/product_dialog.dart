import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:pscomidas/app/global/models/entities/item.dart';
import 'package:pscomidas/app/global/models/entities/product.dart';
import 'package:pscomidas/app/global/utils/format_money.dart';
import 'package:pscomidas/app/global/utils/schemas.dart';
import 'package:pscomidas/app/modules/cart/cart_store.dart';
import 'package:pscomidas/app/modules/restaurant/restaurant_store.dart';
import 'package:flutter/material.dart';
import 'package:pscomidas/app/modules/restaurant/widgets/product_options/product_store.dart';

class ProductDialog extends StatefulWidget {
  const ProductDialog({
    Key? key,
    required this.product,
    this.isEditing,
  }) : super(key: key);

  final Product product;
  final Item? isEditing;

  @override
  State<ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  final RestaurantStore restaurantStore = Modular.get();

  final CartStore cartStore = Modular.get();

  final ProductOptionsStore store = Modular.get();

  @override
  void initState() {
    store.quantity =
        widget.isEditing == null ? 1 : widget.isEditing!.quantidade;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return AlertDialog(
      titleTextStyle: const TextStyle(color: Colors.black54),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Title(
              color: tertiaryColor,
              child: Text(
                widget.product.name.toString(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Modular.to.pop();
              store.dispose();
            },
            child: const Align(
              child: Icon(Icons.close, color: tertiaryColor),
            ),
          ),
        ],
      ),
      content: SizedBox(
        width: screen.width * .6,
        height: 400,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (screen.width > 1069) ...[
              Expanded(
                child: Container(
                  height: 300.0,
                  width: screen.width * .2,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        widget.product.imgUrl ??
                            'https://firebasestorage.googleapis.com/v0/b/ps-comidas.appspot.com/o/no-image.png?alt=media&token=ef69bdba-5ece-4dc0-9754-fcf2a04364f0',
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),
            ],
            SizedBox(
              width: screen.width > 1069
                  ? screen.width * .30
                  : screen.width > 350
                      ? screen.width * .5
                      : screen.width,
              child: ListView(
                shrinkWrap: true,
                children: [
                  if (widget.product.description != null) ...[
                    Container(
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        widget.product.description.toString(),
                        textAlign: TextAlign.justify,
                        style:
                            const TextStyle(color: tertiaryColor, fontSize: 15),
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  if (widget.product.price != null) ...[
                    Container(
                      color: Colors.white,
                      height: 20,
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        "" + FormatMoney.doubleToMoney(widget.product.price!),
                        textAlign: TextAlign.justify,
                        style:
                            const TextStyle(color: Colors.green, fontSize: 15),
                      ),
                    ),
                  ],
                  const SizedBox(height: 20),
                  Container(
                    height: 140,
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      border: Border.all(color: tertiaryColor, width: 1),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.storefront),
                            const Padding(padding: EdgeInsets.all(3.0)),
                            Expanded(
                              child: Text(
                                restaurantStore.restaurant.body!.socialName,
                                style: const TextStyle(fontSize: 15),
                              ),
                            ),
                            const Icon(
                              Icons.star,
                              size: 15,
                              color: Color(0XFFe8a44c),
                            ),
                            const Padding(padding: EdgeInsets.all(2.0)),
                            Text(
                              restaurantStore.restaurant.body!.avaliation!
                                  .toStringAsFixed(1),
                              style: const TextStyle(
                                color: Color(0XFFe8a44c),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: List.generate(
                              300 ~/ 5,
                              (index) => Expanded(
                                    child: Container(
                                      color: index % 2 == 0
                                          ? Colors.transparent
                                          : tertiaryColor,
                                      height: 1,
                                    ),
                                  )),
                        ),
                        Row(
                          children: [
                            Text(
                              restaurantStore.restaurant.body!.prepareTime +
                                  ' min - ' +
                                  FormatMoney.doubleToMoney(restaurantStore
                                      .restaurant.body!.deliveryPrice),
                              style: const TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.bottomLeft,
                      child: const Text(
                        "Algum comentário?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: tertiaryColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 140,
                    child: TextField(
                      controller: store.observation,
                      textInputAction: TextInputAction.newline,
                      autofocus: true,
                      maxLength: 150,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        hintText: "Ex: tirar cebola, maionese à parte, etc.",
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: secondaryColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 55,
              decoration: BoxDecoration(
                border: Border.all(
                  color: tertiaryColor,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Observer(
                    builder: (_) => IconButton(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () => store.decrement(),
                      icon: Icon(
                        Icons.remove,
                        color: store.quantity > 1
                            ? secondaryColor
                            : Colors.black26,
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 50,
                    color: primaryColor,
                    child: Center(
                      child: Observer(
                        builder: (_) => Text("${store.quantity}"),
                      ),
                    ),
                  ),
                  IconButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () => store.increment(),
                    icon: const Icon(
                      Icons.add,
                      color: secondaryColor,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 55,
                width: 160,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: secondaryColor,
                    onPrimary: Colors.black,
                  ),
                  onPressed: () {
                    if (widget.isEditing == null) {
                      store.makeItem(widget.product);
                    } else {
                      store.makeItem(widget.product);
                      cartStore.removeItem(widget.isEditing!.itemid);
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text(
                              "Você editou um item",
                              textAlign: TextAlign.center,
                            ),
                            content: const Icon(Icons.add_shopping_cart,
                                size: 80, color: secondaryColor),
                            actions: <Widget>[
                              // define os botões na base do dialogo
                              Center(
                                child: ElevatedButton(
                                  child: const Text("Fechar",
                                      style: TextStyle(color: primaryColor)),
                                  style: ElevatedButton.styleFrom(
                                    primary: secondaryColor,
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Observer(builder: (_) {
                    return Text(
                      "Adicionar " +
                          FormatMoney.doubleToMoney(
                              widget.product.price! * store.quantity),
                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 14.0,
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
