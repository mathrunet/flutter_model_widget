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
import 'package:masamune_core/masamune_core.dart';
export 'package:flutter_hooks/flutter_hooks.dart';

part 'core/modelhook.dart';
part 'core/modelstate.dart';
part 'core/modelcontext.dart';
part 'core/model.dart';
part 'core/fieldmodel.dart';
part 'core/documentmodel.dart';
part 'core/collectionmodel.dart';

part 'component/datafieldmodel.dart';
part 'component/datadocumentmodel.dart';
part 'component/datacollectionmodel.dart';
part 'component/localdocumentmodel.dart';
part 'component/localcollectionmodel.dart';