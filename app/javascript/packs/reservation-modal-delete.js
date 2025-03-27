document.addEventListener('turbolinks:load', function () {
    const modal = document.getElementById('reservationModalDelete');
    const roomNameElement = document.getElementById('reservation-room-name'); // 変数名を変更
    const roomPriceElement = document.getElementById('reservation-room-price');
    const roomImageElement = document.getElementById('reservation-room-image');
    const checkInDateElement = document.getElementById('reservation-check-in-date');
    const checkOutDateElement = document.getElementById('reservation-check-out-date');
    const numberOfPeopleElement = document.getElementById('reservation-number-of-people');
    const confirmDeleteButton = document.getElementById('reservation-confirm-delete');
    const cancelDeleteButton = document.getElementById('reservation-cancel-delete-button');
  
    // 削除対象の予約IDを保持する変数
    let reservationIdToDelete = null;
  
    // 削除リンクをクリックしたときの処理
    function setupDeleteLinks() {
      const deleteButtons = document.querySelectorAll('.open-reservation-modal'); // 削除リンクを取得
      deleteButtons.forEach(button => {
        button.addEventListener('click', function (e) {
          e.preventDefault();  // デフォルトのリンクの挙動を防ぐ
  
          // 削除する予約の情報を取得
          reservationIdToDelete = this.dataset.reservationId;
          const roomName = this.dataset.roomName;
          const roomPrice = this.dataset.roomPrice;
          const roomImage = this.dataset.roomImage;
          const checkInDate = this.dataset.checkInDate;
          const checkOutDate = this.dataset.checkOutDate;
          const numberOfPeople = this.dataset.numberOfPeople;
  
          // モーダルに予約情報を表示
          roomNameElement.textContent = `施設名: ${roomName}`; // 変数名を変更
          roomPriceElement.textContent = `¥${roomPrice}~/日`;
          checkInDateElement.textContent = `チェックイン日: ${checkInDate}`;
          checkOutDateElement.textContent = `チェックアウト日: ${checkOutDate}`;
          numberOfPeopleElement.textContent = `宿泊人数: ${numberOfPeople}人`;
          roomImageElement.src = roomImage;
  
          // モーダル表示
          modal.style.display = 'block';
        });
      });
    }
  
    // 削除ボタンがクリックされたときの処理
    if (confirmDeleteButton) {
      confirmDeleteButton.addEventListener('click', function () {
        if (!reservationIdToDelete) return;  // 削除対象が設定されていない場合は何もしない
  
        // 動的にフォームを作成して送信
        const form = document.createElement('form');
        form.method = 'POST';
        form.action = `/reservations/${reservationIdToDelete}`;
  
        // CSRFトークンを追加
        const csrfToken = document.querySelector('[name="csrf-token"]').content;
        const csrfInput = document.createElement('input');
        csrfInput.type = 'hidden';
        csrfInput.name = 'authenticity_token';
        csrfInput.value = csrfToken;
        form.appendChild(csrfInput);
  
        // DELETEメソッド用の隠しフィールドを追加
        const methodInput = document.createElement('input');
        methodInput.type = 'hidden';
        methodInput.name = '_method';
        methodInput.value = 'DELETE';
        form.appendChild(methodInput);
  
        // フォームを送信
        document.body.appendChild(form);
        form.submit();
      });
    }
  
    // モーダル外をクリックしたとき
    window.addEventListener('click', function (event) {
      if (event.target === modal) {
        modal.style.display = 'none';  // モーダルを非表示
      }
    });
  
    // キャンセルボタンがクリックされたとき
    if (cancelDeleteButton) {
      cancelDeleteButton.addEventListener('click', function () {
        modal.style.display = 'none';  // モーダルを非表示にする
      });
    }
  
    // ページが読み込まれるたびに削除リンクを再設定
    setupDeleteLinks();
  });
  