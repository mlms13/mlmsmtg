package app.util;

import app.storage.IStorage;

class Config {
  public static var storage(default, null) : IStorage;

  public static function init(storage) {
    Config.storage = storage;
  }
}
