part of flutter_widget_model;

class _ModelHook extends Hook<ModelContext> {
  const _ModelHook(this.model);

  final Model model;

  @override
  _ModelHookState createState() => _ModelHookState(this.model);
}

class _ModelHookState extends HookState<ModelContext, _ModelHook> {
  final ModelContext _context;
  _ModelHookState(Model model) : this._context = ModelContext._();
  @override
  void initHook() {
    super.initHook();
    this._update();
  }

  @override
  void didUpdateHook(_ModelHook oldHook) {
    super.didUpdateHook(oldHook);
    if (oldHook != hook && oldHook.model != hook.model) {
      this._update();
    }
  }

  void _update() {
    Future future = hook.model?.createTask();
    future?.then(
      (value) {
        _context?._subscription?.cancel();
        _context?._path?.unlisten(this._listener);
        if (value is IPath) {
          _context._path = value.listen(this._listener);
        } else if (value is Stream) {
          _context._subscription = value.listen(this._listener);
        }
      },
    );
  }

  @override
  void dispose() {
    _context?._path?.unlisten(this._listener);
    _context?._subscription?.cancel();
    super.dispose();
  }

  @override
  ModelContext build(BuildContext context) {
    return _context;
  }

  void _listener(dynamic value) {
    setState(() {});
  }

  @override
  Object get debugValue => _context;

  @override
  String get debugLabel => 'usePath';
}
