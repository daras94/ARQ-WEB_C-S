var bd_dat = {
	peliculas : [
		{
			idcine   : "C-01",	   
			titulo   : "Bohemian Rhapsody",
			caratula : "../res/img/cartelera/C-01.jpg",
			trailer  : "UiOYxLrKYYc", 
			duracion : 134,
			director : ["Bryan Singer", "Dexter Fletcher"],
			reparto  : ["Rami Malek", "Gwilym Lee", "Lucy Boynton"],
			pases    : ["16:20", "19:20", "22:00", "17:45", "20:35"]
		},
		{
			idcine   : "C-02",	
			titulo   : "El cascanueces y los cuatro reinos",
			caratula : "../res/img/cartelera/C-02.jpg",
			trailer  : "nu9Cu07_M8U", 
			duracion : 100,
			director : ["Bryan Singer", "Dexter Fletcher"],
			reparto  : ["Rami Malek", "Gwilym Lee", "Lucy Boynton"],
			pases    : ["16:00",  "18:10", "20:20", "22:30", "17:05", "19:15"]
		},
		{
			idcine   : "C-03",	
			titulo   : "Escuela para fracasados",
			caratula : "../res/img/cartelera/C-03.jpg",
			trailer  : "S2qWSNU1GWQ", 
			duracion : 111,
			director : ["Lasse Hallström"],
			reparto  : ["Keira Knightley", "Mackenzie Foy", "Helen Mirren"],
			pases    : ["16:00", "18:10", "20:00", "20:35"]
		}
	],
	menus : [
		{
			idmenu   : "M-01",
			titulo   : "Menu del Dia",
			icon	 : "../res/img/menus/M-01.png",
			precio   : 20,
			primeros : ["Pulpo a la feira", "Entrecot", "Ensalada"],
			segundos : ["Mariscada", "Pimientos de padron", "Churasco"],
			postres  : ["Flan", "Macedonia", "Pudin", "Cafe o Infusion"]
		},
		{
			idmenu   : "M-03",
			titulo   : "Menu Especial",
			icon	 : "../res/img/menus/M-03.png",
			precio   : 80,
			primeros : ["Suflet", "Rodaballo confitado con sofrito de tomate"],
			segundos : ["Rape con ragout de verduras y manitas de cerdo", " Pularda asada con ciruelas y piñones"],
			postres  : ["Flan", "Macedonia", "Pudin", "Cafe o Infusion"]
		},
		{
			idmenu   : "M-02",
			titulo   : "Menu Infantil",
			icon	 : "../res/img/menus/M-02.png",
			precio   : 8,
			primeros : ["Pizza", "Macarones con tomate", "Espaquetis"],
			segundos : ["Hamburguesa", "Filete de pollo", "Arroz a la Cubana"],
			postres  : ["Elados", "Fantasmitos", "Tarta Chocolate"]
		},
	]

};
// Check browser support
if (typeof(Storage) !== "undefined") {
    localStorage.setItem("bbdd", JSON.stringify(bd_dat));
} else {
    alert("Sorry, your browser does not support Web Storage...");
}

