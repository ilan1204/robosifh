B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.3
@EndOfDesignText@
Sub Class_Globals
	Public x As Float
	Public y As Float
End Sub
 
Public Sub Initialize(vx As Float, vy As Float)
	x = vx
	y = vy
End Sub

Public Sub add(v2 As vector)
	x = x + v2.x
	y = y + v2.y
End Sub

Public Sub vSub(v2 As vector)
	x = x - v2.x
	y = y - v2.y
End Sub

Public Sub mult(value As Float)
	x = x * value
	y = y * value
End Sub

Public Sub mult2(v2 As vector)
	x = x * v2.x
	y = y * v2.y
End Sub

Public Sub div( v2 As vector)
	x = x / v2.x
	y = y / v2.y
End Sub

Public Sub setAngle(angle As Float)
	Dim len As Float = mag
	x = Cos(angle)*len
	y = Sin(angle)*len
End Sub

Public Sub mag As Float
	Dim v As vector
	v.Initialize(x,y)
	Return Sqrt((v.x * v.x) + (v.y * v.y))
End Sub

Public Sub magSq() As Float
	Return (x * x) + (y * y)
End Sub

Public Sub setXY(vx As Float, vy As Float)
	x = vx
	y = vy
End Sub

Public Sub getXY As vector
	Dim v As vector
	v.Initialize(x,y)
	Return v
End Sub

Public Sub setMag(value As Float)
	normalize
	x = x * value
	y = y * value
End Sub

Public Sub normalize
	Dim m As Float = mag
	If m > 0 Then
		x = x/m
		y = y/m
	End If
End Sub

Public Sub limit(maxV As Float)
	If mag > maxV Then
		normalize
		x = x * maxV
		y = y *maxV
	End If
End Sub

Public Sub heading As Float
	Dim v As vector
	v.Initialize(x,y)
	Return (-ATan2(-y, x))
End Sub

Public Sub copy(v2 As vector) As vector
	Dim v As vector
	v.Initialize(v2.x, v2.y)
	Return v
End Sub

Public Sub negative
	x = -x
	y = -y
End Sub

Public Sub rotate(a As Float)
	Dim b As Float = heading + a
	Dim c As Float = mag
	x = Cos(b) * c
	y = Sin(b) * c
End Sub
