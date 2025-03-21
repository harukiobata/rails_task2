document.addEventListener('turbolinks:load', function () {
    const modal = document.getElementById('modalDelete');
    const roomTitleElement = document.getElementById('room-name');
    const roomPriceElement = document.getElementById('room-price');
    const roomImageElement = document.getElementById('room-image');
    const confirmDeleteButton = document.getElementById('confirmDelete');
    const cancelDeleteButton = document.getElementById('cancelDeleteButton');

    // 削除対象のIDを保持する変数
    let roomIdToDelete = null;

    // 削除リンクをクリックしたときの処理
    function setupDeleteLinks() {
        const deleteButtons = document.querySelectorAll('.open-modal-delete');  // 削除リンクを取得
        deleteButtons.forEach(button => {
            button.addEventListener('click', function (e) {
                e.preventDefault();  // デフォルトのリンクの挙動を防ぐ
                roomIdToDelete = this.dataset.roomId;  // 削除する投稿のIDを取得
                const roomName = this.dataset.roomName;  // 削除する投稿の名前を取得
                const roomPrice = this.dataset.roomPrice;  // 削除する投稿の価格を取得
                const roomImage = this.dataset.roomImage;  // 削除する投稿の画像URLを取得

                // モーダルのタイトル部分に投稿タイトルを挿入
                roomTitleElement.textContent = `施設名:${roomName}`;
                roomPriceElement.textContent = `¥${roomPrice}~/日`;

                // 画像のURLを設定
                roomImageElement.src = roomImage;

                // モーダル表示
                modal.style.display = 'block';
            });
        });
    }
    
    
    // 削除ボタンがクリックされたときの処理
    if (confirmDeleteButton) {
        confirmDeleteButton.addEventListener('click', function () {
            if (!roomIdToDelete) return;  // 削除対象が設定されていない場合は何もしない

            // 動的にフォームを作成して送信
            const form = document.createElement('form');
            form.method = 'POST';
            form.action = `/rooms/${roomIdToDelete}`;

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
