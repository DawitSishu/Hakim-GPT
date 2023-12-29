import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

Message(String text, {required bool isMe}) {
  return Align(
    alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: isMe ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    ),
  );
}

void showSnackbar(BuildContext context,
    {String text = 'Error: Failed to generate Please try again!!'}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.fromLTRB(35, 5, 35, 25),
      backgroundColor: const Color(0xFFC72C41),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

class SquareTile extends StatelessWidget {
  final String imagePath;
  const SquareTile({
    super.key,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[200],
      ),
      child: Image.asset(
        imagePath,
        height: 40,
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            fillColor: Colors.grey.shade200,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500])),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final Function()? onTap;

  const MyButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text(
            "Sign In",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}

void successSnackbar(BuildContext context,
    {String text = 'Your data is Saved Successfully!!'}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.fromLTRB(35, 5, 35, 25),
      backgroundColor: const Color.fromARGB(255, 75, 199, 44),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      content: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

class InputBox extends StatefulWidget {
  const InputBox({
    Key? key,
    this.inputLabel,
    this.placeHolder,
    this.isPassword = false,
    this.textArea = false,
    this.update,
    this.customController,
    this.isPhone = false,
  }) : super(key: key);

  final inputLabel;
  final placeHolder;
  final isPassword;
  final textArea;
  final customController;
  final update;
  final isPhone;

  @override
  _InputBoxState createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  TextEditingController controller = TextEditingController();
  bool showError = false;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    focusNode.removeListener(_handleFocusChange);
    focusNode.dispose();
    controller.dispose();
    super.dispose();
  }

  void _validateInput() {
    final inputValue = controller.text.trim();
    final hasInput = inputValue.isNotEmpty;
    setState(() {
      showError = !hasInput;
    });
  }

  void _handleFocusChange() {
    if (!focusNode.hasFocus) {
      _validateInput();
    }
  }

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          TextField(
            onChanged: (value) {
              widget.update(value);
              _validateInput();
            },
            controller: controller,
            focusNode: focusNode,
            obscureText: widget.isPassword,
            keyboardType:
                widget.isPhone ? TextInputType.phone : TextInputType.text,
            decoration: InputDecoration(
              // prefixIcon: widget.icon,
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(50, 0, 0, 0)),
              ),
              border: const OutlineInputBorder(
                borderSide: BorderSide(width: 16, color: Colors.white),
              ),
              hintText: widget.placeHolder,
              hintStyle: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 14,
                fontFamily: 'Poppins',
              ),
              labelText: widget.inputLabel,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
              errorText: showError
                  ? 'Please enter a valid  ${widget.inputLabel}'
                  : null,
            ),
            minLines: 1,
            maxLines: widget.textArea ? 6 : 1,
          ),
        ],
      );
}

class CustomButton extends StatefulWidget {
  const CustomButton({Key? key, required this.onPressed, this.label = 'Button'})
      : super(key: key);
  final onPressed;
  final String label;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  var loading = false;
  @override
  Widget build(BuildContext context) => SizedBox(
        height: 50,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () async {
            if (!loading) {
              setState(() {
                loading = true;
              });
              await widget.onPressed();
              loading = false;
              setState(() {});
            }
          },
          child: Ink(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 116, 59, 107),
                  Color.fromARGB(255, 100, 58, 97)
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              constraints: const BoxConstraints(
                maxWidth: 250,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: loading
                        ? LoadingAnimationWidget.threeRotatingDots(
                            color: Colors.white, size: 15)
                        : null,
                  ),
                  Text(
                    widget.label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
