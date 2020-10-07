part of flutter_widget_model;

class _ModelHook<Created extends Object> extends Hook<Created> {
  const _ModelHook(this.model, this.initialValue);

  final Model<Created> model;
  final Created initialValue;

  @override
  _ModelHookState<Created> createState() =>
      _ModelHookState<Created>(this.model);
}

class _ModelHookState<Created extends Object>
    extends HookState<Created, _ModelHook<Created>> {
  Created _state;
  _ModelHookState(Model<Created> model);
  @override
  void initHook() {
    super.initHook();
    this._update();
  }

  void _update() {
    this._listener(hook.initialValue);
    Future<Created> future = hook.model.createTask(hook.model.context);
    if (future == null) return;
    future.then(this._listener);
  }

  @override
  void dispose() {
    hook.model?.removeListener(this._state, this._listener);
    super.dispose();
  }

  @override
  Created build(BuildContext context) {
    return this._state;
  }

  void _listener(dynamic value) {
    this._state = value;
    hook.model?.addListener(this._state, this._listener);
    setState(() {});
  }

  @override
  Object get debugValue => _state;

  @override
  String get debugLabel => 'usePath';
}
