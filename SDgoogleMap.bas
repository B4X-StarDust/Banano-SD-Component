B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'Custom BANano View class

#Event: Click (Lat As Double, Lng As Double)
#Event: DblClick (Lat As Double, Lng As Double)
#Event: MouseMove (Lat As Double, Lng As Double)
#Event: ZoomChanged (Zoom As Int)
#Event: CenterMapMove (Lat As Double, Lng As Double)
#Event: Ready (Success As Boolean)
#Event: MarkerClick (Title As String, MarkerObject As BANanoObject)
#Event: MarkerDblClick (Title As String, MarkerObject As BANanoObject)
#Event: PolygonClick (PolygonObject As BANanoObject)
#Event: PolygonDblClick (PolygonObject As BANanoObject)
#Event: PolylineClick (PolylineObject As BANanoObject)
#Event: PolylineDblClick (PolylineObject As BANanoObject)
#Event: CircleClick (CircleObject As BANanoObject)
#Event: CircleDblClick (CircleObject As BANanoObject)
#Event: InfoWindowCloseClick(InfoWindow As BANanoObject)

'Uncomment the events you want to show to the user and implement the HandleEvents in DesignerCreateView 
'#Event: Focus (event As BANanoEvent)
'#Event: Blur (event As BANanoEvent)
'#Event: Resize (event As BANanoEvent)
'#Event: Scroll (event As BANanoEvent)
'#Event: Keydown (event As BANanoEvent)
'#Event: KeyPress (event As BANanoEvent)
'#Event: KeyUp (event As BANanoEvent)
'#Event: Click (event As BANanoEvent)
'#Event: ContextMenu (event As BANanoEvent)
'#Event: Dblclick (event As BANanoEvent)
'#Event: MouseDown (event As BANanoEvent)
'#Event: MouseEnter (event As BANanoEvent)
'#Event: MouseLeave (event As BANanoEvent)
'#Event: MouseMove (event As BANanoEvent)
'#Event: MouseOver (event As BANanoEvent)
'#Event: MouseOut (event As BANanoEvent)
'#Event: MouseUp (event As BANanoEvent)
'#Event: Wheel (event As BANanoEvent)
'#Event: Drag (event As BANanoEvent)
'#Event: DragEnd (event As BANanoEvent)
'#Event: DragEnter (event As BANanoEvent)
'#Event: DragStart (event As BANanoEvent)
'#Event: DragLeave (event As BANanoEvent)
'#Event: DragOver (event As BANanoEvent)
'#Event: Drop (event As BANanoEvent)
'#Event: TouchCancel (event As BANanoEvent)
'#Event: TouchEnd (event As BANanoEvent)
'#Event: TouchEnter (event As BANanoEvent)
'#Event: TouchLeave (event As BANanoEvent)
'#Event: TouchMove (event As BANanoEvent)
'#Event: TouchStart (event As BANanoEvent)
'#Event: Change (event As BANanoEvent)

' Properties that will be show in the ABStract Designer.  They will be passed in the props map in DesignerCreateView (Case Sensitive!)
#DesignerProperty: Key: mWidth, DisplayName: Width, FieldType: String, DefaultValue: 100vw, Description: width
#DesignerProperty: Key: mHeight, DisplayName: Height, FieldType: String, DefaultValue: 70vh, Description: Height
#DesignerProperty: Key: mDBLClickZoom, DisplayName: Disable DblClick Zoom, FieldType: Boolean, DefaultValue: False, Description: Disable double clicking on the map to zoom
#DesignerProperty: Key: Classes, DisplayName: Classes, FieldType: String, DefaultValue: , Description: Classes added to the HTML tag.
#DesignerProperty: Key: Style, DisplayName: Style, FieldType: String, DefaultValue: , Description: Styles added to the HTML tag. Must be a json String.
#DesignerProperty: Key: MarginLeft, DisplayName: Margin Left, FieldType: String, DefaultValue: , Description: Margin Left
#DesignerProperty: Key: MarginRight, DisplayName: Margin Right, FieldType: String, DefaultValue: , Description: Margin Right
#DesignerProperty: Key: MarginTop, DisplayName: Margin Top, FieldType: String, DefaultValue: , Description: Margin Top
#DesignerProperty: Key: MarginBottom, DisplayName: Margin Bottom, FieldType: String, DefaultValue: , Description: Margin Bottom
#DesignerProperty: Key: PaddingLeft, DisplayName: Padding Left, FieldType: String, DefaultValue: , Description: Padding Left
#DesignerProperty: Key: PaddingRight, DisplayName: Padding Right, FieldType: String, DefaultValue: , Description: Padding Right
#DesignerProperty: Key: PaddingTop, DisplayName: Padding Top, FieldType: String, DefaultValue: , Description: Padding Top
#DesignerProperty: Key: PaddingBottom, DisplayName: Padding Bottom, FieldType: String, DefaultValue: , Description: Padding Bottom
#DesignerProperty: Key: Enabled, DisplayName: Enabled, FieldType: Boolean, DefaultValue: True, Description: If enabled.
#DesignerProperty: Key: Visible, DisplayName: Visible, FieldType: Boolean, DefaultValue: True, Description: If visible.
Sub Class_Globals
    Private BANano As BANano 'ignore
	Private mName As String 'ignore
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mTarget As BANanoElement 'ignore
	Private mElement As BANanoElement 'ignore
	
	Private mWidth As String = ""
	Private mHeight As String = ""
	Private mDBLClickZoom As Boolean = False
	Private mClasses As String = ""
	Private mStyle As String = ""
	Private mMarginLeft As String = ""
	Private mMarginRight As String = ""
	Private mMarginTop As String = ""
	Private mMarginBottom As String = ""
	Private mPaddingLeft As String = ""
	Private mPaddingRight As String = ""
	Private mPaddingTop As String = ""
	Private mPaddingBottom As String = ""
	Private mVisible As Boolean = True
	Private mEnabled As Boolean = True

	Private Rdy As Boolean
	Private Maps As Object
	Private mTag As Object
End Sub

' initializes the component
Public Sub Initialize (CallBack As Object, Name As String, EventName As String)
	mName = Name
	mEventName = EventName.ToLowerCase
	mCallBack = CallBack
	
	Rdy=False
End Sub

' returns the BANanoElement
public Sub getElement() As BANanoElement
	Return mElement
End Sub

' returns the tag id
public Sub getID() As String
	Return mName
End Sub

' this is the place where you create the view in html and run initialize javascript
Public Sub DesignerCreateView (Target As BANanoElement, Props As Map)
	mTarget = Target

	If Props <> Null Then
		mWidth = Props.Get("mWidth")
		mHeight = Props.Get("mHeight")
		mDBLClickZoom = Props.Get("mDBLClickZoom")
		mClasses = Props.Get("Classes")
		mStyle = Props.Get("Style")
		mMarginLeft = Props.Get("MarginLeft")
		mMarginRight = Props.Get("MarginRight")
		mMarginTop = Props.Get("MarginTop")
		mMarginBottom = Props.Get("MarginBottom")
		mPaddingLeft = Props.Get("PaddingLeft")
		mPaddingRight = Props.Get("PaddingRight")
		mPaddingTop = Props.Get("PaddingTop")
		mPaddingBottom = Props.Get("PaddingBottom")
		mVisible = Props.Get("Visible")
		mEnabled = Props.Get("Enabled")
	End If
	
	Dim exStyle As String = BuildExStyle
			
	mElement = mTarget.Append($"<div id="${mName}" class="${mClasses}" style="text-align: center;border: 1px solid #ccc;width: ${mWidth}; height: ${mHeight};"${exStyle}${mStyle}">
	Waiting..</div>"$).Get("#" & mName)
		
	'' defining events is very simple. Note that it has to be run AFTER adding it to the HTML DOM! eventName must be lowercase!
	'mElement.HandleEvents("click", mCallBack, mEventName & "_click")
	'mElement.HandleEvents("mouseenter", Me, "mouseenter")
	
	carica
End Sub

Private Sub carica
	'BANano.JS($"google.maps.event.addDomListener(window, 'load', initializesdMap('${mName}','${mName}_mousemove','${mName}_click'));"$)
	Sleep(100)
	
	Maps=BANano.RunJavascriptMethod("initializesdMap", Array (mName,Me,mCallBack,mDBLClickZoom ,$"${mName}_mousemove"$,$"${mName}_click"$,$"${mName}_dblclick"$,$"${mName}_zoomchanged"$,$"${mName}_centermapmove"$))
End Sub

Public Sub IsReady As Boolean
	Return Rdy
End Sub

Public Sub gmap_r(redy As Boolean, mmap As Object)
	Maps=mmap
	Rdy=redy
	BANano.CallSub(mCallBack,mEventName & "_Ready", Array (Rdy))
End Sub

' ListCoordinate.Add(CreateMap("lat":41.9028,"lng":12.4964))
' AddPolygon("#000000","#FFFF00",ListCoordinate)
Public Sub AddPolygon(CornerColor As String, FillColor As String, ListCoordinate As List) As BANanoObject
	Dim Coo As Map = CreateMap("strokeColor":CornerColor,"fillColor":FillColor,"coord":ListCoordinate)
	Return BANano.RunJavascriptMethod("AddPolygon",Array (Maps,Coo,mCallBack,mEventName & "_polygonclick",mEventName & "_polygondblclick"))
End Sub

' ListCoordinate.Add((CreateMap("lat":41.9028,"lng":12.4964))
' AddPolyline("#FF0000",ListCoordinate)
Public Sub AddPolyline(CornerColor As String, ListCoordinate As List) As BANanoObject
	Dim Coo As Map = CreateMap("strokeColor":CornerColor,"coord":ListCoordinate)
	Return BANano.RunJavascriptMethod("AddPolyline",Array (Maps,Coo,mCallBack,mEventName & "_polylineclick",mEventName & "_polylinedblclick"))
End Sub

'GM.GetPolyPath(Polygon) -> array As Map {lat: , lng: }
'<code>For Each M As Map In SDgoogleMap1.GetPolyPath(PolyObject)
'	Dim Lat  As Double = M.Get("lat")
'	Dim Lng  As Double = M.Get("lng")
'	BANano.Console.Log("Lat: " & Lat)
'	BANano.Console.Log("Lng: " & Lng)
'Next
'</code>
Public Sub GetPolyPath(Poly As BANanoObject) As Map()
	Return  BANano.RunJavascriptMethod("getPolygonPathAsArray",Array(Poly))
End Sub

' gm.AddMarker("Home", Lar, Lng,"") ' standard icon
' gm.AddMarker("Home", Lar, Lng,"http://maps.google.com/mapfiles/ms/icons/blue-dot.png") ' custom icon
Public Sub AddMarker(Title As String, Lat As Double, Lng As Double, iconUrl As String) As BANanoObject
	If iconUrl = "" Then 
		Return BANano.RunJavascriptMethod("AddMarker",Array (Maps,Lat,Lng, Title,mCallBack,mEventName & "_markerclick",mEventName & "_markerdblclick"))
	Else
		Return BANano.RunJavascriptMethod("AddMarker2",Array (Maps,Lat,Lng, Title,iconUrl,mCallBack,mEventName & "_markerclick",mEventName & "_markerdblclick"))
	End If
End Sub

' AddInfoWindow("Hallo",Lat,Lng)
Public Sub AddInfoWindow(Text As String, Lat As Double, Lng As Double) As BANanoObject
	Return BANano.RunJavascriptMethod("addInfow",Array(Maps, Text, Lat, Lng,mCallBack,$"${mEventName}_infowindowcloseclick"$))
End Sub

Public Sub AddCircle(Lat As Double, Lng As Double, Radius As Int , CornerColor As String, FillColor As String) As BANanoObject
	Return BANano.RunJavascriptMethod("AddCircle",Array (Maps,Lat,Lng,Radius,CornerColor,FillColor,mCallBack,$"${mEventName}_circleclick"$,$"${mEventName}_circledblclick"$))
End Sub

Public Sub GetMarkerPosition(Marker As BANanoObject) As Map
	Return Marker.RunMethod("getPosition",Null)
End Sub

Public Sub SetInfoWindowsText(InfoWindow As BANanoObject, text As String)
	InfoWindow.RunMethod("setContent",Array(text))
End Sub

Public Sub SetInfoWindowsPosition(InfoWindow As BANanoObject, Lat As Double, Lng As Double)
	InfoWindow.RunMethod("setPosition",Array(CreateMap("lat":Lat,"lng":Lng)))
End Sub

Public Sub GetInfoWindowText(InfoWindow As BANanoObject) As String
	Return BANano.ToString(InfoWindow.RunMethod("getContent",Null))
End Sub

Public Sub SetObjVisible(GMobject As BANanoObject, Vis As Boolean)
	GMobject.RunMethod("setMap",IIf(Vis,Maps,Null))
End Sub

Public Sub SetObjDaggable(GMobject As BANanoObject, Draggable As Boolean)
	GMobject.RunMethod("setDraggable",Array (Draggable))
End Sub

Public Sub GetObjDaggable(GMobject As BANanoObject) As Boolean
	Return GMobject.RunMethod("getDraggable",Null)
End Sub

Public Sub 	GoToAddress(address As String)
	BANano.RunJavascriptMethod("GoToAddress",Array (Maps,address))
End Sub

Public Sub 	GoToLL(Lat As Double, Lng As Double)
	BANano.RunJavascriptMethod("GoToLL",Array (Maps,Lat,Lng))
End Sub

Public Sub GetCirclePosition(Circle As BANanoObject) As Map
	Dim M As Map
	M.Put("lat",Circle.RunMethod("getCenter",Null).RunMethod("lat",Null))
	M.Put("lng",Circle.RunMethod("getCenter",Null).RunMethod("lng",Null))
	Return M
End Sub

Public Sub GetCircleRadius(Circle As BANanoObject) As Int
	Return Circle.RunMethod("getRadius",Null)
End Sub

' ------------------------------------- STANDARD -------------------------------------------------------

' add the component to a parent tag
public Sub AddToParent(targetID As String)
	mTarget = BANano.GetElement("#" & targetID.ToLowerCase)
	DesignerCreateView(mTarget, Null)
End Sub

' removes the component from the parent tag
public Sub Remove()
	mTarget.Empty
	BANano.SetMeToNull
End Sub

#Region common shared properties and methods
' trigger an event
public Sub Trigger(event As String, params() As String)
	If mElement <> Null Then
		mElement.Trigger(event, params)
	End If
End Sub

' internal method to build the style
public Sub BuildExStyle() As String
	Dim sb As StringBuilder
	sb.Initialize
	If mMarginLeft <> "" Then sb.Append("margin-left: " & mMarginLeft & ";")
	If mMarginRight <> "" Then sb.Append("margin-right: " & mMarginRight & ";")
	If mMarginTop <> "" Then sb.Append("margin-top: " & mMarginTop & ";")
	If mMarginBottom <> "" Then sb.Append("margin-bottom: " & mMarginBottom & ";")
	If mPaddingLeft <> "" Then sb.Append("padding-left: " & mPaddingLeft & ";")
	If mPaddingRight <> "" Then sb.Append("padding-right: " & mPaddingRight & ";")
	If mPaddingTop <> "" Then sb.Append("padding-top: " & mPaddingTop & ";")
	If mPaddingBottom <> "" Then sb.Append("padding-bottom: " & mPaddingBottom & ";")
	Return sb.ToString
End Sub

' set css classes to the main tag
public Sub setClasses(Classes As String)
	If mElement <> Null Then
		mElement.AddClass(Classes)
	End If
	mClasses = Classes
End Sub

public Sub getClasses() As String
	Return mClasses
End Sub

' get/set the style of the main tag
public Sub setStyle(Style As String)
	Dim tmpStyle As String = Style
	If tmpStyle.StartsWith("{") = False Then
		Dim spl() As String = BANano.Split(";", Style)
		Dim m As Map
		m.Initialize
		For i = 0 To spl.Length - 1
			Dim spl2() As String = BANano.Split(":", spl(0))
			Dim key As String = spl2(0).Replace(Chr(34), "").trim
			Dim val As String = spl2(1).Replace(Chr(34), "").trim
			m.Put(key, val)
		Next
		Dim jsonG As BANanoJSONGenerator
		jsonG.Initialize(m)
		tmpStyle = jsonG.ToString
	End If	
	If mElement <> Null Then
		mElement.SetStyle(Style)
	End If
	mStyle = Style
End Sub

public Sub getStyle() As String
	Return mStyle
End Sub

' get/set if the component is visible
public Sub setVisible(Visible As Boolean)
	If mElement <> Null Then
		If Visible Then
			mElement.RemoveClass("u-hide")
		Else
			mElement.AddClass("u-hide")
		End If
	End If
	mVisible=Visible
End Sub

public Sub getVisible() As Boolean
	mVisible = Not(mElement.HasClass("u-hide"))
	Return mVisible
End Sub

' get/set if the component is enabled
public Sub setEnabled(Enabled As Boolean)
	If mElement <> Null Then
		If Enabled Then
			mElement.RemoveAttr("disabled")
		Else
			mElement.SetAttr("disabled", True)
		End If
	End If
	mEnabled = Enabled
End Sub

public Sub getEnabled() As Boolean
	mEnabled = Not(mElement.hasAttr("disabled"))
	Return mEnabled
End Sub

' get/set the margin left of the main tag
public Sub setMarginLeft(mar As String)
	mMarginLeft = mar
End Sub

public Sub getMarginLeft() As String
	Return mMarginLeft
End Sub

' get/set the margin right of the main tag
public Sub setMarginRight(mar As String)
	mMarginRight = mar
End Sub

public Sub getMarginRight() As String
	Return mMarginRight
End Sub

' get/set the margin top of the main tag
public Sub setMarginTop(mar As String)
	mMarginTop = mar
End Sub

public Sub getMarginTop() As String
	Return mMarginTop
End Sub

' get/set the margin bottom of the main tag
public Sub setMarginBottom(mar As String)
	mMarginBottom = mar
End Sub

public Sub getMarginBottom() As String
	Return mMarginBottom
End Sub

' get/set the Padding left of the main tag
public Sub setPaddingLeft(pad As String)
	mPaddingLeft = pad
End Sub

public Sub getPaddingLeft() As String
	Return mPaddingLeft
End Sub

' get/set the Padding right of the main tag
public Sub setPaddingRight(pad As String)
	mPaddingRight = pad
End Sub

public Sub getPaddingRight() As String
	Return mPaddingRight
End Sub

' get/set the Padding top of the main tag
public Sub setPaddingTop(pad As String)
	mPaddingTop = pad
End Sub

public Sub getPaddingTop() As String
	Return mPaddingTop
End Sub

' get/set the Padding bottom of the main tag
public Sub setPaddingBottom(pad As String)
	mPaddingBottom = pad
End Sub

public Sub getPaddingBottom() As String
	Return mPaddingBottom
End Sub

' get/set attach any object to the component
public Sub setTag(t As Object)
	mTag = t
End Sub

public Sub getTag() As Object
	Return mTag
End Sub
#End Region

#Region Internal Events

#End Region

#IF Javascript

async function initializesdMap(divname, cbackmap,obmap, dblclickzoom, mouseMoveMethod, clickMethod, dblclickMethod, czMethod, cmmMethod) {
// Funzione per attendere che il documento sia caricato
    const waitForDocumentReady = () => {
        return new Promise((resolve) => {
            if (document.readyState === "complete" || document.readyState === "interactive") {
                resolve();
            } else {
                document.addEventListener("DOMContentLoaded", resolve);
            }
        });
    };

 // Attendi che il documento sia caricato
    await waitForDocumentReady();

    // Dichiarazione di map come variabile locale
    var map;
    var centro_italia = new google.maps.LatLng(41.9028, 12.4964); // Roma, Italia

 	console.log('**initialize ' + divname + ' ' + mouseMoveMethod + ' ' + clickMethod);
    // Inizializzazione della mappa
    map = new google.maps.Map(document.getElementById(divname), {
        zoom: 16,
        center: centro_italia,
        mapTypeId: google.maps.MapTypeId.ROADMAP, // Usa ROADMAP invece di MAP
        gestureHandling: 'greedy',
        disableDefaultUI: false,
		disableDoubleClickZoom: dblclickzoom,
        zoomControl: true
    });

	console.log(map);
    // Ciclo per cercare la chiave che inizia con "_banano_"
    for (const key in window) {
        if (key.startsWith("_banano_")) {
			console.log('trovata ' + key)
            // Aggiungi event listener per il movimento del mouse sulla mappa
            google.maps.event.addListener(map, 'mousemove', function (event) {
				// console.log('Evento mousemove attivato');
                var pnt = event.latLng;
                var lat = pnt.lat();
                var lng = pnt.lng();

                // Verifica che il metodo gmap_mousemove (passato come mouseMoveMethod) sia presente
                if (typeof obmap[mouseMoveMethod] === 'function') {
                    obmap[mouseMoveMethod](lat, lng);
					// console.log('Metodo ' + mouseMoveMethod + ' trovato per la chiave: ' + key);
                } else {
                    // console.log('Metodo ' + mouseMoveMethod + ' non trovato per la chiave: ' + key);
                }
            });

            // Aggiungi event listener per il click sulla mappa
            google.maps.event.addListener(map, 'click', function (event) {
                var pnt = event.latLng;
                var lat = pnt.lat();
                var lng = pnt.lng();

                // Verifica che il metodo gmap_click (passato come clickMethod) sia presente
                if (typeof obmap[clickMethod] === 'function') {
                    obmap[clickMethod](lat, lng);
					// console.log('Metodo ' + clickMethod + ' trovato per la chiave: ' + key);
                } else {
                    // console.log('Metodo ' + clickMethod + ' non trovato per la chiave: ' + key);
                }
            });
			
			// Aggiungi event listener per il doppio click sulla mappa
            google.maps.event.addListener(map, 'dblclick', function (event) {
                var pnt = event.latLng;
                var lat = pnt.lat();
                var lng = pnt.lng();

                // Verifica che il metodo gmap_click (passato come dblclickMethod) sia presente
                if (typeof obmap[dblclickMethod] === 'function') {
                    obmap[dblclickMethod](lat, lng);
					// console.log('Metodo ' + dblclickMethod + ' trovato per la chiave: ' + key);
                } else {
                    // console.log('Metodo ' + dblclickMethod + ' non trovato per la chiave: ' + key);
                }
            });
			
			// Aggiungi event listener per lo zoom sulla mappa
			google.maps.event.addListener(map, 'zoom_changed', () => {
        		var currentZoom = map.getZoom();
        		if (typeof obmap[czMethod] === 'function') {
                    obmap[czMethod](currentZoom);
                }
    		});
			
			// Aggiungi un listener per il cambio del centro
            google.maps.event.addListener(map, "center_changed", () => {
                // Ottieni il nuovo centro della mappa
                var newCenter = map.getCenter();
                if (typeof obmap[cmmMethod] === 'function') {
                    obmap[cmmMethod](newCenter.lat(),newCenter.lng());
				}
            });
			
			cbackmap.gmap_r(true,map);
            return;
        }
    }

    // Se non viene trovata nessuna chiave che inizia con "_banano_", mostra un messaggio
    console.log("Nessuna chiave trovata che inizia con _banano_");
	
	cbackmap.gmap_r(false,map);
	return;
}

function AddPolygon(map, coo, objmap, clickMethod, dblclickMethod) {
	var Pol = new google.maps.Polygon({
			paths: coo.coord,
			strokeColor: coo.strokeColor,
			strokeOpacity: 0.8,
			strokeWeight: 2,
			fillColor: coo.fillColor,
			fillOpacity: 0.20,
			draggable: false,
		});
	Pol.addListener("click", () => {
        if (typeof objmap[clickMethod] === 'function') {
            objmap[clickMethod](Pol);
        } else {
            console.error("La funzione specificata non è definita.");
        }
    });
	Pol.addListener("dblclick", () => {
        if (typeof objmap[dblclickMethod] === 'function') {
            objmap[dblclickMethod](Pol);
        } else {
            console.error("La funzione specificata non è definita.");
        }
    });
		
	Pol.setMap(map);
	return Pol;
}

function AddPolyline(map, coo, objmap, clickMethod, dblclickMethod) {
	var Pol = new google.maps.Polyline({
		  path: coo.coord,
		  geodesic: true, 
		  strokeColor: coo.strokeColor,
		  strokeOpacity: 1.0,
		  strokeWeight: 2,
		  draggable: false,
		});
	Pol.addListener("click", () => {
        if (typeof objmap[clickMethod] === 'function') {
            objmap[clickMethod](Pol);
        } else {
            console.error("La funzione specificata non è definita.");
        }
    });
	Pol.addListener("dblclick", () => {
        if (typeof objmap[dblclickMethod] === 'function') {
            objmap[dblclickMethod](Pol);
        } else {
            console.error("La funzione specificata non è definita.");
        }
    });
	
	Pol.setMap(map);
	return Pol;
}

function AddMarker(map, vLat, vLng, vTitle, objmap, clickMethod, dblclickMethod) {
	var marker = new google.maps.Marker({
                position: { lat: vLat, lng: vLng }, // Coordinate del marker
                map: map, // Collegamento alla mappa
                title: vTitle,
            });
	marker.addListener("click", () => {
        if (typeof objmap[clickMethod] === 'function') {
            objmap[clickMethod](marker.getTitle(), marker);
        } else {
            console.error("La funzione specificata non è definita.");
        }
    });
	marker.addListener("dblclick", () => {
        if (typeof objmap[dblclickMethod] === 'function') {
            objmap[dblclickMethod](marker.getTitle(), marker);
        } else {
            console.error("La funzione specificata non è definita.");
        }
    });
	return marker;
}

function AddMarker2(map, vLat, vLng, vTitle, murl, objmap, clickMethod, dblclickMethod) {
	var iconaPersonalizzata = {
          url: murl, // URL dell'immagine
          scaledSize: new google.maps.Size(50, 50), // Dimensione personalizzata
          origin: new google.maps.Point(0, 0), // Punto di origine dell'immagine
          anchor: new google.maps.Point(25, 50), // Punto di ancoraggio (centro basso)
        };
	var marker = new google.maps.Marker({
                position: { lat: vLat, lng: vLng }, // Coordinate del marker
                map: map, // Collegamento alla mappa
				icon: iconaPersonalizzata,
                title: vTitle,
				draggable: false,
            });
	marker.addListener("click", () => {
        if (typeof objmap[clickMethod] === 'function') {
            objmap[clickMethod](marker.getTitle(), marker);
        } else {
            console.error("La funzione specificata non è definita.");
        }
    });
	marker.addListener("dblclick", () => {
        if (typeof objmap[dblclickMethod] === 'function') {
            objmap[dblclickMethod](marker.getTitle(), marker);
        } else {
            console.error("La funzione specificata non è definita.");
        }
    });
	return marker;
}

function AddCircle(map, vLat, vLng, Radius, corner, fillc , objmap, clickMethod, dblclickMethod) {
	 var circle = new google.maps.Circle({
		strokeColor: corner, // Colore del bordo
		strokeOpacity: 0.8,    // Opacità del bordo
		strokeWeight: 2,       // Spessore del bordo
		fillColor: fillc,  // Colore di riempimento
		fillOpacity: 0.35,     // Opacità del riempimento
		map: map,              // Mappa su cui disegnare il cerchio
		center: { lat: vLat, lng: vLng }, // Centro del cerchio
		radius: Radius,          // Raggio in metri
		draggable: false,
	});
	
	circle.addListener("click", () => {
        if (typeof objmap[clickMethod] === 'function') {
            objmap[clickMethod](circle);
        } else {
			console.error("La funzione specificata non è definita.");
        }
    });
	circle.addListener("dblclick", () => {
        if (typeof objmap[dblclickMethod] === 'function') {
            objmap[dblclickMethod](circle);
        } else {
            console.error("La funzione specificata non è definita.");
        }
    });
	
	return circle;
}

function GoToAddress(map, address) {
	geocoder = new google.maps.Geocoder();
	geocoder.geocode( {address:address}, function(results, status) 
	{
	  if (status == google.maps.GeocoderStatus.OK) 
	  {
		//place a marker at the location			
		 map.setCenter(results[0].geometry.location);//center the map over the result
		 map.setZoom(18);
	  } else {
		alert('Indirizzo non trovato per la seguente ragione: ' + status);
	 }
	});
}

function GoToLL(map, lat,lng) {
	map.setCenter(new google.maps.LatLng(lat, lng));
}

function getPolygonPathAsArray(polygon) {
  // Ottieni il path del Polygon (MVCArray)
  const path = polygon.getPath();
  
  // Converti il path in un array di coordinate (lat, lng)
  const pathArray = [];
  path.forEach(function(latLng) {
    pathArray.push({ lat: latLng.lat(), lng: latLng.lng() });
  });
  
  return pathArray;
}

function addInfow(map, text, nlat, nlng, objmap, closeclick) {
	var infoWindow = new google.maps.InfoWindow({
	 	content: text,
        position: { lat: nlat, lng: nlng }, 
	});
	
	infoWindow.addListener("closeclick", () => {
        if (typeof objmap[closeclick] === 'function') {
            objmap[closeclick](infoWindow);
        } else {
            console.error("La funzione specificata non è definita.");
        }
    });
	
	infoWindow.open(map);
	return infoWindow;
}

#End If


' ---------------------------- EVENTI MAPPA ---------------------------------
'bounds_changed: Triggered quando i limiti della mappa cambiano.
'center_changed: Triggered quando il centro della mappa cambia.
'click: Triggered quando si clicca sulla mappa.
'dblclick: Triggered quando si fa doppio clic sulla mappa.
'drag: Triggered durante il trascinamento della mappa.
'dragend: Triggered quando il trascinamento della mappa termina.
'dragstart: Triggered quando inizia il trascinamento della mappa.
'idle: Triggered quando la mappa ha completato un movimento (trascinamento o zoom).
'maptypeid_changed: Triggered quando cambia il tipo di mappa (es. da roadmap a satellite).
'mousemove: Triggered quando il mouse si muove sulla mappa.
'mouseout: Triggered quando il mouse esce dalla mappa.
'mouseover: Triggered quando il mouse entra nella mappa.
'projection_changed: Triggered quando la proiezione della mappa cambia.
'resize: Triggered quando la mappa cambia dimensione.
'rightclick: Triggered quando si clicca con il tasto destro sulla mappa.
'tilesloaded: Triggered quando tutte le tile della mappa sono caricate.
'zoom_changed: Triggered quando cambia il livello di zoom.