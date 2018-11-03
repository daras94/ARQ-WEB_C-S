var dat = {
	ticket : [],
	menus  : []
};

function loadCarrito() {
	var x = '';
	// Check browser support
	if (typeof(Storage) !== "undefined") {
		var bd      = localStorage.getItem('bbdd')
		var session = sessionStorage.getItem('carrito');
		if (session !== null || bd !== null) {
			x += '<div id="c-box">';
			x += '<div id="view-ticket">';
			x += '<h1> - Tus entradas:</h1>'
			var tick = JSON.parse(session).ticket;
			if (tick.length > 0) {
				var cine = JSON.parse(bd).peliculas;
				for (var i = tick.length - 1; i >= 0; i--) {
					for (var j = cine.length - 1; j >= 0; j--) {
						var aux_cine = cine[j];
					 	if (aux_cine.idcine === tick[i]) {
					 		x += '<div id="box-cine">';
					    	x += '<img class="caratula" id="' + aux_cine.idcine + '" src="' + aux_cine.caratula + '" alt="'+ aux_cine.titulo +'">';
					    	x += '<div id="peli-info">';
					    	x += '<ul>';
					    	x += '<li><h2>' + aux_cine.titulo + '</h2></li>';
					    	x += '<ul>';
					    	x += '<li><p id="dur-info"><b>Duracion  : </b>' + aux_cine.duracion + ' mim</p></li>';
					    	x += '<li><p id="dir-info"><b>Direccion : </b>' + aux_cine.director + '</p></li>';
					    	x += '<li><p id="rep-info"><b>Reparto   : </b>' + aux_cine.reparto  + '</p></li>';
					    	x += '</ul>';
					    	x += '</ul>';
					    	x += '<div id="pases">'
					    	for (var k in aux_cine.pases) {
					    		x  += '<p class="tag">' + aux_cine.pases[k] + '</p>';
					    	}
					    	x += '</div>';
					    	x += '</div>';
					    	x += '<iframe width="600" height="325" src="https://www.youtube.com/embed/' + aux_cine.trailer + '"></iframe>';
					    	x += '</div>';
					 	}
					 } 
				}
			} else {
				x += '<div class="error">';
				x += '<p>No as añadido niguna entrada <a href="./cartelera_ej24y3.html">Ir a la cartelera</a>.</p>';
				x += '</div>';
			}
			x += '</div>';
			x += '<div id="view-ticket">';
			x += '<h1> - Tus Menus:</h1>'
			var total_menus  = 0;
			var eat = JSON.parse(session).menus;
			if (eat.length > 0) {
				var comida = JSON.parse(bd).menus;
				for (var i = eat.length - 1; i >= 0; i--) {
					for (var j = comida.length - 1; j >= 0; j--) {
						var aux_eat = comida[j];
						if (aux_eat.idmenu === eat[i]) {
							x += '<div id="box-menu">';
							x += '<img class="caratula" id="' + aux_eat.idmenu + '" src="' + aux_eat.icon + '" alt="' + aux_eat.titulo + '">';
							x += '<h1>' + aux_eat.titulo + '</h1>';
							x += '<div class="column">';
							x += '<ul>';
							x += '<li><h3><b>Primeros Platos:</b></h3>';
							x += '<ul>';
							for (var k = aux_eat.primeros.length - 1; k >= 0; k--) {
								x  += '<li>' + aux_eat.primeros[j] + '</li>';
							}
							x += '</ul>';
							x += '</li>';
							x += '<ul>';
							x += '</div>';
							x += '<div class="column">';
							x += '<ul>';
							x += '<li><h3><b>Segundos Platos:</b></h3>';
							x += '<ul>';
							for (var j = aux_eat.segundos.length - 1; j >= 0; j--) {
								x  += '<li>' + aux_eat.segundos[j] + '</li>';
							}
							x += '</ul>';
							x += '</li>';
							x += '<ul>';
							x += '</div>';
							x += '<div id="postres"><p class="tag"><b>Postres:</b></p>'
							for (var j = aux_eat.postres.length - 1; j >= 0; j--) {
								x  += '<p class="tag">' + aux_eat.postres[j] + ',</p>';
							}
							x += '</div>';
							x += '<p id="precio"><input type="text" value="' + aux_eat.precio + '€" id="a_pagar"></p>	'
					    	x += '</div>';
					    	total_menus += aux_eat.precio;
						}
					}
				}
			} else {
				x += '<div class="error">';
				x += '<p>No as añadido niguna menu de nuestro restaurante <a href="./restaurant_ej24y3.html">Ir Restaurante</a>.</p>';
				x += '</div>';
			}
			x += '</div>';
			x += '</div>';
			document.getElementById("precio-2").value = (eat.length * 6.30) + total_menus;
		} else {
			if (sessionStorage.getItem('carrito') === null) {
	    		sessionStorage.setItem("carrito", JSON.stringify(dat));
		    } 
		    loadCarrito();
		}
	    document.getElementById("view-carrito").innerHTML = x;
	} else {
	    document.getElementById("view-carrito").innerHTML = "Sorry, your browser does not support Web Storage...";
	}
}


function pagar() {
	sessionStorage.clear();
	if (sessionStorage.getItem('carrito') === null) {
    	sessionStorage.setItem("carrito", JSON.stringify(dat));
    } 
	loadCarrito();
}



