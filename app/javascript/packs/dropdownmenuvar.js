document.addEventListener("turbolinks:load", function() {
    const userMenu = document.querySelector('.homepage-user-menu');
    const dropdownMenu = userMenu.querySelector('.dropdown-menu');
  
    // アイコンまたは名前をクリックしたときにメニューを表示/非表示にする
    userMenu.addEventListener('click', function(event) {
      // メニューが表示されている場合は非表示にする
      if (dropdownMenu.style.display === 'block') {
        dropdownMenu.style.display = 'none';
      } else {
        dropdownMenu.style.display = 'block';
      }
    });
    // メニュー外をクリックしたときにメニューを閉じる
    document.addEventListener('click', function(event) {
      if (!userMenu.contains(event.target)) {
        dropdownMenu.style.display = 'none';
      }
    });
  });
  
  

