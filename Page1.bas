B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	Private BANano As BANano 'ignore
	
	'lay1
	Private SDcontainer1 As SDcontainer 'ignore
	Private SDgrid1 As SDgrid 'ignore
	Private SDselect1 As SDselect 'ignore
	Private SDlist1 As SDlist 'ignore
	Private SDswitch5 As SDswitch 'ignore
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(nBANano As BANano)
	BANano=nBANano
End Sub

Public Sub Show
	'SDfunc.MainLayout.Empty
	SDfunc.MainLayout.LoadLayout("MainLayout1")
	SetLay1
End Sub

Private Sub SetLay1 'ignore
	SDgrid1.AddRow(Array As String("1","John Doe","john@example.com","123-456-7890"))
	SDgrid1.AddRow(Array As String("2","Jane Smith","jane@example.com","987-654-3210"))
	SDgrid1.AddRow(Array As String("3","Samuel Green","samuel@example.com","555-555-5555"))
	SDgrid1.AddRow(Array As String("4","Alice Johnson","alice@example.com","444-444-4444"))
		
	SDgrid1.setCellTextColor("red",1,2)
	SDgrid1.setBoldText(1,2)
	
	SDlist1.BackgroundColor="yellow"
	SDlist1.TextColor="red"
End Sub

#Region Lay1

Private Sub Modal_ModalClick(btn As String)
	SDfunc.ShowToast("Answer : " & btn,SDfunc.TpeAlert,1000,True)
End Sub

Private Sub SDgrid1_Click (Row As Int, Col As Int)
	SDfunc.ShowToast($"Clicked Row:${Row} Col:${Col}"$,SDfunc.TpeError,1500,False)
End Sub

Private Sub SDgrid1_HeadClick (Col As Int)
	SDfunc.ShowToast($"Clicked Header Col:${Col}"$,SDfunc.TpeInfo,1500,False)
End Sub

Private Sub SDbutton1_Click (event As BANanoEvent)
	SDselect1.ChangeOption(Array As String("Opt A","Opt B","Opt C","Opt D"),Array As String("1","2","3","4"))
	SDlist1.Changeitem(Array As String("Opt A","Opt B","Opt C","Opt D"),Array As String("1","2","3","4"))
	
	SDgrid1.setCellTextColor("white",4,4)
	SDgrid1.setCellBackgroundColor("red",4,4)
	SDgrid1.setText($"${NumberFormat(Rnd(100,999),3,0)}-888-${NumberFormat(Rnd(100,999),3,0)}"$,4,4)
End Sub

Private Sub SDlist1_Click (Item As String, ID As String)
	SDfunc.ShowToast($"List select: ${Item} - ${ID}"$,SDfunc.TpeInfo,1500,False)
End Sub

Private Sub SDicon1_Click (event As BANanoEvent)
	'SDfunc.ShowToast($"Icon"$,SDfunc.TpeAlert,1500,False)
	SDfunc.ShowModal(Me,"Modal","Title","This is test or text. Boh!","Cancel","Confirm","")
End Sub

Private Sub SDcombo1_Selected (Text As String)
	SDfunc.ShowToast($"Combo: ${Text}"$,SDfunc.TpeAlert,1500,False)
End Sub

#End Region
