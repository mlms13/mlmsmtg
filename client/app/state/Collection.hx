package app.state;

import haxe.ds.Option;
import thx.Convert;

class Collection {
  public var name(default, null) : String;
  public var cards(default, null) : Array<Card>;
  public var collections(default, null) : Array<Collection>;
  public var meta(default, null) : Option<ReleaseSetMeta>;

  public function new(data : CollectionRaw) {
    this.name = data.name;
    this.cards = data.cards != null ? data.cards : [];
    this.collections = data.collections != null ? data.collections : [];
    this.meta = data.meta;
  }

  public static function fromDynamic(data : Dynamic) : Collection {
    return new Collection({
      name : data.name,
      cards : Convert.toArray(data.cards, Card.fromDynamic),
      collections : data.collections != null ?
        Convert.toArray(data.collections, Collection.fromDynamic) : [],
      meta : data.code != null ? Some({
        code : data.code,
        releaseDate : Convert.toDate(data.releaseDate),
        border : data.border,
        type : data.type,

        // FIXME: skipping this because [["mythic", "rare"], "uncommon", "..."]
        // is not an easy data structure to deal with
        // booster : Convert.toArrayString(data.booster),
      }) : None
    });
  }
}

typedef CollectionRaw = {
  name : String,
  ?cards : Array<Card>,
  ?collections : Array<Collection>,
  meta : Option<ReleaseSetMeta>
};

typedef ReleaseSetMeta = {
  code : String,
  releaseDate : Date,
  border : String, // TODO: enum, but not sure what the values are
  type : String, // TODO: also enum

  // actually, Array<Either<Array<String>, String>>
  // booster : Array<String> // TODO: again enum
}
