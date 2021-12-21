// import 'dart:math';

// import 'package:flutter/material.dart';

// class FlipImg extends StatefulWidget {
//   final String assetPath;

//   const FlipImg({Key? key, required this.assetPath}) : super(key: key);

//   @override
//   _FlipImgState createState() => _FlipImgState();
// }

// class _FlipImgState extends State<FlipImg>
//     with SingleTickerProviderStateMixin {
//   late String _currentImagePath;
//   late String _image1;
//   late String _image2;
//   late AnimationController _animationController;
//   final Curve _rotationCurve = Curves.elasticOut;
//   double _rotation = 0.0;

//   @override
//   void initState() {
//     super.initState();

//     _image1 = widget.assetPath;
//     _currentImagePath = widget.assetPath;

//     _animationController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 3800),
//     )
//       ..addListener(_updateRotation)
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           _onRotationComplete();
//         }
//       });
//   }

//   @override
//   void didUpdateWidget(covariant FlippingImage oldWidget) {
//     super.didUpdateWidget(oldWidget);

//     if (widget.assetPath != oldWidget.assetPath) {
//       _immediatelyFinishCurrentAnimation();
//       _image2 = widget.assetPath;
//       _flipCard();
//     }
//   }

//   void _flipCard() {
//     _currentImagePath = _image1;
//     _animationController.forward(from: 0.0);
//   }

//   void _immediatelyFinishCurrentAnimation() {
//     if (_animationController.isAnimating) {
//       _animationController.stop();
//       _currentImagePath = _image2;
//       _image1 = _image2;
//     }
//   }

//   void _onRotationComplete() {
//     setState(() {
//       _animationController.value = 0;
//       _image1 = _image2;
//       _currentImagePath = _image2;
//     });
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   void _updateRotation() {
//     setState(() {
//       _rotation = pi * _rotationCurve.transform(_animationController.value);

//       if (_currentImagePath == _image1 && _rotation > pi / 2) {
//         _currentImagePath = _image2;
//       } else if (_currentImagePath == _image2 && _rotation < pi / 2) {
//         _currentImagePath = _image1;
//       } else if (_currentImagePath == _image2) {
//         _rotation = _rotation - pi;
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child: Transform(
//           transform: Matrix4.identity()
//             ..setEntry(3, 2, 0.001)
//             ..rotateY(_rotation),
//           alignment: FractionalOffset.center,
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(16),
//             child: IntrinsicHeight(
//               child: Image.asset(
//                 _currentImagePath,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }