B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private stoneImg As B4XBitmap
	Private position As vector
	Public sizeRect As B4XRect
End Sub

'Initializes the object. You can add parameters to this method if needed.
Public Sub Initialize(bmp As B4XBitmap,size As B4XRect)
	position.Initialize(size.Left,size.top)
	stoneImg = bmp
	sizeRect = size
End Sub
 
Public Sub draw
	Main.cnv.DrawBitmap(stoneImg,sizeRect)
End Sub
 