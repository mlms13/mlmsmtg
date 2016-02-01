package app.state;

import thx.Convert;

class Collection {
  public var name(default, null) : String;
  public var cards(default, null) : Array<Card>;

  public function new(data : CollectionRaw) {
    this.name = data.name;
    this.cards = data.cards;
  }

  public static function fromDynamic(data : Dynamic) {
    return new Collection({
      name : data.name,
      cards : Convert.toArray(data.cards, Card.fromDynamic)
    });
  }
}

typedef CollectionRaw = {
  name : String,
  cards : Array<Card>
};
