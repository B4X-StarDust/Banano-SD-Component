B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'Custom BANano View class
#Event: Open
#Event: Save

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
#DesignerProperty: Key: mWidth, DisplayName: Width, FieldType: String, DefaultValue: 100%, Description: Width
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
	
	Private bName() As String 
	Private fas() As String
		
	Private mTag As Object
End Sub

'undo/redo; Cerca; aggiunta immagini; tabelle; 

' initializes the component
Public Sub Initialize (CallBack As Object, Name As String, EventName As String)
	mName = Name
	mEventName = EventName.ToLowerCase
	mCallBack = CallBack
	
	bName = SDfunc.SDRegEx(",","Bold,Italic,Underline,Left,Center,Right,NumberList,BulletList,image,link,removeformat,save,open,")
	fas = SDfunc.SDRegEx(",","fa-bold,fa-italic,fa-underline,fa-align-left,fa-align-center,fa-align-right,fa-list-ol,fa-list-ul,fa-regular fa-image,fa-link,fa-eraser,fa-save,fa-folder-open,")
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
		mWidth =  Props.Get("mWidth")
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
	
	mElement = mTarget.Append($"<div id="${mName}" class="${mClasses}" style="${exStyle}${mStyle}">
	<div id="${mName}_toolbar" style=" display: flex;">${CreateButton}</div>
	<div id="${mName}_editor" class="sdeditor" contenteditable="true">
        Start editing here...
    </div>
	</div>"$).Get("#" & mName)
		
	'' defining events is very simple. Note that it has to be run AFTER adding it to the HTML DOM! eventName must be lowercase!
	'mElement.HandleEvents("click", mCallBack, mEventName & "_click")
	'mElement.HandleEvents("mouseenter", Me, "mouseenter")
	CreateEvent
	BANano.GetElement($"#${mName}_bgColorPicker"$).SetStyle($"{ "color": "#FFFFFF" }"$)
End Sub

Private Sub CreateButton As String
	Dim html As String = ""
	Dim Butt As String = ""
	' Bold, Italic, Underline, Left, Center, Right, Number List, Bullet List, link, remove format
	'bold,Italic,underline,justifyLeft,justifyCenter,justifyRight,insertOrderedList,insertUnorderedList,createLink,removeFormat
	
	For i=0 To fas.Length-1
		Butt = $"<button id="${mName}_${bName(i)}" data-id="${mName}_${bName(i)}" Type="button" style="font-size: 14px;width: 30px; height: 30px;" >
		<i class="fas ${fas(i)}"></i>
		</button>"$
		html=$"${html}${Butt}"$
	Next
	
	Butt=$"&nbsp;&nbsp;&nbsp;<label>
            <i id="${mName}_texticon" class="fa-solid fa-droplet"></i>
            <input id="${mName}_colorPicker" type="color">
        </label>
        <label>
            <i id="${mName}_bgicon" class="fa-solid fa-paint-roller"></i>
            <input id="${mName}_bgColorPicker" type="color" value="#ffffff">
        </label>"$
	html = html & Butt
	
	Return html
End Sub

Private Sub CreateEvent
	For i=0 To fas.Length-1
		BANano.GetElement($"#${mName}_${bName(i)}"$).HandleEvents("click", Me, "button_click")
	Next
	
	BANano.GetElement($"#${mName}_colorPicker"$).HandleEvents("change", Me, "change_TextColor")
	BANano.GetElement($"#${mName}_bgColorPicker"$).HandleEvents("change", Me, "change_BgColor")
End Sub

Private Sub button_click (event As BANanoEvent)
	Dim ob As BANanoObject = event.CurrentTarget
	Dim idname As String = ob.GetField("id").ToString
	Dim tbutton As String = idname.SubString(idname.LastIndexOf("_")+1)
	Dim doc As BANanoObject = BANano.Window.GetField("document")
	Dim command() As String = SDfunc.SDRegEx(",","bold,Italic,underline,justifyLeft,justifyCenter,justifyRight,insertOrderedList,insertUnorderedList,insertImage,createLink,removeFormat,")
	
	Select tbutton
		Case "open"
			BANano.CallSub(mCallBack, mEventName & "_Open",Null)
		Case "save"
			BANano.CallSub(mCallBack, mEventName & "_Save",Null)
		Case "image"
			Dim url As String = SDfunc.prompt("Url image","https://www.b4x.com/images/Logo_on-dark.png")
			doc.RunMethod("execCommand",Array ("insertImage",False,url))
		Case Else
	
			For index=0 To bName.Length-1
				If tbutton=bName(index) Then
					doc.RunMethod("execCommand",Array (command(index),False,Null))
					
					If index<3 Then
						Select index
							Case 0
								Dim isActive As Boolean = doc.RunMethod("queryCommandState",Array("bold"))
							Case 1
								Dim isActive As Boolean = doc.RunMethod("queryCommandState",Array("italic"))
							Case 2
								Dim isActive As Boolean = doc.RunMethod("queryCommandState",Array("underline"))
						End Select
						If isActive Then
							BANano.GetElement($"#${idname}"$).SetStyle($"{ "color": "red" }"$)
						Else
							BANano.GetElement($"#${idname}"$).SetStyle($"{ "color": "black" }"$)
						End If
					End If
				End If
			Next
	End Select
	BANano.GetElement($"#${mName}_editor"$).RunMethod("focus",Null)
End Sub

Private Sub change_TextColor
	Dim color As String = BANano.GetElement($"#${mName}_colorPicker"$).GetValue
	BANano.Window.GetField("document").RunMethod("execCommand",Array ("foreColor",False,color))
	'BANano.GetElement($"#${mName}_texticon"$).SetStyle($"{ "color": "${color}" }"$)
	BANano.GetElement($"#${mName}_editor"$).RunMethod("focus",Null)
End Sub

Private Sub change_BgColor
	Dim color As String = BANano.GetElement($"#${mName}_bgColorPicker"$).GetValue
	BANano.Window.GetField("document").RunMethod("execCommand",Array ("hiliteColor",False,color))
	'BANano.GetElement($"#${mName}_bgicon"$).SetStyle($"{ "color": "${color}" }"$)
	BANano.GetElement($"#${mName}_editor"$).RunMethod("focus",Null)
End Sub

Public Sub content As String
	Dim editor As BANanoElement = BANano.GetElement($"#${mName}_editor"$)

	Return editor.GetHTML
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
	sb.Append($"width: ${mWidth};"$)
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

'function updateStatus() {
'    const statusDiv = document.getElementById('status');
'    const isBold = document.queryCommandState('bold');
'    const isItalic = document.queryCommandState('italic');
'    const isUnderline = document.queryCommandState('underline');
'    const isOrderedList = document.queryCommandState('insertOrderedList');
'    const isUnorderedList = document.queryCommandState('insertUnorderedList');
'
'    let activeStyles = [];
'    If (isBold) activeStyles.push('Bold');
'    If (isItalic) activeStyles.push('Italic');
'    If (isUnderline) activeStyles.push('Underline');
'    If (isOrderedList) activeStyles.push('Numbered List');
'    If (isUnorderedList) activeStyles.push('Bullet List');
'
'    statusDiv.innerText = `Active styles: ${activeStyles.length > 0 ? activeStyles.join(', ') : 'None'}`;
'}