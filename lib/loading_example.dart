import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class Loading {
  final BehaviorSubject<String> behaviorSubject;
  final OverlayState _overlayState;
  final BuildContext context;
  late final OverlayEntry? _overlayEntry;
  Loading({required this.context})
      : behaviorSubject = BehaviorSubject<String>(),
        _overlayState = Overlay.of(context);

  void dispose() {
    behaviorSubject.sink.close();
    _overlayState.dispose();
  }

  void showOverlay({
    required String text,
  }) async {
    behaviorSubject.sink.add(text);
    final availableSpace = context.findRenderObject() as RenderBox;
    _overlayEntry = OverlayEntry(builder: (context) {
      return Material(
        color: Colors.black.withOpacity(0.5),
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              minHeight: availableSpace.size.height * 0.2,
              minWidth: availableSpace.size.width * 0.6,
              maxHeight: availableSpace.size.height * 0.3,
              maxWidth: availableSpace.size.width * 0.7,
            ),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    const CircularProgressIndicator(),
                    const SizedBox(
                      height: 20,
                    ),
                    StreamBuilder(
                      stream: behaviorSubject.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            snapshot.requireData.isNotEmpty) {
                          return Text(snapshot.data ?? "");
                        }
                        return const SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
    _overlayState.insert(_overlayEntry!);
  }

  void removeOverlay() {
    _overlayEntry?.remove();
  }
}
