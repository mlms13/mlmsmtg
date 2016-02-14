package app.view;

import haxe.ds.Option;
import app.state.Collection;
import app.state.Card;
import app.Action;
import Doom.*;
using thx.Arrays;

class CardCollection extends Doom {
  @:state var collection : app.state.Collection;

  override function render() {
    // TODO: optionally receive viewMode as part of @state
    var viewMode = determineViewMode(collection, Option.None);

    trace(viewMode);

    return div([ "class" => "mtg-collection-container" ], [
      collectionHeader(collection),
      collectionBody(collection, viewMode)
    ]);
  }

  function getAllCollectionCards(collection : Collection) : Array<Card> {
     return collection.collections.reduce(function (cards : Array<Card>, sub) {
       return cards.concat(getAllCollectionCards(sub));
     }, collection.cards);
  }

  function determineViewMode(collection : Collection, mode : Option<CollectionView>) {
    return switch mode {
      case Some(view): view;
      case None:
        collection.collections.length > 5 ?
          SubCollectionOverview : SubCollectionTabs;
    }
  }

  function collectionHeader(collection : Collection) {
    return div([ "class" => "collection-header"], [
      h2(collection.name)
    ]);
  }

  function collectionBody(collection : Collection, mode : CollectionView) {
    return switch mode {
      case SubCollectionOverview: subCollectionOverview(collection);
      case SubCollectionTabs: subCollectionTabs(collection);
    }
  }

  function subCollectionOverview(collection : Collection) {
    return div( ["class" => "sub-collections"], collection.collections.slice(0, 20).map(function (sub) {
      return div([ "class" => "collection-overview" ], [
        h3(sub.name),
        ul(getAllCollectionCards(sub).slice(0, 10).map(function (card) {
          return li(app.view.Card.with(card));
        }))
      ]);
    }));
  }

  function subCollectionTabs(colleciton : Collection) {
    return div([ "class" => "nav-tabs"]);
  }
}

enum CollectionView {
  // default view for a collection with lots and lots of sub-collections
  SubCollectionOverview;

  // view for collection with < 6 sub-collections
  SubCollectionTabs;
}
