# xojo-polyline-decoder
Classes and functions to decode polylines based on the [Google](https://developers.google.com/maps/documentation/utilities/polylinealgorithm?hl=de) and [HereMaps](https://github.com/heremaps/flexible-polyline/blob/3cb169e46e07990f63bd22bbb299d048dbbd6b5d/javascript/index.js) algorithms.

- Everthing under Geo is related to the Google Algorithm.
- Everything under Here Maps is related to HereMaps.
- For Google, there's also en implementation to ENcode a set of coordinates
- For HereMaps I've only written the DEcode methods so far.

## What is this algorithm:

### Polyline Algorithm Format 

Polyline encoding is a lossy compression algorithm that allows you to store a series of coordinates as a single string. Point coordinates are encoded using signed values. If you only have a few static points, you may also wish to use the interactive polyline encoding utility.

The encoding process converts a binary value into a series of character codes for ASCII characters using the familiar base64 encoding scheme: to ensure proper display of these characters, encoded values are summed with 63 (the ASCII character '?') before converting them into ASCII. The algorithm also checks for additional character codes for a given point by checking the least significant bit of each byte group; if this bit is set to 1, the point is not yet fully formed and additional data must follow.


## How to use this Xojo code
### decode a Google polyline

```VB
Var encodedPolyline As String = TextArea1.Text
Var decodedCoordinates() As Pair = DecodePolyline(encodedPolyline)
For Each coord As Pair In decodedCoordinates
  
  Var latStr As String = Format(coord.Left, "0.000000").Replace(",", ".")
  Var lngStr As String = Format(coord.Right, "0.000000").Replace(",", ".")
  Var s As String = (latStr + ", " + lngStr)
  
  Self.TextArea2.Text = Self.TextArea2.Text + EndOfLine + s
  
Next

```

### Decode a HereMaps Polyline

XojoCode
```VB
Dim encodedPolyline As String = TextArea1.Text
Dim decodedData As HereMapsPolylineDecoder.PolylineData = HereMapsPolylineDecoder.Decode(encodedPolyline)

Var coordinates() As HereMapsPolylineDecoder.PolylineCoordinate = decodedData.getCoodinates

For Each coo As HereMapsPolylineDecoder.PolylineCoordinate In coordinates
  
  Var latStr As String = Format(coo.lat, "0.000000").Replace(",", ".")
  Var lngStr As String = Format(coo.lng, "0.000000").Replace(",", ".")
  Var s As String = (latStr + ", " + lngStr)
  
  Self.TextArea2.Text = Self.TextArea2.Text + EndOfLine + s
  
Next

```
