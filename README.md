A utility library for error prone situtations like JSON deserialization and other extensions on
existing (3rd party) libraries

## Features

- **JsonUtils**: Shorthand functions to deserialize a JSON string into different collection types
- **Logging**
    - *LoggingConfig*: A wrapper around the Logger class of the `logger` package, introducing
      mutable
      log levels
    - *PrefixPrinter*: A LogPrinter used to always add a prefix to any logs of the provided
      LogPrinter

## Usage

### Logging

```dart
// Construct a LoggingConfig
final config = LoggingConfig();
final logger = config.logger;
logger.d("Some message, that won't be printed because the default log level is Level.info");
config.level = Level.debug;
logger.d("Another message, that will be printed this time");
```
