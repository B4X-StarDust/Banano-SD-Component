B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	Private BANano As BANano 'ignore
	
	'lay3
	Private SDlabel1 As SDlabel 'ignore
	Private SDgoogleMap1 As SDgoogleMap 'ignore
	Private SDtimepicker1 As SDtimepicker 'ignore
	Private SDdatepicker1 As SDdatepicker 'ignore
	Private SDinput1 As SDinput 'ignore
	Private SDinput2 As SDinput 'ignore
	Private SDinput4 As SDinput 'ignore
	Private SDinput3 As SDinput 'ignore
	Private SDinput5 As SDinput 'ignore
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(nBANano As BANano)
	BANano=nBANano
End Sub

Public Sub Show
	'SDfunc.MainLayout.Empty
	SDfunc.MainLayout.LoadLayout("MainLayout3") 
End Sub

#Region Lay3

Private Sub SDmenuHoriz1_Click (Pos As Int, Item As String)
	SDfunc.ShowToast($"Item ${Pos} ${Item}"$,SDfunc.TpeAlert,500,True)
End Sub

Private Sub SDtimepicker1_Click (event As BANanoEvent)
	SDfunc.ShowToast($"Time ${SDtimepicker1.GetTime}"$,SDfunc.TpeAlert,500,True)
End Sub

Private Sub SDdatepicker1_Click (event As BANanoEvent)
	SDfunc.ShowToast($"Date ${SDdatepicker1.GetDate}"$,SDfunc.TpeAlert,500,True)
End Sub

Private Sub SDinput1_Change (event As BANanoEvent)
	SDfunc.ShowToast($"Check ${SDinput1.GetChecked}"$,SDfunc.TpeAlert,500,True)
End Sub

Private Sub SDinput2_Change (event As BANanoEvent)
	SDfunc.ShowToast($"Radio 1 ${SDinput2.GetValue}"$,SDfunc.TpeAlert,500,True)
End Sub

Private Sub SDinput6_Change (event As BANanoEvent)
	SDfunc.ShowToast($"Radio 2 ${SDinput2.GetValue}"$,SDfunc.TpeAlert,500,True)
End Sub

Private Sub SDinput3_Change (event As BANanoEvent)
	SDfunc.ShowToast($"Pass ${SDinput3.GetValue}"$,SDfunc.TpeAlert,500,True)
End Sub

Private Sub SDinput4_Change (event As BANanoEvent)
	SDfunc.ShowToast($"Color ${SDinput4.GetValue}"$,SDfunc.TpeAlert,500,True)
End Sub

Private Sub SDgoogleMap1_Ready (Success As Boolean)
	If Success Then
		Dim ListCoordinate As List
		ListCoordinate.Initialize2(Array (CreateMap("lat":41.9038,"lng":12.4954),CreateMap("lat":41.9014,"lng":12.4989),CreateMap("lat":41.9020,"lng":12.4925)))
		SDgoogleMap1.AddPolygon("#000000","#FFFF00",ListCoordinate)
		SDgoogleMap1.AddPolyline("#FF0000",Array(CreateMap("lat":41.9041,"lng":12.4954),CreateMap("lat":41.9054,"lng":12.4989),CreateMap("lat":41.9034,"lng":12.4989),CreateMap("lat":41.9041,"lng":12.4954)))
		SDgoogleMap1.AddMarker("Roma",41.9028, 12.4934,"")
		SDgoogleMap1.AddInfoWindow("Roma",41.9028, 12.5004)
		
		Dim C As BANanoObject = SDgoogleMap1.AddCircle(41.9028, 12.4964,100,"black","red")
		SDfunc.ShowToast("Center circle " & BANano.ToJson(SDgoogleMap1.GetCirclePosition(C)),SDfunc.TpeAlert,1000,True)
	End If
End Sub

Private Sub SDgoogleMap1_Click (Lat As Double, Lng As Double)
	SDfunc.ShowModal(Me,"Modal","Mappa",$"lat:${Lat} Lon:${Lng}"$,"Confirm","Cancel","")
End Sub

Private Sub SDgoogleMap1_MouseMove (Lat As Double, Lng As Double)
	SDlabel1.Text=$"lat: ${NumberFormat(Lat,1,4)}  - Lon:${NumberFormat(Lng,1,4)}"$
End Sub

Private Sub SDgoogleMap1_CircleClick (CircleObject As BANanoObject)
	SDfunc.ShowToast($"Click Circle"$,SDfunc.TpeAlert,1500,False)
End Sub

Private Sub SDgoogleMap1_CircleDblClick (CircleObject As BANanoObject)
	Dim Dr As Boolean = SDgoogleMap1.GetObjDaggable(CircleObject)
	Dr=Not(Dr)
	SDfunc.ShowModalTimed("Circle","Double Click - DRAGGABLE " & BANano.ToString(Dr),1500)
	SDgoogleMap1.SetObjDaggable(CircleObject,Dr)
End Sub

Private Sub SDgoogleMap1_PolygonClick (PolygonObject As BANanoObject)
	SDfunc.ShowToast($"Click PolyGon"$,SDfunc.TpeAlert,1500,False)
End Sub

Private Sub SDgoogleMap1_PolygonDblClick (PolygonObject As BANanoObject)
	Dim Drgb As Boolean = Not(SDgoogleMap1.GetObjDaggable(PolygonObject))
	SDfunc.ShowModalTimed("Circle","Polygon Double Click - DRAGGABLE " & BANano.ToString(Drgb),1500)
	SDgoogleMap1.SetObjDaggable(PolygonObject,Drgb)
End Sub

Private Sub SDgoogleMap1_MarkerClick (Title As String, MarkerObject As BANanoObject)
	SDfunc.ShowToast($"Click Marker"$,SDfunc.TpeAlert,1500,False)
End Sub

Private Sub SDgoogleMap1_InfoWindowCloseClick(InfoWindow As BANanoObject)
	SDfunc.ShowToast($"Info cloded"$,SDfunc.TpeAlert,1500,False)
End Sub

Private Sub SDgoogleMap1_CenterMapMove (Lat As Double, Lng As Double)
	SDlabel1.Text=$"CENTER lat: ${NumberFormat(Lat,1,4)}  - Lon:${NumberFormat(Lng,1,4)}"$
End Sub

#End Region
