B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Public fishList, matingPool, stoneList As List
	Public popSize As Int
	Private stones(3) As B4XBitmap
End Sub
 
Public Sub Initialize
	fishList.Initialize
	matingPool.Initialize
	stoneList.Initialize
	For i = 0 To stones.Length-1
		stones(i) = xui.LoadBitmap(File.DirAssets,$"stone${i}.png"$)
	Next
	popSize = 50
	For i = 0 To popSize-1
		Dim index As Int = getRandomIndex
		Dim f As fish
		f.Initialize(Null,Main.vpW/2,Main.vpH,Main.fishBmps(index),Main.fishBmps(index+1))
		fishList.Add(f)
	Next
	If Not(Main.noStones) Then createRandomStonesPos(Rnd(8,20))
End Sub

Private Sub getRandomIndex As Int
	Dim rndNr As Int = Rnd(0,Main.fishBmps.Length)
	If rndNr Mod 2 = 0 Then 
		Return rndNr
	Else 
		If rndNr < Main.fishBmps.Length-1 Then Return rndNr + 1 Else Return rndNr - 1
	End If
End Sub

Private Sub createRandomStonesPos(stonesCount As Int)
	stoneList.Clear
	For i = 0 To stonesCount-1
		Dim v As vector = vectorJS.getVector(Rnd(Main.vpW*0.05,Main.vpW*0.9),Rnd(Main.vpH*0.15,Main.vpH*0.8))
		Dim r As B4XRect = vectorJS.getRect(v.x,v.y,Main.vpH*0.046,Main.vpH*0.046)
		Dim s As stone 
		s.Initialize(stones(Rnd(0,stones.Length)),r)
		stoneList.Add(s)
	Next
End Sub

Public Sub run
	For Each f As fish In fishList
		f.update(stoneList)
		f.draw
	Next 
	For Each s As stone In stoneList
		s.draw
	Next
End Sub

Public Sub evaluate
	Dim maxfit As Float = 0
	matingPool.Clear
	For Each f As fish In fishList
		f.calcFitness
		If f.myFitness > maxfit Then maxfit = f.myFitness
	Next
	For Each f As fish In fishList
		f.myFitness = f.myFitness / maxfit
		Dim n As Int = f.myFitness * 100
		For j = 0 To n-1
			matingPool.Add(f)
		Next
	Next
End Sub

Public Sub selection
	Dim newFishlist As List
	newFishlist.Initialize
	For i = 0 To fishList.Size-1
		Dim parentA As dna = matingPool.Get(Rnd(0,matingPool.Size)).As(fish).myDNA
		Dim parentB As dna = matingPool.Get(Rnd(0,matingPool.Size)).As(fish).myDNA
		Dim child As dna = parentA.crossOver(parentB)
		child.mutation
		Dim index As Int = getRandomIndex
		Dim f As fish
		f.Initialize(child,Main.vpW/2,Main.vpH,Main.fishBmps(index),Main.fishBmps(index+1))
		newFishlist.Add(f)
	Next
	fishList.Clear
	fishList.AddAll(newFishlist)
End Sub
