import 'package:flutter/material.dart';
import 'dart:math';

import 'package:greaticker/common/component/text_style.dart';

Future<void> showImageWithConfettiAnimationDialog({
  required BuildContext context,
  required String comment,
  required String imagePath,
}) {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return ConfettiExplosionDialog(comment: comment, imagePath: imagePath);
    },
  );
}

class ConfettiExplosionDialog extends StatefulWidget {
  final String comment;
  final String imagePath;

  ConfettiExplosionDialog({required this.comment, required this.imagePath});

  @override
  _ConfettiExplosionDialogState createState() => _ConfettiExplosionDialogState();
}

class _ConfettiExplosionDialogState extends State<ConfettiExplosionDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _controller.forward(); // 애니메이션을 한 번만 수행

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {}); // 애니메이션이 완료되었을 때 다시 빌드
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: Alignment.center,
        children: [
          AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(widget.imagePath, height: 180, width: 180),
                SizedBox(height: 20),
                Text(
                  widget.comment,
                  style: YeongdeokSeaTextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 팝업 닫기
                },
                child: Text('close'),
              ),
            ],
          ),
          if (_controller.status != AnimationStatus.completed)
            Positioned.fill(
              child: IgnorePointer(
                child: CustomPaint(
                  painter: ConfettiPainter(controller: _controller),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class ConfettiPainter extends CustomPainter {
  final Animation<double> controller;
  final Random random = Random();

  ConfettiPainter({required this.controller}) : super(repaint: controller);

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < 20; i++) {
      final paint = Paint()
        ..color = Color.fromRGBO(
          random.nextInt(256),
          random.nextInt(256),
          random.nextInt(256),
          1,
        )
        ..style = PaintingStyle.fill;

      final scale = controller.value;
      final dx = size.width * random.nextDouble();
      final dy = size.height * random.nextDouble();
      final path = Path();

      path.moveTo(dx, dy);
      path.lineTo(dx + 10 * scale, dy + 20 * scale);
      path.lineTo(dx - 10 * scale, dy + 20 * scale);
      path.close();

      canvas.save();
      canvas.translate(dx, dy);
      canvas.rotate(random.nextDouble() * 2 * pi * scale);
      canvas.translate(-dx, -dy);
      canvas.drawPath(path, paint);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
