document.addEventListener("turbolinks:load", function () {
    const modal = document.getElementById("success-modal1");
  
    // 5秒後にモーダルを自動で閉じる
    if (modal) {
        // 5秒後にモーダルを自動で閉じる
        setTimeout(function() {
          modal.classList.remove("show");
        }, 5000);
    }
  });