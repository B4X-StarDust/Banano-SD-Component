B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
'Custom BANano View class

#Event: Change (PercentStart As Double, PercentEnd As Double)
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
#DesignerProperty: Key: mValueS, DisplayName: Initial Start, FieldType: Int, DefaultValue: 0, MinRange: 0, MaxRange: 100,Description: Initial start percentage (0..100)
#DesignerProperty: Key: mValueE, DisplayName: Initial End, FieldType: Int, DefaultValue: 100, MinRange: 0, MaxRange: 100,Description: Initial end percentage (0..100)
#DesignerProperty: Key: Classes, DisplayName: Classes, FieldType: String, DefaultValue: sdseekbar-container, Description: Classes added to the HTML tag.
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
	
	Private mValueS As Int = 0
	Private mValueE As Int = 0
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
	Private percentS As Double
	Private percentE As Double
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
		mValueS =  1 * Props.Get("mValueS")
		mValueE =  1 * Props.Get("mValueE")
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
		<div class="sdseekbar" id="${mName}-rangebar">
			<div class="sdseekbar-progress" id="${mName}-Progress"></div>
			<div class="sdseekbar-thumb" id="${mName}-Min"></div>
			<div class="sdseekbar-thumb" id="${mName}-Max"></div>
		</div>
	</div>"$).Get("#" & mName)
		
	'' defining events is very simple. Note that it has to be run AFTER adding it to the HTML DOM! eventName must be lowercase!
	'mElement.HandleEvents("click", mCallBack, mEventName & "_click")
	'mElement.HandleEvents("mouseenter", Me, "mouseenter")
	BANano.GetElement($"#${mName}-Min"$).HandleEvents("mousemove",Me,"drag_minrangebar")
	BANano.GetElement($"#${mName}-Max"$).HandleEvents("mousemove",Me,"drag_maxrangebar")
	BANano.GetElement($"#${mName}-rangebar"$).HandleEvents("mousemove",Me,"drag_rangebar")
	
	BANano.GetElement($"#${mName}-Min"$).HandleEvents("touchmove",Me,"touch_minrangebar")
	BANano.GetElement($"#${mName}-Max"$).HandleEvents("touchmove",Me,"touch_maxrangebar")
	
	setValueStart(mValueS)
	setValueEnd(mValueE)
End Sub

Private Sub drag_rangebar (event As BANanoEvent)
	If event.Buttons=1 Then
		Dim rangebar As BANanoElement = BANano.GetElement($"#${mName}-rangebar"$)
		Dim tch As Double = event.ClientX
		Dim mnc As Double = 1 * BANano.GetElement($"#${mName}-Min"$).GetStyle("left").Replace("px","")
		Dim mxc As Double = 1 * BANano.GetElement($"#${mName}-Max"$).GetStyle("left").Replace("px","")
				
		If Abs(tch-mnc)<Abs(tch-mxc) Then 
			' min
			percentS = ((event.ClientX - rangebar.OffsetLeft) / rangebar.offsetWidth) * 100
		Else
			' max
			percentE = ((event.ClientX - rangebar.OffsetLeft) / rangebar.offsetWidth) * 100
		End If
		update_rangebar
		
		percentS=Max(Min(100,percentS),0)
		update_rangebar
	End If
End Sub

Private Sub drag_minrangebar (event As BANanoEvent)
	If event.Buttons=1 Then
		Dim rangebar As BANanoElement = BANano.GetElement($"#${mName}-rangebar"$)
		percentS = ((event.ClientX - rangebar.OffsetLeft) / rangebar.offsetWidth) * 100
		percentS=Max(Min(100,percentS),0)
		update_rangebar
	End If
End Sub

Private Sub drag_maxrangebar (event As BANanoEvent)
	If event.Buttons=1 Then
		Dim rangebar As BANanoElement = BANano.GetElement($"#${mName}-rangebar"$)
		percentE = ((event.ClientX - rangebar.OffsetLeft) / rangebar.offsetWidth) * 100
		percentE=Max(Min(100,percentE),0)
		update_rangebar
	End If
End Sub

Private Sub touch_minrangebar (event As BANanoEvent)
	Dim rangebar As BANanoElement = BANano.GetElement($"#${mName}-rangebar"$)
	Dim eventx As Double = BANano.RunJavascriptMethod("touchx", Array(event))
	percentS = ((eventx - rangebar.OffsetLeft) / rangebar.offsetWidth) * 100
	percentS=Max(Min(100,percentS),0)
	update_rangebar
End Sub

Private Sub touch_maxrangebar (event As BANanoEvent)
	Dim rangebar As BANanoElement = BANano.GetElement($"#${mName}-rangebar"$)
	Dim eventx As Double = BANano.RunJavascriptMethod("touchx", Array(event))
	percentE = ((eventx - rangebar.OffsetLeft) / rangebar.offsetWidth) * 100
	percentE=Max(Min(100,percentE),0)
	update_rangebar
End Sub

Private Sub update_rangebar
	
	BANano.GetElement($"#${mName}-Min"$).SetStyle($" { "left":"${percentS}%" }"$)
	BANano.GetElement($"#${mName}-Max"$).SetStyle($" { "left":"${percentE}%" }"$)
	
	BANano.GetElement($"#${mName}-Progress"$).SetStyle($" { "margin-left":"${percentS}%", "width":"${(percentE-percentS)}%" }"$)
		
	BANano.CallSub(mCallBack,mEventName & "_change",Array (percentS,percentE))
End Sub

' 0..100
Public Sub getValueStart As Double
	Return percentS
End Sub

Public Sub setValueStart (v As Double)
	percentS=Min(Max(v,0),100)
	update_rangebar
	BANano.CallSub(mCallBack,mEventName & "_change",Array (percentS,percentE))
End Sub

' 0..100
Public Sub getValueEnd As Double
	Return percentE
End Sub

Public Sub setValueEnd (v As Double)
	percentE=Min(Max(v,0),100)
	update_rangebar
	BANano.CallSub(mCallBack,mEventName & "_change",Array (percentS,percentE))
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
#End Region

#Region Internal Events

#End Region

#IF javascript
function touchx(event) {
	return event.touches[0].clientX;;
}
#End If