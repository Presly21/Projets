import 'package:get/get.dart';

class LocalString extends Translations{
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
   'en_EN':{
    'EDit':'Edit Task',
    'add':"ADD Task",
    'change':"Change Language",
    'Re':"Refrech",
    'lo':"Loading...",
    'up':"Update",
    'Sub':"Submit",
    'tas':"Add Task",
    'enter':"Enter Task",
    'Choose':"Choose a Language",
   },
   'fr_FR':{
     'add':"Ajouter une Tache",
    'change':"Change de Langue",
    'Re':"Rafrechir",
    'Choose':"Choisir une Langue",
    'lo':"Chargement...",
    'up':"Mise a Jour",
    'Sub':"Sumettre",
    'tas':"Ajourter une Tache",
    'enter':"Entrer  une Tache",
   },

  };
  
}