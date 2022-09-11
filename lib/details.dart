import 'package:flutter/material.dart';
import 'package:food_app/database.dart';
import 'package:food_app/readmore.dart';

class Detail extends StatefulWidget {
  final Item item;
  const Detail(this.item);
  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFF1F1),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xFFFFF1F1),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: const Color(0xFFFFF1F1),
            iconTheme: const IconThemeData(color: Colors.black),
            actions: [
              IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.favorite_outline))
            ],
          ),
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(widget.item.name,
                    style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                Text("\$ ${widget.item.price}",
                    style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.w700)),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 250,
                  child: Image(image: AssetImage(widget.item.image)),
                ),
                const SizedBox(
                  height: 17,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          if (quantity > 1) quantity -= 1;
                        });
                      },
                      child: const CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.horizontal_rule,
                            size: 16, color: Colors.black),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(quantity.toString(),
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          quantity += 1;
                        });
                      },
                      child: const CircleAvatar(
                        radius: 16,
                        backgroundColor: Colors.red,
                        child: Icon(Icons.add, size: 16, color: Colors.white),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.star_border),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(widget.item.rating)
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.fastfood_outlined),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(widget.item.cal)
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.timer),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(widget.item.time)
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  child: ReadMoreText(
                    widget.item.detail,
                    trimLines: 3,
                    colorClickableText: Colors.black,
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                    textAlign: TextAlign.justify,
                    trimMode: TrimMode.Line,
                    moreStyle: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                    lessStyle: const TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            "Total x$quantity",
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(
                            "\$${int.parse(widget.item.price) * quantity}",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 30),
                          )
                        ],
                      ),
                      Container(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(25)),
                        child: const Text(
                          "Add to cart",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}