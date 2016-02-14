package app.storage;

import app.state.*;
import haxe.ds.Option;
import thx.OrderedMap;
import thx.promise.Promise;

class Memory implements IStorage {
  var collections : Array<Collection>;

  public function new() {
    collections = [];
  }

  public function saveCollection(collection : Collection) {
    trace('saving collection');
    collections.push(collection);
    return Promise.nil;
  }

  public function getDefaultCollection() {
    return collections.length == 0 ?
      Promise.value(Option.None) :
      Promise.value(Option.Some(collections[0]));
  }
}
