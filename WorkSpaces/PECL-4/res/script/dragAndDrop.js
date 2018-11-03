var dat = {
	ticket : [],
	menus  : []
};

function allowDrop(ev) {
    ev.preventDefault();
}

function drag(ev) {
    ev.dataTransfer.setData("text", ev.target.id);
}

/************************************************************************
*	   {Funcion drag and drop con sesiones para pelcular y carrito}.    *
*************************************************************************/
function dropTicket(ev) {
    ev.preventDefault();
    var data  = ev.dataTransfer.getData("text");
    if (typeof(Storage) !== "undefined") {
    	var output = "";
	    if (sessionStorage.getItem('carrito') === null) {
	    	sessionStorage.setItem("carrito", JSON.stringify(dat));
	    } 
	    var carro = JSON.parse(sessionStorage.getItem('carrito'));
	    if (ev.target.id === 'drag') {
	   		carro.ticket.push(data);
	   		var bd = localStorage.getItem('bbdd');
	   		if (bd !== null) {
	   			var pelis    = JSON.parse(bd).peliculas;
	   			loop: for (var i = pelis.length - 1; i >= 0; i--) {
	   				if (pelis[i].idcine === data) {
	   					output =  '<b>Añadiste:</b> ' + pelis[i].titulo;
	   					break loop;
	   				}
	   			}
	   		}
	    } else if (ev.target.id === 'drop') {
	    	var index = carro.ticket.indexOf(data);
	    	if (index > -1) {
	    		carro.ticket.splice(index, 1);
	    	}
	    }
	    sessionStorage.setItem("carrito", JSON.stringify(carro));
	    document.getElementById("producto").innerHTML = output;
	} else {
		alert("Sorry, your browser does not support Web Storage..");
	}
    ev.target.appendChild(document.getElementById(data));
}

/************************************************************************
*	   {Funcion drag and drop con sesiones para pelcular y carrito}.    *
*************************************************************************/
function dropMenu(ev) {
    ev.preventDefault();
    var data  = ev.dataTransfer.getData("text");
    if (typeof(Storage) !== "undefined") {
    	var output = "";
	    if (sessionStorage.getItem('carrito') === null) {
	    	sessionStorage.setItem("carrito", JSON.stringify(dat));
	    } 
	    var carro = JSON.parse(sessionStorage.getItem('carrito'));
	    if (ev.target.id === 'drag') {
	   		carro.menus.push(data);
	   		var bd = localStorage.getItem('bbdd');
	   		if (bd !== null) {
	   			var m = JSON.parse(bd).menus;
	   			loop: for (var i = m.length - 1; i >= 0; i--) {
	   				if (m[i].idmenu === data) {
	   					output =  '<b>Añadiste:</b> ' + m[i].titulo;
	   					break loop;
	   				}
	   			}
	   		}
	    } else if (ev.target.id === 'drop') {
	    	var index = carro.menus.indexOf(data);
	    	if (index > -1) {
	    		carro.ticket.splice(index, 1);
	    	}
	    }
	    sessionStorage.setItem("carrito", JSON.stringify(carro));
	    document.getElementById("producto").innerHTML = output;
	} else {
		alert("Sorry, your browser does not support Web Storage..");
	}
    ev.target.appendChild(document.getElementById(data));
}