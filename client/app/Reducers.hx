package app;

import app.Action;
import app.State;
import app.state.Card;
import lies.Reduced;
import thx.http.Request;
import thx.http.RequestInfo;
using thx.promise.Promise;
using thx.promise.Future;

class Reducers {
  public static function mtgApp(state : State, action : Action) {
    trace(action);
    return switch action {
      case RequestInitialData: getCards(state);
      case DataLoaded(Success(collection)): Reduced.fromState(BrowseCards(collection));
      case DataLoaded(Failure(err)): Reduced.fromState(ErrorView(err));
    };
  }

  static function getCards(state) {
    var info = new RequestInfo(Get, thx.Url.fromString("https://api.deckbrew.com/mtg/cards"));

    // TODO: async state magic
    var futureOfCards = Request.make(info).mapEitherFuture(function (res) {
      return res.asString().mapEither(function (body : String) {
        var json : Array<Card> = haxe.Json.parse(body);
        return DataLoaded(Success({
          name : "All cards",
          cards : json
        }));
      }, function (err : thx.Error) {
        trace(err);
        return DataLoaded(Failure(err));
      });
    }, function (err : thx.Error) {
      trace(err);
      return Future.value(DataLoaded(Failure(err)));
    });

    return Reduced.fromState(state).withFuture(futureOfCards);
  }
}
