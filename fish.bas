B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Public position,velocity,acceleration As vector
	Public myDNA As dna
	Public myFitness As Float
	Private size As vector
	Private xui As XUI
	Private completed, crashed As Boolean
	Private fishBmps(2) As B4XBitmap
	Private frames As Int 
	Private spriteIndex As Int 
End Sub
 
Public Sub Initialize(senderDna As dna, x As Float, y As Float, bmp1 As B4XBitmap, bmp2 As B4XBitmap)
	size.Initialize(Main.vpH*0.02,Main.vpH*0.05)
	position.Initialize(x, y)
	velocity.Initialize(0,0)
	acceleration.Initialize(0,0)
	myFitness = 0
	spriteIndex = 0
	completed = False
	crashed = False
	fishBmps(0) = bmp1
	fishBmps(1) = bmp2
	If senderDna <> Null Then 
		myDNA.Initialize(senderDna.genes)
	Else 
		myDNA.Initialize(Null)	
	End If
End Sub

Public Sub getCenterPoint As vector
	Dim v As vector
	v.Initialize(position.x,position.y)
	v.x = v.x+(size.x/2)
	v.y = v.y+(size.y/2)
	Return v
End Sub

Public Sub applyForce(force As vector)
	acceleration.add(force)
End Sub

Public Sub update(l As List)
	frames = frames + 1
	If completed Or crashed Then Return
	If position.x>Main.target.Left And position.x<Main.target.Right And position.y>Main.target.Top And position.y<Main.target.Bottom Then 
		If Not(completed) Then
			Main.hittarget = Main.hittarget + 1
			Main.fishesCatched = Main.fishesCatched + 1
		End If
		completed = True
		position.copy(getVector(Main.target.CenterX,Main.target.CenterY))
		Return		
	End If
	 
	For Each s As stone In l
		If position.x>s.sizeRect.Left And position.x<s.sizeRect.Right And position.y>s.sizeRect.Top And position.y<s.sizeRect.Bottom Then 
			crashed = True
			Return
		End If
	Next
 
	If position.x > Main.vpW Or position.x < 0 Then 
		crashed = True
		Return
	End If
 
	applyForce(myDNA.genes.Get(Main.count))
	If Not(completed) And Not(crashed) Then 
		velocity.add(acceleration)
		position.add(velocity)
		acceleration.mult(0)	
		velocity.limit(4)
	End If
End Sub
 
Public Sub draw
	Dim rotateVector As vector
	rotateVector.Initialize(velocity.x,velocity.y)
	Dim r As B4XRect = vectorJS.getRect(position.x-(size.x/2),position.y-(size.y/2),size.x,size.y)
	If frames Mod 6 = 0 Then spriteIndex = (spriteIndex+1) Mod fishBmps.Length
	Main.cnv.DrawBitmapRotated(fishBmps(spriteIndex),r,90+radiansToDeg(rotateVector.heading))
End Sub

Public Sub calcFitness
	Dim centerTarget As vector
	centerTarget.Initialize(Main.target.CenterX,Main.target.CenterY)
	Dim d As Float = vectorJS.dist(getCenterPoint,centerTarget)
	myFitness = mapping(d,0,Main.vpW,Main.vpW,0)
	If completed Then myFitness = myFitness * 10
	If crashed Then myFitness = myFitness / 10
End Sub

Private Sub radiansToDeg(value As Float) As Float 'ignore
	Return value * (180/cPI)
End Sub

Private Sub degToRadians(value As Float) As Float 'ignore
	Return value * (cPI/180)
End Sub

Private Sub mapping(var As Float, min_real As Float, max_real As Float, min_scaled As Float, max_scaled As Float) As Float
	Return (var * ((max_scaled-min_scaled) / (max_real-min_real))) + min_scaled
End Sub

Private Sub getVector(x As Float, y As Float) As vector
	Dim v As vector
	v.Initialize(x,y)
	Return v
End Sub
