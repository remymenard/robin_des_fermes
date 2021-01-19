import 'select2';

const initSelect2 = () => {
  $('select').each((_index, select) => {
    $(select).select2();
    }
  )};

export { initSelect2 };
