package app.state;

import thx.Convert;

class ReleaseSet extends Collection {
  public var code(default, null) : String;
  public var releaseDate(default, null) : Date;
  public var border(default, null) : String; // TODO: enum, but not sure what the values are,
  public var type(default, null) : String; // TODO: also enum,
  public var booster(default, null) : Array<String>; // TODO: again enum

  public function new(data : ReleaseSetRaw) {
    super(data);

    this.code = data.code;
    this.releaseDate = data.releaseDate;
    this.border = data.border;
    this.type = data.type;
    this.booster = data.booster;
    this.cards = data.cards;
  }

  public static function fromDynamic(data : Dynamic) {
    var coll = Collection.fromDynamic(data);
    return {
      name : coll.name,
      code : data.code,
      releaseDate : Convert.toDate(data.releaseDate),
      border : data.border,
      type : data.type,
      booster : Convert.toArrayString(data.booster),
      cards : coll.cards
    };
  }
}

typedef ReleaseSetRaw = { > Collection.CollectionRaw,
  code : String,
  releaseDate : Date,
  border : String,
  type : String,
  booster : Array<String>
};
