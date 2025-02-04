library;

import 'package:logger/logger.dart';
import 'package:meta/meta.dart';

/// Configuration class for a [Logger]
class LoggingConfig {
  Logger? _logger;

  late final LogFilter _filter;
  late final LogPrinter _printer;

  LoggingConfig(
      {LogFilter? filter, Level logLevel = Level.info, LogPrinter? printer}) {
    _filter = filter ?? ProductionFilter();
    _filter.level = logLevel;
    _printer = printer ?? SimplePrinter(printTime: true, colors: true);
  }

  LoggingConfig.prefix(
      {LogFilter? filter,
      Level logLevel = Level.info,
      required String prefix,
      required LogPrinter printer})
      : this(
            filter: filter,
            logLevel: logLevel,
            printer: PrefixPrinter(prefix, printer));

  LoggingConfig.pretty(
      {LogFilter? filter,
      Level logLevel = Level.info,
      required String prefix,
      PrettyPrinter? printer})
      : this(
            filter: filter,
            logLevel: logLevel,
            printer: PrefixPrinter.pretty(prefix, printer: printer));

  /// Change the [Level] of the logger
  set level(Level? level) => _filter.level = level;

  /// Get the current [Level] of the logger
  Level? get level => _filter.level;

  /// Get the [Logger] as a singleton
  Logger get logger {
    _logger ??= createLogger(_filter);
    return _logger!;
  }

  @protected
  Logger createLogger(LogFilter filter) {
    return Logger(filter: filter, printer: _printer);
  }
}

class PrefixPrinter extends LogPrinter {
  final String prefix;
  final LogPrinter _realPrinter;

  PrefixPrinter(this.prefix, this._realPrinter);

  factory PrefixPrinter.pretty(final String prefix,
      {final PrettyPrinter? printer}) {
    PrettyPrinter pretty = printer ??
        PrettyPrinter(
            methodCount: 0,
            errorMethodCount: 2,
            noBoxingByDefault: true,
            printEmojis: false);
    return PrefixPrinter(prefix, pretty);
  }

  @override
  List<String> log(LogEvent event) {
    List<String> logs = _realPrinter.log(event);
    return logs.map((l) => '$prefix: $l').toList();
  }
}

void main() {
  final config = LoggingConfig();
  final logger = config.logger;
  logger.d(
      "Some message, that won't be printed because the default log level is Level.info");
  config.level = Level.debug;
  logger.d("Another message, that will be printed this time");
}
