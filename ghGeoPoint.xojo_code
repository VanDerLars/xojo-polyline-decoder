#tag Class
Protected Class ghGeoPoint
	#tag Method, Flags = &h0
		Sub constructor(LatLng as String)
		  Var latlngArr() As String = ReplaceAll(LatLng, " ", "").Split(",")
		  Self.lat = latlngArr(0)
		  Self.lng = latlngArr(1)
		  Self.Description = ""
		  
		  Self.ID = getID
		  
		  Self.data = New Dictionary
		  
		  Self.jsonData = New JSONItem
		  Self.jsonData.Value("lat") = Self.Lat
		  Self.jsonData.Value("lng") = Self.Lng
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub constructor(Lat_ as string, Lng_ as string, optional Description_ as string = "", optional Identifier_ as string = "")
		  Self.lat = lat_
		  self.lng = lng_
		  self.Description = Description_
		  
		  if Identifier_ = "" then
		    id = getID
		  else
		    ID = Identifier_
		  end if
		  
		  Self.data = New Dictionary
		  
		  Self.jsonData = New JSONItem
		  Self.jsonData.Value("lat") = Self.Lat
		  Self.jsonData.Value("lng") = Self.Lng
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function getID() As String
		  Dim r As New Random
		  Dim i As Integer = r.InRange(0, 1000)
		  
		  return "gh_point_" + i.toString
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function hash() As String
		  Return MD5(Self.Lat.Left(8) + "," + Self.lng.Left(8)).Lowercase
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function isValid() As Boolean
		  If lat.Length > 3 And lng.Length > 3 Then
		    Return True
		  Else
		    Return False
		  End If
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		data As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		Description As String
	#tag EndProperty

	#tag Property, Flags = &h0
		ID As String
	#tag EndProperty

	#tag Property, Flags = &h0
		jsonData As JsonItem
	#tag EndProperty

	#tag Property, Flags = &h0
		Lat As string
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return lat + "," + lng
			  
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  value = ReplaceAll(value, " ", "")
			  dim spl() as string = split(value, ",")
			  
			  self.Lat = spl(0)
			  self.lng = spl(1)
			End Set
		#tag EndSetter
		LatLng As String
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return "[" + lat + "," + lng + "]"
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  value = ReplaceAll(value, " ", "")
			  dim spl() as string = split(value, ",")
			  
			  self.Lat = spl(0)
			  self.lng = spl(1)
			End Set
		#tag EndSetter
		LatLngArray As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Lng As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return lng + "," + lat
			  
			  
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  dim spl() as string = split(value)
			  
			  self.Lat = spl(1)
			  self.lng = spl(2)
			End Set
		#tag EndSetter
		LngLat As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Order As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		WayPointInformation As ghWayPointInformation
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Description"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
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
			Name="Lat"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LatLng"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LatLngArray"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="Lng"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="LngLat"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Order"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
