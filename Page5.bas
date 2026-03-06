B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	Private BANano As BANano 'ignore
	
	Private SDlabel1 As SDlabel 'ignore
	Private SDseekbar1 As SDseekbar 'ignore
	Private SDlabel2 As SDlabel 'ignore
	Private SDstat1 As SDstat 'ignore
	Private SDstat2 As SDstat 'ignore
	Private SDwordEditor1 As SDwordEditor 'ignore
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(nBANano As BANano)
	BANano=nBANano
End Sub

Public Sub Show
	'SDfunc.MainLayout.Empty
	SDfunc.MainLayout.LoadLayout("MainLayout5")
	
	SDstat1.AddPoint("A",10).AddPoint("B",25).AddPoint("C",15).AddPoint("D",30).AddPoint("E",20)
	SDstat1.AddPoint("F",40).AddPoint("G",35)
	SDstat1.Draw
	
	SDstat2.AddPoint("A",10).AddPoint("B",25).AddPoint("C",15).AddPoint("D",30).AddPoint("E",20)
	SDstat2.AddPoint("F",40).AddPoint("G",35)
	SDstat2.Draw
End Sub

Private Sub SDseekbar1_Change (Percent As Double)
	SDlabel1.Text = $"${NumberFormat(Percent,1,0)}%"$
End Sub

Private Sub SDrangebar1_Change (PercentStart As Double, PercentEnd As Double)
	SDlabel2.Text = $"${NumberFormat(PercentStart,1,0)}% -${NumberFormat(PercentEnd,1,0)}%"$
End Sub

Private Sub SDwordEditor1_Save
	BANano.console.Log(SDwordEditor1.content)
End Sub