package app;

import app.Action;
import app.State;
import app.state.*;
import lies.Reduced;
using thx.Arrays;
using thx.Iterators;
import thx.http.Request;
import thx.http.RequestInfo;
using thx.promise.Future;

class Reducers {
  public static function mtgApp(state : State, action : Action) {
    return switch action {
      case RequestInitialData: getCards(state);
      case DataLoaded(Success(collection)): Reduced.fromState(BrowseCards(collection));
      case DataLoaded(Failure(err)): Reduced.fromState(ErrorView(err));
    };
  }

  static function getCards(state) {
    var info = new RequestInfo(Get, thx.Url.fromString("/api/cards"));

    var futureOfCards = Request.make(info).mapEitherFuture(function (res) {
      return res.asString().mapEither(function (body : String) {
        try {
          var json = haxe.Json.parse(body),
              collections = thx.Convert.toMap(json, ReleaseSet.fromDynamic);

          return DataLoaded(Success(Collection.fromDynamic({
            name : "All cards",
            cards : collections.iterator().reduce(function (acc : Array<Card>, coll) {
              return acc.concat(coll.cards);
            }, []).distinct()
          })));

        } catch(err : thx.Error) {
          trace(err);
          return DataLoaded(Failure(err));
        }
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
