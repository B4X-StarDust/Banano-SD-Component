B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	Private BANano As BANano 'ignore
	
	'Lay2
	Private SDplanning1 As SDplanning 'ignore
	Private SDcalendar1 As SDcalendar 'ignore
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(nBANano As BANano)
	BANano=nBANano
End Sub

Public Sub Show
	'SDfunc.MainLayout.Empty
	SDfunc.MainLayout.LoadLayout("MainLayout2")
	SetLay2
End Sub

Private Sub SetLay2 'ignore
	SDplanning1.SetHeader(Array As String("15 feb","16 feb","17 feb","18 feb","19 feb","20 feb","21 feb"))
	SDplanning1.SetHeaderStyle("lightgray","black")
	SDplanning1.AddItem(0,"0_08_00",DateTime.TimeParse("08:00"),60,"Test 1")
	SDplanning1.AddItem(2,"2_11_10",DateTime.TimeParse("11:10"),60,"Test 3")
	SDplanning1.AddItem(2,"2_10_00",DateTime.TimeParse("10:00"),60,"test 2")
	SDplanning1.AddItem(2,"2_10_30",DateTime.TimeParse("10:30"),60,"Test 3")
	SDplanning1.AddItem(2,"2_08_00",DateTime.TimeParse("08:00"),60,"test 2")
	SDplanning1.AddItem(2,"2_12_00",DateTime.TimeParse("12:00"),60,"test 2")
	SDplanning1.AddItem(6,"6_12_00",DateTime.TimeParse("12:00"),60,"Text 4")
	
	SDplanning1.AddElement(4,"4_11_10",DateTime.TimeParse("11:10"),60).LoadLayoutArray("item",False)
	SDplanning1.AddElement(4,"4_12_10",DateTime.TimeParse("12:10"),60).LoadLayoutArray("item",False)
	
	Dim Be As BANanoElement = SDplanning1.AddElement(5,"5_11_10",DateTime.TimeParse("11:10"),60)
	Be.LoadLayoutArray("item",False)
	
	For Each ch As BANanoElement In Be.Children("")
		BANano.Console.Log("ID: " & ch.Name)
	Next
End Sub

#region Lay2

Private Sub SDbuttonModal_Click (event As BANanoEvent)
	SDfunc.ShowModal(Me,"Modal","Title","This is test or text. Boh! ","Cancel","Confirm","Altro")
End Sub

Private Sub SDcalendar1_DayClick (Day As Int)
	SDfunc.ShowToast($"Cliccato giorno: ${Day}"$,SDfunc.TpeAlert,1500,False)
	SDcalendar1.SetDay(Day,"white", "#4CAF50")
	Sleep(2000)
	SDcalendar1.reSetDay(Day)
End Sub

Private Sub SDcalendar1_ChangeCalendar (Year As Int, Month As Int)
	SDfunc.ShowToast($"Cambiate: ${Month}/${Year}"$,SDfunc.TpeAlert,1500,False)
End Sub

#End Region
