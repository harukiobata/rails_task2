document.addEventListener("turbolinks:load", function () {
    const modal = document.getElementById("error-message-modal");
  
    // 5秒後にモーダルを自動で閉じる
    if (modal) {
        // 5秒後にモーダルを自動で閉じる
        setTimeout(function() {
          modal.classList.remove("show");
        }, 5000);
    }
  });