import 'package:flutter/material.dart';
import 'package:foodieree/widgets/order_button.dart';
import 'package:video_player/video_player.dart';

class VideolItem extends StatefulWidget {
  final String reel;
  final String thumb;
  final String title;
  final String author;
  final bool isLiked;
  final String km;

  const VideolItem({
    super.key,
    required this.reel,
    required this.thumb,
    required this.title,
    required this.author,
    required this.isLiked,
    required this.km,
  });

  @override
  State<VideolItem> createState() => _VideolItemState();
}

class _VideolItemState extends State<VideolItem> {
  late VideoPlayerController _controller;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  String km = "";

  void _initializeVideo() async {
    String add = widget.reel.substring(4);
    String now = "https$add";
    km = widget.km[0];

    _controller = VideoPlayerController.networkUrl(
      Uri.parse(now),
    )..initialize().then(
        (_) {
          setState(() {
            _isVideoInitialized = true;
          });
          _controller.setLooping(true);
          _controller.play();
        },
      );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.network(widget.thumb.toString()).image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (_isVideoInitialized)
          InkWell(
            onTap: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: SizedBox.expand(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
          )
        else
          const Center(
            child: CircularProgressIndicator(),
          ),
        Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    "Location : ${widget.author}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '$km km away',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  OrderButton(onPressed: () {}),
                  Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: widget.isLiked ? Colors.red : Colors.grey,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
        // if (_isVideoInitialized)
        //   Center(
        //     child: IconButton(
        //       onPressed: () {
        //         setState(() {
        //           _controller.value.isPlaying
        //               ? _controller.pause()
        //               : _controller.play();
        //         });
        //       },
        //       icon: Icon(
        //         Icons.play_arrow,
        //         size: 120,
        //       ),
        //     ),
        //   )
      ],
    );
  }
}
