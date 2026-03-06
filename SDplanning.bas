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
#DesignerProperty: Key: mOpen, DisplayName: Item Open, FieldType: Boolean, DefaultValue: False, Description: Start with Item opened or closed
#DesignerProperty: Key: mClasses, DisplayName: Classes, FieldType: String, DefaultValue: sdplanning, Description: Classes added to the HTML tag.
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

	Private mOpen As Boolean = False
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
	
	Private DayList(7) As List
End Sub

' initializes the component
Public Sub Initialize (CallBack As Object, Name As String, EventName As String)
	mName = Name
	mEventName = EventName.ToLowerCase
	mCallBack = CallBack
	
	For i=0 To 6
		Dim L As List 
		L.Initialize
		DayList(i)= l
	Next
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
		mOpen  = Props.Get("mOpen")
		mClasses = Props.Get("mClasses")
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
	<div id="${mName}_0" class="sdplanningcol"></div><div id="${mName}_1" class="sdplanningcol"></div>
	<div id="${mName}_2" class="sdplanningcol"></div><div id="${mName}_3" class="sdplanningcol"></div>
	<div id="${mName}_4" class="sdplanningcol"></div><div id="${mName}_5" class="sdplanningcol"></div>
	<div id="${mName}_6" class="sdplanningcol"></div>
	</div>"$).Get("#" & mName)
	
	For col=0 To 6
		Dim El As BANanoElement = BANano.GetElement($"#${mName}_${col}"$)
		El.Append($"<div id="${mName}_t${col}" style="margin-bottom: 5px; text-align: center;background-color: black;color: white;">${col}</div>"$)
	Next
	
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

' SetHeader(Array As String("Title1","Title2","Title3","Title4","Title5","Title6","Title7"))
Public Sub SetHeader(Title() As String)
	For col = 0 To Min(6,Title.Length-1)
		Dim El As BANanoElement = BANano.GetElement($"#${mName}_t${col}"$)
		El.SetText(Title(col))
	Next
End Sub

' SetHeaderStyle("black","white")
Public Sub SetHeaderStyle(BackgroundColor As String, TextColor As String)
	For col = 0 To 6
		Dim El As BANanoElement = BANano.GetElement($"#${mName}_t${col}"$)
		El.SetStyle($"{"background-color": "${BackgroundColor}", "color": "${TextColor}" }"$)
	Next
End Sub

'the items will Be sorted by ID. We suggest entering the ID As the day-time
'Example: 09:30 am -> ID = 5_0930
'AddItem(0,"05-08:00",DateTime.TimeParse("08:00"),60, "Text 1")
'AddItem(1,"06-08:00",DateTime.TimeParse("08:00"),60, "Text 1")
Public Sub AddItem(posDay As Int, ID As String, time As Long, durationMinutes As Int, Text As String) As BANanoElement
	Dim Be As BANanoElement = AddElementIntern(posDay,ID,time,durationMinutes)
	Be.SetText(Text)
	BANano.GetElement($"#${mName}_time_${ID}"$).HandleEvents("click", Me, "reduce_click")
	If mOpen=False Then ItemStateID(ID,False)
	Return Be
End Sub

'the items will Be sorted by ID. We suggest entering the ID As the day-time
'Example: 09:30 am -> ID = 5_0930
'AddElement(5,"5-0800",DateTime.TimeParse("08:00"),60)
Public Sub AddElement(posDay As Int, ID As String, time As Long, durationMinutes As Int) As BANanoElement
	Dim Be As BANanoElement = AddElementIntern(posDay,ID,time,durationMinutes)
	'Be.LoadLayout(LayoutName)
	Be.SetText("")
	BANano.GetElement($"#${mName}_time_${ID}"$).HandleEvents("click", Me, "reduce_click")
	If mOpen=False Then ItemStateID(ID,False)
	Return Be
End Sub

Private Sub reduce_click (event As BANanoEvent)
	Dim id As String = event.ID
	Dim time As BANanoElement = BANano.GetElement($"#${id}"$)
	Dim intern As BANanoElement= BANano.GetElement($"#${id.Replace("_time_","_item_")}"$)
		
	If intern.GetStyle("display")="none" Then 
		time.SetStyle($" { "transform":"rotate(90deg)" } "$)
		intern.SetStyle($" { "display":"block" } "$)
	Else
		time.SetStyle($" { "transform":"rotate(0deg)" } "$)
		intern.SetStyle($" { "display":"none" } "$)
	End If
	
End Sub

Public Sub ItemStateDay(posDay As Int, Open As Boolean)
	Dim items As List = DayList(posDay)
	For i=0 To items.Size-1
		Dim item As String = items.Get(i)
		Dim ID As String = item.SubString(item.LastIndexOf("_")+1)
		Dim itm As BANanoElement= BANano.GetElement($"#${mName}_time_${ID}"$)
		Dim te As BANanoElement = BANano.GetElement($"#${mName}_item_${ID}"$)
		
		If Open Then 
			te.SetStyle($" { "transform":"rotate(90deg)" } "$)
			itm.SetStyle($" { "display":"block" } "$)
		Else
			te.SetStyle($" { "transform":"rotate(0deg)" } "$)
			itm.SetStyle($" { "display":"none" } "$)
		End If
	Next
End Sub

Public Sub ItemStateID(ID As String, Open As Boolean)
	Dim itm As BANanoElement= BANano.GetElement($"#${mName}_item_${ID}"$)
	Dim te As BANanoElement = BANano.GetElement($"#${mName}_time_${ID}"$)
	
	If Open Then
		te.SetStyle($" { "transform":"rotate(90deg)" } "$)
		itm.SetStyle($" { "display":"block" } "$)
	Else
		te.SetStyle($" { "transform":"rotate(0deg)" } "$)
		itm.SetStyle($" { "display":"none" } "$)
	End If
End Sub


Private Sub AddElementIntern(posDay As Int, ID As String, time As Long, durationMinutes As Int) As BANanoElement 'ignore
	' stato,ditta,tipo,attrezzature,messaggi
	Dim Item As List = DayList(posDay)
	DateTime.TimeFormat="HH:mm"
	Dim Tm As String = DateTime.Time(time)
	Dim El As BANanoElement = BANano.GetElement($"#${mName}_${posDay}"$)
	Dim html As String = $"<div id="${mName}_it_${ID}" class="sdplanitem"><div id="${mName}_time_${ID}" class="sdplanvert">${Tm}</div><div id="${mName}_item_${ID}" class="sdplanhoriz"> </div></div>"$
	
	If Item.Size>0 Then 
		Item.add($"${mName}_it_${ID}"$)
		Item.Sort(True)
		
		For i=0 To Item.Size-1
			If Item.Get(i)=$"${mName}_it_${ID}"$ Then
				If i=0 Then 
					Dim itm2 As BANanoElement = BANano.GetElement($"#${Item.Get(i+1)}"$)
					itm2.Before(html)
				Else
					Dim itm2 As BANanoElement = BANano.GetElement($"#${Item.Get(i-1)}"$)
					itm2.After(html)
				End If
			End If
		Next
		
	Else ' First
		El.Append(html)
		Item.Add($"${mName}_it_${ID}"$)
	End If

	Return BANano.GetElement($"#${mName}_item_${ID}"$)
End Sub

Public Sub getItemFromID(ID As String) As BANanoElement
	Return BANano.GetElement($"#${mName}_item_${ID}"$)
End Sub

' posDay = 0..6
Public Sub ClearDay(posDay As Int)
	Dim El As BANanoElement = BANano.GetElement($"#${mName}_${posDay}"$)
	El.Empty
	DayList(posDay).Clear
End Sub

' Clear all
Public Sub Clear
	For d=0 To 6
		BANano.GetElement($"#${mName}_${D}"$).Empty
		DayList(d).Clear
	Next
	
End Sub

#End Region

#Region Internal Events

#End Region

