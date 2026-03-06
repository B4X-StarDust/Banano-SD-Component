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
#Event: Select (ID as String, Item As String)

' Properties that will be show in the ABStract Designer.  They will be passed in the props map in DesignerCreateView (Case Sensitive!)
#DesignerProperty: Key: mHint, DisplayName: Hint, FieldType: String, DefaultValue: Seletct an Option, Description: Hint
#DesignerProperty: Key: mOption, DisplayName: Option, FieldType: String, DefaultValue: Option 1;Option 2;Option 3, Description: Options separated by ;
#DesignerProperty: Key: midOption, DisplayName: id Option, FieldType: String, DefaultValue: id1;id2;id3, Description: id Options separated by |
#DesignerProperty: Key: mTextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Text Color
#DesignerProperty: Key: mBackground, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFFF0F0F0, Description: Background Color
#DesignerProperty: Key: mmTextColor, DisplayName: Menu Text Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Menu Text Color
#DesignerProperty: Key: mmBackground, DisplayName: Menu Background Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Menu Background Color
#DesignerProperty: Key: mRadius, DisplayName: Border radius, FieldType: String, DefaultValue: 20px, Description: Border radius
#DesignerProperty: Key: Classes, DisplayName: Classes, FieldType: String, DefaultValue: sd-select, Description: Classes added to the HTML tag.
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
	Private selected As BANanoElement 'ignore
	Private items As BANanoElement 'ignore

	Private ListOption() As String
	Private ListidOption() As String
	Private SelectItem As String = ""
	Private SelectID As String = ""

	Private mHint As String = ""
	Private mOption As String = ""
	Private midOption As String = ""
	Private mBackground As String = ""
	Private mTextColor As String = ""
	Private mmBackground As String = ""
	Private mmTextColor As String = ""
	Private mRadius As String = ""
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
		mHint = Props.Get("mHint")
		mOption = Props.Get("mOption")
		midOption = Props.Get("midOption")
		mBackground = Props.Get("mBackground")
		mTextColor = Props.Get("mTextColor")
		mmBackground = Props.Get("mmBackground")
		mmTextColor = Props.Get("mmTextColor")
		mRadius = Props.Get("mRadius")
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
	ListOption = SDfunc.SDRegEx(";",mOption)
	ListidOption = SDfunc.SDRegEx(";",midOption)
	
	mElement = mTarget.Append($"<div id="div_${mName}" style="${exStyle}${mStyle}">${genSelected}</div>"$).Get("#" & mName)
	
	selected = BANano.GetElement("#" & mName)
	items = BANano.GetElement("#item_" & mName)
	'' defining events is very simple. Note that it has to be run AFTER adding it to the HTML DOM! eventName must be lowercase!
	selected.HandleEvents("click", Me, "selected_click")
	items.HandleEvents("click", Me, "item_click")
	'mElement.HandleEvents("mouseenter", Me, "mouseenter")
	
	BANano.GetElement("#" & mName).SetStyle($"{"background":"${mBackground}"}"$)
	BANano.GetElement("#" & mName).SetStyle($"{"color":"${mTextColor}"}"$)
	BANano.GetElement("#item_" & mName).SetStyle($"{"background":"${mmBackground}"}"$)
	BANano.GetElement("#item_" & mName).SetStyle($"{"color":"${mmTextColor}"}"$)
End Sub

Private Sub genSelected As String
	Dim ContentOption As String =""
	Dim lop As Int = Min(ListidOption.Length,ListOption.Length)
	
	For i=0 To lop-1
		ContentOption=$"${ContentOption}<div data-id="${ListidOption(i)}">${ListOption(i)}</div>"$
	Next
	
	ContentOption = $"<div id="${mName}" class="sdselect-selected">${mHint}</div>
<div id="item_${mName}" class="sdselect-items">
${ContentOption}</div>"$
	
	Return ContentOption
End Sub

' SetOptions("Opt1;Opt2;","ID1;ID2;")
Public Sub SetOptions(EnumerationOption As String, EnumerationID As String)
	Dim BaDiv As BANanoElement = BANano.GetElement($"#div_${mName}"$)
	If EnumerationID.trim.Replace(";","")="" Then 
		ListidOption = Array As String ()
		ListOption = Array As String ()
	Else
		ListidOption = SDfunc.SDRegEx(";",EnumerationID)
		ListOption = SDfunc.SDRegEx(";",EnumerationOption)
	End If
			
	BaDiv.Empty
	BaDiv.Append(genSelected)
	
	selected = BANano.GetElement("#" & mName)
	items = BANano.GetElement("#item_" & mName)
	selected.HandleEvents("click", Me, "selected_click")
	items.HandleEvents("click", Me, "item_click")
		
	BANano.GetElement("#item_" & mName).SetStyle($"{"background":"${mmBackground}"}"$)
	BANano.GetElement("#item_" & mName).SetStyle($"{"color":"${mmTextColor}"}"$)
End Sub

Public Sub SetSelectOption(NameOption As String)
	Dim lop As Int = Min(ListidOption.Length,ListOption.Length)
	For i=0 To lop-1
		Dim option As String = ListOption(i)
		If option=NameOption Then
			SelectItem=option
			SelectID=ListidOption(i)
			selected.SetText(option)
		End If
	Next
End Sub

Public Sub SetSelectID(IDoption As String)
	Dim lop As Int = Min(ListidOption.Length,ListOption.Length)
	For i=0 To lop-1
		Dim ID As String = ListidOption(i)
		If ID=IDoption Then
			SelectItem=ListOption(i)
			SelectID=IDoption
			selected.SetText(SelectItem)
		End If
	Next
End Sub

Private Sub selected_click(event As BANanoEvent)
	If items.GetStyle("display")="block" Then 
		items.SetStyle($"{"display":"none"}"$)
	Else
		items.SetStyle($"{"display":"block"}"$)
	End If
End Sub

Private Sub item_click(event As BANanoEvent)
	Log(event.ID)
	Dim target As BANanoObject = event.Target
	Dim tagname As String = BANano.ToString(target.GetField("tagName"))
	If (tagname = "DIV") Then
		Dim option As String = BANano.ToString(target.GetField("textContent"))
		Dim id As String = BANano.ToString(target.RunMethod("getAttribute", "data-id"))
		selected.SetText(option)
		items.SetStyle($"{"display":"none"}"$)
		BANano.CallSub(mCallBack,mEventName & "_select",Array As String(id,option))
		SelectItem=option
		SelectID=id
'		selected.textContent = option;
'		items.style.display = 'none'; // Nascondi le opzioni
'		output.textContent = `Selezionato: ${option}, ID: ${id}`;
	End If
End Sub

Public Sub getSelectedID As String
	Return SelectID
End Sub

Public Sub getSelectedoption As String
	Return SelectItem
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
	sb.Append($"border-radius: ${mRadius};"$)
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

Public Sub ChangeOption(Option() As String, idOption() As String)
	Dim ContentOption As String =""
	Dim lop As Int = Min(idOption.Length,Option.Length)
	
	For i=0 To lop-1
		ContentOption=$"${ContentOption}<div data-id="${idOption(i)}">${Option(i)}</div>"$
	Next
	
	BANano.GetElement("#item_" & mName).Empty
	BANano.GetElement("#item_" & mName).Append(ContentOption)
End Sub

#End Region

#Region Internal Events

#End Region

