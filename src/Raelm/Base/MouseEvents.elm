module Raelm.Base.MouseEvents exposing (..)

-- Elm Imports
import Html.Events exposing (on)

-- Local Imports
import Raelm.Base.Messages exposing (MouseEventsMsg(..))
import Raelm.Base.Decoders exposing (clickDecoder)

-- Dependency Imports
import Raelm.Map.Messages exposing (MapMessage(..))

-- Exports
onClick =
  on "click" clickDecoder

-- Maps a local event message into a MapMessage
eventMapper : MouseEventsMsg -> MapMessage
eventMapper event =
  case event of
    Click (x, y) ->
      Centre ( toFloat x, toFloat y)
    Drag (x, y, k, l) ->
      Pan ( toFloat x, toFloat y, 0, 0)
    Scroll z ->
      Zoom z