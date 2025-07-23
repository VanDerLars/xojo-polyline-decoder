#tag Class
Protected Class cls_geoPolygon
	#tag Method, Flags = &h0
		Sub addFirstPoint()
		  Self.polygon.Append(self.polygon(0))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor()
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(geoPoints() As ghGeoPoint)
		  self.polygon = geoPoints
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(polygon As String, optional isFromDatabase As Boolean = False)
		  Var latIndex As Integer = 0
		  Var lngIndex As Integer = 1
		  
		  If isFromDatabase Then
		    latIndex = 1
		    lngIndex = 0
		    
		    polygon = Replace(polygon, "POLYGON((", "")
		    polygon = Replace(polygon, "))", "")
		  End If
		  
		  Var points() As String = polygon.Split(",")
		  
		  For Each p As String In points
		    Var geoPoint() As String = p.Split(" ")
		    Self.polygon.Append(New ghGeoPoint(geoPoint(latIndex), geoPoint(lngIndex)))
		  Next
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPolygonForDatabase() As String
		  Var points() As String 
		  
		  For Each geoPoint As ghGeoPoint In Self.polygon
		    points.Append(geoPoint.Lng + " " + geoPoint.Lat)
		  Next
		  
		  return "PolygonFromText('POLYGON((" + Join(points, ",") + "))')"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getPolygonForMap() As String
		  Var points() As String
		  
		  For Each geoPoint As ghGeoPoint In Self.polygon
		    points.append(geoPoint.LatLngArray)
		  Next
		  
		  Return "[" + Join(points, ",") + "]"
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		polygon() As ghGeoPoint
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
