function auto_calc (){
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    const addTaxDom = document.getElementById("add-tax-price")
    addTaxDom.innerHTML =  Math.floor(inputValue / 10)
    const addTotal = document.getElementById("profit")
    addTotal.innerHTML = (inputValue - addTaxDom.innerHTML)
  })
}
window.addEventListener('load', auto_calc);