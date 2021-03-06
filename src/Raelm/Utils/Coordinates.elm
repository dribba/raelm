module Raelm.Utils.Coordinates exposing (..)
import Raelm.Types.Coordinates exposing (Point, Bounds)

getMinMaxBounds : Bounds -> Bounds
getMinMaxBounds ((x1, y1), (x2, y2)) =
  let
    minPoint : Point
    minPoint = (min x1 x2, min y1 y2)

    maxPoint : Point
    maxPoint = (max x1 x2, max y1 y2)
  in
    (minPoint, maxPoint)

scaleBy : (Float, Float) -> (Float, Float) -> Point
scaleBy (x, y) (scaleX, scaleY) =
  (x * scaleX, y * scaleY)

unscaleBy : (Float, Float) -> (Float, Float) -> Point
unscaleBy (x, y) (unscaleX, unscaleY) =
  (x / unscaleX, y / unscaleY)

floorPoint : (Float, Float) -> (Float, Float)
floorPoint (x, y) =
  (toFloat (floor x), toFloat (floor y))

ceilPoint : (Float, Float) -> (Float, Float)
ceilPoint (x, y) =
  (toFloat (ceiling x), toFloat (ceiling y))

subtractPoint : Point -> Point -> Point
subtractPoint point1 point2 =
  mapPoint (-) point1 point2

addPoint : Point -> Point -> Point
addPoint point1 point2 =
  mapPoint (+) point1 point2

mapPoint : (Float -> Float -> Float) -> Point -> Point -> Point
mapPoint mapper (x, y) (k, l) =
  (mapper x k, mapper y l)

divideBy : Point -> Float -> Point
divideBy (x, y) f =
  (x / f, y / f)

roundPoint : Point -> Point
roundPoint (x, y) =
  (toFloat (round x), toFloat (round y))

toFixed : Int -> Point -> Point
toFixed precision point1 =
  let
    point1 = mapPoint (*) point1 (toFloat precision, toFloat precision)
    point2 = roundPoint point1
  in
    mapPoint (/) point2 (toFloat precision, toFloat precision)



getBoundsCentre ((x1, y1), (x2, y2)) roundIt =
  let
    ((minX, minY), (maxX, maxY)) = getMinMaxBounds ((x1, y1), (x2, y2))
    (avgX, avgY) = ( (minX + maxX) / 2, (minY + maxY) / 2)
  in
    if roundIt == True then
      roundPoint (avgX, avgY)
    else
      (avgX, avgY)

wrapNum : Float -> Point -> Float
wrapNum x (minX, maxX) =
  -- if x == maxX then
  --   x
  -- else
  let
    d = round (maxX - minX)
    a = round (x - minX)
    b = a % d + d
    c = b % d
  in
    (toFloat c) + minX
