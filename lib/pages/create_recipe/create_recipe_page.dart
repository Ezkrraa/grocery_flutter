import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_flutter/pages/grocery_list_info/item_card.dart';
import 'package:grocery_flutter/pages/grocery_lists/grocery_list_item_display.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/v4.dart';

class CreateRecipePage extends StatefulWidget {
  const CreateRecipePage({super.key});

  @override
  State<StatefulWidget> createState() => _CreateRecipePageState();
}

class _CreateRecipePageState extends State<CreateRecipePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController stepsController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  List<Uint8List> imageBytes = List.empty(growable: true);
  List<Image> imageViews = List.empty(growable: true);

  final carouselController = CarouselSliderController();
  List<GroceryListItemDisplay> items = List.generate(
    20,
    (i) => GroceryListItemDisplay(
      id: UuidV4().toString(),
      name: "Item #${i + 1}",
      quantity: i,
      categoryId: "",
      categoryName: "Category ${i / 3}",
    ),
  );
  int currentPage = 0;

  submit() {
    Fluttertoast.showToast(msg: nameController.text);
  }

  void showSelectImageSource() {
    showModalBottomSheet(
      context: context,
      builder:
          (context) => Padding(
            padding: const EdgeInsets.only(bottom: 30, top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              spacing: 30,
              children: [
                IconButton(
                  onPressed: () => selectImage(context, ImageSource.gallery),
                  icon: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.photo,
                        size: 60,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                      const Text("Gallery"),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => selectImage(context, ImageSource.camera),
                  icon: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 60,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                      ),
                      const Text("Camera"),
                    ],
                  ),
                ),
              ],
            ),
          ),
    );
  }

  void selectImage(BuildContext context, ImageSource source) async {
    if (source == ImageSource.camera) {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        final fileBytes = await pickedFile.readAsBytes();
        if (context.mounted) {
          setState(() {
            imageBytes.add(fileBytes);
            imageViews.add(Image.memory(fileBytes));
          });
          Navigator.of(context).pop();
        }
      }
    } else {
      final pickedFiles = await _picker.pickMultiImage();
      if (pickedFiles.isNotEmpty) {
        final List<Uint8List> filesBytes = List.empty(growable: true);
        for (int i = 0; i < pickedFiles.length; i++) {
          final bytes = await pickedFiles[i].readAsBytes();
          filesBytes.add(bytes);
        }
        if (context.mounted) {
          setState(() {
            imageBytes.addAll(filesBytes);
            imageViews.addAll(filesBytes.map((e) => Image.memory(e)));
          });
          Navigator.of(context).pop();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('New recipe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 0.95,
                    enlargeCenterPage: true,
                    aspectRatio: 3 / 2,
                    onPageChanged: (index, reason) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                  ),
                  items:
                      imageViews
                          .map<Widget>(
                            (e) => GestureDetector(
                              onTap:
                                  () => showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return GestureDetector(
                                        onTap: () => Navigator.of(ctx).pop(),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20),
                                          child: e,
                                        ),
                                      );
                                    },
                                  ),
                              child: e,
                            ),
                          )
                          .followedBy([
                            GestureDetector(
                              onTap: () => showSelectImageSource(),
                              child: Container(
                                constraints: BoxConstraints.tight(
                                  const Size.fromHeight(200),
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                  color:
                                      Theme.of(
                                        context,
                                      ).colorScheme.secondaryContainer,
                                ),
                                child: const Icon(
                                  Icons.add_photo_alternate,
                                  size: 100,
                                ),
                              ),
                            ),
                          ])
                          .toList(),
                ),

                const SizedBox.square(dimension: 6),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: ShapeDecoration(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(11)),
                    ),
                    // color:
                    // Theme.of(context).buttonTheme.colorScheme!.onSecondary,
                  ),
                  child: DotsIndicator(
                    dotsCount: imageBytes.length + 1,
                    position: currentPage.toDouble(),
                    onTap:
                        (position) =>
                            carouselController.animateToPage(position),

                    decorator: DotsDecorator(
                      activeColor: Theme.of(context).colorScheme.primary,
                      size: Size.square(6),
                      activeSize: Size.square(8),
                    ),
                  ),
                ),
              ],
            ),
            Column(
              spacing: 10,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Name",
                  ),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Description",
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  maxLines: 15,
                  minLines: 1,
                  controller: stepsController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: "Instructions",
                  ),
                ),

                Container(
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(11)),
                    ),
                    color: Theme.of(context).colorScheme.surfaceContainerHigh,
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children:
                        items.isEmpty
                            ? [
                              Text(
                                "Ingredients:",
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ]
                            : items
                                .map<Widget>((item) => ItemCard(info: item))
                                .toList(),
                  ),
                ),
                FilledButton(onPressed: () => submit(), child: Text("Leave")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
