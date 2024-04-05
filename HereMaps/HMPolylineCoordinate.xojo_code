#tag Class
Protected Class HMPolylineCoordinate
	#tag Method, Flags = &h0
		Sub constructor(lat_ as Double, lng_ as Double, optional z_ as Double = 0)
		  Self.lat = lat_
		  Self.lng = lng_
		  Self.z = z_
		  
		  
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		lat As double
	#tag EndProperty

	#tag Property, Flags = &h0
		lng As double
	#tag EndProperty

	#tag Property, Flags = &h0
		z As double
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
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
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="lat"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="lng"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="double"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="z"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="double"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
