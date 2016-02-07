package app;

import app.state.*;

enum Action {
  CheckForData;
  RequestInitialData;
  SaveCollection(collection : Collection);
  DisplayCollection(collection : Collection);
  DisplayNoCards;
  DisplayError(err : thx.Error);
}
