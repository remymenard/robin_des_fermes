import { initQuantityButtons } from '../modal/changeQuantityButton'
import { initCloseBasketButton } from '../modal/closeBasketButton'
import { initOpenBasketButton } from '../modal/shoppingCartButton'
import { initRemoveButton } from '../modal/removeButton'
import { initAddToBasketButton } from '../pages/addToBasketButton';
import { updateNavbarInfos } from './updateNavbarInfos';
import { reviewBasketButtons } from '../pages/reviewBasketButtons';

export function initBasket() {
  $(() => {
    initQuantityButtons();
    initCloseBasketButton();
    initOpenBasketButton();
    initRemoveButton();
    initAddToBasketButton();
    updateNavbarInfos();
    reviewBasketButtons();
  });
}
