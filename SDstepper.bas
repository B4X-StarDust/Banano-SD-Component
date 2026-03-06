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
#Event: Click (event As BANanoEvent)
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
#DesignerProperty: Key: Value, DisplayName: Start value, FieldType: Int, DefaultValue: 0, Description: Starter value
#DesignerProperty: Key: minValue, DisplayName: Min value, FieldType: Int, DefaultValue: 0, Description: Minimum value
#DesignerProperty: Key: maxValue, DisplayName: Max value, FieldType: Int, DefaultValue: 10, Description: Maximum value
#DesignerProperty: Key: TextColor, DisplayName: Number Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Text Color
#DesignerProperty: Key: Background, DisplayName: Background Color, FieldType: Color, DefaultValue: 0x00FFFFFF, Description: Background Color
#DesignerProperty: Key: btnTextColor, DisplayName: Button text Color, FieldType: Color, DefaultValue: 0xFFFFFFFF, Description: Button Text Color
#DesignerProperty: Key: btnBackground, DisplayName: Button Background Color, FieldType: Color, DefaultValue: 0xFFA52A2A, Description: Button  Background Color
#DesignerProperty: Key: mBorder, DisplayName: Border size, FieldType: Int, DefaultValue: 0, Description: Border size
#DesignerProperty: Key: Classes, DisplayName: Classes, FieldType: String, DefaultValue: sd-stepper, Description: Classes added to the HTML tag.
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
#DesignerProperty: Key: Type, DisplayName: Type, FieldType: String, DefaultValue: p, List: p|div|span|h1|h2|h3|h4|h5|h6, Description: Type of label
#DesignerProperty: Key: StringWithListExample, DisplayName: String With List, FieldType: String, DefaultValue: Sunday, List: Sunday|Monday|Tuesday|Wednesday|Thursday|Friday|Saturday

Sub Class_Globals
	Private BANano As BANano 'ignore
	Private mName As String 'ignore
	Private mEventName As String 'ignore
	Private mCallBack As Object 'ignore
	Private mTarget As BANanoElement 'ignore
	Private mElement As BANanoElement 'ignore
	Private btnMeno As BANanoElement 'ignore
	Private btnPiu As BANanoElement 'ignore
	
	Private mValue As String = ""
	Private minValue As Int = 0
	Private maxValue As Int = 10
	Private mTextColor As String = ""
	Private mBackground As String = ""
	Private mbtnTextColor As String = ""
	Private mbtnBackground As String = ""
	Private mBorder As Int = 0
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
	Private mType As String = "p"
	
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
		mValue = Props.Get("Value")
		minValue = 1 * Props.Get("minValue")
		maxValue = 1 * Props.Get("maxValue")
		mTextColor = Props.Get("TextColor")
		mBackground = Props.Get("Background")
		mbtnTextColor = Props.Get("btnTextColor")
		mbtnBackground = Props.Get("btnBackground")
		mBorder = Props.Get("mBorder")
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
		mType = Props.Get("Type")
	End If
	
	Dim exStyle As String = BuildExStyle

	'mElement = mTarget.Append($"<div id="div${mName}" class="${mClasses}" style="${exStyle}${mStyle}"><${mType} id="${mName}">${mValue}<${mType}/></div>"$).Get("#" & mName)
	mElement = mTarget.Append($"<div id="div_${mName}" class="sd-label" style="width: 100%; box-sizing: border-box; overflow: hidden; text-align: center; border-radius: 10px; border: ${mBorder}px solid #AAAAAA;${exStyle}${mStyle}">
		<div style="width: 30%; height: 50px; text-align: center; line-height: 50px;">
			<button id="meno_${mName}" Type="button" class="${mClasses}" style="border-radius: 50%; padding: 10px 15px;">-</button>
		</div>
		<div style="min-width: 35%; height: 50px; text-align: center; line-height: 20px;">
			<${mType} id="${mName}">${mValue}</${mType}>
		</div>
		<div style="width: 30%; height: 50px; text-align: center; line-height: 50px;">
			<button id="plus_${mName}" Type="button" class="${mClasses}" style="border-radius: 50%; padding: 10px 15px;">+</button>
		</div>
	</div>"$)
				
	'' defining events is very simple. Note that it has to be run AFTER adding it to the HTML DOM! eventName must be lowercase!
	'mElement.HandleEvents("click", mCallBack, mEventName & "_click")
	'mElement.HandleEvents("mouseenter", Me, "mouseenter")
	btnMeno = mElement.Get($"#meno_${mName}"$)
	btnPiu = mElement.Get($"#plus_${mName}"$)
	btnMeno.HandleEvents("click", Me, "meno_click")
	btnPiu.HandleEvents("click", Me, "piu_click")
	
	setBackgroundColor(mBackground)
	setTextColor(mTextColor)
	setbtnBackgroundColor(mbtnBackground)
	setbtnTextColor(mbtnTextColor)
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

public Sub setValue(t As String)
	If BANano.IsNumber(t) Then 
		mValue = t
		Dim be As BANanoElement = BANano.GetElement("#" & mName)
		be.SetText(t)
	End If
End Sub

public Sub getValue() As String
	Return mValue
End Sub

Public Sub setBackgroundColor(Color As String)
	mBackground=Color
	BANano.GetElement("#" & mName).SetStyle($"{"background-color":"${Color}"}"$)
	BANano.GetElement("#div_" & mName).SetStyle($"{"background-color":"${Color}"}"$)
End Sub

Public Sub getBackgroundColor As String
	Return mBackground
End Sub

Public Sub setTextColor(Color As String)
	mTextColor=Color
	Dim be As BANanoElement = BANano.GetElement("#" & mName)
	be.SetStyle($"{"color":"${Color}"}"$)
End Sub

Public Sub getTextgroundColor As String
	Return mTextColor
End Sub

Public Sub setbtnBackgroundColor(Color As String)
	mbtnBackground=Color
	btnMeno.SetStyle($"{"background-color":"${Color}"}"$)
	btnPiu.SetStyle($"{"background-color":"${Color}"}"$)
End Sub

Public Sub getbtnBackgroundColor As String
	Return mbtnBackground
End Sub

Public Sub setbtnTextColor(Color As String)
	mbtnTextColor=Color
	btnMeno.SetStyle($"{"color":"plus_${Color}"}"$)
	btnPiu.SetStyle($"{"color":"meno_${Color}"}"$)
End Sub

Public Sub getbtnTextgroundColor As String
	Return mbtnTextColor
End Sub

#End Region

#Region Internal Events

Private Sub meno_click(event As BANanoEvent)
	Log(event.ID)
	mValue=Max(mValue-1,minValue)
	Dim be As BANanoElement = BANano.GetElement("#" & mName)
	be.SetText(mValue)
End Sub

private Sub piu_click(event As BANanoEvent)
	Log(event.ID)
	mValue=Min(mValue+1,maxValue)
	Dim be As BANanoElement = BANano.GetElement("#" & mName)
	be.SetText(mValue)
End Sub

#End Region
