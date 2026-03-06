B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=10
@EndOfDesignText@
Sub Class_Globals
	Private BANano As BANano 'ignore
	
	Private SDcarousel1 As SDcarousel 'ignore
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(nBANano As BANano)
	BANano=nBANano
End Sub

Public Sub Show
	SDfunc.MainLayout.LoadLayout("MainLayout6")
	
	SDcarousel1.AddImage("https://www.sapevatelo.org/wp-content/uploads/2018/01/desktop-hd-inverno.jpg")
	SDcarousel1.AddImage("https://sfondo.info/i/original/5/4/e/20770.jpg")
	SDcarousel1.AddImage("https://sfondo.info/i/original/9/d/8/50176.jpg")
	SDcarousel1.AddImage("https://sfondo.info/i/original/6/4/f/1675.jpg")
	SDcarousel1.AddImage("https://www.pomodorozen.com/wp-content/uploads/2016/06/Sondi-desktop-tramonti-28.jpg")
End Sub