// Copyright 2020 mathru. All rights reserved.

/// Package that allows you to treat your models like widgets.
/// Used with [flutter_hooks].
///
/// To use, import `package:flutter_widget_model/flutter_widget_model.dart`.
///
/// [mathru.net]: https://mathru.net
/// [YouTube]: https://www.youtube.com/c/mathrunetchannel
library flutter_widget_model;

import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:masamune_core/masamune_core.dart';
export 'package:masamune_core/masamune_core.dart';
export 'package:flutter_hooks/flutter_hooks.dart';
export 'package:flutter_hooks/flutter_hooks.dart';

part 'core/modelhook.dart';
part 'core/modelcontext.dart';
part 'core/model.dart';
part 'core/pathmodelmixin.dart';
part 'core/fieldmodel.dart';
part 'core/documentmodel.dart';
part 'core/collectionmodel.dart';
part 'core/documenthook.dart';
part 'core/collectionhook.dart';
part 'core/refreshhook.dart';

part 'component/datafieldmodel.dart';
part 'component/runtimedocumentmodel.dart';
part 'component/runtimecollectionmodel.dart';
part 'component/localdocumentmodel.dart';
part 'component/localcollectionmodel.dart';

part 'widget/modelbuilder.dart';
