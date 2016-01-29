package app;

import app.state.*;

enum Action {
  RequestInitialData;
  DataLoaded(results : LoadResult);
  // Load;
}

enum LoadResult {
  Success(collection : Collection);
  Failure(error : thx.Error);
}
