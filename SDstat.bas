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
#DesignerProperty: Key: mType, DisplayName: Type diagram, FieldType: String, DefaultValue: Line,List: Line|Bar, Description: Type of diagram
#DesignerProperty: Key: mWidth, DisplayName: Width, FieldType: String, DefaultValue: 200px, Description: Width
#DesignerProperty: Key: mHeight, DisplayName: Height, FieldType: String, DefaultValue: 200px, Description: Height
#DesignerProperty: Key: mlColor, DisplayName: Lines Color, FieldType: Color, DefaultValue: 0xFF007BFF, Description: Lines Color
#DesignerProperty: Key: mpColor, DisplayName: Point Color, FieldType: Color, DefaultValue: 0xFFFF0000, Description: Point Color
#DesignerProperty: Key: mtColor, DisplayName: Text Color, FieldType: Color, DefaultValue: 0xFF000000, Description: Label Text Color
#DesignerProperty: Key: mTracer, DisplayName: Line Tracer, FieldType: Boolean, DefaultValue: True, Description: Reference lines y values
#DesignerProperty: Key: mStartZero, DisplayName: Start Zero, FieldType: Boolean, DefaultValue: True, Description: Y start from zero or minimu value
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
	
	Private mType As String = "Line"
	Private mWidth As String = ""
	Private mHeight As String = ""
	Private mTracer As Boolean = True
	Private mStartZero As Boolean = True
	Private mlColor As String =""
	Private mpColor As String =""
	Private mtColor As String =""
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
	Private Padding As Int = 35
	Private cWidth As Int = 0
	Private cHeight As Int = 0
	Private Values As List
	Private Names As List
	
	Private chartWidth As Int = 0
	Private chartHeight As Int = 0
	Private nTarget As Int = 10
	Private MaxValues As Int = 0
	Private MinValues As Int = 0
	Private PointDepth As Int = 4
End Sub

' initializes the component
Public Sub Initialize (CallBack As Object, Name As String, EventName As String)
	mName = Name
	mEventName = EventName.ToLowerCase
	mCallBack = CallBack	
	
	Values.Initialize
	Names.Initialize
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
		mType = Props.Get("mType")
		mWidth = Props.Get("mWidth")
		mHeight = Props.Get("mHeight")
		mTracer = Props.Get("mTracer")
		mStartZero = Props.Get("mStartZero")
		mlColor = Props.Get("mlColor")
		mpColor = Props.Get("mpColor")
		mtColor = Props.Get("mtColor")
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
	
	mElement = mTarget.Append($"<canvas id="${mName}" width="${mWidth}" height="${mHeight}" style="${exStyle}${mStyle}"></canvas>"$).Get("#" & mName)
	
	'' defining events is very simple. Note that it has to be run AFTER adding it to the HTML DOM! eventName must be lowercase!
	'mElement.HandleEvents("click", mCallBack, mEventName & "_click")
	'mElement.HandleEvents("mouseenter", Me, "mouseenter")
	cWidth = mElement.OffsetWidth
	cHeight = mElement.OffsetHeight
	Draw
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

' SetPaddingCart(15)
Public Sub SetPaddingCart(Pad As Int)
	Padding=Pad
	Draw
End Sub

Public Sub Clear
	Values.Clear
	Names.Clear
	Draw
End Sub

' AddPinti(Name,Value) Value -> (0..100)
Public Sub AddPoint(Name As String, Value As Double) As SDstat
	Names.Add(Name)
	Values.Add(Value)
	Return Me
End Sub
#End Region

#Region Internal Events

Public Sub Draw
	Dim doc As BANanoObject = BANano.Window.GetField("document")
	Dim canvas As BANanoObject = doc.RunMethod("getElementById", Array($"${mName}"$))
	Dim ctx As BANanoObject = canvas.RunMethod("getContext", Array("2d"))
	
	ctx.RunMethod("clearRect", Array(0, 0,cWidth,cHeight))
	ctx.SetField("fillStyle","white")
	ctx.RunMethod("fillRect", Array(0, 0,cWidth,cHeight))
	
	DrawAxes(ctx)
	Select mType
		Case "Line"
			DrawLines(ctx)
		Case "Bar"
			DrawChart(ctx)
	End Select
End Sub

Private Sub DrawAxes(ctx As BANanoObject)
	chartWidth = cWidth-Padding*1.3
	chartHeight = cHeight-Padding*2
		
	' Drae Axes
	ctx.RunMethod("beginPath", Null)
	ctx.RunMethod("moveTo", Array(Padding, Padding))
	ctx.RunMethod("lineTo", Array(Padding, Padding + chartHeight))
	ctx.RunMethod("lineTo", Array(Padding+chartWidth, Padding + chartHeight))
	ctx.SetField("strokeStyle","#333")
	ctx.RunMethod("stroke", Null)

	If Values.Size>0 Then
		MaxValues = Values.Get(0)
		MinValues = Values.Get(0)
		
		' MinimumValue and Maximum Value
		For index=0 To Values.Size-1
			MaxValues=Max(Values.Get(index),MaxValues)
			MinValues=Min(Values.Get(index),MinValues)
		Next
		If mStartZero Then MinValues=0
		'Label
		ctx.SetField("font","11px Arial")
		ctx.SetField("fillStyle",mtColor)
		' Etichette Y
		For index=0 To nTarget
			Dim y As Double = chartHeight + Padding - (index * chartHeight / nTarget)
			Dim value As Double = MinValues + index * ((MaxValues-MinValues)/nTarget)
			ctx.RunMethod("fillText",Array(NumberFormat(value,1,0), 3, y + 5))
			If mTracer Then
				ctx.RunMethod("beginPath", Null)
				ctx.RunMethod("moveTo", Array(Padding, y))
				ctx.RunMethod("lineTo", Array(Padding+chartWidth, y))
				ctx.SetField("strokeStyle","rgba(200, 200, 200, 0.2)")
				ctx.SetField("lineWidth", 1)
				ctx.RunMethod("stroke", Null)
			End If
		Next
		' Etichette X
		For index=0 To Names.Size-1
			Dim x As Double = Padding + (index * (chartWidth / (Names.Size - 1)))
			ctx.RunMethod("fillText",Array(Names.Get(index), x-15, chartHeight + Padding + 20))
		Next
	End If
End Sub

Private Sub DrawLines(ctx As BANanoObject)
	If Values.Size>0 Then
		Dim Range As Double = MaxValues-MinValues

		' lines
		ctx.RunMethod("beginPath", Null)
		For index=0 To Values.Size-1
			Dim x As Double = Padding + (index * (chartWidth / (Values.Size - 1)))
			Dim y As Double = chartHeight + Padding - ((Values.Get(index)-MinValues) * chartHeight / Range)
			If (index = 0) Then 
				ctx.RunMethod("moveTo", Array(x, y))
			Else 
				ctx.RunMethod("lineTo", Array(x, y))
			End If
		Next
		ctx.SetField("strokeStyle",mlColor)
		ctx.SetField("lineWidth", 2)
		ctx.RunMethod("stroke", Null)
		
		' point
		For index=0 To Values.Size-1
			Dim x As Double = Padding + (index * (chartWidth / (Values.Size - 1)))
			Dim y As Double = chartHeight + Padding - ((Values.Get(index)-MinValues) * chartHeight / Range)
			ctx.RunMethod("beginPath", Null)
			
			ctx.RunMethod("arc", Array(x,y,PointDepth,0,cPI*2))
			ctx.SetField("fillStyle",mpColor)
			ctx.RunMethod("fill", Null)
		Next
	End If
End Sub

Private Sub DrawChart(ctx As BANanoObject)
	If Values.Size>0 Then 
		Dim barWidth As Double = chartWidth / Values.Size - 10
		Dim Range As Double = MaxValues-MinValues
		Dim chartW As Double = cWidth-Padding-barWidth- 5
		Dim chartH As Double = cHeight-Padding*2
		
		For index=0 To Values.Size-1
			Dim x As Double = Padding + (barWidth/2) + (index * (chartW / (Values.Size - 1))) - (barWidth / 2)
			Dim y As Double = chartH + Padding - (Values.Get(index) * chartH / Range)
			Dim height As Double = Values.get(index) * chartH / Range
		
			ctx.SetField("fillStyle",mlColor)
			ctx.RunMethod("fillRect", Array(x, y, barWidth, height))
		Next
	End If
End Sub

#End Region

