import 'package:flutter/material.dart';
import '../utils/constants.dart';

class SearchBarWidget extends StatefulWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final TextEditingController? controller;
  final bool autofocus;

  const SearchBarWidget({
    super.key,
    this.hintText = 'Search surahs...',
    this.onChanged,
    this.onClear,
    this.controller,
    this.autofocus = false,
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  late TextEditingController _controller;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _controller.text.isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  void _clearText() {
    _controller.clear();
    widget.onClear?.call();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppConstants.paddingMedium),
      decoration: BoxDecoration(
        color: AppConstants.surfaceColor,
        borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
        boxShadow: [
          BoxShadow(
            color: AppConstants.borderColor.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _controller,
        autofocus: widget.autofocus,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: AppConstants.bodyMedium.copyWith(
            color: AppConstants.textSecondaryColor,
          ),
          prefixIcon: Icon(
            Icons.search,
            color: AppConstants.textSecondaryColor,
            size: AppConstants.iconSizeMedium,
          ),
          suffixIcon: _hasText
              ? IconButton(
                  onPressed: _clearText,
                  icon: Icon(
                    Icons.clear,
                    color: AppConstants.textSecondaryColor,
                    size: AppConstants.iconSizeMedium,
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusLarge),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: AppConstants.surfaceColor,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingMedium,
            vertical: AppConstants.paddingMedium,
          ),
        ),
        style: AppConstants.bodyMedium,
        textInputAction: TextInputAction.search,
      ),
    );
  }
}
