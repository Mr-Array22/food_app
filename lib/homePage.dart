import 'package:flutter/material.dart';
import 'package:food_app/database.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_app/details.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Item> currentItem=categoryList[0].items;
  int categoryIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF1F1),
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "eats",
                      style: TextStyle(
                          color: Colors.red,
                          fontSize: 36,
                          fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.shopping_cart_outlined,
                      size: 30,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Flexible(
                      child: TextField(
                        autofocus: false,
                        cursorColor: Colors.red,
                        decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[400],
                            prefixIcon: const Icon(
                              Icons.search,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Search.."),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.sort,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: categoryList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: (){
                        currentItem=categoryList[index].items;
                        categoryIndex=index;
                        setState(() {

                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.grey,
                                  spreadRadius: 1),
                            ]),
                        child: CircleAvatar(
                          backgroundColor:categoryIndex==index? Colors.red:Colors.white,
                          radius: 30,
                          child: SvgPicture.asset(
                            categoryList[index].image,
                            fit: BoxFit.fill,
                            height: 30,
                            color:categoryIndex==index?Colors.white: Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height:15 ,),
              SizedBox(
                height: 210,
                child: ShowItems(currentItem),
              ),
              const SizedBox(height: 15,),
              SizedBox(
                height: 140,
                child: ShowCategory(name:"Best Seller",item:currentItem),
              ),
              const SizedBox(height: 15,),
              AllProduct(name:"All Product",item:currentItem)
            ],
          ),
        ),
      ),
    );
  }
}

class ShowItems extends StatelessWidget {
  final List<Item> items;
  ShowItems(this.items);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
        itemBuilder:(BuildContext context,int index){
        return ShowProduct(items[index],context);
        }
    );
  }
}


class AllProduct extends StatelessWidget {
  final String name;
  List<Item> item;
  AllProduct({required this.name,required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10,bottom: 10),
          child: Text(
            name,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 25,fontWeight: FontWeight.bold),
          ),
        ),
        Flexible(
          child: GridView.builder(
            itemCount: item.length,
            shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (_,index){
                return ShowProduct(item[index], context);
              }
          ),
        )
      ],
    );
  }
}



Widget ShowProduct(Item item,BuildContext context){
  return GestureDetector(
    onTap: (){
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context)=>Detail(item))
      );
    },
    child: Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 170,
            width: 150,
            margin: const EdgeInsets.all(10),
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50),
                topRight: Radius.circular(50),
              )
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name,style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                  ),),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\$${item.price}",
                        style:const TextStyle(
                          color: Colors.grey,
                          fontSize: 18
                        ),
                      ),
                      const CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 20,
                        child: Icon(Icons.add,color: Colors.white,),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          child: SizedBox(
            height: 100,
            child: Image(image:AssetImage(item.image) ,),
          ),
        )
      ],
    ),
  );
}

class ShowCategory extends StatelessWidget {
  final String name;
  final List<Item> item;
  const ShowCategory({required this.name,required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Text(
            name,
            textAlign: TextAlign.left,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: item.length,
            itemBuilder: (BuildContext context,int index){
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=>Detail(item[index]))
                  );
                },
                child: Container(
                  width: 260,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 5,
                        color: Colors.grey,
                        spreadRadius: 1
                      ),
                    ],
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: Image(image:AssetImage(item[index].image),),
                      ),
                      Row(
                       crossAxisAlignment: CrossAxisAlignment.end,
                       children: [
                         Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             SizedBox(
                               width: 150,
                               child: Text(item[index].name,
                                 style: const TextStyle(fontWeight: FontWeight.bold,fontSize:23 ),
                               ),
                             ),
                             Text("\$${item[index].price}",style:const TextStyle(
                               color: Colors.grey,
                               fontSize: 18
                             ),
                             )
                           ],
                         ),
                         const CircleAvatar(
                           backgroundColor: Colors.red,
                           radius: 15,
                           child: Icon(Icons.add,color: Colors.white,),
                         )
                       ],
                      )
                    ],
                  ) ,
                ),
              );
            },
          ),
        )
      ],
    );
  }
}

