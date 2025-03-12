import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_flutter/http/item/item_controller.dart';
import 'package:grocery_flutter/http/social/request_result.dart';
import 'package:grocery_flutter/pages/create_list/category_model.dart';

class CreateListPage extends StatefulWidget {
  const CreateListPage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateListPageState();
}

class _CreateListPageState extends State<CreateListPage> {
  late List<CategoryModel>? items = null;
  late int _currentPage = 0;
  final CarouselSliderController carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final jwt = ModalRoute.of(context)!.settings.arguments as String;
    ItemController controller = ItemController(jwt: jwt);

    if (items == null) {
      var result = controller.getItemsInGroup();
      result.then((value) {
        if (value is RequestSuccess) {
          value = value as RequestSuccess<List<CategoryModel>?>;
          setState(() {
            items = (value as RequestSuccess).result;
          });
        } else if (value is RequestError) {
          Fluttertoast.showToast(msg: (value as RequestError).error);
        } else {
          Fluttertoast.showToast(msg: "Invalid type");
        }
      });
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("New grocery list"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child:
            items == null
                ? const Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text("Fetching items..."),
                    ],
                  ),
                )
                : Column(
                  children: [
                    CarouselSlider(
                      carouselController: carouselController,
                      items:
                          items!
                              .map(
                                (category) => Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: ShapeDecoration(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(11),
                                        ),
                                      ),
                                      color:
                                          Theme.of(context)
                                              .buttonTheme
                                              .colorScheme!
                                              .onSecondary,
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Row(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Text(
                                              category.name,
                                              style:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.headlineSmall,
                                            ),
                                            Spacer(),
                                            IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.add),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          spacing: 4,
                                          children:
                                              category.items.isNotEmpty
                                                  ? category.items
                                                      .map(
                                                        (item) => Container(
                                                          decoration: ShapeDecoration(
                                                            color:
                                                                Theme.of(
                                                                      context,
                                                                    )
                                                                    .colorScheme
                                                                    .primaryContainer,
                                                            shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    7,
                                                                  ),
                                                            ),
                                                          ),
                                                          child: Row(
                                                            spacing: 8,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                            children: [
                                                              IconButton(
                                                                style: IconButton.styleFrom(
                                                                  backgroundColor:
                                                                      Theme.of(
                                                                        context,
                                                                      ).colorScheme.surface,
                                                                ),
                                                                onPressed:
                                                                    item.quantity >
                                                                            0
                                                                        ? () {
                                                                          setState(() {
                                                                            category.changeQuantity(
                                                                              item,
                                                                              item.quantity -
                                                                                  1,
                                                                            );
                                                                          });
                                                                        }
                                                                        : null,
                                                                icon: Icon(
                                                                  Icons.remove,
                                                                  color:
                                                                      Theme.of(
                                                                        context,
                                                                      ).colorScheme.onSurface,
                                                                ),
                                                              ),

                                                              Text(
                                                                item.quantity
                                                                    .toString(),
                                                                style:
                                                                    Theme.of(
                                                                          context,
                                                                        )
                                                                        .textTheme
                                                                        .bodyLarge,
                                                              ),
                                                              IconButton(
                                                                style: IconButton.styleFrom(
                                                                  backgroundColor:
                                                                      Theme.of(
                                                                        context,
                                                                      ).colorScheme.onPrimaryContainer,
                                                                ),
                                                                onPressed: () {
                                                                  setState(() {
                                                                    category.changeQuantity(
                                                                      item,
                                                                      item.quantity +
                                                                          1,
                                                                    );
                                                                  });
                                                                },
                                                                icon: Icon(
                                                                  Icons.add,
                                                                  color:
                                                                      Theme.of(
                                                                        context,
                                                                      ).colorScheme.surface,
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    EdgeInsets.only(
                                                                      left: 10,
                                                                    ),
                                                                child: Text(
                                                                  item.name,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                      .toList()
                                                  : <Widget>[
                                                    Center(
                                                      child: Text(
                                                        "No items are in this category yet :[",
                                                      ),
                                                    ),
                                                    // TextButton(
                                                    //   onPressed:
                                                    //       () => carouselController
                                                    //           .animateToPage(5),
                                                    //   child: Text("Test"),
                                                    // ),
                                                  ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                      options: CarouselOptions(
                        enlargeCenterPage: true,
                        animateToClosest: true,
                        viewportFraction: 0.98,
                        height: 600,
                        enableInfiniteScroll: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _currentPage = index;
                          });
                        },
                      ),
                    ),
                    DotsIndicator(
                      dotsCount: items?.length ?? 0,
                      position: _currentPage.toDouble(),
                      onTap:
                          (position) =>
                              carouselController.animateToPage(position),

                      decorator: DotsDecorator(
                        activeColor: Colors.blue,
                        size: Size.square(8.0),
                        activeSize: Size.square(12.0),
                      ),
                    ),
                  ],
                ),
      ),
    );
  }
}
