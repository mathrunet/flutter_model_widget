part of flutter_widget_model;

/// Widget that displays loading if no data has been loaded.
class ModelBuilder<T extends Model> extends HookWidget {
  /// Model data.
  final T model;

  /// Builder when the data is empty.
  final WidgetBuilder empty;

  /// Loading indicator color.
  final Color indicatorColor;

  /// Builder when waiting for a task.
  final Widget Function(BuildContext context, T data) waiting;

  /// Builder when the task is completed.
  final Widget Function(BuildContext context, T data) builder;

  /// Widget that displays loading if no data has been loaded.
  ///
  /// [model]: Model data.
  /// [empty]: Builder when the data is empty.
  /// [indicatorColor]: Loading indicator color.
  /// [waiting]: Builder when waiting for a task.
  /// [child]: Builder when the task is completed.
  ModelBuilder(
      {this.model,
      this.empty,
      this.indicatorColor,
      this.waiting,
      @required this.builder});

  /// Build method.
  ///
  /// [BuildContext]: Build Context.
  @override
  Widget build(BuildContext context) {
    if (this.model == null || this.model.state == null) {
      return this._buildInternal(context);
    } else if ((this.model.state is Future) &&
        !(this.model.state as Future).isCompleted) {
      return FutureBuilder<ITask>(
        future: this.model.state as Future,
        builder: (context, snapshot) {
          return this._buildInternal(context, snapshot);
        },
      );
    } else if (this.model.state is ITask &&
        !(this.model.state as ITask).isDone) {
      return FutureBuilder<ITask>(
        future: (this.model.state as ITask).future,
        builder: (context, snapshot) {
          return this._buildInternal(context, snapshot);
        },
      );
    } else {
      return this.builder(context, this.model);
    }
  }

  Widget _buildInternal(BuildContext context, [AsyncSnapshot<ITask> snapshot]) {
    if (snapshot == null || !snapshot.hasData || snapshot.data == null) {
      if (this.empty != null) {
        Widget widget = this.empty(context);
        if (widget != null) return widget;
      }
      return Center(
          child: LoadingBouncingGrid.square(
              backgroundColor:
                  this.indicatorColor ?? Theme.of(context).disabledColor));
    } else if (snapshot.connectionState != ConnectionState.done) {
      if (this.waiting != null) {
        Widget widget = this.waiting(context, this.model);
        if (widget != null) return widget;
      }
      return Center(
          child: LoadingBouncingGrid.square(
              backgroundColor:
                  this.indicatorColor ?? Theme.of(context).disabledColor));
    } else {
      return this.builder(context, this.model);
    }
  }
}
