function concafe(mesas){

	
	var elemento = document.getElementById("opt_mes");
	var sel1 = elemento.options[elemento.selectedIndex].value;
	
	if(sel1=="Mesa 1"){
		mesas[0].push("Cafe");
	}
	
	if(sel1=="Mesa 2"){
		mesas[1].push("Cafe");
	}
	
	if(sel1=="Mesa 3"){
		mesas[2].push("Cafe");
	}
	
	if(sel1=="Mesa 4"){
		mesas[3].push("Cafe");
	}
	
	if(sel1=="Mesa 5"){
		mesas[4].push("Cafe");
	}
	
	cambio_mesa(mesas);
	


}


function concopa(mesas){
	

	
	var elemento = document.getElementById("opt_mes");
	var sel1 = elemento.options[elemento.selectedIndex].value;
	
	if(sel1=="Mesa 1"){
		mesas[0].push("Copa");
	}
	
	if(sel1=="Mesa 2"){
		mesas[1].push("Copa");
	}
	
	if(sel1=="Mesa 3"){
		mesas[2].push("Copa");
	}
	
	if(sel1=="Mesa 4"){
		mesas[3].push("Copa");
	}
	
	if(sel1=="Mesa 5"){
		mesas[4].push("Copa");
	}
	
	cambio_mesa(mesas);
	


}


function cambio_mesa(mesas){
	//window.alert("hola");
	var elemento = document.getElementById("opt_mes");
	var sel = elemento.options[elemento.selectedIndex].value;
	//window.alert("Ha seleccionado la " + sel);
	var x = document.getElementById("selecciones");
	var i = x.length;
	do {
	x.remove(0);
		i--;
	}
	while (i > 0);
	
	if(sel=="Mesa 1"){
		//window.alert("hola");
		//window.alert(mesas[0]);
		var mesa_t = mesas[0];
		var long = mesa_t.length;
		
		var final = document.getElementById("selecciones");
		if(long == 0);
		else{
		do {
			var option1 = document.createElement("option");
			option1.text = mesa_t[long - 1];
			final.add(option1);
			
			long--;
		}
		while (long > 0);

		}
	}
	
	if(sel=="Mesa 2"){
		//window.alert("hola");
		//window.alert(mesas[1]);
		var mesa_t = mesas[1];
		var long = mesa_t.length;
		var final = document.getElementById("selecciones");
		if(long == 0);
		else{
		do {
			var option1 = document.createElement("option");
			option1.text = mesa_t[long - 1];
			final.add(option1);
			
			long--;
		}
		while (long > 0);

		}}
	
	if(sel=="Mesa 3"){
		//window.alert("hola");
		//window.alert(mesas[2]);
		var mesa_t = mesas[2];
		var long = mesa_t.length;
		var final = document.getElementById("selecciones");
		if(long == 0);
		else{
		do {
			var option1 = document.createElement("option");
			option1.text = mesa_t[long - 1];
			final.add(option1);
			
			long--;
		}
		while (long > 0);

		}}
	
	
	if(sel=="Mesa 4"){
		//window.alert("hola");
		//window.alert(mesas[3]);
		var mesa_t = mesas[3];
		var long = mesa_t.length;
		var final = document.getElementById("selecciones");
		if(long == 0);
		else{
		do {
			var option1 = document.createElement("option");
			option1.text = mesa_t[long - 1];
			final.add(option1);
			
			long--;
		}
		while (long > 0);

		}}
	
	if(sel=="Mesa 5"){
		//window.alert("hola");
		//window.alert(mesas[4]);
		var mesa_t = mesas[4];
		var long = mesa_t.length;
		var final = document.getElementById("selecciones");
		if(long == 0);
		else{
		do {
			var option1 = document.createElement("option");
			option1.text = mesa_t[long - 1];
			final.add(option1);
			
			long--;
		}
		while (long > 0);

		}}
}

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

function seleccion_primero(mesas){
	
	var elemento = document.getElementById("selecciones_platos");
	var sel = elemento.options[elemento.selectedIndex].value;

	var x =document.getElementById("selecciones");
	var plato1 = document.createElement("option");
	plato1.text = sel
	//x.add(plato1)
	
	var elemento = document.getElementById("opt_mes");
	var sel1 = elemento.options[elemento.selectedIndex].value;
	
	if(sel1=="Mesa 1"){
		mesas[0].push(sel);
	}
	
	if(sel1=="Mesa 2"){
		mesas[1].push(sel);
	}
	
	if(sel1=="Mesa 3"){
		mesas[2].push(sel);
	}
	
	if(sel1=="Mesa 4"){
		mesas[3].push(sel);
	}
	
	if(sel1=="Mesa 5"){
		mesas[4].push(sel);
	}
	
	cambio_mesa(mesas);
	

}

function myFunction(mesas){
	
	var elemento = document.getElementById("opt_mes");
	var sel1 = elemento.options[elemento.selectedIndex].value;
	
	if(sel1=="Mesa 1"){
		var long = mesas[0].length;
		
		var importe =  5.137 * long ; 
		var pagar = document.getElementById("a_pagar");
		pagar.value = importe ; 
		mesas[0] = [];cambio_mesa(mesas);
	}
	
	if(sel1=="Mesa 2"){
		var long = mesas[1].length;
		
		var importe =  5.137 * long ; 
		var pagar = document.getElementById("a_pagar");
		pagar.value = importe ; 
		mesas[1] = [];cambio_mesa(mesas);
	}
	
	if(sel1=="Mesa 3"){
		var long = mesas[2].length;
		
		var importe =  5.137 * long ; 
		var pagar = document.getElementById("a_pagar");
		pagar.value = importe ; 
		mesas[2] = [];cambio_mesa(mesas);
	}
	
	if(sel1=="Mesa 4"){
		var long = mesas[3].length;
		
		var importe =  5.137 * long ; 
		var pagar = document.getElementById("a_pagar");
		pagar.value = importe ; 
		mesas[3] = [];cambio_mesa(mesas);
	}
	
	if(sel1=="Mesa 5"){
		var long = mesas[4].length;
		
		var importe =  5.137 * long ; 
		var pagar = document.getElementById("a_pagar");
		pagar.value = importe ; 
		mesas[4] = [];cambio_mesa(mesas);
	}
}
