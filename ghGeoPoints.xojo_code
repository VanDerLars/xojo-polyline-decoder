 #tag Class
Protected Class ghGeoPoints
	#tag Method, Flags = &h0
		Function asJSArray() As String
		  Var arr() As String 
		  
		  For i As Integer = 0 To Points.Ubound
		    If points(i).Lat <> "" And points(i).Lng <> "" Then
		      arr.Append(points(i).LatLngArray)
		    Else
		      //fehlende latlng daten -> Fehler
		      Break
		    End If
		  Next
		  
		  dim ret as string = "[" + join(arr, ", ") + "]"
		  
		  return ret
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(optional identifier as string = "", optional points_() as ghGeoPoint)
		  
		  if Identifier = "" then
		    id= getID
		  else
		    ID = Identifier
		  end if
		  
		  if Points_ <> nil then
		    Points = points_
		  end if
		  
		  
		  
		  self.data = new Dictionary
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function descriptionAsJSArray() As string
		  Var arr() As String 
		  
		  For i As Integer = 0 To Points.Ubound
		    If points(i).Lat <> "" And points(i).Lng <> "" Then
		      arr.Append("'" + points(i).Description + "'")
		    Else
		      //fehlende latlng daten -> Fehler
		      Break
		    End If
		  Next
		  
		  dim ret as string = "[" + join(arr, ", ") + "]"
		  
		  Return ret
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getID() As String
		  Dim r As New Random
		  Dim i As Integer = r.InRange(0, 1000)
		  
		  return "gh_points_" + i.toString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function namesAsJSArray() As string
		  dim arr() as String 
		  
		  for i as integer = 0 to Points.Ubound
		    arr.Append ("'" + points(i).ID + "'")
		  next
		  
		  dim ret as string = "[" + join(arr, ", ") + "]"
		  
		  return ret
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		data As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		FixEndTime As date
	#tag EndProperty

	#tag Property, Flags = &h0
		FixStartTime As date
	#tag EndProperty

	#tag Property, Flags = &h0
		ID As String
	#tag EndProperty

	#tag Property, Flags = &h0
		lengthMeter As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		lengthmeter_last As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		lengthmeter_leer As Double
	#tag EndProperty

	#tag Property, Flags = &h0
		Points() As ghGeoPoint
	#tag EndProperty

	#tag Property, Flags = &h0
		TimeSeconds As Integer
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="ID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="lengthMeter"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="lengthmeter_last"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="lengthmeter_leer"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="TimeSeconds"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
