#tag Class
Protected Class HMPolylineData
	#tag Method, Flags = &h0
		Sub Constructor(header As HMPolylineHeader, polyline() As Double)
		  Me.Header = header
		  Me.Polyline = polyline
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getCoodinates() As VIA.Geo.HereMaps.HMPolylineCoordinate()
		  
		  
		  ' Zugriff auf die dekodierten Koordinaten
		  Dim coordinates() As Double = Self.Polyline
		  
		  Var d As Integer = Self.Header.ThirdDim
		  Dim stepSize As Integer = If(Self.hasThirdDimension, 3, 2)
		  
		  Var ret() As VIA.Geo.HereMaps.HMPolylineCoordinate
		  
		  
		  ' Iteration über die Koordinaten
		  For i As Integer = 0 To coordinates.Count - 1 Step stepSize
		    Dim lat As Double = coordinates(i)
		    Dim lng As Double = coordinates(i + 1)
		    Dim z As Double 
		    If Self.hasThirdDimension Then
		      z = coordinates(i + 2) ' Nur relevant, wenn es sich um eine 3D-Polyline handelt
		    End If 
		    
		    Var coo As New VIA.Geo.HereMaps.HMHMPolylineCoordinate(lat, lng, z)
		    
		    ret.AddRow(coo)
		    
		  Next
		  
		  
		  Return ret
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function hasThirdDimension() As Boolean
		  Dim hasThirdDimension As Boolean 
		  Select Case Self.Header.ThirdDim
		  Case ABSENT
		    hasThirdDimension = False
		  Case Else
		    hasThirdDimension = True
		  End Select
		  
		  Return hasThirdDimension
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Header As HMPolylineHeader
	#tag EndProperty

	#tag Property, Flags = &h0
		Polyline() As Double
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
	#tag EndViewBehavior
End Class
#tag EndClass
