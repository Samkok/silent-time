import 'dart:io';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

class FileLogger {
  static const int _maxFileSizeInBytes = 5 * 1024 * 1024; // 5 MB
  static const int _maxLogFiles = 5;

  final Logger _logger = Logger("FileLogger");
  IOSink? _sink;
  late File _logFile;

  FileLogger._internal();

  static final FileLogger _instance = FileLogger._internal();

  factory FileLogger() => _instance;

  Future<void> init() async {
    final directory = await getApplicationDocumentsDirectory();
    _logFile = File('${directory.path}/app.log');
    print("Directory path: $directory");
    _sink = _logFile.openWrite(mode: FileMode.append);
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen((LogRecord rec) {
      final logMessage = '${rec.level.name}: ${rec.time}: ${rec.message}';
      _writeLog(logMessage);
    });

    _logger.info('Logger initialized.');
  }

  void _writeLog(String message) async {
    if (_logFile.existsSync() && await _logFile.length() > _maxFileSizeInBytes) {
      await _rotateLogs();
    }
    _sink?.writeln(message);
  }

  Future<void> _rotateLogs() async {
    await _sink?.close();

    for (int i = _maxLogFiles - 1; i > 0; i--) {
      final olderFile = File('${_logFile.path}.$i');
      final newerFile = File('${_logFile.path}.${i + 1}');
      if (olderFile.existsSync()) {
        olderFile.renameSync(newerFile.path);
      }
    }

    _logFile.renameSync('${_logFile.path}.1');
    _logFile = File(_logFile.path); // Create a new log file
    _sink = _logFile.openWrite(mode: FileMode.append);
  }

  void dispose() {
    _sink?.close();
  }
}
