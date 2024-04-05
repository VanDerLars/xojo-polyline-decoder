#tag Module
Protected Module HereMaps
	#tag Method, Flags = &h1
		Protected Function Decode(encoded As String) As HMPolylineData
		  Dim decoder() As Integer = DecodeUnsignedValues(encoded)
		  Dim header As HMPolylineHeader = DecodeHeader(decoder(0), decoder(1))
		  
		  Dim factorDegree As Double = 10 ^ header.Precision
		  Dim factorZ As Double = 10 ^ header.ThirdDimPrecision
		  Dim thirdDim As Boolean = header.ThirdDim <> ABSENT
		  
		  Dim lastLat, lastLng, lastZ As Double
		  Dim res() As Double
		  
		  Dim i As Integer = 2
		  While i < decoder.Count
		    Dim deltaLat As Double = ToSigned(decoder(i)) / factorDegree
		    Dim deltaLng As Double = ToSigned(decoder(i + 1)) / factorDegree
		    lastLat = lastLat + deltaLat
		    lastLng = lastLng + deltaLng
		    
		    If thirdDim Then
		      Dim deltaZ As Double = ToSigned(decoder(i + 2)) / factorZ
		      lastZ = lastZ + deltaZ
		      res.AddRow(lastLat)
		      res.AddRow(lastLng)
		      res.AddRow(lastZ)
		      i = i + 3
		    Else
		      res.AddRow(lastLat)
		      res.AddRow(lastLng)
		      i = i + 2
		    End If
		  Wend
		  
		  If i <> decoder.Count Then
		    Raise New RuntimeException("Invalid encoding. Premature ending reached")
		  End If
		  
		  Return New HMPolylineData(header, res)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DecodeChar(char As String) As Integer
		  Var DECODING_TABLE() As Integer = Array (62, -1, -1, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -1, -1, -1, -1, -1, -1, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -1, -1, -1, -1, 63, -1, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51)
		  
		  Dim charCode As Integer = Asc(char)
		  Return DECODING_TABLE(charCode - 45)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DecodeHeader(version As Integer, encodedHeader As Integer) As HMPolylineHeader
		  If version <> FORMAT_VERSION Then
		    Raise New RuntimeException("Invalid format version")
		  End If
		  
		  Dim precision As Integer = BitAnd(encodedHeader, &hF)
		  Dim thirdDim As Integer = Bitwise.ShiftRight(BitAnd(encodedHeader, &h70), 4)
		  Dim thirdDimPrecision As Integer = Bitwise.ShiftRight(BitAnd(encodedHeader, &hF80), 7)
		  
		  Return New HMPolylineHeader(precision, thirdDim, thirdDimPrecision)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function DecodeUnsignedValues(encoded As String) As Integer()
		  Dim result As UInt64 = 0
		  Dim shift As UInt64 = 0
		  Dim resList() As Integer
		  
		  Try
		    For i As Integer = 1 To encoded.Length 
		      Dim char As String = encoded.mid(i, 1) 'Extrahiert ein Zeichen an Position i
		      Dim value As UInt64 = DecodeChar(char)
		      result = BitOr(result, Bitwise.ShiftLeft(BitAnd(value, &h1F), shift))
		      
		      If BitAnd(value, &h20) = 0 Then
		        resList.AddRow(result)
		        result = 0
		        shift = 0
		      Else
		        shift = shift + 5
		      End If
		    Next
		    
		    If shift > 0 Then
		      Raise New RuntimeException("Invalid encoding")
		    End If
		    
		    Return resList
		  Catch err As OutOfBoundsException
		    Break
		    
		  End Try
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Function ToSigned(value As UInt64) As Integer
		  
		  If (value Mod 2) = 0 Then
		    Return value \ 2
		  Else
		    Return - ((value \ 2) + 1)
		  End If
		End Function
	#tag EndMethod


	#tag Constant, Name = ABSENT, Type = , Dynamic = False, Default = \"0", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ALTITUDE, Type = , Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CUSTOM1, Type = , Dynamic = False, Default = \"6", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = CUSTOM2, Type = , Dynamic = False, Default = \"7", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ELEVATION, Type = , Dynamic = False, Default = \"3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = ENCODING_TABLE, Type = , Dynamic = False, Default = \"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = FORMAT_VERSION, Type = , Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = LEVEL, Type = , Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant


End Module
#tag EndModule
