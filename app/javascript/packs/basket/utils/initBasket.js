import { initQuantityButtons } from '../modal/changeQuantityButton'
import { initCloseBasketButton } from '../modal/closeBasketButton'
import { initOpenBasketButton } from '../modal/shoppingCartButton'
import { initRemoveButton } from '../modal/removeButton'

export function initBasket() {
  $(() => {
    initQuantityButtons();
    initCloseBasketButton();
    initOpenBasketButton();
    initRemoveButton();
  });
}
