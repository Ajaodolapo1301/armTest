

import 'package:arm_test/sizeConfig/sizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class CustomTextField extends FormField<String> {
  final String header;
  final String hint;

  final Color cursorColor;
  final String label;
  final bool obscureText;
  final Widget suffix;
  final IconData suffixIcon;
  final Widget outerSuffix;
  final bool readOnly;
  final String prefix;
  final bool headerLess;
  final int minLines;
  final int maxLines;
  final int lines;

  final IconData prefixIcon;
  final Function onTap;
  final FocusNode focusNode;
  final List<TextInputFormatter> textInputFormatters;
  final FieldType type;
  final ActionType textActionType;
  final TextStyle labelStyle;
//<<<<<<< Updated upstream
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmit;
  final TextEditingController textEditingController;

  CustomTextField(
      {Key key,
      this.header,
      this.type,
        this.cursorColor = Colors.white,
      this.hint,
      this.obscureText = false,
      this.suffix,
      this.readOnly = false,
      this.outerSuffix,
      this.headerLess = false,
      this.prefix,
      this.prefixIcon,
      this.label,
      this.minLines,
      this.maxLines,

      this.lines,
      this.onTap,
      this.textEditingController,
      this.textInputFormatters,
      this.validator,
      this.onSubmit,
      this.textActionType,
        this.suffixIcon,
        this.labelStyle,
      this.focusNode,
      this.onChanged})
      : super(
          key: key,
          validator: validator,
          enabled: true,
          autovalidateMode: AutovalidateMode.disabled,
          initialValue:
              textEditingController != null ? textEditingController.text : "",
          builder: (FormFieldState<String> field) {
            final _CustomTextFieldState state = field as _CustomTextFieldState;

            void onChangedHandler(String value) {
              field.didChange(value);
              if (onChanged != null) {
                onChanged(value);
              }
            }
            TextInputType getTextInputType() {
              switch (type) {
                case FieldType.email:
                  return TextInputType.emailAddress;
                  break;
                case FieldType.phone:
                  return TextInputType.phone;
                  break;

                case FieldType.multiline:
                  return TextInputType.multiline;
                  break;
                case FieldType.number:
                  return TextInputType.number;
                default:
                  return TextInputType.text;
                  break;
              }
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                cursorColor: cursorColor,
                  onTap: onTap,
                  keyboardType: getTextInputType(),
                  readOnly: readOnly,
                    onSubmitted: onSubmit,
                  onChanged: onChangedHandler,
                  focusNode: focusNode,
                  style: TextStyle(
                    color: cursorColor,
                    fontSize: 1.7 * SizeConfig.textMultiplier,


                  ),
                  controller: state._effectiveController,
                  decoration: InputDecoration(

                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: cursorColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: cursorColor),
                      ),
                      // contentPadding: const EdgeInsets.all(kPaddingM),
                      // focusedBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(8),
                      //   borderSide: BorderSide(color: kPrimaryColor),
                      // ),
                      // enabledBorder: OutlineInputBorder(
                      //   borderRadius: BorderRadius.circular(8),
                      //   borderSide: BorderSide(
                      //     color: Colors.black.withOpacity(0.5),
                      //   ),
                      // ),

                      labelText: label,


                      suffix: suffix,
                      suffixIcon: suffixIcon != null
                          ? Icon(
                        suffixIcon,
                        size: 21,
                        //          color: Colors.black.withOpacity(0.5),
                      )
                          : null,
                      labelStyle: TextStyle(
                        fontSize: 13,
                        // 1.3 * SizeConfig.textMultiplier ,
                       color:  cursorColor,
                        fontWeight: FontWeight.w500,
                      ),
                      prefixIcon: prefixIcon != null
                          ? Icon(
                              prefixIcon,
                              size: 20,
                              //          color: Colors.black.withOpacity(0.5),
                            )
                          : null,
                      prefix: prefix != null ? Image.asset(prefix) : null),
                  obscureText: obscureText,
                ),
                if (field.errorText != null)
                  Container(
                    margin: EdgeInsets.only(left: 5, top: 4),
                    child: Text(
                      field.errorText ?? "",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                  )
              ],
            );
          },
        );

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends FormFieldState<String> {
  TextEditingController _controller;

  TextEditingController get _effectiveController =>
      widget.textEditingController ?? _controller;

  @override
  CustomTextField get widget => super.widget as CustomTextField;

  @override
  void initState() {
    super.initState();
    if (widget.textEditingController == null) {
      _controller = TextEditingController(text: widget.initialValue);
    } else {
      widget.textEditingController.addListener(_handleControllerChanged);
    }
  }

  @override
  void didUpdateWidget(CustomTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.textEditingController != oldWidget.textEditingController) {
      oldWidget.textEditingController?.removeListener(_handleControllerChanged);
      widget.textEditingController?.addListener(_handleControllerChanged);

      if (oldWidget.textEditingController != null &&
          widget.textEditingController == null)
        _controller = TextEditingController.fromValue(
            oldWidget.textEditingController.value);
      if (widget.textEditingController != null) {
        setValue(widget.textEditingController.text);
        if (oldWidget.textEditingController == null) _controller = null;
      }
    }
  }

  @override
  void dispose() {
    widget.textEditingController?.removeListener(_handleControllerChanged);
    super.dispose();
  }

  @override
  void didChange(String value) {
    super.didChange(value);
    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? '';
    }
  }

  @override
  void reset() {
    _effectiveController.text = widget.initialValue ?? '';
    super.reset();
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value)
      didChange(_effectiveController.text);
  }

  TextInputType getTextInputType() {
    switch (widget.type) {
      case FieldType.email:
        return TextInputType.emailAddress;
        break;
      case FieldType.phone:
        return TextInputType.phone;
        break;

      case FieldType.multiline:
        return TextInputType.multiline;
        break;
      case FieldType.number:
        return TextInputType.number;
      default:
        return TextInputType.text;
        break;
    }
  }

  TextInputAction getActionInputType() {
    switch (widget.textActionType) {
      case ActionType.next:
        return TextInputAction.next;
        break;
      case ActionType.done:
        return TextInputAction.done;
        break;
      default:
        return TextInputAction.next;
        break;
    }
  }
}

enum FieldType { text, email, phone, password, dropdown, number, multiline }

enum ActionType { next, done }






class CustomDropDown extends FormField<dynamic> {
  final String titleText;
  final String hintText;
  final bool required;
  final String errorText;
  final dynamic value;
  final List dataSource;
  final String textField;
  final String valueField;
  final Function onChanged;
//  Color fillColor = HexColor('#F7F7F7');
  final bool isDark;

  CustomDropDown(
      {this.isDark = false, FormFieldSetter<dynamic> onSaved,
        FormFieldValidator<dynamic> validator,
        bool autovalidate = false,
        this.titleText = 'Title',
        this.hintText = 'Select one option',
        this.required = false,
        this.errorText = 'Please select one option',
        this.value,
        this.dataSource,
        this.textField,
        this.valueField,
        this.onChanged,
//        this.fillColor
      })
      : super(
    onSaved: onSaved,
    validator: validator,
    autovalidate: autovalidate,
    builder: (FormFieldState<dynamic> state) {
      return Column(
       children: [
         DropdownButtonHideUnderline(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
          InputDecorator(
          decoration:  InputDecoration(

          border: OutlineInputBorder(),
            labelStyle: TextStyle(
color: Colors
    .black, //This is an example of a change
),
labelText: " Select Monthly transaction volume",
      focusedBorder: OutlineInputBorder(
      borderSide:
      BorderSide(color: Color(0xffFFC844))),
      enabledBorder: OutlineInputBorder(
      borderSide:
      BorderSide(color: Colors.grey[300]),
      ),
         )
          ),
            Padding(
              padding: const EdgeInsets.all(6.5),
              child: DropdownButton<dynamic>(
                dropdownColor: isDark ? Color(0xff191D20) : Colors.white,
                isDense: true,
                icon: Icon(Icons.keyboard_arrow_down_sharp),
                hint: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    hintText,
                    style: TextStyle(color: isDark ? Colors.white : Colors.grey),
                  ),
                ),
                value: value == '' ? null : value,
                onChanged: (dynamic newValue) {
                  state.didChange(newValue);
                  onChanged(newValue);
                },
                items: dataSource.map((item) {
                  return DropdownMenuItem<dynamic>(
                    value: item,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        item,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: isDark ? Colors.white : Colors.black
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      )

         ),
         SizedBox(height: state.hasError ? 5.0 : 0.0),
         Text(
           state.hasError ? state.errorText : '',
           style: TextStyle(
               color: Colors.redAccent.shade700,
               fontSize: state.hasError ? 12.0 : 0.0),
         ),
       ],

          );
    },
  );
}

class AppDropdownInput<T> extends StatelessWidget {
  final String hintText;
  final List<T> options;
  final T value;
  final String Function(T) getLabel;
  final void Function(T) onChanged;

  AppDropdownInput({
    this.hintText = 'Please select an Option',
    this.options = const [],
    this.getLabel,
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      builder: (FormFieldState<T> state) {
        return InputDecorator(
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
                horizontal: 20.0, vertical: 15.0),
            labelText: hintText,
            border:OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          isEmpty: value == null || value == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isDense: true,
              onChanged: onChanged,
              items: options.map((T value) {
                return DropdownMenuItem<T>(
                  value: value,
                  child: Text(getLabel(value)),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}