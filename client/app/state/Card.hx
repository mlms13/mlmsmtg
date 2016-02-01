package app.state;

import thx.Convert;

class Card {
  public var artist(default, null) : String;
  public var cmc(default, null) : Int;
  public var colors(default, null) : Array<String>;
  public var flavor(default, null) : String;
  public var id(default, null) : String;
  public var imageName(default, null) : String;
  public var layout(default, null) : String;
  public var manaCost(default, null) : String;
  public var multiverseid(default, null) : Int;
  public var name(default, null) : String;
  public var power(default, null) : String;
  public var rarity(default, null) : String;
  public var subtypes(default, null) : Array<String>;
  public var text(default, null) : String;
  public var toughness(default, null) : String;
  public var type(default, null) : String;
  public var types(default, null) : Array<String>;

  public function new(data : CardRaw) {
    this.artist = data.artist;
    this.cmc = data.cmc;
    this.colors = data.colors;
    this.flavor = data.flavor;
    this.id = data.id;
    this.imageName = data.imageName;
    this.layout = data.layout;
    this.manaCost = data.manaCost;
    this.multiverseid = data.multiverseid;
    this.name = data.name;
    this.power = data.power;
    this.rarity = data.rarity;
    this.subtypes = data.subtypes;
    this.text = data.text;
    this.toughness = data.toughness;
    this.type = data.type;
    this.types = data.types;
  }

  public static function fromDynamic(data : Dynamic) {
    return new Card({
      artist : data.artist,
      cmc : data.cmc,
      colors : Convert.toArrayString(data.colors),
      flavor : data.flavor,
      id : data.id,
      imageName : data.imageName,
      layout : data.layout,
      manaCost : data.manaCost,
      multiverseid : data.multiverseid,
      name : data.name,
      power : data.power,
      rarity : data.rarity,
      subtypes : Convert.toArrayString(data.subtypes),
      text : data.text,
      toughness : data.toughness,
      type : data.type,
      types : Convert.toArrayString(data.types)
    });
  }
}

typedef CardRaw = {
  artist : String,
  cmc : Int,
  colors : Array<String>,
  flavor : String,
  id : String,
  imageName : String,
  layout : String,
  manaCost : String,
  multiverseid : Int,
  name : String,
  power : String,
  rarity : String,
  subtypes : Array<String>,
  text : String,
  toughness : String,
  type : String,
  types : Array<String>
}
