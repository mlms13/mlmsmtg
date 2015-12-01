package app.views;

import thx.ReadonlyArray;

enum AppState {
  Loading;
  Error(msg : String);
  Data(data : ReadonlyArray<Card>);
}
