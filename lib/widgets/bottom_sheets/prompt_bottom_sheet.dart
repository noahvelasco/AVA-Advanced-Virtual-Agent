import 'package:ava_v2/controllers/export_controllers.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../database/prompt_storage_helper.dart';
import '../../providers/theme_provider.dart';

//TODO - fix duplicates issue and issue with not showing prompts until clicking on it twice

class PromptBottomSheet extends StatefulWidget {
  final InputQuestionController inputQuestionController;

  const PromptBottomSheet({
    super.key,
    required this.inputQuestionController,
  });

  @override
  State<PromptBottomSheet> createState() => _PromptBottomSheetState();
}

class _PromptBottomSheetState extends State<PromptBottomSheet> {
//Create the database object maker and its CRUD functions
  late final PromptStorageHelper _promptStorageHelper;

  //create the database object using the database object maker
  late final Database? _database;
  late final Future<List<Map<String, dynamic>>> _promptList;
  @override
  void initState() {
    super.initState();
    _promptStorageHelper = PromptStorageHelper();
    _initializeDatabase();
    _promptList = _promptStorageHelper.getAllData();

    /*
      Debugging purposes only - comment 'await promptStorageHelper.database;' 
      and uncomment below to delete DB 
    */

    // debugPrint("Printing Table");
    // promptStorageHelper.printTableData();

    // _promptStorageHelper.deleteTable();
    // debugPrint("Deleted Table");

    // _promptStorageHelper.deleteDB();
    // debugPrint("Deleted DB");
  }

  Future<void> _initializeDatabase() async {
    _database = await _promptStorageHelper.database;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    ColorScheme colorScheme = Theme.of(context).colorScheme;
    final provider = Provider.of<ThemeProvider>(context);

    return SizedBox(
      height: height * .75,
      child: FutureBuilder<List<Map<String, dynamic>>>(
        future: _promptList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }

          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          final data = snapshot.data!;

          return Scrollbar(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                // final title = item['title'];
                final prompt = item['prompt'];
                // final status = item['status'];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: width * .80,
                    height: height * .16,
                    child: NeumorphicButton(
                      minDistance: -5,
                      style: NeumorphicStyle(
                        lightSource: LightSource.topLeft,
                        intensity: provider.theme == ThemeMode.light ? .8 : .6,
                        color: colorScheme.primary,
                        shadowDarkColor: Colors.black,
                        shadowLightColorEmboss: Colors.white,
                        shadowDarkColorEmboss: Colors.black,
                        depth: 2,
                        shape: NeumorphicShape.flat,
                        boxShape: NeumorphicBoxShape.roundRect(
                            BorderRadius.circular(20)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          // Text(
                          //   title,
                          //   style: const TextStyle(
                          //     fontSize: 20,
                          //     fontStyle: FontStyle.italic,
                          //   ),
                          // ),
                          Scrollbar(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Text(
                                prompt,
                              ),
                            ),
                          )
                        ],
                      ),
                      onPressed: () {
                        widget.inputQuestionController.setText(prompt);
                        Navigator.pop(context);
                      },
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
