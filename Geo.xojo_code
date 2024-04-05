#tag Module
Protected Module Geo
	#tag Method, Flags = &h1
		Protected Function decodePolyline(encodedPolyline As String) As Pair()
		  Var index As Integer = 0
		  Var currentLat As Integer = 0
		  Var currentLng As Integer = 0
		  Var coordinates() As Pair
		  
		  While index < encodedPolyline.Length
		    Var deltaLat As Integer = decodePolylineLeg(encodedPolyline, index)
		    Var deltaLng As Integer = decodePolylineLeg(encodedPolyline, index)
		    
		    currentLat = currentLat + deltaLat
		    currentLng = currentLng + deltaLng
		    
		    // Umrechnen in Dezimalgrade
		    Var latitude As Double = currentLat / 100000.0
		    Var longitude As Double = currentLng / 100000.0
		    
		    coordinates.Append(New Pair(latitude, longitude))
		  Wend
		  
		  Return coordinates
		  
		  
		  //VERWENDUNG:
		  //
		  //Var encodedPolyline As String = TextArea1.Text
		  //Var decodedCoordinates() As Pair = DecodePolyline(encodedPolyline)
		  //For Each coord As Pair In decodedCoordinates
		  //
		  //Var latStr As String = Format(coord.Left, "0.000000").Replace(",", ".")
		  //Var lngStr As String = Format(coord.Right, "0.000000").Replace(",", ".")
		  //Var s As String = (latStr + ", " + lngStr)
		  //
		  //Self.TextArea2.Text = Self.TextArea2.Text + EndOfLine + s
		  //
		  //Next
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function decodePolylineLeg(encoded As String, ByRef index As Integer) As Integer
		  Var result As Integer = 0
		  Var shift As Integer = 0
		  Var b As Integer
		  Do
		    b = Asc(encoded.Mid(index + 1, 1)) - 63
		    index = index + 1
		    result = result + Bitwise.ShiftLeft((b And &h1F), shift)
		    shift = shift + 5
		  Loop Until (b And &h20) = 0
		  
		  // Anwenden der Umkehrung der XOR-Operation für negative Werte
		  If (result And 1) <> 0 Then
		    result = -Bitwise.ShiftRight(result, 1)
		  Else
		    result = Bitwise.ShiftRight(result, 1)
		  End If
		  
		  Return result
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function encodePolyline(coordinates() as pair, usePrintserver as Boolean = false) As string
		  Var ret As String
		  
		  
		  If Not usePrintserver Then
		    //eigene interne Implementierung nehmen
		    Var oldLat, oldLng As Double = 0
		    For i As Integer = 0 To coordinates.Ubound
		      Var newLat, newLng As Double
		      
		      If oldLat = 0 And oldLng = 0 Then
		        newLat = coordinates(i).Left.DoubleValue 
		        newLng = coordinates(i).Right.DoubleValue 
		      Else
		        newLat = coordinates(i).Left.DoubleValue - oldLat
		        newLng = coordinates(i).Right.DoubleValue - oldLng
		      End If
		      
		      ret = ret + encodePolylineLeg(newLat)
		      ret = ret + encodePolylineLeg(newLng)
		      
		      oldLat = coordinates(i).Left.DoubleValue
		      oldLng = coordinates(i).Right.DoubleValue
		      
		    Next
		    
		    
		  Else
		    
		  End If
		  
		  
		  Return ret
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function encodePolylineLeg(value as double) As string
		  Var s As String
		  Var base As Integer = 256 ^ 4
		  Var minus As Boolean = (value < 0)
		  
		  If minus Then
		    value = -value
		  End If
		  
		  Var x As Integer = value * 100000
		  //Break
		  
		  If minus Then
		    x = base - x
		  End If
		  
		  x = x * 2
		  
		  If minus Then
		    x = (base * 2) - 1 - x
		  End If
		  
		  While x > 0 
		    Var y As Integer
		    y = x Mod 32
		    x = x / 32
		    
		    If x > 0 Then
		      y = y + 32
		    End If
		    
		    y = y + 63
		    
		    //Self.charcodes = Self.charcodes + y.ToString + " "
		    s = s + Encodings.ASCII.Chr(y)
		    
		  Wend
		  
		  Return s
		End Function
	#tag EndMethod


	#tag Method, Flags = &h1
		Protected Function getAreasByGeoJSON(geometries As JSONItem) As cls_geoPolygon()
		  Var metrics() As JSONItem
		  Var polygons() As cls_geoPolygon
		  
		  If geometries.Lookup("type", "").StringValue = "Polygon" Then
		    metrics.append(geometries.Child("coordinates").Child(0))
		  ElseIf geometries.Lookup("type", "").StringValue = "MultiPolygon" Then
		    geometries = geometries.Child("coordinates")
		    For i As Integer = 0 To geometries.Count - 1
		      Var geometry As JSONItem = geometries.Child(i)
		      metrics.append(geometry.Child(0))
		    Next
		  End If
		  
		  For Each metric As JsonItem In metrics
		    Var points() As ghGeoPoint
		    For i As Integer = 0 To metric.Count - 1
		      Var coord As JSONItem = metric.Child(i)
		      Var lat As String = coord.Value(1).DoubleValue.ToString
		      Var lng As String = coord.Value(0).DoubleValue.ToString
		      points.Append(New ghGeoPoint(lat, lng))
		    Next
		    polygons.Append(New cls_geoPolygon(points))
		  Next
		  
		  Return polygons
		End Function
	#tag EndMethod


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
End Module
#tag EndModule
