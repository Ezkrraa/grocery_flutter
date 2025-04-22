import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:grocery_flutter/http/recipe-controller/recipe_controller.dart';
import 'package:grocery_flutter/http/social/request_result.dart';
import 'package:grocery_flutter/pages/recipes/recipe_display.dart';
import 'package:grocery_flutter/pages/recipes/recipe_info.dart';
import 'package:grocery_flutter/pages/recipes/recipe_list_card.dart';

class RecipesPage extends StatefulWidget {
  const RecipesPage({super.key});

  @override
  State<RecipesPage> createState() => _RecipesPageState();
}

class _RecipesPageState extends State<RecipesPage> {
  late RecipeController? controller = null;
  late List<RecipeDisplay>? recipeDisplays = null;

  getRecipes(RecipeController controller) async {
    final RequestResult<List<RecipeInfo>> result =
        await controller.getAllRecipes();
    if (result is RequestSuccess<List<RecipeInfo>>) {
      var recipes = result.result;
      if (recipes.isEmpty) {
        if (mounted) {
          setState(() {
            recipeDisplays = List.empty();
          });
        }
      } else {
        for (int i = 0; i < recipes.length; i++) {
          final element = recipes[i];
          Uint8List? img = null;
          if (element.pictureName != null && element.pictureName!.isNotEmpty) {
            RequestResult<Uint8List?> pictureResult = await controller
                .getPicture(element.pictureName!);
            if (pictureResult is RequestSuccess<Uint8List?>) {
              img = pictureResult.result;
            }
          }
          if (mounted) {
            setState(() {
              recipeDisplays ??= List<RecipeDisplay>.empty(growable: true);
              recipeDisplays!.add(
                RecipeDisplay(info: element, imageBytes: img),
              );
            });
          }
        }
      }
    } else {
      var errorResult = result as RequestError<List<RecipeInfo>?>;
      if (mounted) {
        setState(() {
          recipeDisplays = List.empty();
        });
      }
      Fluttertoast.showToast(msg: "Error $errorResult >:[");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (recipeDisplays == null) {
      String jwt = ModalRoute.of(context)!.settings.arguments as String;
      if (controller == null) {
        setState(() => controller = RecipeController(jwt: jwt));
      }
      getRecipes(controller!);
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Recipes'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => Navigator.of(context).pushNamed("/create-recipe"),
      ),
      body:
          recipeDisplays == null
              ? const Center(child: CircularProgressIndicator())
              : recipeDisplays!.isEmpty
              ? const Center(child: Text("You don't have any recipes"))
              : ListView.separated(
                padding: const EdgeInsets.all(5),
                separatorBuilder:
                    (c, i) => const SizedBox.square(dimension: 10),
                itemCount: recipeDisplays?.length ?? 0,

                itemBuilder: (context, index) {
                  return RecipeListCard(
                    info: recipeDisplays![index],
                    onTap: () {
                      // TODO: Navigate to a recipe view that lets you edit
                      showBottomSheet(
                        context: context,
                        builder: (context) {
                          return Padding(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [Icon(Icons.add), Text("Test")],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
    );
  }
}
