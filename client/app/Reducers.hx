package app;

import app.Action;
import app.State;
import app.state.*;
import app.util.Storage;
import lies.Reduced;
using thx.Arrays;
import thx.Error;
using thx.Iterators;
import thx.http.Request;
import thx.http.RequestInfo;
using thx.promise.Future;

class Reducers {
  public static function mtgApp(state : State, action : Action) {
    return switch action {
      case CheckForData: queryData(state);
      case RequestInitialData: loadDataFromServer(state);
      case DisplayNoCards: Reduced.fromState(NoCards);
      case DisplayCollection(collection): Reduced.fromState(BrowseCollection(collection));
      case DisplayError(err): Reduced.fromState(Error(err));
      case SaveCollection(collection): saveCollection(state, collection);
    };
  }

  static function queryData(state) {
    var nextAction = Storage.getDefaultCollection()
      .mapEither(function (collection) {
        return switch collection {
          case Some(collection): DisplayCollection(collection);
          case None: RequestInitialData;
        }
      }, function (err : Error) {
        return DisplayError(err);
      });

    return Reduced.fromState(state).withFuture(nextAction);
  }

  static function loadDataFromServer(state) {
    var info = new RequestInfo(Get, thx.Url.fromString("/api/cards"));

    var futureOfCards = Request.make(info).mapEitherFuture(function (res) {
      return res.asString().mapEither(function (body : String) {
        try {
          var json = haxe.Json.parse(body),
              collections = thx.Convert.toMap(json, Collection.fromDynamic);

          return SaveCollection(new Collection({
            name : "All sets",
            collections : collections.iterator().toArray(),
            meta : haxe.ds.Option.None
          }));

        } catch(err : Error) {
          trace(err);
          return DisplayError(err);
        }
      }, function (err : Error) {
        trace(err);
        return DisplayError(err);
      });
    }, function (err : Error) {
      trace(err);
      return Future.value(DisplayError(err));
    });

    return Reduced.fromState(state).withFuture(futureOfCards);
  }

  static function saveCollection(state, collection : Collection) {
    // TODO: ...
    return Reduced.fromState(state);
  }
}
