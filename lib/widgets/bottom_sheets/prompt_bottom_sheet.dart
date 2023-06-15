import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:provider/provider.dart';

import '../../controllers/export_controllers.dart';
import '../../providers/theme_provider.dart';

class PromptBottomSheet extends StatefulWidget {
  final InputQuestionController inputQuestionController;
  final List<Map>? promptList;

  const PromptBottomSheet({
    super.key,
    required this.inputQuestionController,
    required this.promptList,
  });

  @override
  State<PromptBottomSheet> createState() => _PromptBottomSheetState();
}

class _PromptBottomSheetState extends State<PromptBottomSheet> {
  @override
  void initState() {
    super.initState();
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
      child: Scrollbar(
        thumbVisibility: true,
        radius: const Radius.circular(5.0),
        thickness: 5,
        child: ListView.builder(
          itemCount: widget.promptList?.length,
          itemBuilder: (context, index) {
            final item = widget.promptList?[index];
            final title = item?['title'];
            final prompt = item?['prompt'];
            // final status = item['status'];

            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: SizedBox(
                width: width,
                height: height * .09,
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
                    boxShape:
                        NeumorphicBoxShape.roundRect(BorderRadius.circular(20)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              fontSize: 10,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
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
      ),
    );
  }
}
