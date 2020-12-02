part of flutter_widget_model;

/// Hook to update the screen.
RefreshController useRefresh() {
  return use(_RefreshHook());
}

class _RefreshHook extends Hook<RefreshController> {
  _RefreshHook();
  @override
  _RefreshHookState createState() => _RefreshHookState();
}

class _RefreshHookState extends HookState<RefreshController, _RefreshHook> {
  RefreshController _controller;
  @override
  void initHook() {
    super.initHook();
    this._controller = RefreshController._(state: this);
  }

  void _refresh() {
    this.setState(() {});
  }

  @override
  RefreshController build(BuildContext context) {
    return this._controller;
  }
}

class RefreshController {
  final _RefreshHookState _state;
  RefreshController._({_RefreshHookState state}) : this._state = state;

  void refresh() {
    this._state?._refresh();
  }
}
