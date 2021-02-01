const pay = () => {
  // 公開鍵を環境変数へ
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY);
  // クレジットカード情報のトークン化を、送信ボタンクリック時に発火。
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();

    // ブラウザ上に表示されているフォームの情報を取得するための記述
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);

    // 生成したFormDataオブジェクトから、クレジットカードに関する情報を取得し、変数cardに代入するオブジェクトとして定義
    const card = {
      number: formData.get("address_buy[number]"),
      cvc: formData.get("address_buy[cvc]"),
      exp_month: formData.get("address_buy[exp_month]"),
      exp_year: `20${formData.get("address_buy[exp_year]")}`,
    };

console.log(card)

    // カード情報をPAY.JP側に送りトークン化
    // 第一引数のcardは、PAY.JP側に送るカードの情報で、直前で定義したカード情報のオブジェクトが入る
    // 第二引数のcallbackには、PAY.JP側からトークンが送付された後に実行する処理を記述
    Payjp.createToken(card, (status, response) => {
      if (status == 200) {

        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} name='token' type="hidden"> `;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }

      // フォームに存在するクレジットカードの各情報を削除
      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");
      // フォームの情報をサーバーサイドに送信
      document.getElementById("charge-form").submit();
    });
  });
};

// ページが読み込まれた時に、payという変数に代入したアロー関数が実行
window.addEventListener("load", pay);