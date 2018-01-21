/*
Author: BACONMOP
Description: Defines MAin Ao's n shiz
Contributors: Zissou & Pero

last edited: 2/09/2017, by stanhope

edited: fixed Abdera <=> Abdera typo.
ex:
	class ****** {
		name =  "*****";
		nearlocations[]={
			
		};
		type = "Outpost";
		vehicles[] = {};
	};
*/

class AOs{
	class Base {
		name =  "Camp Landfell";
		nearlocations[]={
			"Zeko_Valley",
			"Shegara_champ",
			"Kalae_Noowi",
			"Kinduf_1",
			"Shoran",
			"Zregurat",
			"Orcarif",
			"Abi_Valley",
			"Adrian_River",
			"Afarat",
			"Afsher",
			"Amir",
			"Anyakar",
			"Arobster",
			"Badgir",
			"Benamair",
			"Doran",
			"Focheur",
			"Hill_1",
			"Iban_camp_base",
			"Kamir",
			"Karift",
			"Limari",
			"Le_Sarde",
			"Patersone",
			"Ramir",
			"Mozarat_Death"
			
			
			
		};
		type = "MainBase";
		vehicles[] = {};
	};
	class Zregurat {
		name =  "Zregurat";
		nearlocations[]={
			"Zregurat_industrie",
			"Kunduf_sation_depuration",
			"Zagun"
		};
		type = "Town";
		vehicles[] = {};
	};
	class Kunduf_sation_depuration {
		name =  "Kunduf sation d'épuration";
		nearlocations[]={
			"Lobo_Rider_Bed",
			"Kinduf_1",
			"Zregurat"
		};
		type = "Field";
		vehicles[] = {};
	};
	class Shegara_champ {
		name =  "Shegara champ";
		nearlocations[]={
			"Kinduf_1",
			"Shegara",
			"Shegara_champ",
			"Iban_camp_base",
			"Iban_castle",
			"Base"
		};
		type = "Field";
		vehicles[] = {};
	};
	class Zregurat_industrie {
		name =  "Zregurat Industrie";
		nearlocations[]={
			"Zregurat",
			"Base",
			"Zagun_Road",
			"Zagun"
		};
		type = "Field";
		vehicles[] = {};
	};
	class Zagun {
		name =  "Zagun";
		nearlocations[]={
			"Zregurat",
			"Zagun_Road",
			"Zregurat_industrie"
		};
		type = "Town";
		vehicles[] = {};
	};
	class Bagdir {
		name =  "Bagdir";
		nearlocations[]={
			"Puesto_Mate"
		};
		type = "Town";
		vehicles[] = {};
	};
	class Lobo_Rider_Bed {
		name =  "Lobo Rider Bed";
		nearlocations[]={
			"Orcarif",
			"Shegara",
			"Kinduf_1"
		};
		type = "Field";
		vehicles[] = {};
	};
	class Shegara {
		name =  "Shegara";
		nearlocations[]={
			"Lobo_Rider_Bed",
			"Kinduf_1",
			"Iban_camp_base",
			"Iban_camp_base"
		};
		type = "Town";
		vehicles[] = {};
	};
	class Kinduf_1 {
		name =  "Kinduf Nord";
		nearlocations[]={
			"Shegara",
			"Lobo_Rider_Bed",
			"Shegara_champ",
			"Kunduf_sation_depuration",
			"Base"
		};
		type = "Town";
		vehicles[] = {};
	};
	class Iban_camp_base {
		name =  "Iban camp base";
		nearlocations[]={
			"Shegara",
			"Shegara_champ",
			"Peleton_Camp_Base",
			"Orfar",
			"Iban_castle"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Iban_castle {
		name =  "Iban castle";
		nearlocations[]={
			"Peleton_Camp_Base",
			"Orfar",
			"Iban_camp_base",
			"Shegara_champ"
		};
		type = "Hill";
		vehicles[] = {};
	};
	class Puesto_Mate {
		name =  "Puesto Mate";
		nearlocations[]={
			"Bagdir",
			"Kinduf_Factorie",
			"Kinduf_Factorie_base"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Kinduf_Factorie {
		name =  "Kinduf Factorie";
		nearlocations[]={
			"Puesto_Mate",
			"Adrian_River",
			"Kinduf_Factorie_base"
		};
		type = "Field";
		vehicles[] = {};
	};
	class Kinduf_Factorie_base {
		name =  "Kinduf Factorie base";
		nearlocations[]={
			"Adrian_River",
			"Kinduf_Factorie"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Orfar {
		name =  "Orfar";
		nearlocations[]={
			"Peleton_Camp_Base",
			"Iban_camp_base",
			"Adrian_River",
			"Hill_1",
			"Offar",
			"Iban_castle"
		};
		type = "Town";
		vehicles[] = {};
	};
	class Peleton_Camp_Base {
		name =  "Peleton Camp Base";
		nearlocations[]={
			"Iban_castle",
			"Iban_camp_base",
			"Hill_1",
			"Fabiano_Camp_Base",
			"Orfar"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Orcarif {
		name =  "Orcarif";
		nearlocations[]={
			"Green_Camp_Base",
			"Lobo_Rider_Bed"
		};
		type = "Town";
		vehicles[] = {};
	};
	class Adrian_River {
		name =  "Adrian River";
		nearlocations[]={
			"Orfar",
			"Offar",
			"Kinduf_Factorie_base",
			"Kinduf_Factorie"
		};
		type = "Field";
		vehicles[] = {};
	};
	class Offar {
		name =  "Offar";
		nearlocations[]={
			"Hill_1",
			"Adrian_River",
			"Teruk",
			"Rommell_Caves",
			"Orfar"
		};
		type = "Town";
		vehicles[] = {};
	};
	class Teruk {
		name =  "Teruk";
		nearlocations[]={
			"Offar",
			"Hill_2",
			"Rommell_Caves"
		};
		type = "Town";
		vehicles[] = {};
	};
	class Rommell_Caves {
		name =  "Rommell Caves";
		nearlocations[]={
			"Offar",
			"Teruk"
		};
		type = "Hill";
		vehicles[] = {};
	};
	class Hill_1 {
		name =  "Orfar Colline";
		nearlocations[]={
			"Offar",
			"Orfar",
			"Peleton_Camp_Base",
			"Fabiano_Camp_Base",
			"Arobster",
			"Hill_2"
			
		};
		type = "Hill";
		vehicles[] = {};
	};
	class Hill_2 {
		name =  "Hill_2";
		nearlocations[]={
			"Arobster",
			"Yemara",
			"Teruk",
			"Hill_1"
		};
		type = "Hill";
		vehicles[] = {};
	};
	class Fabiano_Camp_Base {
		name =  "Fabiano Camp Base";
		nearlocations[]={
			"Arobster",
			"Hill_1",
			"Hill_3",
			"Afsher",
			"Peleton_Camp_Base"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Hill_3 {
		name =  "Hill_3";
		nearlocations[]={
			"Hill_4",
			"Fabiano_Camp_Base"
		};
		type = "Hill";
		vehicles[] = {};
	};
	class Arobster {
		name =  "Arobster";
		nearlocations[]={
			"Afsher",
			"Yeray_River_S",
			"Hill_2",
			"Hill_1",
			"Fabiano_Camp_Base"
		};
		type = "Base";
		vehicles[] = {};
	};
	class Afsher {
		name =  "Afsher";
		nearlocations[]={
			"Yeray_River_S",
			"Arobster",
			"Fabiano_Camp_Base"
		};
		type = "Town";
		vehicles[] = {};
	};
	class Yeray_River_S {
		name =  "Yeray River Sud";
		nearlocations[]={
			"Yemara",
			"Yemara_N",
			"Yeray_River_N",
			"Afsher",
			"Arobster"
		};
		type = "Field";
		vehicles[] = {};
	};
	class Yeray_River_N {
		name =  "Yeray River Nord";
		nearlocations[]={
			"Razbula",
			"Yemara_N",
			"Yeray_River_S"
		};
		type = "Field";
		vehicles[] = {};
	};
	class Yemara_N {
		name =  "Yemara Nord";
		nearlocations[]={
			"Yemara",
			"Yeray_River_S",
			"Yeray_River_N"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Yemara {
		name =  "Yemara";
		nearlocations[]={
			"Hill_2",
			"Yemara_N"
		};
		type = "Town";
		vehicles[] = {};
	};
	class Hill_4 {
		name =  "Hill_4";
		nearlocations[]={
			"Hill_3",
			"Puesto_Crow"
		};
		type = "Hill";
		vehicles[] = {};
	};
	class Puesto_Crow {
		name =  "Puesto_Crow";
		nearlocations[]={
			"Hill_4",
			"Hill_7",
			"Bramar"
		};
		type = "Town";
		vehicles[] = {};
	};
	class Green_Camp_Base {
		name =  "Green Camp Base";
		nearlocations[]={
			"Morut",
			"Patersone",
			"Bramar",
			"Orcarif"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Bramar {
		name =  "Bramar";
		nearlocations[]={
			"Puesto_Crow",
			"Orcarif",
			"Green_Camp_Base",
			"Patersone"
		};
		type = "Town";
		vehicles[] = {};
	};
	class Morut {
		name =  "Morut";
		nearlocations[]={
			"Green_Camp_Base",
			"Patersone",
			"Field_2",
			"Morut_Hill"
		};
		type = "Hill";
		vehicles[] = {};
	};
	class Patersone {
		name =  "Patersone";
		nearlocations[]={
			"Limari",
			"Bramar",
			"Morut",
			"Green_Camp_Base"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Razbula {
		name =  "Razbula";
		nearlocations[]={
			"Yeray_River_N",
			"Anyakar",
			"Zeko_Valley",
			"Hill_6"
		};
		type = "Town";
		vehicles[] = {};
	};
	class Anyakar {
		name =  "Anyakar";
		nearlocations[]={
			"Razbula",
			"Zeko_Valley"
		};
		type = "Town";
		vehicles[] = {};
	};
	class Zeko_Valley {
		name =  "Zeko Valley";
		nearlocations[]={
			"Anyakar",
			"Razbula",
			"Hill_6",
			"Hill_9",
			"Base"
		};
		type = "Hill";
		vehicles[] = {};
	};
	class Hill_6 {
		name =  "Hill_6";
		nearlocations[]={
			"Hill_9",
			"Hill_7",
			"Zeko_Valley"
		};
		type = "Hill";
		vehicles[] = {};
	};
	class Hill_7 {
		name =  "Hill_7";
		nearlocations[]={
			"Hill_6",
			"Hill_8",
			"Puesto_Crow"
		};
		type = "Hill";
		vehicles[] = {};
	};	
	class Hill_8 {
		name =  "Hill_8";
		nearlocations[]={
			"Hill_7",
			"Hill_10",
			"Hill_11"
		};
		type = "Hill";
		vehicles[] = {};
	};
	class Hill_9 {
		name =  "Hill_9";
		nearlocations[]={
			"Zeko_Valley",
			"Hill_10",
			"Hill_6",
			"Zarath"
		};
		type = "Hill";
		vehicles[] = {};
	};
	class Hill_10 {
		name =  "Hill_10";
		nearlocations[]={
			"Hill_11",
			"Hill_9",
			"Hill_8",
			"Zarath_W"
		};
		type = "Hill";
		vehicles[] = {};
	};
	class Hill_11 {
		name =  "Hill_11";
		nearlocations[]={
			"Hill_10",
			"Ramir",
			"Hill_8"
		};
		type = "Hill";
		vehicles[] = {};
	};
	class Zarath {
		name =  "Zarath";
		nearlocations[]={
			"Zarath_W",
			"Zarath_E",
			"Hill_9",
			"Hill_12"
		};
		type = "Town";
		vehicles[] = {};
	};
	class Zarath_E {
		name =  "Zarath Est";
		nearlocations[]={
			"Zarath",
			"Hill_13"
		};
		type = "Field";
		vehicles[] = {};
	};
	class Zarath_W {
		name =  "Zarath West";
		nearlocations[]={
			"Hill_12",
			"Kalae_Noowi_SE",
			"Zarath",
			"Hill_10"
		};
		type = "Field";
		vehicles[] = {};
	};
	class Hill_12 {
		name =  "Hill_12";
		nearlocations[]={
			"Hill_13",
			"Kamir",
			"Zarath_W",
			"Zarath"
		};
		type = "Hill";
		vehicles[] = {};
	};
	class Hill_13 {
		name =  "Hill_13";
		nearlocations[]={
			"Kamir",
			"Kamir_E",
			"Hill_12",
			"Zarath_E"
		};
		type = "Hill";
		vehicles[] = {};
	};
	class Kamir {
		name =  "Kamir";
		nearlocations[]={
			"Kamir_E",
			"Hill_14",
			"Hill_13",
			"Hill_12",
			"Hill_15"
		};
		type = "Town";
		vehicles[] = {};
	};
	class Kamir_E {
		name =  "Kamir Est";
		nearlocations[]={
			"Morar",
			"Hill_14",
			"Kamir",
			"Hill_13"
		};
		type = "Town";
		vehicles[] = {};
	};
	class Morar {
		name =  "Morar";
		nearlocations[]={
			"Hill_14",
			"Kamir_E"
		};
		type = "Town";
		vehicles[] = {};
	};
	class Hill_14 {
		name =  "Hill_14";
		nearlocations[]={
			"Kamir",
			"Kamir_E",
			"Morar",
			"Afarat"
		};
		type = "Hill";
		vehicles[] = {};
	};
	class Afarat {
		name =  "Afarat";
		nearlocations[]={
			"Hill_15",
			"Hill_14"
		};
		type = "Town";
		vehicles[] = {};
	};
	class Hill_15 {
		name =  "Hill_15";
		nearlocations[]={
			"Afarat",
			"Kamir",
			"Kalae_Noowi_NE",
			"Kalae_Noowi_Hospital"
		};
		type = "Field";
		vehicles[] = {};
	};
	class Kalae_Noowi_Hospital {
		name =  "Kalae Noowi Hospital";
		nearlocations[]={
			"Kalae_Noowi_NE",
			"Hill_15",
			"Kalae_Noowi_SE",
			"Kalae_Noowi",
			"Kalae_Noowi_NW",
			"Kalae_Noowi_Term",
			"Kalae_Noowi_Bunker"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Kalae_Noowi {
		name =  "Kalae Noowi";
		nearlocations[]={
			"Base",
			"Kalae_Noowi_NE",
			"Kalae_Noowi_Base",
			"Kalae_Noowi_SE",
			"Kalae_Noowi_Hospital",
			"Kalae_Noowi_NW",
			"Kalae_Noowi_Term",
			"Kalae_Noowi_Bunker"
		};
		type = "Town";
		vehicles[] = {};
	};
	class Kalae_Noowi_SE {
		name =  "Kalae Noowi Sud Est";
		nearlocations[]={
			"Ramir",
			"Zarath_W",
			"Kalae_Noowi_Hospital",
			"Kalae_Noowi"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Ramir {
		name =  "Ramir";
		nearlocations[]={
			"Hill_11",
			"Kalae_Noowi_SE",
			"Kalae_Noowi_Term"
		};
		type = "Town";
		vehicles[] = {};
	};
	class Kalae_Noowi_NE {
		name =  "Kalae Noowi Nord Est";
		nearlocations[]={
			"Kalae_Noowi_Hospital",
			"Kalae_Noowi",
			"Kalae_Noowi_NW",
			"Kalae_Noowi_Bunker",
			"Kalae_Noowi_Radio",
			"Hill_15"
		};
		type = "Field";
		vehicles[] = {};
	};
	class Kalae_Noowi_NW {
		name =  "Kalae Noowi Nord West";
		nearlocations[]={
			"Kalae_Noowi_Radio",
			"Kalae_Noowi_NE",
			"Kalae_Noowi_Hospital",
			"Kalae_Noowi",
			"Kalae_Noowi_Term",
			"Kalae_Noowi_Base",
			"Kalae_Noowi_Bunker"
		};
		type = "Field";
		vehicles[] = {};
	};
	class Kalae_Noowi_Term {
		name =  "Kalae Noowi Terminal";
		nearlocations[]={
			"Kalae_Noowi_Bunker",
			"Kalae_Noowi_NW",
			"Kalae_Noowi_Hospital",
			"Kalae_Noowi",
			"Kalae_Noowi_Base",
			"Kalae_Noowi_SW",
			"Ramir"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Kalae_Noowi_Base {
		name =  "Kalae Noowi Reg 44";
		nearlocations[]={
			"Kalae_Noowi_SW",
			"Kalae_Noowi_Term",
			"Kalae_Noowi_NW",
			"Kalae_Noowi_Bunker",
			"Kalae_Noowi_Radio",
			"Kalae_Noowi"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Kalae_Noowi_Bunker {
		name =  "Kalae Noowi Bunker";
		nearlocations[]={
			"Kalae_Noowi_NW",
			"Kalae_Noowi_Radio",
			"Kalae_Noowi_NE",
			"Kalae_Noowi_Hospital",
			"Kalae_Noowi",
			"Kalae_Noowi_Term",
			"Kalae_Noowi_Base",
			"Alfaraz"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Kalae_Noowi_Radio {
		name =  "Kalae Noowi Tour Radio";
		nearlocations[]={
			"Kalae_Noowi_NW",
			"Kalae_Noowi_Bunker",
			"Kalae_Noowi_NE",
			"Kalae_Noowi_Base",
			"Alfaraz"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Alfaraz {
		name =  "Alfaraz";
		nearlocations[]={
			"Kalae_Noowi_Radio",
			"Kalae_Noowi_Bunker"
		};
		type = "Town";
		vehicles[] = {};
	};
	class Kalae_Noowi_SW {
		name =  "Kalae Noowi Sud West";
		nearlocations[]={
			"Tunkuf",
			"Kandar",
			"Kalae_Noowi_Base",
			"Kalae_Noowi_Term"
		};
		type = "Field";
		vehicles[] = {};
	};
	class Limari {
		name =  "Limari";
		nearlocations[]={
			"Patersone",
			"Mikis_Fob"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Mikis_Fob {
		name =  "Mikis Fob";
		nearlocations[]={
			"Hill_16",
			"Kunara",
			"Limari"
		};
		type = "Base";
		vehicles[] = {};
	};
	class Kunara {
		name =  "Kunara";
		nearlocations[]={
			"Tunkuf",
			"Mikis_Fob",
			"Hill_16",
			"Zafir_NE",
			"Kunara_Hill"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Tunkuf {
		name =  "Tunkuf";
		nearlocations[]={
			"Kalae_Noowi_SW",
			"Kunara",
			"Kunara_Hill"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Kunara_Hill {
		name =  "Kunara Colline";
		nearlocations[]={
			"Kunara",
			"Zafir_NE",
			"Shoran_Hill",
			"Shoran",
			"Tunkuf"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Kandar {
		name =  "Kandar";
		nearlocations[]={
			"Hill_17",
			"Kandar_Hill",
			"Shoran_Hill",
			"Kalae_Noowi_SW"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Kandar_Hill {
		name =  "Kandar Colline";
		nearlocations[]={
			"Doran",
			"Nefer_Hill",
			"Kandar"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Doran {
		name =  "Doran";
		nearlocations[]={
			"Focheur",
			"Nefer_Hill",
			"Kandar_Hill"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Focheur {
		name =  "La Colline De Focheur";
		nearlocations[]={
			"Doran",
			"Nefer_Hill"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Nefer_Hill {
		name =  "Nefer Colline";
		nearlocations[]={
			"Puesto_Vulcan",
			"Nefer",
			"Hill_17",
			"Kandar_Hill",
			"Doran",
			"Focheur"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Nefer {
		name =  "Nefer";
		nearlocations[]={
			"Martin_Fob",
			"Limar_E",
			"Hill_17",
			"Puesto_Vulcan",
			"Nefer_Hill"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Hill_17 {
		name =  "Hill_17";
		nearlocations[]={
			"Kandar",
			"Shoran_Hill",
			"Limar_E",
			"Nefer",
			"Puesto_Vulcan"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Puesto_Vulcan {
		name =  "Puesto Vulcan";
		nearlocations[]={
			"Martin_Fob",
			"Limar_E",
			"Nefer_Hill",
			"Hill_17",
			"Nefer"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Shoran_Hill {
		name =  "Shoran Colline";
		nearlocations[]={
			"Kandar",
			"Shoran",
			"Kunara_Hill",
			"Hill_17"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Shoran {
		name =  "Shoran";
		nearlocations[]={
			"Shoran_Hill",
			"Zafir_NE",
			"Shoran_Hill",
			"Base"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Limar_E {
		name =  "Limar Est";
		nearlocations[]={
			"Nefer",
			"Martin_Fob",
			"Limar",
			"Puesto_Vulcan",
			"Hill_17"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Martin_Fob {
		name =  "Martin Fob";
		nearlocations[]={
			"Iban_Riverbed",
			"Limar",
			"Limar_E",
			"Puesto_Vulcan",
			"Nefer"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Iban_Riverbed {
		name =  "Iban Riverbed";
		nearlocations[]={
			"Martin_Fob",
			"Limar"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Limar {
		name =  "Limar";
		nearlocations[]={
			"Iban_Riverbed",
			"Martin_Fob",
			"Limar_S",
			"Mayankel_E",
			"Limar_E"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Zafir_NE {
		name =  "Zafir Nord Est";
		nearlocations[]={
			"Shoran",
			"Zafir",
			"Buushlurker_Camp_Base",
			"Hill_16",
			"Kunara",
			"Kunara_Hill"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Hill_16 {
		name =  "Hill_16";
		nearlocations[]={
			"Mikis_Fob",
			"Zafir_NE",
			"Buushlurker_Camp_Base",
			"Field_2",
			"Kunara"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Limar_S {
		name =  "Limar Sud";
		nearlocations[]={
			"Mayankel_E",
			"Mayankel",
			"Limar"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Mayankel {
		name =  "Mayankel";
		nearlocations[]={
			"Mayankel_Hill",
			"Mayankel_E",
			"Limar_S"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Mayankel_E {
		name =  "Mayankel Est";
		nearlocations[]={
			"Karift",
			"Mayankel",
			"Limar_S",
			"Limar"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Mayankel_Hill {
		name =  "Mayankel Colline";
		nearlocations[]={
			"Karift_Hill",
			"Kafira_Valley",
			"Mayankel"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Karift {
		name =  "Karift";
		nearlocations[]={
			"Karift_Hill",
			"Zafir",
			"Mayankel_E"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Zafir {
		name =  "Zafir";
		nearlocations[]={
			"Zafir_NE",
			"Buushlurker_Camp_Base",
			"Mafaraz",
			"Karift"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Karift_Hill {
		name =  "Karift Colline";
		nearlocations[]={
			"Karift",
			"Kafira_Valley",
			"Mayankel_Hill"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Kafira_Valley {
		name =  "Kafira Valley";
		nearlocations[]={
			"Abi_Valley_NW",
			"Mayankel_Hill",
			"Karift_Hill"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Buushlurker_Camp_Base {
		name =  "Buushlurker Camp Base";
		nearlocations[]={
			"Zafir",
			"Mafaraz_S",
			"Mafaraz",
			"Hill_16",
			"Zafir_NE"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Mafaraz {
		name =  "Mafaraz";
		nearlocations[]={
			"Buushlurker_Camp_Base",
			"Mafaraz_S",
			"Zafir"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Field_2 {
		name =  "Field_2";
		nearlocations[]={
			"Morut_Hill",
			"Morut",
			"Abi_Valley_E",
			"Hill_16"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Abi_Valley_E {
		name =  "Abi Valley Est";
		nearlocations[]={
			"Mafaraz_S",
			"Abi_Valley_SE",
			"Abi_Valley",
			"Morut_Hill",
			"Field_2"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Mafaraz_S {
		name =  "Mafaraz Sud";
		nearlocations[]={
			"Abi_Valley_NW",
			"Abi_Valley",
			"Abi_Valley_E",
			"Buushlurker_Camp_Base",
			"Mafaraz"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Morut_Hill {
		name =  "Morut_Hill";
		nearlocations[]={
			"Morut",
			"Amir",
			"Abi_Valley_E",
			"Field_2"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Abi_Valley_NW {
		name =  "Abi Valley Nord West";
		nearlocations[]={
			"Kafira_Valley",
			"Abi_Valley",
			"Mafaraz_S"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Abi_Valley {
		name =  "Abi Valley";
		nearlocations[]={
			"Abi_Valley_NW",
			"Abi_Valley_E",
			"Abi_Valley_SE",
			"Abi_Valley_S",
			"Abi_Valley_SW",
			"Mafaraz_S"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Abi_Valley_SE {
		name =  "Abi Valley Sud Est";
		nearlocations[]={
			"Abi_Valley_SE",
			"Abi_Valley_E",
			"Abi_Valley_S"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Abi_Valley_S {
		name =  "Abi Valley Sud";
		nearlocations[]={
			"Abi_Valley_SE",
			"Benamair_Hill",
			"Abi_Valley_SW",
			"Abi_Valley"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Abi_Valley_SW {
		name =  "Abi Valley Sud West";
		nearlocations[]={
			"Abi_Valley_S",
			"Le_Sarde",
			"Abi_Valley"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Amir {
		name =  "Amir";
		nearlocations[]={
			"Benamair_Hill",
			"Benamair",
			"Morut_Hill"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Benamair_Hill {
		name =  "Benamair Colline";
		nearlocations[]={
			"Amir",
			"Benamair",
			"Mozarat_Death",
			"Le_Sarde",
			"Abi_Valley_S"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Le_Sarde {
		name =  "Le Champs D'Herbe De Le Sarde";
		nearlocations[]={
			"Abi_Valley_SW",
			"Mozarat_Death",
			"Benamair_Hill"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Mozarat_Death {
		name =  "Mozarat Death";
		nearlocations[]={
			"Le_Sarde",
			"Zagun_Road",
			"Benamair",
			"Benamair_Hill"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Benamair {
		name =  "Benamair";
		nearlocations[]={
			"Amir",
			"Zagun_Road",
			"Benamair_Hill",
			"Mozarat_Death"
		};
		type = "Outpost";
		vehicles[] = {};
	};
	class Zagun_Road {
		name =  "Zagun Route";
		nearlocations[]={
			"Mozarat_Death",
			"Zagun",
			"Zregurat_industrie",
			"Benamair"
		};
		type = "Outpost";
		vehicles[] = {};
	};
};

