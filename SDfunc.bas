B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=10
@EndOfDesignText@
'Static code module
Sub Process_Globals
	Private BANano As BANano
	
	Private nToast As Int = 0
	Private listToast As List
	Private modalWin As BANanoElement
	Private mCallBack As Object
	Private mEventName As String
	
	Private mLayout As BANanoElement
	Private mbody As BANanoElement
	Public const TpeInfo As String = "lightgreen"
	Public const TpeError As String = "red"
	Public const TpeAlert As String = "yellow"
End Sub

' Before Build - SDFunf.Initialize(Banano)
Public Sub Initialize(mBANano As BANano)
	BANano=mBANano 
	'BANano.Header.AddJavascriptFile($""https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet""$)
	'BANano.Header.AddCSSFile("https://cdnjs.cloudflare.com/ajax/libs/skeleton/2.0.4/skeleton.min.css")
	BANano.Header.AddCSSFile("https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css")
	listToast.Initialize
End Sub

' Initialize Maps component
Public Sub InitializeGmap(key As String)
	BANano.Header.AddJavascriptFile($"https://maps.google.com/maps/api/js?key=${key}&libraries=drawing"$)
End Sub

' Initialize 3D component
Public Sub InitializeThreeD
	BANano.Header.AddJavascriptFile("https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js")
	BANano.Header.AddJavascriptFile("https://cdn.jsdelivr.net/npm/three@0.128.0/examples/js/loaders/OBJLoader.js")
End Sub

' Initializa TensorFlow light component
Public Sub InitializeTS
	BANano.Header.AddJavascriptFile("https://cdn.jsdelivr.net/npm/@tensorflow/tfjs@latest/dist/tf.min.js")
	'BANano.Header.AddJavascriptFile("https://cdn.jsdelivr.net/npm/@tensorflow/tfjs-vis@latest")
End Sub


' Inside Banano_Ready after body.Initialize
Public Sub ConfigBody(body As BANanoElement)
	mbody=body
	mbody.SetStyle($"{"height":"100vh","margin":"0","padding":"0"} "$)
	mbody.Append($"<div class="sdloading-container" id="sdloading"><div class="sdspinner"></div></div>"$)
	mbody.Append($" <div id="modalWin" class="sdmodal-overlay">
        <div class="sdmodal">
            <h2 id="sdModalTitle">Modal Windows</h2>
            <p id="sdModalText">Questo è un esempio di finestra modale.</p>
            <button id="sdmodalclose" class="sdclose-btn">Close</button>
			<button id="sdmodalother" class="sdconfirm-btn">Close</button>
			<button id="sdmodalconfirm" class="sdconfirm-btn">Confirm</button>
        </div>
    </div>"$)
	mbody.Append($"<div id="mainHolder"></div>"$).Get("#mainHolder")
	
	BANano.GetElement("#sdmodalclose").HandleEvents("click",Me,"modal_close")
	BANano.GetElement("#sdmodalconfirm").HandleEvents("click",Me,"modal_confirm")
	BANano.GetElement("#sdmodalother").HandleEvents("click",Me,"modal_other")
	modalWin=BANano.GetElement("#modalWin")
	
	mLayout=BANano.GetElement("#mainHolder")
End Sub

' SDfunc.Display (0=smartphone 1=big smartphone 2=Tablet 3= laptop 4=Desktop 5=big display
Public Sub Display As Int
	Dim I As Int = 0
	If BANano.Window.InnerWidth<=480 Then
		I=0
	Else If BANano.Window.InnerWidth<=768 Then
		I=1
	Else if BANano.Window.InnerWidth<=1024 Then
		I=2
	Else if BANano.Window.InnerWidth<=1280 Then
		I=3
	Else if BANano.Window.InnerWidth<=1536 Then
		I=4
	Else 
		I=5
	End If
	
	Return I
End Sub

Public Sub SetBodyImage(urlimage As String)
	mbody.SetStyle($"{ "background-image":"url('${urlimage}')", "background-size":"cover", "background-repeat":"no-repeat", "background-attachment":"fixed", "background-position":"center" }"$)
End Sub

Public Sub LoadingIndicator(Show As Boolean)
	If Show Then 
		BANano.GetElement("#sdloading").SetStyle($"{ "display":"flex" }"$)
	Else
		BANano.GetElement("#sdloading").SetStyle($"{ "display":"none" }"$)
	End If
End Sub

Public Sub MainLayout As BANanoElement
	mLayout.Empty
	Return mLayout
End Sub

Public Sub SetMainLayout(B As BANanoElement)
	mLayout=B
End Sub

Public Sub ResetMainLayout
	mLayout=BANano.GetElement("#mainHolder")
End Sub

Public Sub ShowToast(Text As String, Tpe As String, Durate As Int, Cancellable As Boolean)
	Dim Toast As BANanoElement
	nToast=nToast+1
			
	BANano.GetElement("#body").Append($"<div id="sdtoast${nToast}" style="height: 35px; bottom: ${(nToast*50-25)}px;display: flex;" class="sdtoast">
	<div style="max-width: 10px; flex: 1; background-color: ${Tpe};"></div><div style="left: 20px; flex:1;">${Text}</div></div>"$)
	Toast = BANano.GetElement($"#sdtoast${nToast}"$)
	
	listToast.Add(Toast)
	Toast.AddClass("show")
	Sleep(Durate)
	Toast.Name
	listToast.RemoveAt(listToast.IndexOf(Toast))
	Toast.RemoveClass("show")
	Toast.Remove
	If listToast.Size<nToast-1 Then nToast=0
End Sub

' Event: EventName_ModalClick(Success As Boolean)
'<code>Private Sub EventName_ModalClick(Success As Boolean)
'	'Your Code
'End Sub</code>
public Sub ShowModal(CallBack As Object, EventName As String, Title As String, Text As String, btnCancel As String, btnConfirm As String, btnOther As String)
	mCallBack=CallBack
	mEventName=EventName
	BANano.GetElement("#sdModalTitle").SetText(Title)
	BANano.GetElement("#sdModalText").SetText(Text)
	BANano.GetElement("#sdmodalclose").SetText(btnCancel)
	BANano.GetElement("#sdmodalconfirm").SetText(btnConfirm)
	BANano.GetElement("#sdmodalother").SetText(btnOther)
	If btnCancel="" Then BANano.GetElement("#sdmodalclose").SetStyle($"{"visibility": "hidden"}"$) Else BANano.GetElement("#sdmodalclose").SetStyle($"{"visibility": "visible"}"$)
	If btnConfirm="" Then BANano.GetElement("#sdmodalconfirm").SetStyle($"{"visibility": "hidden"}"$) Else BANano.GetElement("#sdmodalconfirm").SetStyle($"{"visibility": "visible"}"$)
	If btnOther="" Then BANano.GetElement("#sdmodalother").SetStyle($"{"visibility": "hidden"}"$) Else BANano.GetElement("#sdmodalother").SetStyle($"{"visibility": "visible"}"$)
	modalWin.SetStyle($"{"display": "block"}"$)
End Sub

Public Sub prompt(Message As String, Default As String) As String
	'Return BANano.JS($"prompt("${Message}", "${Default}");"$).ToString
	Return BANano.RunJavascriptMethod("winprompt", Array(Message,Default))
End Sub

Private Sub modal_close
	modalWin.SetStyle($"{"display": "none"} "$)
	BANano.CallSub(mCallBack,mEventName & "_ModalClick",Array As String(BANano.GetElement("#sdmodalclose").GetText))
End Sub

Private Sub modal_confirm
	modalWin.SetStyle($"{"display": "none"} "$)
	BANano.CallSub(mCallBack,mEventName & "_ModalClick",Array As String(BANano.GetElement("#sdmodalconfirm").GetText))
End Sub

Private Sub modal_other
	modalWin.SetStyle($"{"display": "none"} "$)
	BANano.CallSub(mCallBack,mEventName & "_ModalClick",Array As String(BANano.GetElement("#sdmodalother").GetText))
End Sub

public Sub ShowModalTimed(Title As String, Text As String, DurationMS As Long)
	BANano.GetElement("#sdModalTitle").SetText(Title)
	BANano.GetElement("#sdModalText").SetText(Text)
	BANano.GetElement("#sdmodalclose").SetStyle($"{"visibility": "hidden"}"$) 
	BANano.GetElement("#sdmodalconfirm").SetStyle($"{"visibility": "hidden"}"$)
	BANano.GetElement("#sdmodalother").SetStyle($"{"visibility": "hidden"}"$)
	modalWin.SetStyle($"{"display": "block"}"$)
	Sleep(DurationMS)
	modalWin.SetStyle($"{"display": "none"} "$)
End Sub

Public Sub NavigateTo(MainPageElement As BANanoElement, LayoutName As String)
	MainPageElement.Empty
	MainPageElement.LoadLayout(LayoutName)
End Sub

Public Sub SDRegEx(Pattern As String, str As String) As String()
	Dim I As Int = 0
	Dim F As Int = 0
	Dim Le As Int = Pattern.Length
	Dim L As List
	
	'l=BANano.Split(".", "alain.is.here")
	If Not(str.EndsWith(Pattern)) Then str=str & Pattern
	L.Initialize
	F=str.IndexOf2(Pattern,0)
	Do While F>-1
		L.Add(str.SubString2(I,F))
		I=F+Le
		F=str.IndexOf2(Pattern,i)
	Loop
	
	If l.Size=0 Then
		Return Array As String()
	Else
		Dim Rs(l.Size) As String
		For i=0 To L.Size-1
			Dim S As String = L.Get(I)
			Rs(I)=S.Trim
		Next
		
		Return Rs
	End If
End Sub

Public Sub BANano_namespace As String
	Return BANano.RunJavascriptMethod("namespacekeys", Null)
End Sub

#IF Javascript

function namespacekeys() {
    for (const key in window) {
        if (key.startsWith("_banano_")) {
            return key; // Restituisce il primo risultato trovato
        }
    }
    return null; // Se nessun risultato è trovato, restituisce null
}

function winprompt(message,dfault) {
	return prompt(message, dfault);
}

#End If


#IF CSS
/* ------------------------------ ROOT -------------------------*/
:root {
            --menubg-color: #007BFF; /* Colore di sfondo del menu */
            --menutext-color: #FFFFFF; /* Colore del testo */
            --hover-menubg-color: #0056b3; /* Colore di sfondo al passaggio del mouse */
            --hover-menutext-color: #FFD700; /* Colore del testo al passaggio del mouse */
        }
		
/* ------------------------ BODY ------------------------- */
body {
		font-family: 'Roboto', sans-serif;
	 }

 /* ------------------------ TOAST -------------------------- */
	/* Toast Styles */
	.sdtoast {
	  visibility: hidden; /* Nascondi di default */
	  min-width: 250px;
	  margin: 0 auto;
	  background-color: #333;
	  color: #fff;
	  text-align: center;
	  border-radius: 5px;
	  padding: 5px;
	  position: fixed;
	  bottom: 30px;
	  left: 50%;
	  transform: translateX(-50%);
	  z-index: 1;
	  font-size: 17px;

	  /* Effetti di transizione */
	  opacity: 0;
	  transition: visibility 0s, opacity 0.5s ease-in-out;
	}

	/* Mostra il toast */
	.sdtoast.show {
	  visibility: visible;
	  opacity: 1;
	}
	
/* --------------------------- CLASSI DI APPOGGIO ---------------- */
.u-hide {
  display: none;
}

 /* -----------------------------  Stili per label */
    .sd-label {
      background-color: #FFFFFF; 
      border: none;
      color: black;
      padding: 15px 32px;
      text-align: center;
      text-decoration: none;
      display: inline-flex; /* Utilizzo di flexbox per l'allineamento */
      justify-content: center; /* Centra il testo orizzontalmente */
      align-items: center; /* Centra il testo verticalmente */
      font-size: 16px;
      border-radius: 8px; /* Angoli arrotondati */
      cursor: pointer;
      transition: background-color 0.3s ease, transform 0.2s ease;
	  box-sizing: border-box; 
	  overflow: hidden;
	  width: 100%;
    }

    /* Effetto di focus (quando il bottone è selezionato) */
    .sd-label:focus {
      outline: none;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    }

 /* -----------------------------  Stili per il bottone */
    .sd-button {
      background-color: #FFFFFF; /* Colore di sfondo verde */
      border: none;
      color: black;
      padding: 15px 32px;
      text-align: center;
      text-decoration: none;
      display: inline-flex; /* Utilizzo di flexbox per l'allineamento */
      justify-content: center; /* Centra il testo orizzontalmente */
      align-items: center; /* Centra il testo verticalmente */
      font-size: 16px;
      border-radius: 8px; /* Angoli arrotondati */
      cursor: pointer;
      transition: background-color 0.3s ease, transform 0.2s ease;
    }

    /* Effetto hover */
    .sd-button:hover {
      background-color: #45a049; /* Colore di sfondo quando si passa sopra */
      transform: scale(1.1); /* Aumento dimensione al passaggio del mouse */
    }

    /* Effetto di focus (quando il bottone è selezionato) */
    .sd-button:focus {
      outline: none;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    }

 /* -----------------------------  Stili per stepper */
    .sd-stepper {
      background-color: #AAAAAA; /* Colore di sfondo grigio */
      border: none;
      color: white;
      padding: 15px 32px;
      text-align: center;
      text-decoration: none;
      display: inline-flex; /* Utilizzo di flexbox per l'allineamento */
      justify-content: center; /* Centra il testo orizzontalmente */
      align-items: center; /* Centra il testo verticalmente */
      font-size: 18px;
      border-radius: 10px; /* Angoli arrotondati */
      cursor: pointer;
      transition: background-color 0.3s ease, transform 0.2s ease;
    }

    /* Effetto hover */
    .sd-stepper:hover {
      background-color: #45A049; /* Colore di sfondo quando si passa sopra */
	  color: black;
      transform: scale(1.1); /* Aumento dimensione al passaggio del mouse */
    }

    /* Effetto di focus (quando il bottone è selezionato) */
    .sd-stepper:focus {
      outline: none;
      box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
    }
	
/* -------------------------------------- Contenitore dello switch */
        /* Stile comune per gli switch */
        .sdswswitch {
            position: relative;
            display: inline-block;
            width: 60px;
            height: 34px;
            margin: 10px;
        }

        .sdswswitch input {
            display: none;
        }

        .sdswslider {
            position: absolute;
            cursor: pointer;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background-color: #ccc;
            transition: 0.4s;
            border-radius: 34px;
        }

        .sdswslider:before {
            position: absolute;
            content: "";
            height: 26px;
            width: 26px;
            left: 4px;
            bottom: 4px;
            background-color: white;
            transition: 0.4s;
            border-radius: 50%;
        }

        /* Stato ON */
        input:checked + .sdswslider {
            background-color: #4caf50;
        }

        input:checked + .sdswslider:before {
            transform: translateX(26px);
        }

        /* Punti di stato */
        .status {
            margin-top: 10px;
        }


/* -------------------------------------- Contenitore SELECT */
	.sd-select {
     position: relative;
     display: inline-block;
     max-width: 100%; /* Definisci una larghezza fissa */
    }

    .sd-select select {
      display: none; /* Nascondi il select nativo */
    }

    .sdselect-selected {
      background-color: #f0f0f0;
      padding: 10px;
      border: 1px solid #ccc;
      border-radius: 5px;
      cursor: pointer;
	  max-width: 100%; /* Assicurati che riempia il contenitore */
	  border-radius: 20px;
    }

    .sdselect-items {
      position: absolute;
      background-color: #fff;
      border: 1px solid #ccc;
      border-radius: 5px;
      margin-top: 5px;
      z-index: 99;
      display: none;
	  width: 100%;
	  max-width: 300px; /* Mantieni le opzioni larghe quanto il selezionato */
      max-height: 200px;
	  border-radius: 10px;
	  overflow-y: auto; 
    }

    .sdselect-items div {
      padding: 10px;
      cursor: pointer;
      max-width: 100%; /* Assicurati che siano larghe quanto il contenitore */
    }

    .sdselect-items div:hover {
      background-color: #ddd;
    }


/* ----------------------------------------- ICON BUTTON ---------------------------------- */

 /* Stile per il bottone */
        .sdicon-button {
            display: inline-flex;
            justify-content: center;
            align-items: center;
            width: 60px; /* Larghezza del bottone */
            height: 60px; /* Altezza del bottone */
            border: none;
            border-radius: 50%; /* Rende il bottone rotondo */
            background-color: #007BFF; /* Colore di sfondo */
            color: white; /* Colore dell'icona */
            font-size: 24px; /* Dimensione dell'icona */
            cursor: pointer; /* Cambia il cursore quando si passa sopra */
            box-shadow: 0 3px 3px rgba(0, 0, 0, 0.2); /* Aggiunge ombra */
            transition: background-color 0.3s, transform 0.2s; /* Effetto hover */
			 text-decoration: none; 
        }

        /* Stile al passaggio del mouse */
        .sdicon-button:hover {
            background-color: #0056b3; /* Colore più scuro in hover */
            transform: scale(1.1); /* Leggero ingrandimento */
        }

        /* Stile per disabilitare il focus del bordo */
        .sdicon-button:focus {
            outline: none;
        }
		
		
/* ----------------------------------------- GRID ---------------------------------- */
  .sdgrid {
    position: relative;
    width: 100%;
    /* max-width: 960px; */
    margin: 0 auto;
    padding: 0 20px;
    box-sizing: border-box;
	}
	
  .sdgrid {
  	display: flex;
  	flex-direction: column; /* Disporre le righe in colonna */
	/* overflow: hidden; */
  	gap: 10px; /* Spaziatura tra le righe */
	box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
	background: #ffffff;
	}

  .sdgridheader {
  	display: flex; /* Disporre le colonne in riga */
  	justify-content: space-between; /* Spaziatura uniforme tra le colonne */
  	gap: 0px; /* Spaziatura tra le colonne */
	font-size: 14px;
	background-color: #6200ea;
    color: #ffffff;
	}
	
  .sdgridrow {
	display: flex; /* Disporre le colonne in riga */
	justify-content: space-between; /* Spaziatura uniforme tra le colonne */
	gap: 1px; /* Spaziatura tra le colonne */
	font-size: 14px;
	/* background: linear-gradient(135deg, #4a90e2, #005f99); */
	}
	
  .sdgridrow:nth-child(even) {
    background-color: #fafafa;
    }

  .sdgridrow:hover {
    background-color: #f1f1f1;
    }

  .sdgridcolumn {
  	flex: 1; /* Occupa lo stesso spazio */
  	text-align: left;
  	padding: 10px;
  	/* background-color: lightblue; */
  	border: 0px solid #ccc;
	}

/* -------------------------------- LIST View ---------------------------- */
	.sdlistview {
      list-style-type: none; /* Rimuove i puntini della lista */
      margin: 0;
      padding: 0;
      border: 1px solid #ccc; /* Bordo per la lista */
      border-radius: 5px;
      max-width: 400px;
    }
    .sdlistview li {
      padding: 15px;
      border-bottom: 1px solid #ccc;
      cursor: pointer;
	  margin: 3px;
      padding: 3px;
    }
    .sdlistview li:last-child {
      border-bottom: none; /* Rimuove il bordo dall'ultimo elemento */
    }
    .sdlistview li:hover {
      background-color: #f0f0f0; /* Cambia colore al passaggio del mouse */
    }

/* ---------------------------- COMBO ----------------------------------- */
        /* Stile per i suggerimenti */
        .sdcombos {
            border: 1px solid #ddd;
			border-radius: 5px;
            background-color: #fff;
            /* position: absolute; */
            max-height: 150px;
			overflow-y: auto;
        }
		.sdcombos:empty {
			border: none;
    		background-color: transparent; /* Opzionale, per rimuovere anche lo sfondo */
		}
        .sdcombo {
            padding: 0px;
            cursor: pointer;
        }
        .sdcombo:hover {
            background-color: #f0f0f0;
        }


/* ------------------------------- Modal --------------------------------- */

 /* Stile per il background scuro */
        .sdmodal-overlay {
            display: none; /* Nascondi di default */
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5); /* Sfondo semitrasparente */
            z-index: 999; /* Posizionamento sopra altri elementi */
        }

        /* Stile per il contenitore della finestra modale */
        .sdmodal {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background-color: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            z-index: 1000;
            width: 80%;
            max-width: 400px;
        }

        /* Pulsante per chiudere la modale */
        .sdclose-btn {
            background: red;
            color: white;
            border: none;
            border-radius: 5px;
            padding: 5px 10px;
            cursor: pointer;
            font-size: 1rem;
        }

        /* Pulsante per aprire la modale */
        .sdconfirm-btn {
			background: green;
			color: white;
			border: none;
            border-radius: 5px;
            padding: 5px 10px;
            cursor: pointer;
			font-size: 1rem;
        }

/* ---------------------------- PLANNING ----------------------------------- */
        /* Stile per i suggerimenti */
        .sdplanning {
			width: 100%;
			display: flex; /* Disporre le colonne in riga */
			flex-direction: row; /* Disporre le righe in colonna */
			justify-content: space-between; /* Spaziatura uniforme tra le colonne */
			gap: 1px; /* Spaziatura tra le colonne */
			font-size: 14px;
			border: 1px solid gray;
        }
		.sdplanningcol {
			flex: 1; /* Occupa lo stesso spazio */
  			text-align: left;
  			padding: 1px;
  			/* background-color: lightblue; */
  			border: 0px solid #ccc;
			width: 14%;
        }
		.sdplanitem {
			display: flex;
			align-items: center;
			border: 1px solid #ccc; /* Bordo sottile */
			border-radius: 10px; /* Angoli arrotondati */
			padding: 20px;
			box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1); /* Opzionale: effetto ombra */
			overflow: hidden; /* Impedisce al testo di uscire */
			min-height: 30px;
			margin-bottom: 5px; /* Spazio tra i contenitori */
		}
		.sdplanvert {
			transform: rotate(90deg); /* Ruota il testo di 90 gradi */
			transform-origin: left top; /* Regola il punto di rotazione */
			font-size: 14px;
			margin-right: 5px;
			color: black;
			background: lightgray;
			padding: 7px;
			border-radius: 10px; /* Angoli arrotondati */
			white-space: nowrap; /* Impedisce al testo di andare a capo */
			position: relative;
   			top: -10px; /* Sposta verso l’alto */
			left: 5px;
		}
		.sdplanhoriz {
			font-size: 14px;
			margin-right: 5px;
			color: black;
			white-space: nowrap; /* Impedisce al testo di andare a capo */
			position: relative;
			left: -30px;
		}

/** ------------------------------ Calendar ----------------------------------- **/
 		.sdcalendar {
            /**max-width: 320px;**/
            /**min-width: 300px;**/
            /**width: 320px;**/
            /**box-sizing: border-box;**/
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }
        .sdcalendar-header {
            background-color: #4CAF50;
            color: white;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 10px 15px;
            font-size: 20px;
            font-weight: bold;
        }
        .sdcalendar-body {
            display: grid;
            grid-template-columns: repeat(7, 1fr);
            border-top: 1px solid #ddd;
			 background-color: #FFFFFFDD;
        }
        .sdmonth-title {
            flex: 1;
            text-align: center;
        }
        .sdday {
            padding: 10px;
            text-align: center;
            border: 1px solid #ddd;
            background-color: #f9f9f9;
			margin: 1px;
        }
        .sdday-header {
            background-color: #f0f0f0;
            font-weight: bold;
        }
        .sdday.empty {
            background-color: #ffffff;
        }
        .sdnav-button {
            background-color: white;
            color: gray;
            border: 2px solid lightgray;
            border-radius: 50%;
            width: 30px;
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: all 0.3s;
        }
        .sdnav-button:hover {
            background-color: lightgray;
            color: white;
        }
/** --------------------------- Horizzontal MENU ------------------------------- **/

.sdmenu {
  display: flex; /* mantiene le voci sulla stessa riga */
  justify-content: center;
  padding: 0;
  margin: 0;
  list-style: none;
  background-color: var(--menubg-color); /* sfondo del menu */
}

.sdmenu li {
  position: relative; /* necessario per la linea animata */
  margin: 5px 5px;
  padding: 10px 15px 12px 15px; /* padding-bottom maggiore per la linea */
  color: var(--menutext-color);
  text-decoration: none;
  transition: color 0.3s ease;
  cursor: pointer;
  display: inline-block; /* così rimangono sulla stessa riga */
}

/* Linea animata */
.sdmenu li::after {
  content: "";
  position: absolute;
  left: 0;
  bottom: 0;
  width: 0%;
  height: 2px;
  background-color: var(--hover-menubg-color);
  transition: width 0.3s ease;
}

.sdmenu li:hover::after {
  width: 100%;
}

/* Facoltativo: cambiare colore del testo al passaggio del mouse */
.sdmenu li:hover {
  color: var(--hover-menutext-color);
  font-weight: bold;
}


/* -------------------------------------------- TIME picker  ---------------------------------------- */
        .sdtime-picker {
            background-color: #f0f0f0;
            padding: 5px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
			width: 200px;
        }
		
		
 		.sdtime-picker p {
			text-align: center;
		}
		
        .sdtime-picker input[type="time"] {
            padding: 10px;
            font-size: 16px;
            border: 2px solid #ccc;
            border-radius: 8px;
            margin-top: 10px;
			width: 100%;
			text-align: center;
			box-sizing: border-box;
        }

        .sdtime-picker input[type="time"]:hover {
            border-color: #3498db;
            outline: none;
        }
		
/* ----------------------------------- DATE PICKER ----------------------------------- */
	.sddate-picker {
		padding: 5px;
		border: 2px solid #3498db;
		border-radius: 8px;
		background-color: #fff;
		color: #3498db;
		max-width: 220px;
		transition: border-color 0.3s ease;
	}

	.sddate-picker:focus {
		border-color: #2980b9;
		outline: none;
		font-size: 16px;
	}
	
	.sddate-picker input[type="date"] {
        padding: 10px;
        font-size: 16px;
        border: 2px solid #ccc;
        border-radius: 8px;
        margin-top: 10px;
		width: 100%;
		text-align: center;
		border-color: lightgray;
		box-sizing: border-box;  /* non oltre */
	}

	.sddate-picker::-webkit-calendar-picker-indicator {
		background: url('https://img.icons8.com/ios/452/calendar.png') no-repeat center center;
		background-size: 20px;
		opacity: 0.6;
	}

	.sddate-picker::-webkit-input-placeholder {
		color: #95a5a6;
	}

	.sddate-picker input:hover {
		border-color: #3498db;
		outline: none;
	}

/* ----------------------------------- Input PICKER -----------------------------------*/
	.sdinput-picker {
		border: 2px solid #ccc;
		border-radius: 15px;
		padding: 15px;
		outline: none;
		font-size: 16px;
	}
	.sdinput-picker:hover {
		border-color: #3498db;
	}
	.sdinput-picker input {
		box-sizing: border-box;
	}
	
/* -------------------------------------------- SIDEBAR -------------------------------------*/
    /* Contenitore del menu */
	.sd-sidebar {
		height: 100%;
		width: 0px;
		position: fixed;
		top: 0;
		left: 0;
		background-color: #111;
		overflow-x: hidden;
		transition: 0.3s;
		padding-top: 60px;
    }

    /* Link del menu */
    .sd-sidebar-div {
      padding: 10px 15px;
      text-decoration: none;
      font-size: 18px;
      color: #fff;
      transition: 0.3s;
    }

    /* Effetto hover sui link */
    .sd-sidebar-div:hover {
      background-color: #575757;
    }

/* --------------------------------------- SEEK BAR --------------------------- */
    .sdseekbar-container {
      width: 100%;
    }
    .sdseekbar {
      width: 100%;
      height: 8px;
      background-color: #ccc;
      border-radius: 4px;
      position: relative;
	  margin-bottom: 5px;
    }
    .sdseekbar-progress {
      height: 100%;
      background-color: #007bff;
      border-radius: 4px;
      width: 0;
    }
    .sdseekbar-thumb {
      width: 16px;
      height: 16px;
      background-color: #007bff;
      border-radius: 50%;
      position: absolute;
      top: 50%;
      transform: translate(-50%, -50%);
      cursor: pointer;
    }
    .sddisplay {
      text-align: center;
      margin-top: 10px;
      font-size: 14px;
      color: #555;
    }
	
/* -------------------------------- LOADIN>G  ----------------------------------*/
	
        .sdloading-container {
            display: none; /* Nascondilo di default */
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: none;
            justify-content: center;
            align-items: center;
            z-index: 1000;
        }

        /* Lo spinner */
        .sdspinner {
            width: 50px;
            height: 50px;
            border: 5px solid rgba(255, 255, 255, 0.3);
            border-top-color: white;
            border-radius: 50%;
            animation: sdspin 1s linear infinite;
        }

        /* Animazione */
        @keyframes sdspin {
            from {
                transform: rotate(0deg);
            }
            to {
                transform: rotate(360deg);
            }
        }
	
/* -------------------------------- TARGA ------------------------------------------- */
  .sd-targa {
    width: 400px;
    height: 110px;
    background-color: white;
    border: 2px solid black;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    font-family: 'Arial', sans-serif;
    position: relative;
  }
  
  .sd-targa .blu {
    width: 50px;
    height: 100%;
    background-color: #005BBB;
    display: flex;
    justify-content: center;
    align-items: center;
    color: white;
    font-weight: bold;
    font-size: 18px;
  }

  /* Testo della targa */
  .sd-targa .testo {
    flex: 1;
    text-align: center;
    font-size: 30px;
    letter-spacing: 8px;
    font-weight: bold;
    color: black;
  }
  
 /* ----------------------------- EDITOR ------------------------------ */
 .sdeditor {
	width: 95%;
	min-width: 300px;
	min-height: 300px;
	border: 1px solid #ccc;
	padding: 10px;
	margin: 10px 5px;
	overflow-y: auto;
	text-align: left;
	}
 #colorPicker, #bgColorPicker {
            margin: 5px;
            border: 1px solid #ddd;
            padding: 3px;
            border-radius: 4px;
            cursor: pointer;
			height: 30px;
            width: 30px;
        }
		
/* ------------------------------ CLOCK -------------------------------*/
    .sdclock {
      background: #FFFFFF;
      padding: 10px 10px;
      border-radius: 20px;
      box-shadow: 0 0 15px #00ffcc;
    }
#End If
