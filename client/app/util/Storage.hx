package app.util;

import npm.lf.Schema;
import npm.lf.schema.ConnectOptions;
using thx.promise.Promise;

class Storage {
  public static function init() {
    Storage.createSetTable();
    Storage.createCardTable();
    Storage.connect();
  }

  static function createDeckBuilder() {
    return Schema.create('deckbuilder', 1);
  }

  public static function createSetTable() {
    var builder = createDeckBuilder();
    builder.createTable('Set')
      .addColumn('name', npm.lf.Type.STRING)
      .addColumn('code', npm.lf.Type.STRING)
      .addColumn('gathererCode', npm.lf.Type.STRING)
      .addColumn('magicCardsInfoCode', npm.lf.Type.STRING)
      .addColumn('releaseDate', npm.lf.Type.DATE_TIME)
      .addColumn('border', npm.lf.Type.STRING)
      .addColumn('type', npm.lf.Type.STRING)
      .addColumn('booster', npm.lf.Type.ARRAY_BUFFER)
      .addColumn('cards', npm.lf.Type.ARRAY_BUFFER)
      .addPrimaryKey(['code']);
  }

  public static function createCardTable() {
    var builder = createDeckBuilder();
    builder.createTable('Card')
      .addColumn('artist', npm.lf.Type.STRING)
      .addColumn('cmc', npm.lf.Type.INTEGER)
      .addColumn('colors', npm.lf.Type.ARRAY_BUFFER)
      .addColumn('flavor', npm.lf.Type.STRING)
      .addColumn('id', npm.lf.Type.STRING)
      .addColumn('imageName', npm.lf.Type.STRING)
      .addColumn('layout', npm.lf.Type.STRING)
      .addColumn('manaCost', npm.lf.Type.STRING)
      .addColumn('multiverseid', npm.lf.Type.INTEGER)
      .addColumn('name', npm.lf.Type.STRING)
      .addColumn('power', npm.lf.Type.STRING)
      .addColumn('rarity', npm.lf.Type.STRING)
      .addColumn('subtypes', npm.lf.Type.ARRAY_BUFFER)
      .addColumn('text', npm.lf.Type.STRING)
      .addColumn('toughness', npm.lf.Type.STRING)
      .addColumn('type', npm.lf.Type.STRING)
      .addColumn('types', npm.lf.Type.ARRAY_BUFFER)
      .addPrimaryKey(['id']);
    return builder;
  }

  public static function connect(?opts : ConnectOptions) : Promise<npm.lf.Database> {
    return createDeckBuilder().connect(opts).promise();
  }
}
