B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=StaticCode
Version=9.3
@EndOfDesignText@
'Static code module
Sub Process_Globals
End Sub
 
Public Sub dist(v1 As vector, v2 As vector) As Float '*
	Dim dx As Float = v1.x - v2.x
	Dim dy As Float = v1.y - v2.y
	Return Sqrt((dx * dx) + (dy * dy))
End Sub

Public Sub distSq (v1 As vector, v2 As vector) As Float '*
	Dim dx As Float = v1.x - v2.x
	Dim dy As Float = v1.y - v2.y
	Return (dx * dx) + (dy * dy)
End Sub
	
Public Sub vectorSub(v1 As vector, v2 As vector) As vector '*
	Dim v As vector
	v.Initialize(0,0)
	v.x = v1.x - v2.x
	v.y = v1.y - v2.y
	Return v
End Sub

Public Sub vectorAdd(v1 As vector, v2 As vector) As vector '*
	Dim v As vector
	v.Initialize(0,0)
	v.x = v1.x + v2.x
	v.y = v1.y + v2.y
	Return v
End Sub

Public Sub vectorMult(v1 As vector, v2 As vector) As vector
	Dim v As vector
	v.Initialize(0,0)
	v.x = v1.x * v2.x
	v.y = v1.y * v2.y
	Return v
End Sub

Public Sub vectorDiv(v1 As vector, v2 As vector) As vector
	Dim v As vector
	v.Initialize(0,0)
	v.x = v1.x / v2.x
	v.y = v1.y / v2.y
	Return v
End Sub

Public Sub vectorFromAngle(angle As Float) As vector '*
	Dim v As vector
	v.Initialize(0,0)
	v.x = Cos(angle)
	v.y = Sin(angle)
	Return v
End Sub

Public Sub random2d As vector
	Dim v As vector
	v.Initialize(Rnd(-100,100)/100,Rnd(-100,100)/100)
	Return v
End Sub

Public Sub getVector(x As Float, y As Float) As vector
	Dim v As vector
	v.Initialize(x,y)
	Return v
End Sub

Public Sub getRect(x As Float, y As Float, w As Float, h As Float) As B4XRect
	Dim r As B4XRect
	r.Initialize(x,y,x+w,y+h)
	Return r
End Sub


  