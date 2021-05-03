// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// 無限スクロール
document.querySelectorAll('.scroll').forEach(elm => {
	elm.onscroll = function () {
		if (this.scrollTop + this.clientHeight >= this.scrollHeight) {
			//スクロールが末尾に達した
			if (parseInt(this.dataset.lastnum) < parseInt(this.dataset.max)) {
				//未ロードの画像がある場合
				this.dataset.lastnum = parseInt(this.dataset.lastnum) + 1;
				let img = document.createElement('img');
				img.src =  this.dataset.lastnum +'.jpg';
				this.appendChild(img);
			}
		}
	};
});