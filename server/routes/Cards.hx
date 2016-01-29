package routes;

import abe.App;

@:path("/cards")
class Cards implements abe.IRoute{
  @:get("/")
  function getCards() {
    response.sendFile('AllCards.json', { root : './public' });
  }
}
