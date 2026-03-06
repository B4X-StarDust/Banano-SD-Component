B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'Custom BANano View class

#Event: Click (Row As Int, Col As Int)
#Event: HeadClick (Col As Int)
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
#DesignerProperty: Key: Cols, DisplayName: N. of Cols, FieldType: Int, DefaultValue: 4, MinRange: 1, MaxRange: 12, Description: Number of Columns
#DesignerProperty: Key: mColsName, DisplayName: Cols Name, FieldType: String, DefaultValue: , Description: Names separated by |
#DesignerProperty: Key: Overflow, DisplayName: Scrolling Horiz, FieldType: Boolean, DefaultValue: False, Description: Horizontal scrolling
#DesignerProperty: Key: mHeaderTextColor, DisplayName: Header Text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Header Text Color
#DesignerProperty: Key: mHeaderBackground, DisplayName: Header Background Color, FieldType: Color, DefaultValue: 0xFF6200EA, Description: Header Background Color
#DesignerProperty: Key: mTextColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Text Color
#DesignerProperty: Key: mBackground, DisplayName: Background Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Background Color
#DesignerProperty: Key: mClasses, DisplayName: Classes, FieldType: String, DefaultValue: sdgrid, Description: Classes added to the HTML tag.
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
	
	Private mHeaderTextColor As String = ""
	Private mHeaderBackground As String = ""
	Private mTextColor As String = ""
	Private mBackground As String = ""
	Private mCols As Int = 4
	Private mColsName As String = ""
	Private mOverflow As Boolean = False 'ignore
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
	Private ListRows As List
	
	Type tCell(Tpe As Int, Content As String, Color As String, Background As String)
	Type tRow(Background As String,ListCell As List)
End Sub

' initializes the component
Public Sub Initialize (CallBack As Object, Name As String, EventName As String)
	mName = Name
	mEventName = EventName.ToLowerCase
	mCallBack = CallBack
	ListRows.Initialize
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
		mHeaderTextColor = Props.Get("mHeaderTextColor")
		mHeaderBackground = Props.Get("mHeaderBackground")
		mTextColor = Props.Get("mTextColor")
		mBackground = Props.Get("mBackground")
		mColsName = Props.GetDefault("mColsName","")
		mCols = Props.Get("Cols")
		mOverflow = Props.Get("Overflow")
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
	
	
	mElement = mTarget.Append($"<div id="${mName}" class="${mClasses}" style="${exStyle}${mStyle}">${genGrid}</div>"$).Get("#" & mName)
		
	'' defining events is very simple. Note that it has to be run AFTER adding it to the HTML DOM! eventName must be lowercase!
	'mElement.HandleEvents("click", mCallBack, mEventName & "_click")
	'mElement.HandleEvents("mouseenter", Me, "mouseenter")
	mElement.HandleEvents("click", Me,"Event_Click")
	
	SetGridTextColor(mTextColor)
	SetGridBackgroundColor(mBackground)
	SetHeaderRowTextColor(mHeaderTextColor) 
	SetHeaderRowBackgroundColor(mHeaderBackground)
	
	'BANano.GetElement($"#${mName}_${Row}_${col}"$).HandleEvents("click", Me,"Event_Click")
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

Private Sub genGrid As String
	Dim sIntern As String = ""
	Dim ColumnsName() As String = SDfunc.SDRegEx(",",mColsName)
	Dim Cname As String
	
	sIntern=$"${sIntern}<div id="${mName}_0" class="sdgridheader">"$ ' init row
	' Columns Name
	For col=1 To mCols
		If mColsName<>"" And ColumnsName.Length>=col Then Cname=ColumnsName(col-1) Else Cname = ""
		sIntern=$"${sIntern}  <div id="${mName}_0_${col}" class="sdgridcolumn" Style="font-weight: bold; background: ${mHeaderBackground}";>${Cname}</div>"$
	Next
	sIntern=$"${sIntern}</div>"$ ' close row
	
	' FIeld
	For Row=1 To ListRows.Size
		sIntern=$"${sIntern}<div id="${mName}_${Row}" class="sdgridrow">"$ ' init row
		Dim Column() As String = ListRows.Get(Row-1)
		For col=1 To mCols
			sIntern=$"${sIntern}  <div id="${mName}_${Row}_${col}" class="sdgridcolumn">${Column(col-1)}</div>"$
		Next
		sIntern=$"${sIntern}</div>"$ ' close row
	Next
	
	Return sIntern
End Sub

Private Sub Event_Click (event As BANanoEvent)
	Dim Param() As String = SDfunc.SDRegEx("_",event.ID)
	If Param.Length=3 Then 
		Dim Row As Int = 1 * Param(1)
		Dim Col As Int = 1 * Param(2)
		If Row=0 Then 
			BANano.CallSub(mCallBack, mEventName & "_HeadClick",Array As Int(Col))
		Else
			BANano.CallSub(mCallBack, mEventName & "_Click",Array As Int(Row,Col))
		End If
	End If
	
End Sub

Public Sub refresh
	
End Sub

Public Sub Clear
	mElement.Empty
	ListRows.Clear
End Sub

Public Sub AddRow(Column() As String)
	If Column.Length=mCols Then 
		mElement.Empty
		ListRows.Add(Column)
		mElement.Append(genGrid)
	End If
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

Public Sub SetGridTextColor(Color As String)
	BANano.GetElement("#" & mName).SetStyle($"{"color":"${Color}"}"$)
End Sub

Public Sub SetGridBackgroundColor(Color As String)
	BANano.GetElement("#" & mName).SetStyle($"{"background":"${Color}"}"$)
End Sub

Public Sub SetHeaderRowBackgroundColor(Color As String)
	BANano.GetElement($"#${mName}_0"$).SetStyle($"{"background":"${Color}"}"$)
End Sub

Public Sub SetHeaderRowTextColor(Color As String)
	BANano.GetElement($"#${mName}_0"$).SetStyle($"{"color":"${Color}"}"$)
End Sub

Public Sub SetRowBackgroundColor(Color As String, Row As Int)
	BANano.GetElement($"#${mName}_${Row}"$).SetStyle($"{"background":"${Color}"}"$)
End Sub

Public Sub SetRowTextColor(Color As String, Row As Int)
	BANano.GetElement($"#${mName}_${Row}"$).SetStyle($"{"color":"${Color}"}"$)
End Sub

Public Sub setCellBackgroundColor(Color As String, Row As Int, Col As Int)
	BANano.GetElement($"#${mName}_${Row}_${Col}"$).SetStyle($"{"background":"${Color}"}"$)
End Sub

Public Sub setCellTextColor(Color As String, Row As Int, Col As Int)
	BANano.GetElement($"#${mName}_${Row}_${Col}"$).SetStyle($"{"color":"${Color}"}"$)
End Sub

Public Sub setBoldText(Row As Int, Col As Int)
	BANano.GetElement($"#${mName}_${Row}_${Col}"$).SetStyle($"{"font-weight":"bold"}"$)
End Sub

Public Sub setNormalText(Row As Int, Col As Int)
	BANano.GetElement($"#${mName}_${Row}_${Col}"$).SetStyle($"{"font-weight":"normal"}"$)
End Sub

#End Region

#Region ither

Public Sub SetText(Text As String, Row As Int, Col As Int)
	BANano.GetElement($"#${mName}_${Row}_${Col}"$).SetText(Text)
End Sub

Public Sub GetText( Row As Int, Col As Int) As String
	Return BANano.GetElement($"#${mName}_${Row}_${Col}"$).GetText
End Sub

Public Sub GetRow(Row As Int) As String()
	Dim Column() As String = ListRows.Get(Row-1)
	Return Column
End Sub

Public Sub getRowCount As Int
	Return ListRows.Size
End Sub

#End Region

#Region Internal Events

#End Region

