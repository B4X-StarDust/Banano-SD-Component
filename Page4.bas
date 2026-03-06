B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	Private BANano As BANano 'ignore
	
	Private SDthree1 As SDthree 'ignore
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(nBANano As BANano)
	BANano=nBANano
End Sub

Public Sub Show
	'SDfunc.MainLayout.Empty
	SDfunc.MainLayout.LoadLayout("MainLayout4")
	
	Sleep(2000)
	SDthree1.SetPosition(SDthree1.GetPositionX+5,SDthree1.GetPositionY+5,SDthree1.GetPositionz+5)
End Sub