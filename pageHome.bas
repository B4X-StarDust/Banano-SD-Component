B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	Private BANano As BANano 'ignore
	Private SDpanelMain As SDpanel 'ignore
	Private SDmenuHmain As SDmenuHoriz 'ignore
	Private SDsidebarMain As SDsidebar 'ignore
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(nBANano As BANano)
	BANano=nBANano
End Sub

Public Sub Show
	'SDfunc.MainLayout.Empty
	SDfunc.SetBodyImage("https://cdn.pixabay.com/photo/2017/06/14/08/20/map-of-the-world-2401458_1280.jpg")
	SDfunc.MainLayout.LoadLayout("MainPage")
	SDfunc.SetMainLayout(SDpanelMain.Element)
	
	SDfunc.LoadingIndicator(True)
	Sleep(1000)
	SDfunc.LoadingIndicator(False)
End Sub

Private Sub SDmenuHmain_Click (Pos As Int, Item As String)
	Select Item
		Case "Home"
			SDfunc.MainLayout
		Case "Page 1"
			Main.classPage1.Show
		Case "Page 2"
			Main.classPage2.Show
		Case "Page 3"
			Main.classPage3.Show
		Case "Page 4"
			Main.classPage4.Show
		Case "Page 5"
			Main.classPage5.Show
		Case "Page 6"
			Main.classPage6.Show
	End Select
	SDsidebarMain.Opened=False
End Sub

Private Sub SDsidebarMain_Click (Pos As Int, Item As String)
	Select Pos
		Case 0
			SDfunc.MainLayout
		Case 1
			Main.classPage1.Show
		Case 2
			Main.classPage2.Show
		Case 3
			Main.classPage3.Show
		Case 4
			Main.classPage4.Show
		Case 5
			Main.classPage5.Show
		Case 6
			Main.classPage6.Show
	End Select
	SDsidebarMain.Opened=False
End Sub

Private Sub SDiconMain_Click (event As BANanoEvent)
	Dim B As Boolean = SDsidebarMain.Opened
	SDfunc.ShowToast("Menu: " & BANano.tostring(B),  SDfunc.TpeInfo,500,False)
	SDsidebarMain.Opened=Not(b)
End Sub