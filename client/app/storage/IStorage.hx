package app.storage;

import app.state.*;
import haxe.ds.Option;
import thx.Nil;
import thx.promise.Promise;

interface IStorage {
  public function saveCollection(collection : Collection) : Promise<Nil>;
  public function getDefaultCollection() : Promise<Option<Collection>>;
}
