/*
	(c) Copyright 2014 by Parka
	
	Sistema de Clanes
	
	Inicio: 01/09/2014 - 04:24 p.m.(GTM-4)
	Fin: 01/09/2014 - 06:54 p.m.(GTM-4)
	Ultima Actualizacion: 03/09/2014 - 12:45 p.m.(GTM-4)
	
	Version: 0.2
	
	CLANES_MAXIMOS: El maximo de clanes que se pueden crear(Cambiarlo si es necesario).
	ZONA_LONGITUD: El tamaño de las zonas(Cambiarlo si es necesario).
	MAX_ZONAS: El maximo de zonas que se pueden conquistar(Cambiarlo si es necesario).
	MAX_MIEMBROS_CONQUISTA: El maximo de miembros requeridos para conquistar la zona(Cambiarlo si es necesario).
	MAX_TIEMPO_CONQUISTA: El tiempo que debe estar en la zona para conquistarla(En segundos)(Cambiarlo si es necesario).
*/
//Libreria Default de SA-MP(By SA-MP TEAM)
#include <a_samp>
//Procesador de comandos(By Zeex).
#include <zcmd>
//Estractor de datos(By Y_LESS).
#include <sscanf2>
//Guardado de datos por achivos(By DracoBlue).
#include <Dini>
//Direccion donde se guardaran los jugadores(Datos).
#define Jugadores "/alianza/jugadores/%s.ini"
//Direccion donde se guardaran los Clanes(Datos).
#define Alianza "/alianza/clanes.cfg"
//Maxima cantidad de clanes que pueden ser registrados en el servidor.
#define CLANES_MAXIMOS			(50)
//Maxima cantidad de zonas que pueden ser conquistadas en el servidor.
#define MAX_ZONAS				(16)
//El tamaño de las Zonas.
#define ZONA_LONGITUD			(100.0)
//la cantidad de miembros a conquista la zona.
#define MAX_MIEMBROS_CONQUISTA	(1)
//Tiempo que deben estar en la zona para conquistarla(en segundos).
#define MAX_TIEMPO_CONQUISTA	(10)
//macro, color, gris.
#define Error 0xC0C0C0FF
//macro, color, MediumSpringGreen.
#define ChatColor 0x00FA9AFF
//macro, color, naranja.
#define Naranja 0xFFA500FF
//macro, color, amarillo.
#define Amarillo 0xFFFF00FF
//Macro, dialog, definir ID(Crear Clan).
#define Dialog_Crear_Clan		(1333)
#define Dialog_Infor_Clan		(1334)
//Colores By SA-MP TEAM
new ColoursTableRGBA[256]={
	// The existing colours from San Andreas
	0x00000044, 0xF5F5F544, 0x2A77A144, 0x84041044, 0x26373944, 0x86446E44, 0xD78E1044, 0x4C75B744, 0xBDBEC644, 0x5E707244,
	0x46597A44, 0x656A7944, 0x5D7E8D44, 0x58595A44, 0xD6DAD644, 0x9CA1A344, 0x335F3F44, 0x730E1A44, 0x7B0A2A44, 0x9F9D9444,
	0x3B4E7844, 0x732E3E44, 0x691E3B44, 0x96918C44, 0x51545944, 0x3F3E4544, 0xA5A9A744, 0x635C5A44, 0x3D4A6844, 0x97959244,
	0x421F2144, 0x5F272B44, 0x8494AB44, 0x767B7C44, 0x64646444, 0x5A575244, 0x25252744, 0x2D3A3544, 0x93A39644, 0x6D7A8844,
	0x22191844, 0x6F675F44, 0x7C1C2A44, 0x5F0A1544, 0x19382644, 0x5D1B2044, 0x9D987244, 0x7A756044, 0x98958644, 0xADB0B044,
	0x84898844, 0x304F4544, 0x4D626844, 0x16224844, 0x272F4B44, 0x7D625644, 0x9EA4AB44, 0x9C8D7144, 0x6D182244, 0x4E688144,
	0x9C9C9844, 0x91734744, 0x661C2644, 0x949D9F44, 0xA4A7A544, 0x8E8C4644, 0x341A1E44, 0x6A7A8C44, 0xAAAD8E44, 0xAB988F44,
	0x851F2E44, 0x6F829744, 0x58585344, 0x9AA79044, 0x601A2344, 0x20202C44, 0xA4A09644, 0xAA9D8444, 0x78222B44, 0x0E316D44,
	0x722A3F44, 0x7B715E44, 0x741D2844, 0x1E2E3244, 0x4D322F44, 0x7C1B4444, 0x2E5B2044, 0x395A8344, 0x6D283744, 0xA7A28F44,
	0xAFB1B144, 0x36415544, 0x6D6C6E44, 0x0F6A8944, 0x204B6B44, 0x2B3E5744, 0x9B9F9D44, 0x6C849544, 0x4D849544, 0xAE9B7F44,
	0x406C8F44, 0x1F253B44, 0xAB927644, 0x13457344, 0x96816C44, 0x64686A44, 0x10508244, 0xA1998344, 0x38569444, 0x52566144,
	0x7F695644, 0x8C929A44, 0x596E8744, 0x47353244, 0x44624F44, 0x730A2744, 0x22345744, 0x640D1B44, 0xA3ADC644, 0x69585344,
	0x9B8B8044, 0x620B1C44, 0x5B5D5E44, 0x62442844, 0x73182744, 0x1B376D44, 0xEC6AAE44, 0x00000044,
	// SA-MP extended colours (0.3x)
	0x17751744, 0x21060644, 0x12547844, 0x452A0D44, 0x571E1E44, 0x01070144, 0x25225A44, 0x2C89AA44, 0x8A4DBD44, 0x35963A44,
	0xB7B7B744, 0x464C8D44, 0x84888C44, 0x81786744, 0x817A2644, 0x6A506F44, 0x583E6F44, 0x8CB97244, 0x824F7844, 0x6D276A44,
	0x1E1D1344, 0x1E130644, 0x1F251844, 0x2C453144, 0x1E4C9944, 0x2E5F4344, 0x1E994844, 0x1E999944, 0x99997644, 0x7C849944,
	0x992E1E44, 0x2C1E0844, 0x14240744, 0x993E4D44, 0x1E4C9944, 0x19818144, 0x1A292A44, 0x16616F44, 0x1B668744, 0x6C3F9944,
	0x481A0E44, 0x7A739944, 0x746D9944, 0x53387E44, 0x22240744, 0x3E190C44, 0x46210E44, 0x991E1E44, 0x8D4C8D44, 0x805B8044,
	0x7B3E7E44, 0x3C173744, 0x73351744, 0x78181844, 0x83341A44, 0x8E2F1C44, 0x7E3E5344, 0x7C6D7C44, 0x020C0244, 0x07240744,
	0x16301244, 0x16301B44, 0x642B4F44, 0x36845244, 0x99959044, 0x818D9644, 0x99991E44, 0x7F994C44, 0x83929244, 0x78822244,
	0x2B3C9944, 0x3A3A0B44, 0x8A794E44, 0x0E1F4944, 0x15371C44, 0x15273A44, 0x37577544, 0x06082044, 0x07132644, 0x20394B44,
	0x2C508944, 0x15426C44, 0x10325044, 0x24166344, 0x69201544, 0x8C8D9444, 0x51601344, 0x090F0244, 0x8C573A44, 0x52888E44,
	0x995C5244, 0x99581E44, 0x993A6344, 0x998F4E44, 0x99311E44, 0x0D184244, 0x521E1E44, 0x42420D44, 0x4C991E44, 0x082A1D44,
	0x96821D44, 0x197F1944, 0x3B141F44, 0x74521744, 0x893F8D44, 0x7E1A6C44, 0x0B370B44, 0x27450D44, 0x071F2444, 0x78457344,
	0x8A653A44, 0x73261744, 0x31949044, 0x56941D44, 0x59163D44, 0x1B8A2F44, 0x38160B44, 0x04180444, 0x355D8E44, 0x2E3F5B44,
	0x561A2844, 0x4E0E2744, 0x706C6744, 0x3B3E4244, 0x2E2D3344, 0x7B7E7D44, 0x4A444244, 0x28344E44
};
//Enum de la variable Clanes.
enum eAlianza{
	aSlot,
	aNombre[32],//Almacena el nombre de la alianza
	aLider[24],//Almacena el nombre del lider de la alianza
	aKills,//Almacena la cantidad de Kills(de todos los miembros de la alianza).
	aDeaths,//Almacena la cantidad de Deaths(de todos los miembros de la alianza).
	aConquista,//Almacena el nombre de la alianza
	aColor//Almacena el ID del color.
}
//Clanes(variable), almacenar datos de todos los clanes.
new Clanes[CLANES_MAXIMOS][eAlianza];
//Enum de la variable 
enum zConsquitables{
	Float:zPos[3],
	zClan,
	zGang
}
new ZoneTakeOverTeam[MAX_ZONAS];
new ZoneTakeOverTime[MAX_ZONAS];
//Array Almacena la posicion de las zonas conquistables.
new Zonas[MAX_ZONAS][zConsquitables] = {
	{{2637.2712,1129.2743,11.1797},0},
	{{2000.0106,1521.1111,17.0625},0},
	{{2024.8190,1917.9425,12.3386},0},
	{{2261.9048,2035.9547,10.8203},0},
	{{2262.0986,2398.6572,10.8203},0},
	{{2244.2566,2523.7280,10.8203},0},
	{{2335.3228,2786.4478,10.8203},0},
	{{2150.0186,2734.2297,11.1763},0},
	{{2158.0811,2797.5488,10.8203},0},
	{{1969.8301,2722.8564,10.8203},0},
	{{1652.0555,2709.4072,10.8265},0},
	{{1564.0052,2756.9463,10.8203},0},
	{{1271.5452,2554.0227,10.8203},0},
	{{1441.5894,2567.9099,10.8203},0},
	{{1480.6473,2213.5718,11.0234},0},
	{{1400.5906,2225.6960,11.0234},0}
};	
//Enum de la variable Usuario.
enum eUsuario{
	uLider,
	uMiembro
}
//Usuario(variable), almacenar datos de todos los jugadores.
new Usuario[MAX_PLAYERS][eUsuario];
//Prevenir futuros Bugs.
new PuedeGuardarse = true;
//Obtener directamente el nombre del jugador.
static dbNombre(playerid){
	new nombre[MAX_PLAYER_NAME];
	GetPlayerName(playerid,nombre,sizeof(nombre));
	return nombre;
}
//Obtener directamente la ubicacion del archivo(Jugadores).
static dbJugadores(playerid){
	new str[64];
	format(str,sizeof(str),Jugadores,dbNombre(playerid));
	return str;
}
//Llamada al momento de iniciar el servidor
public OnFilterScriptInit(){
	print("Sistema de clanes: Cargado");
	CargarClanes();
	SetTimer("ActualizarZonas",1000,true);
	for(new z=0;z<sizeof(Zonas);z++){//Bucle, Zonas.
		Zonas[z][zGang] = GangZoneCreate(Zonas[z][zPos][0] - ZONA_LONGITUD,Zonas[z][zPos][1] - ZONA_LONGITUD,Zonas[z][zPos][0] + ZONA_LONGITUD,Zonas[z][zPos][1] + ZONA_LONGITUD);//Crear la GanZone.
		ZoneTakeOverTeam[z] = -1;
	}
}
//Llamada al momento que un jugador entra al juego.
public OnPlayerConnect(playerid){
	switch(dini_Exists(dbJugadores(playerid))){
		case true:{//Si existe, devolverle los valores a ambas variables.
			Usuario[playerid][uLider]		=	dini_Int(dbJugadores(playerid),"lider");//Obtener valor de lider.
			Usuario[playerid][uMiembro]		=	dini_Int(dbJugadores(playerid),"miembro");//Obtener valor de miembro.
		}
		case false:{//De lo contrario, crear el archivo.
			dini_Create(dbJugadores(playerid));//Crea el archivo.
			Usuario[playerid][uLider]	= 0;//Setea a variable a 0
			Usuario[playerid][uMiembro] = 0;//Setea a variable a 0
		}
	}
	for(new z=0;z<sizeof(Zonas);z++){
		GangZoneShowForPlayer(playerid,Zonas[z][zGang],ColoursTableRGBA[Clanes[Zonas[z][zClan]][aColor]]);//Muestra la Zona conquistable.
		if(ZoneTakeOverTeam[z] != -1){//Si la zona esta siendo atacada parpadeara.
			GangZoneFlashForPlayer(playerid,Zonas[z][zGang],ColoursTableRGBA[Clanes[ZoneTakeOverTeam[z]][aColor]]);
		}
	}
	return 1;
}
//Llamada al momento que un jugador sale del juego.
public OnPlayerDisconnect(playerid,reason){
	switch(dini_Exists(dbJugadores(playerid))){
		case true:{//Si existe, devolverle los valores a ambas variables.
			dini_IntSet(dbJugadores(playerid),"lider",Usuario[playerid][uLider]);//Guardar valores en el archivo(Usuario).
			dini_IntSet(dbJugadores(playerid),"miembro",Usuario[playerid][uMiembro]);//Guardar valores en el archivo(Usuario).
		}
	}
	
	if(PuedeGuardarse){
		PuedeGuardarse = false;
		GuardarClanes();
		SetTimer("RetornarTrue",1000,false);
	}
	return 1;
}
//Llamada cuando un jugador Spawnea.
public OnPlayerSpawn(playerid){
	if(Usuario[playerid][uMiembro] != 0){
		SetPlayerColor(playerid,ColoursTableRGBA[Clanes[Usuario[playerid][uMiembro]][aColor]]);
	}else SetPlayerColor(playerid,0xFFFFFFFF);
	return 1;
}
//Llamada cuando un juegador asesina a otro, o el jugador muere.
public OnPlayerDeath(playerid,killerid,reason){
	if(killerid != INVALID_PLAYER_ID){//Verificar que un jugador mato a otro.
		new cAsesino	= Usuario[killerid][uMiembro];//Id del clan del jugador que mata.
		new cMuerto		= Usuario[playerid][uMiembro];//Id del clan del jugador que muere.
		if(cMuerto != 0 && cAsesino != 0){//Si ambos tienen alianza.
			Clanes[cAsesino][aKills]++;//Sumarle +1 kill al clan del jugador que mato.
			Clanes[cMuerto][aDeaths]++;//Sumarle +1 death al clan del jugador que murio.
		}else if(cAsesino != 0){//Si solo el asesino la tiene.
			Clanes[cAsesino][aKills]++;//Sumarle +1 kill al clan del jugador que mato.
		}else if(cMuerto != 0){//Si solo el muerto la tiene.
			Clanes[cMuerto][aDeaths]++;//Sumarle +1 death al clan del jugador que murio.
		}
	}
	return 1;
}
//Comando para crear el clan.
COMMAND:crearclan(playerid,params[]){
	//Comprobar que el usuario no tenga clan.
	if(!Usuario[playerid][uMiembro]){
		//Mostrar dialogo al jugador(para la creacion de clan).
		ShowPlayerDialog(playerid,Dialog_Crear_Clan,DIALOG_STYLE_INPUT,"{ffffff}[!]Nombre del clan:","{ffffff}Escribe en el siguiente \n{ffffff}espacio el nombre del clan:","Aceptar","Cancelar");
	}else return SendClientMessage(playerid,Error,"Error: Usted ya pertenece a una clan.");
	return 1;
}
//Observar todos los comandos del clan.
COMMAND:claninfo(playerid,params[]){
	SendClientMessage(playerid,Naranja,"Comandos para los clanes:");
	SendClientMessage(playerid,Naranja,"/clan = informacion del clan.");
	SendClientMessage(playerid,Naranja,"/t = Chat de la alianza.");
	SendClientMessage(playerid,Naranja,"/miembros = lista de miembros conectados."); 
	SendClientMessage(playerid,Naranja,"/color = Asignarle un color al clan(Lider).");
	SendClientMessage(playerid,Naranja,"/reclutar = invitar a un jugador al clan(Lider).");
	SendClientMessage(playerid,Naranja,"/expulsar = hechar a un jugador al clan(Lider).");
	return 1;
}
//Comando para Expulsar personas(Solo lider).
COMMAND:expulsar(playerid,params[]){
	new user, string[144];
	if(!Usuario[playerid][uMiembro]) return SendClientMessage(playerid,Error,"Usted no pertenece a un clan.");
	if(!Usuario[playerid][uLider]) return SendClientMessage(playerid,Error,"Usted no es lider de clan.");
	if(sscanf(params,"u",user)) return SendClientMessage(playerid,Error,"Error: /Expulsar [ID - Nombre]");
	if(Usuario[user][uMiembro] == Usuario[playerid][uMiembro]){
		Usuario[user][uMiembro] = 0;
		format(string,sizeof(string),"Usted expulso a %s al clan.",dbNombre(user));
		SendClientMessage(playerid,Amarillo,string);
		format(string,sizeof(string),"%s te expulso de su clan.",dbNombre(playerid));
		SendClientMessage(user,Amarillo,string);
	}else SendClientMessage(playerid,Error,"Este jugador no pertenece a tu clan.");
	return 1;
}
//Comando para reclutar personas(Solo lider).
COMMAND:reclutar(playerid,params[]){
	new user, string[144];
	if(!Usuario[playerid][uMiembro]) return SendClientMessage(playerid,Error,"Usted no pertenece a un clan.");
	if(!Usuario[playerid][uLider]) return SendClientMessage(playerid,Error,"Usted no es lider de clan.");
	if(sscanf(params,"u",user)) return SendClientMessage(playerid,Error,"Error: /Reclutar [ID - Nombre]");
	if(!Usuario[user][uMiembro]){
		Usuario[user][uMiembro] = Usuario[playerid][uMiembro];
		format(string,sizeof(string),"Usted recluto a %s al clan.",dbNombre(user));
		SendClientMessage(playerid,Amarillo,string);
		format(string,sizeof(string),"%s te recluto a su clan.",dbNombre(playerid));
		SendClientMessage(user,Amarillo,string);
	}else SendClientMessage(playerid,Error,"Este jugador pertenece a un clan.");
	return 1;
}
//Comando para darle color al clan(Solo lider).
COMMAND:color(playerid,params[]){
	new item, clanid=Usuario[playerid][uMiembro];
	if(!clanid) return SendClientMessage(playerid,Error,"Usted no pertenece a un clan.");
	if(!Usuario[playerid][uLider]) return SendClientMessage(playerid,Error,"Usted no es lider de clan.");
	if(sscanf(params,"d",item)) return SendClientMessage(playerid,Error,"Error: /Color [0 - 255]");
	switch(item){
		case 0 .. 255:{
			Clanes[Usuario[playerid][uMiembro]][aColor] = item;
			SendClientMessage(playerid,ColoursTableRGBA[Clanes[Usuario[playerid][uMiembro]][aColor]],"El color de su clan ha cambiado.");
		}
		default: SendClientMessage(playerid,Error,"Error: /Color [0 - 255]");
	}
	return 1;
}
//Comando para la informacion del clan.
COMMAND:clan(playerid,params[]){
	new string[64], clanid=Usuario[playerid][uMiembro];
	if(!clanid) return SendClientMessage(playerid,Error,"Usted no pertenece a un clan.");
	format(string,sizeof(string),"%s",Clanes[clanid][aNombre]);
	SendClientMessage(playerid,Amarillo,string);
	format(string,sizeof(string),"Lider: %s",Clanes[clanid][aLider]);
	SendClientMessage(playerid,Amarillo,string);
	format(string,sizeof(string),"Kills Total: %d - Deaths Total: %d",Clanes[clanid][aKills],Clanes[clanid][aDeaths]);
	SendClientMessage(playerid,Amarillo,string);
	format(string,sizeof(string),"Conquistas Total: %d",Clanes[clanid][aConquista]);
	SendClientMessage(playerid,Amarillo,string);
	format(string,sizeof(string),"Ratio: %.2f",float(Clanes[clanid][aKills])/float(Clanes[clanid][aDeaths]));
	SendClientMessage(playerid,Amarillo,string);
	return 1;
}
//Comando para chat con miembros del clan.
COMMAND:t(playerid,params[]){
	new sms[90], string[144], clanid=Usuario[playerid][uMiembro];
	if(!clanid) return SendClientMessage(playerid,Error,"Usted no pertenece a un clan.");
	if(sscanf(params,"s[90]",sms)) return SendClientMessage(playerid,Error,"Error: /t [Mensaje]");
	for(new miembro=0;miembro<MAX_PLAYERS;miembro++){
		if(Usuario[miembro][uMiembro] == clanid){
			format(string,sizeof(string),"Chat Clan - %s: %s",dbNombre(playerid),sms);
			SendClientMessage(miembro,ChatColor,string);
		}
	}
	return 1;
}
//Comando para mostrar los miembros del clan.
COMMAND:miembros(playerid,params[]){
	new string[64], clanid=Usuario[playerid][uMiembro];
	if(!clanid) return SendClientMessage(playerid,Error,"Usted no pertenece a un clan.");
	
	SendClientMessage(playerid,Amarillo,"Miembros del clan conectados:");
	for(new miembro=0;miembro<MAX_PLAYERS;miembro++){
		if(Usuario[miembro][uMiembro] == clanid){
			format(string,sizeof(string),"%s[%d] - {00ff00}Conectado",dbNombre(miembro),miembro);
			SendClientMessage(playerid,Amarillo,string);
		}
	}
	return 1;
}
//Llamado cuando un jugador presiona alguno de los botones de un dialogo creado con ShowPlayerDialog.
public OnDialogResponse(playerid,dialogid,response,listitem,inputtext[]){
	new string[256];//Cadena
	new clanid = -1;//Variable para establecer el ID disponible.
	switch(dialogid){
		case Dialog_Crear_Clan:{
			if(!response) return 1;//Presiono Cancelar.
			else if(response){
				//verificar la cantidad de caracteres permitidos.
				if(strlen(inputtext) < 4 || strlen(inputtext) > 31) return ShowPlayerDialog(playerid,Dialog_Crear_Clan,DIALOG_STYLE_INPUT,"{ffffff}[!]Nombre del clan:","{ffffff}Escribe en el siguiente \n{ffffff}espacio el nombre del clan:\n{ff0000}El nombre debe tener de 4 a 32 caracteres.","Aceptar","Cancelar");
				for(new i=1;i<CLANES_MAXIMOS;i++){//Bucle, para revisar si aSlot esta disponible(esta en 0).
					if(!Clanes[i][aSlot]){//Si aSlot, esta en 0(Disponible).
						clanid = i;//Dar el ID disponible a clanid.
						break;//Cortamos el bucle.
					}
				}
				//Si no encuentra aSlot disponible, lanza este mensaje.
				if(clanid == -1) return SendClientMessage(playerid,Error,"Error: No es posible crear mas clanes.");
				//Asignarle Ocupado(1) al ID del clan.
				Clanes[clanid][aSlot] = 1;
				//Dar lider de clan al usuario creador.
				Usuario[playerid][uLider] = 1;
				Usuario[playerid][uMiembro] = clanid;
				//Darle formato a la variable Clanes[clanid][aNombre], en este caso el nombre del clan.
				format(Clanes[clanid][aNombre],32,"%s",inputtext);
				//Darle formato a la variable Clanes[clanid][aLider], en este caso el nombre del lider.
				format(Clanes[clanid][aLider],MAX_PLAYER_NAME,"%s",dbNombre(playerid));
				//Darle formato a la informacion que mostraremos.
				format(string,sizeof(string),"{ffff00}Su clan fue creado con exito.\n\n{FFA500}Nombre: %s\n\n{FFA500}Lider: %s\n\n\n{ffff00}Para mas informacion usar /claninfo.",Clanes[clanid][aNombre],Clanes[clanid][aLider]);
				//Mostrar dialogo al jugador(para la informacion del clan).
				ShowPlayerDialog(playerid,Dialog_Infor_Clan,DIALOG_STYLE_MSGBOX,"{ffffff}[!]Informacion:",string,"Aceptar","Cancelar");				
			}
		}
	}
	return 1;
}
//Guardar Clanes.
forward GuardarClanes();
public GuardarClanes(){
	new clanid, string[256], File:Archivo;
	while(clanid < sizeof(Clanes)){
		format(string,sizeof(string),"%d,%s,%s,%d,%d,%d,%d\n",
		Clanes[clanid][aSlot],
		Clanes[clanid][aNombre],
		Clanes[clanid][aLider],
		Clanes[clanid][aKills],
		Clanes[clanid][aDeaths],
		Clanes[clanid][aConquista],
		Clanes[clanid][aColor]);
		if(!clanid){
			Archivo = fopen(Alianza,io_write);
		}else{
			Archivo = fopen(Alianza,io_append);
		}
		fwrite(Archivo,string);
		clanid++;
		fclose(Archivo);
	}
}
//Cargar datos de los clanes.
forward CargarClanes();
public CargarClanes(){
	new clanid, dbInfo[7][32], string[256], File:Archivo=fopen(Alianza,io_read);
	if(Archivo){
		while(clanid < sizeof(Clanes)){
			fread(Archivo,string);
			split(string,dbInfo,',');
			Clanes[clanid][aSlot] = strval(dbInfo[0]);
			strmid(Clanes[clanid][aNombre],dbInfo[1],0,strlen(dbInfo[1]),32);
			strmid(Clanes[clanid][aLider],dbInfo[2],0,strlen(dbInfo[2]),24);
			Clanes[clanid][aKills] = strval(dbInfo[3]);
			Clanes[clanid][aDeaths] = strval(dbInfo[4]);
			Clanes[clanid][aConquista] = strval(dbInfo[5]); 
			Clanes[clanid][aColor] = strval(dbInfo[6]); 
			clanid++;
		}
		fclose(Archivo);
	}
	return 1;
}
//Para prevenir futuros Bugs.
forward RetornarTrue();
public RetornarTrue(){
	PuedeGuardarse = true;
}
//Usada en un timer para verificar si hay miembros en la zona
forward ActualizarZonas();
public ActualizarZonas(){
	for(new z=0;z<sizeof(Zonas);z++){//Bucle, Zonas.
		if(ZoneTakeOverTeam[z] == -1){//Si la zona no posee dueño.
			for(new t=1;t<CLANES_MAXIMOS;t++){
				if(t == Zonas[z][zClan]) continue;
				if(ObtenerMiembrosEnZona(z,t) >= MAX_MIEMBROS_CONQUISTA){
					ZoneTakeOverTeam[z] = t;
					GangZoneFlashForAll(Zonas[z][zGang],ColoursTableRGBA[Clanes[t][aColor]]);
					ZoneTakeOverTime[z] = 0;
				}
			}
		}else{
			if(ObtenerMiembrosEnZona(z,ZoneTakeOverTeam[z]) > 0){
				ZoneTakeOverTime[z]++;
				if(ZoneTakeOverTime[z] >= MAX_TIEMPO_CONQUISTA){
					GangZoneStopFlashForAll(Zonas[z][zGang]);
					GangZoneShowForAll(Zonas[z][zGang],ColoursTableRGBA[Clanes[ZoneTakeOverTeam[z]][aColor]]);
	                Zonas[z][zClan] = ZoneTakeOverTeam[z];
	                for(new i=0,m=GetMaxPlayers();i<m;i++){
	                    if(IsPlayerConnected(i)){
	                        if(GetPlayerZone(i) == z && Usuario[i][uMiembro] == ZoneTakeOverTeam[z]){
								GameTextForPlayer(i,"_~n~_~n~_~n~_~g~~h~~h~Han conquistado esta Base",2000,6);
							}
						}
					}
					Clanes[Zonas[z][zClan]][aConquista]++;
	                ZoneTakeOverTeam[z] = -1;
	                ZoneTakeOverTime[z] = 0;
				}
			}else{
                ZoneTakeOverTeam[z] = -1;
                GangZoneStopFlashForAll(Zonas[z][zGang]);
                ZoneTakeOverTime[z] = 0;
			}
		}
	}
}
//Funcion para saber que cantidad de miembros hay en la zona.
ObtenerMiembrosEnZona(zoneid,equipo){
	new count = 0;
	new Float:px, Float:py, Float:pz;
	for(new i=0,m=GetMaxPlayers();i<m;i++){
		if(IsPlayerConnected(i)){
			if(GetPlayerState(i) != PLAYER_STATE_WASTED && Usuario[i][uMiembro] == equipo){
				GetPlayerPos(i, px, py, pz);
				if(px > Zonas[zoneid][zPos][0] - ZONA_LONGITUD && py > Zonas[zoneid][zPos][1] - ZONA_LONGITUD && px < Zonas[zoneid][zPos][0] + ZONA_LONGITUD && py < Zonas[zoneid][zPos][1] + ZONA_LONGITUD){
					count++;
				}
			}
		}
	}
	return count;
}
//Sirve para dividir una cadena.
stock split(const strsrc[], strdest[][], delimiter){
	new i, li;
	new aNum;
	new len;
	while(i <= strlen(strsrc)){
	    if(strsrc[i]==delimiter || i==strlen(strsrc)){
	        len = strmid(strdest[aNum], strsrc, li, i, 128);
	        strdest[aNum][len] = 0;
	        li = i+1;
	        aNum++;
		}
		i++;
	}
	return 1;
}
//Detectar si un jugador esta en una zona especifica.
stock GetPlayerZone(playerid){
	if(GetPlayerState(playerid) != PLAYER_STATE_WASTED){
		new Float:px, Float:py, Float:pz;
		GetPlayerPos(playerid, px, py, pz);
		for(new i=0;i<sizeof(Zonas);i++){
		    if(px > Zonas[i][zPos][0] - ZONA_LONGITUD && py > Zonas[i][zPos][1] - ZONA_LONGITUD && px < Zonas[i][zPos][0] + ZONA_LONGITUD && py < Zonas[i][zPos][1] + ZONA_LONGITUD) return i;
		}
	}
	return -1;
}