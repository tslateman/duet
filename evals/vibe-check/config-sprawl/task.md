Vibe check this logging setup module.

```python
# src/logging_config.py
import logging
import logging.handlers
import os
import json
from pathlib import Path
from abc import ABC, abstractmethod


class LogFormatter(ABC):
    @abstractmethod
    def format(self, record):
        pass


class JSONFormatter(LogFormatter, logging.Formatter):
    def format(self, record):
        log_data = {
            "timestamp": self.formatTime(record),
            "level": record.levelname,
            "message": record.getMessage(),
            "module": record.module,
            "function": record.funcName,
            "line": record.lineno,
        }
        if record.exc_info:
            log_data["exception"] = self.formatException(record.exc_info)
        return json.dumps(log_data)


class TextFormatter(LogFormatter, logging.Formatter):
    def format(self, record):
        return f"[{self.formatTime(record)}] {record.levelname} {record.module}:{record.lineno} - {record.getMessage()}"


class LogHandlerFactory:
    @staticmethod
    def create_console_handler(formatter_type="text"):
        handler = logging.StreamHandler()
        if formatter_type == "json":
            handler.setFormatter(JSONFormatter())
        else:
            handler.setFormatter(TextFormatter())
        return handler

    @staticmethod
    def create_file_handler(filename, formatter_type="json"):
        os.makedirs(os.path.dirname(filename), exist_ok=True)
        handler = logging.handlers.RotatingFileHandler(
            filename, maxBytes=10485760, backupCount=5
        )
        if formatter_type == "json":
            handler.setFormatter(JSONFormatter())
        else:
            handler.setFormatter(TextFormatter())
        return handler

    @staticmethod
    def create_error_handler(filename):
        os.makedirs(os.path.dirname(filename), exist_ok=True)
        handler = logging.handlers.RotatingFileHandler(
            filename, maxBytes=10485760, backupCount=5
        )
        handler.setLevel(logging.ERROR)
        handler.setFormatter(JSONFormatter())
        return handler


def setup_logging(app_name="app"):
    log_dir = os.environ.get("LOG_DIR", f"/var/log/{app_name}")
    log_level = os.environ.get("LOG_LEVEL", "INFO")
    log_format = os.environ.get("LOG_FORMAT", "json")

    root_logger = logging.getLogger()
    root_logger.setLevel(getattr(logging, log_level))

    root_logger.addHandler(
        LogHandlerFactory.create_console_handler(log_format)
    )
    root_logger.addHandler(
        LogHandlerFactory.create_file_handler(f"{log_dir}/app.log", log_format)
    )
    root_logger.addHandler(
        LogHandlerFactory.create_error_handler(f"{log_dir}/error.log")
    )

    logging.getLogger("urllib3").setLevel(logging.WARNING)
    logging.getLogger("requests").setLevel(logging.WARNING)

    return root_logger
```
