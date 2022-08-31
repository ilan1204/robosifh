B4J=true
Group=Default Group
ModulesStructureVersion=1
Type=Class
Version=9.8
@EndOfDesignText@
Sub Class_Globals
	Private xui As XUI
	Public genes As List
End Sub
 
Public Sub Initialize(genesSender As List)
	genes.Initialize
	If genesSender.IsInitialized Then 
		genes.AddAll(genesSender)
	Else 
		For i = 0 To Main.lifespan-1
			Dim v As vector = vectorJS.random2d
			v.setMag(Main.maxForce)
			genes.Add(v)
		Next			
	End If
End Sub

Public Sub crossOver(parent As dna) As dna
	Dim newGenes As List
	newGenes.Initialize
	Dim mid As Int = Rnd(0,parent.genes.Size)
	For i = 0 To genes.Size-1
		If i > mid Then 
			newGenes.Add(genes.Get(i))
		Else 
			newGenes.Add(parent.genes.Get(i))
		End If
	Next
	Dim newDna As dna
	newDna.Initialize(newGenes)
	Return newDna
End Sub

Public Sub mutation
	For i = 0 To genes.Size-1
		If Rnd(0,100) <= 1 Then 
			Dim v As vector = vectorJS.random2d
			v.setMag(Main.maxForce)
			genes.Set(i,v)
		End If
	Next
End Sub