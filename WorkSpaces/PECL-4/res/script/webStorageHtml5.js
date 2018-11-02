var cartelera = {
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
	]
};
// Check browser support
if (typeof(Storage) !== "undefined") {
    localStorage.setItem("cartelera", JSON.stringify(cartelera));
} else {
    alert("Sorry, your browser does not support Web Storage...");
}

