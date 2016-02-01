package routes;

import abe.App;

@:path("/cards")
class Cards implements abe.IRoute{
  @:get("/")
  function getCards() {
    response.sendFile('AllSets.json', { root : './public' });
  }
}
