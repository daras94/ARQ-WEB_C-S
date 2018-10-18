function primeros() {
	document.getElementById("resultado").innerHTML = "Cambiando los valores a los primeros";
	// x será donde se realizará la selección de los platos
	var x = document.getElementById("selecciones_platos");
	// i guardará la longitud con los elementos almacenados anteriormente
	var i = x.length;
	
	//formateamos nuestro box de opciones
	do {
		x.remove(0);
    	i--;
	}
	while (i > 0);
	//document.getElementById("resultado").innerHTML = i;
	
	
	var option1 = document.createElement("option");
	option1.text = "Pollo Asado";
	var option2 = document.createElement("option");
	option2.text = "Potaje de Garbanzos";
	var option3 = document.createElement("option");
	option3.text = "Pulpo a la Gallega";
	var option4 = document.createElement("option");
	option4.text = "Paella";
	x.add(option1);
	x.add(option2);
	x.add(option3);
	x.add(option4);
}

function segundos() {
	document.getElementById("resultado").innerHTML = "Cambiando los valores a los segundos";
	// x será donde se realizará la selección de los platos
	var x = document.getElementById("selecciones_platos");
	// i guardará la longitud con los elementos almacenados anteriormente
	var i = x.length;
	
	//formateamos nuestro box de opciones
	do {
		x.remove(0);
    	i--;
	}
	while (i > 0);
	//document.getElementById("resultado").innerHTML = i;
	
	
	var option1 = document.createElement("option");
	option1.text = "Crema Catalana";
	var option2 = document.createElement("option");
	option2.text = "Ensalada";
	var option3 = document.createElement("option");
	option3.text = "Gazpacho";
	var option4 = document.createElement("option");
	option4.text = "Parrillada";
	x.add(option1);
	x.add(option2);
	x.add(option3);
	x.add(option4);
	
}

function postres() {
	document.getElementById("resultado").innerHTML = "Cambiando los valores a los postres";
	// x será donde se realizará la selección de los platos
	var x = document.getElementById("selecciones_platos");
	// i guardará la longitud con los elementos almacenados anteriormente
	var i = x.length;
	
	//formateamos nuestro box de opciones
	do {
		x.remove(0);
    	i--;
	}
	while (i > 0);
	//document.getElementById("resultado").innerHTML = i;
	
	
	var option1 = document.createElement("option");
	option1.text = "Yogurt";
	var option2 = document.createElement("option");
	option2.text = "Helado";
	var option3 = document.createElement("option");
	option3.text = "Sandia";
	var option4 = document.createElement("option");
	option4.text = "Melon";
	x.add(option1);
	x.add(option2);
	x.add(option3);
	x.add(option4);
}
