document.addEventListener("turbolinks:load", function () {
    const modal = document.getElementById("error-modal");
  
    // 5秒後にモーダルを自動で閉じる
    setTimeout(function() {
      if (modal.style.display !== "none") {
        modal.style.display = "none";
      }
    }, 5000); 
  });
  