B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'Custom BANano View class

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
#DesignerProperty: Key: mFileName, DisplayName: url 3d File Name, FieldType: String, DefaultValue: , Description: url 3d File Name.
#DesignerProperty: Key: mWidth, DisplayName: Width, FieldType: String, DefaultValue: 200px, Description: width
#DesignerProperty: Key: mHeight, DisplayName: Height, FieldType: String, DefaultValue: 200px, Description: Height
#DesignerProperty: Key: mDurate, DisplayName: Durate animation, FieldType: Int, DefaultValue: 3000, Description: Animation duration in ms
#DesignerProperty: Key: zPosition, DisplayName: Z positione, FieldType: Int, DefaultValue: 25, Description: Initial Z position
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
	
	Private mFileName As String = ""
	Private mWidth As String = ""
	Private mHeight As String = ""
	Private mDurate As Int = 0
	Private zPosition As Int = 0
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
	
	Private mTag As Object
End Sub

' initializes the component
Public Sub Initialize (CallBack As Object, Name As String, EventName As String)
	mName = Name
	mEventName = EventName.ToLowerCase
	mCallBack = CallBack	
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
		mFileName = Props.Get("mFileName")
		mWidth = Props.Get("mWidth")
		mHeight = Props.Get("mHeight")
		zPosition = 1 * Props.Get("zPosition")
		mDurate = Props.Get("mDurate")
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
	
	Dim exStyle As String = $"width: ${mWidth}; height: ${mHeight};"$ & BuildExStyle
	
	'Dim tmpScriptElem As BANanoElement = BANano.CreateElement("script")
	'tmpScriptElem.SetAttr("src", "https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/three.min.js")
	' set the async
	'tmpScriptElem.SetAttr("async", True)
	
	mElement = mTarget.Append($"<div id="${mName}" class="${mClasses}" style="${exStyle}${mStyle}"></div>"$).Get("#" & mName)
	
	BANano.Await(BANano.RunJavascriptMethod("treddd", Array(mName,mFileName,mDurate,zPosition)))
	
	'' defining events is very simple. Note that it has to be run AFTER adding it to the HTML DOM! eventName must be lowercase!
	'mElement.HandleEvents("click", mCallBack, mEventName & "_click")
	'mElement.HandleEvents("mouseenter", Me, "mouseenter")
End Sub

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

' set rotate degree
Public Sub SetRotate(X As Int, Y As Int, Z As Int)
	Dim rx As Double = cPI*X/180
	Dim ry As Double = cPI*y/180
	Dim rz As Double = cPI*z/180
	BANano.RunJavascriptMethod("rotateObj",Array(rx,ry,rz))
End Sub

' set rotate degree
Public Sub SetPosition(X As Double, Y As Double, Z As Double)
	BANano.RunJavascriptMethod("positionObj",Array(x,y,z))
End Sub

Public Sub GetPositionX As Double
	Return BANano.RunJavascriptMethod("positionObjX",Null)
End Sub

Public Sub GetPositionY As Double
	Return BANano.RunJavascriptMethod("positionObjY",Null)
End Sub

Public Sub GetPositionZ As Double
	Return BANano.RunJavascriptMethod("positionObjZ",Null)
End Sub

#End Region

#Region Internal Events

#End Region

#IF javascript

let loadedObject;

function rotateObj(xSpeed, ySpeed, zSpeed) {
	loadedObject.rotation.x += xSpeed; // Ruota sull'asse X
    loadedObject.rotation.y += ySpeed; // Ruota sull'asse Y
    loadedObject.rotation.z += zSpeed; // Ruota sull'asse Z
}

function positionObj(xPos, yPos, zPos) {
	loadedObject.position.set(xPos, yPos, zPos);
}

function positionObjX() {
	return loadedObject.position.x;
}

function positionObjY() {
	return loadedObject.position.y;
}

function positionObjZ() {
	return loadedObject.position.z;
}

function loadOBJLoader(callback) {
    const script = document.createElement('script');
    //script.src = "https://cdnjs.cloudflare.com/ajax/libs/three.js/r128/examples/js/loaders/OBJLoader.js";
	script.src = "scripts/OBJLoader.js";
    script.onload = callback;
    document.body.appendChild(script);
}

function checkFileExists(url) {
    return fetch(url, {
        method: 'HEAD',  // Usa il metodo 'HEAD' per ottenere solo le intestazioni
        cache: 'no-cache'
    })
    .then(response => {
        if (response.ok) {
            console.log("File trovato!");
            return true;  // Il file esiste
        } else {
            console.log("File non trovato.");
            return false;  // Il file non esiste
        }
    })
    .catch(error => {
        console.log("Errore nella richiesta:", error);
        return false;  // In caso di errore (es. URL non valido)
    });
}

function treddd(idname, nomefile, animationDuration, posizionZ) {
    console.log("3D " + nomefile);
    // Verifica l'esistenza del file prima di caricarlo
    checkFileExists(nomefile).then(exists => {
        if (exists) {
            // Se il file esiste, caricalo
            var scena = new THREE.Scene();
            var camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);

            const wd = document.getElementById(idname).clientWidth;
            const ht = document.getElementById(idname).clientHeight;
            var renderer = new THREE.WebGLRenderer();
            renderer.setSize(wd, ht);
            renderer.setPixelRatio(window.devicePixelRatio);

            // Aggiungi il renderer all'interno del div con ID "contenitore3D"
            document.getElementById(idname).appendChild(renderer.domElement);

            // Aggiungi una luce per illuminare l'oggetto
            var luce = new THREE.AmbientLight(0x404040); // luce ambiente
            scena.add(luce);

            var luceDirez = new THREE.DirectionalLight(0xffffff, 1); // luce direzionale
            luceDirez.position.set(5, 5, 5);
            scena.add(luceDirez);

 			let startTime = null;
			let isDragging = false;
            const objLoader = new THREE.OBJLoader();
            objLoader.load(nomefile, function (obj) {
				loadedObject = obj; // Salva l'oggetto caricato
                scena.add(obj);
                obj.position.set(0, 0, 0); // Posizione del modello
				startTime = Date.now();
                },
                // Funzione di progressione
                function (xhr) {
                    console.log((xhr.loaded / xhr.total * 100) + '% caricato');
                },
                // Funzione di errore
                function (error) {
                    console.log('Errore nel caricamento dell\'oggetto', error);
                }
            );

            camera.position.z = posizionZ;
  
			// Funzione di rendering
	        function animate() {
	            requestAnimationFrame(animate);

	            // Calcola il tempo trascorso
	            const currentTime = Date.now();
	            if (startTime && loadedObject) {
	                const elapsedTime = currentTime - startTime;

	                // Ruota l'oggetto solo se siamo entro i secondi stabiliti
	                if (elapsedTime < animationDuration) {
	                    rotateObject(loadedObject, 0.01, 0.01, 0); // Ruota su X e Y
	                }
	            }

	            renderer.render(scena, camera);
	        }

	        // Funzione per ruotare un oggetto
	        function rotateObject(object, xSpeed, ySpeed, zSpeed) {
	            object.rotation.x += xSpeed; // Ruota sull'asse X
	            object.rotation.y += ySpeed; // Ruota sull'asse Y
	            object.rotation.z += zSpeed; // Ruota sull'asse Z
	        }
			
			 // Eventi per il trascinamento del mouse
	        window.addEventListener('mousedown', (event) => {
	            isDragging = true;
	            previousMousePosition = { x: event.clientX, y: event.clientY };
	        });

	        window.addEventListener('mousemove', (event) => {
	            if (isDragging && loadedObject) {
	                const deltaX = event.clientX - previousMousePosition.x;
	                const deltaY = event.clientY - previousMousePosition.y;

	                // Ruota l'oggetto in base al movimento del mouse
	                loadedObject.rotation.y += deltaX * 0.01; // Ruota sull'asse Y
	                loadedObject.rotation.x += deltaY * 0.01; // Ruota sull'asse X

	                previousMousePosition = { x: event.clientX, y: event.clientY };
	            }
	        });

	        window.addEventListener('mouseup', () => {
	            isDragging = false;
	        });

            // Gestire il ridimensionamento del div e della scena
            window.addEventListener('resize', function () {
                var width = window.innerWidth;
                var height = window.innerHeight;
                renderer.setSize(width, height);
                camera.aspect = width / height;
                camera.updateProjectionMatrix();
            });
			
        	animate();
        } else {
            console.log("Impossibile caricare il file: " + nomefile);
        }
    });
	return loadedObject;
}

#End If