---@diagnostic disable: missing-fields, duplicate-doc-field, unused-local
---@meta intellisense

--[[

Note: This file is exclusively for intellisense purposes. None of this file should ever go within plugin.lua.
Created by Emik and plummyyummy, for the public domain. Use this file as you wish.
DM kvrosakura on Discord if there are any errors within this file.

]]

--[[ UNLICENSE
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <https://unlicense.org>
]]

---@alias NoteLane 1|2|3|4|5|6|7|8|9|10
---@alias SnapNumber 1|2|3|4|5|6|8|12|16 The denominator of the corresponding snap.

-- STARTING LINE
---@class (exact) ScrollGroup
---##### (READ-ONLY)
---#### The initial [sv](lua://ScrollVelocity) multiplier of this [scroll group](lua://ScrollGroup).
---@field InitialScrollVelocity number
---##### (READ-ONLY)
---#### All [scroll velocities](lua://ScrollVelocity) within the [scroll group](lua://ScrollGroup).
---@field ScrollVelocities ScrollVelocity[]
---##### (READ-ONLY)
---#### All [scroll speed factors](lua://ScrollSpeedFactor) within the [scroll group](lua://ScrollGroup).
---@field ScrollSpeedFactors ScrollSpeedFactor[]
---##### (READ-ONLY)
---#### Gets the nearest [scroll velocity](lua://ScrollVelocity) before the `time` parameter.
---@field GetScrollVelocityAt fun(time: number): ScrollVelocity
---##### (READ-ONLY)
---#### Gets the nearest [scroll speed factor](lua://ScrollSpeedFactor) before the `time` parameter.
---@field GetScrollSpeedFactorAt fun(time: number): ScrollSpeedFactor
---##### (READ-ONLY)
---#### A string of format `r,g,b` representing the color of the [editor layer](lua://EditorLayer). `r`, `g`, and `b` are integers within [0,255].
---@field ColorRgb string
---##### (READ-ONLY)
---#### Determines whether or not the timing group color is visible in the editor.
---@field Hidden boolean

---@class (exact) ScrollSpeedFactor
---##### (READ-ONLY)
---#### The time at which the [scroll speed factor](lua://ScrollSpeedFactor) takes effect.
---@field StartTime number
---##### (READ-ONLY)
---#### The factor at which to multiply the player's scroll speed.
---@field Multiplier number

---@class (exact) ScrollVelocity
---##### (READ-ONLY)
---#### The time at which the [scroll velocity](lua://ScrollVelocity) takes effect.
---@field StartTime number
---##### (READ-ONLY)
---#### The factor at which to multiply the player's [scroll velocity](lua://ScrollVelocity).
---@field Multiplier number

---@class (exact) Bookmark
---##### (READ-ONLY)
---#### The time the [bookmark](lua://Bookmark) is attached to.
---@field StartTime integer
---##### (READ-ONLY)
---#### The contents of the [bookmark](lua://Bookmark).
---@field Note string

---@class (exact) HitObject
---##### (READ-ONLY)
---#### The time the note is present.
---@field StartTime integer
---##### (READ-ONLY)
---#### The lane the note is in.
---@field Lane NoteLane
---##### (READ-ONLY)
---#### The time the long note ends. If this note is not a long note, this value is 0.
---@field EndTime number
---##### (READ-ONLY)
---#### A bitwise mask representing hitsounds.
---@field HitSound HitSounds
---##### (READ-ONLY)
---#### The id of the [editor layer](lua://EditorLayer) this note is in.
---@field EditorLayer integer
---##### (READ-ONLY)
---#### `true` if this note is a long note, false otherwise.
---@field IsLongNote boolean
---##### (READ-ONLY)
---#### The id of the [timing group](lua://ScrollGroup) that this note belongs to.
---@field TimingGroup string

---@class (exact) TimingPoint
---##### (READ-ONLY)
---#### The time in which the [timing point](lua://TimingPoint) is located.
---@field StartTime number
---##### (READ-ONLY)
---#### The beats per minute, or bpm of the [timing point](lua://TimingPoint).
---@field Bpm number
---##### (READ-ONLY)
---#### The time signature of the [timing point](lua://TimingPoint).
---@field Signature number
---##### (READ-ONLY)
---#### Determines whether or not the timing lines are rendered.
---@field Hidden boolean

---@class (exact) EditorLayer
---##### (READ-ONLY)
---#### The name of the [editor layer](lua://EditorLayer).
---@field Name string
---##### (READ-ONLY)
---#### `true` if the layer is hidden within the editor.
---@field Hidden boolean
---##### (READ-ONLY)
---#### A string of format `r,g,b` representing the color of the [editor layer](lua://EditorLayer). `r`, `g`, and `b` are integers within [0,255].
---@field ColorRgb string

---@class (exact) EditorAction
---##### (READ-ONLY)
---#### The type of action that was performed.
---@field Type userdata

---@class (exact) Vector2
---@field x number The first component of the vector.
---@field y number The second component of the vector.
---@operator add(Vector2): Vector2
---@operator sub(Vector2): Vector2
---@operator mul(Vector2 | number): Vector2
---@operator div(Vector2 | number): Vector2
---@operator unm(Vector2): Vector2

---@class (exact) Vector3
---@field x number The first component of the vector.
---@field y number The second component of the vector.
---@field z number The third component of the vector.
---@operator add(Vector3): Vector3
---@operator sub(Vector3): Vector3
---@operator mul(Vector3 | number): Vector3
---@operator div(Vector3 | number): Vector3
---@operator unm(Vector3): Vector3

---@class (exact) Vector4
---@field x number The first component of the vector.
---@field y number The second component of the vector.
---@field z number The third component of the vector.
---@field w number The fourth component of the vector.
---@operator add(Vector4): Vector4
---@operator sub(Vector4): Vector4
---@operator mul(Vector4 | number): Vector4
---@operator div(Vector4 | number): Vector4
---@operator unm(Vector4): Vector4

vector = {}

---@generic T : number | Vector2 | Vector3 | Vector4
---##### (READ-ONLY)
---#### Returns the absolute value of each element of a vector.
---@param v T The initial vector.
---@return T vctr The resultant vector.
---@nodiscard
function vector.Abs(v) end

---@generic T : number | Vector2 | Vector3 | Vector4
---##### (READ-ONLY)
---#### Returns the sum of two vectors.
---@param v1 T The first vector.
---@param v2 T The second vector.
---@return T vctr The resultant vector.
---@nodiscard
function vector.Add(v1, v2) end

---@generic T : number | Vector2 | Vector3 | Vector4
---##### (READ-ONLY)
---#### Clamps a vector between two others.
---@param v T The vector to clamp.
---@param min T The floor of the resultant vector.
---@param max T The ceiling of the resultant vector.
---@return T vctr The resultant vector.
---@nodiscard
function vector.Clamp(v, min, max) end

---##### (READ-ONLY)
---#### Takes a cross product between two vectors (only works with [`Vector3`](lua://Vector3)).
---@param v1 Vector3 The first vector.
---@param v2 Vector3 The second vector.
---@return Vector3 vctr The resultant vector, with a magnitude equal to the area of a parallelogram projected by `v1` and `v2`.
---@nodiscard
function vector.Cross(v1, v2) end

---@generic T : number | Vector2 | Vector3 | Vector4
---##### (READ-ONLY)
---#### Finds the distance between two vectors.
---@param v1 T The first vector.
---@param v2 T The second vector.
---@return number distance The distance between the two vectors.
---@nodiscard
function vector.Distance(v1, v2) end

---@generic T : number | Vector2 | Vector3 | Vector4
---##### (READ-ONLY)
---#### Finds the distance between two vectors, squared.
---@param v1 T The first vector.
---@param v2 T The second vector.
---@return number distanceSq The squared distance between the two vectors.
---@nodiscard
function vector.DistanceSquared(v1, v2) end

---@generic T : number | Vector2 | Vector3 | Vector4
---##### (READ-ONLY)
---#### Divides two vectors, termwise.
---@param v1 T The first vector.
---@param v2 T The second vector.
---@return T vctr The resultant vector.
---@nodiscard
function vector.Divide(v1, v2) end

---@generic T : number | Vector2 | Vector3 | Vector4
---##### (READ-ONLY)
---#### Takes the dot product of two vectors; that is, multiplies the two vectors termwise then returns the sum of the resulting terms.
---@param v1 T The first vector.
---@param v2 T The second vector.
---@return number product The dot product of the two vectors.
---@nodiscard
function vector.Dot(v1, v2) end

---@generic T : number | Vector2 | Vector3 | Vector4
---##### (READ-ONLY)
---#### Determines the literal length of a vector. DOES NOT DETERMINE ITS MAGNITUDE.
---@param v T The vector to measure.
---@return 2|3|4 length `4` if the input is a [`Vector4`](lua://Vector4), `3` if the input is a [`Vector3`](lua://Vector3), and `2` otherwise.
---@nodiscard
function vector.Length(v) end

---@generic T : number | Vector2 | Vector3 | Vector4
---##### (READ-ONLY)
---#### Returns a vector that is `(f * 100)%` of the way from travelling between `v1` and `v2`.
---@param v1 T The first vector.
---@param v2 T The second vector.
---@param f number A number within [0-1] which determines the weight of `v2`.
---@return T vctr The resultant vector.
---@nodiscard
function vector.Lerp(v1, v2, f) end

---@generic T : number | Vector2 | Vector3 | Vector4
---##### (READ-ONLY)
---#### Returns a vector which has the maximum value of both vectors, termwise.
---@param v1 T The first vector.
---@param v2 T The second vector.
---@return T vctr The resultant vector.
---@nodiscard
function vector.Max(v1, v2) end

---@generic T : number | Vector2 | Vector3 | Vector4
---##### (READ-ONLY)
---#### Returns a vector which has the minimum value of both vectors, termwise.
---@param v1 T The first vector.
---@param v2 T The second vector.
---@return T vctr The resultant vector.
---@nodiscard
function vector.Min(v1, v2) end

---@generic T : number | Vector2 | Vector3 | Vector4
---##### (READ-ONLY)
---#### Returns a vector which has the remainder of the first vector divided by the second, termwise.
---@param v1 T The first vector.
---@param v2 T The second vector.
---@return T vctr The resultant vector.
---@nodiscard
function vector.Modulo(v1, v2) end

---@generic T : number | Vector2 | Vector3 | Vector4
---##### (READ-ONLY)
---#### Multiplies the two vectors termwise and returns the product.
---@param v1 T The first vector.
---@param v2 T The second vector.
---@return T vctr The resultant vector.
---@nodiscard
function vector.Multiply(v1, v2) end

---@generic T : number | Vector2 | Vector3 | Vector4
---##### (READ-ONLY)
---#### Negates the given vector termwise.
---@param v T The vector to negate.
---@return T vctr The resultant vector.
---@nodiscard
function vector.Negate(v) end

---##### (READ-ONLY)
---#### Creates a new [`Vector2`](lua://Vector2).
---@param s1 number The first element.
---@param s2 number The second element.
---@return Vector2 vctr The output vector.
---@nodiscard
function vector.New(s1, s2) end

---##### (READ-ONLY)
---#### Creates a new [`Vector3`](lua://Vector3).
---@param s1 number The first element.
---@param s2 number The second element.
---@param s3 number The third element.
---@return Vector3 vctr The output vector.
---@nodiscard
function vector.New(s1, s2, s3) end

---##### (READ-ONLY)
---#### Creates a new [`Vector4`](lua://Vector4).
---@param s1 number The first element.
---@param s2 number The second element.
---@param s3 number The third element.
---@param s4 number The fourth element.
---@return Vector4 vctr The output vector.
---@nodiscard
function vector.New(s1, s2, s3, s4) end

---@generic T : number | Vector2 | Vector3 | Vector4
---##### (READ-ONLY)
---#### Normalizes the given vector such that it has a magnitude of 1.
---@param v T The vector to normalize.
---@return T vctr The resultant vector.
---@nodiscard
function vector.Normalize(v) end

---@generic T : Vector2 | Vector3 | Vector4
---##### (READ-ONLY)
---#### Returns a vector of a requested dimension, with all elements being `1`.
---@param n T The dimension of the vector. Assuming a vector is given as the argument, the dimension of the given vector is used.
---@return T vctr A vector of dimension `n` with all elements being `1`.
---@nodiscard
function vector.One(n) end

---##### (READ-ONLY)
---#### Returns a [`Vector2`](lua://Vector2), with all elements being `1`.
---@param n number Any number.
---@return Vector2 vctr A [`Vector2`](lua://Vector2) with all elements being `1`.
---@nodiscard
function vector.One(n) end

---@generic T : number | Vector2 | Vector3 | Vector4
---##### (READ-ONLY)
---#### Reflects a vector across a surface given by its normal vector and pivot point [`vector.Zero`](lua://vector.Zero).
---@param v T The vector to reflect.
---@param norm T The normal vector of the surface in which to reflect `v`.
---@return T vctr The resultant vector.
---@nodiscard
function vector.Reflect(v, norm) end

---@generic T : number | Vector2 | Vector3 | Vector4
---##### (READ-ONLY)
---#### Returns a vector which has the euclidean remainder of the first vector divided by the second, termwise. A euclidean remainder is like a normal remainder, but if the closest normal remainder is negative then the divisor is added to make it positive.
---@param v1 T The first vector.
---@param v2 T The second vector.
---@return T vctr The resultant vector.
---@nodiscard
function vector.RemEuclid(v1, v2) end

---@generic T : number | Vector2 | Vector3 | Vector4
---##### (READ-ONLY)
---#### Square roots the given vector, termwise.
---@param v T The vector to root.
---@return T vctr The resultant vector.
---@nodiscard
function vector.SquareRoot(v) end

---@generic T : number | Vector2 | Vector3 | Vector4
---##### (READ-ONLY)
---#### Returns the difference of two vectors.
---@param v1 T The first vector.
---@param v2 T The second vector.
---@return T vctr The resultant vector.
---@nodiscard
function vector.Subtract(v1, v2) end

---##### (READ-ONLY)
---#### Coerces a [`Vector2`](lua://Vector2) to become a numerically-indexed table.
---@param v Vector2 The vector to pack.
---@return [number, number] table The resultant table.
---@nodiscard
function vector.Table(v) end

---##### (READ-ONLY)
---#### Coerces a [`Vector3`](lua://Vector3) to become a numerically-indexed table.
---@param v Vector3 The vector to pack.
---@return [number, number, number] table The resultant table.
---@nodiscard
function vector.Table(v) end

---##### (READ-ONLY)
---#### Coerces a [`Vector4`](lua://Vector4) to become a numerically-indexed table.
---@param v Vector4 The vector to pack.
---@return [number, number, number, number] table The resultant table.
---@nodiscard
function vector.Table(v) end

---@generic T : Vector2 | Vector3 | Vector4
---##### (READ-ONLY)
---#### Creates a unit vector in the `W` direction with the given dimension.
---@param dim T The dimension of the vector to produce. Assuming a vector is given as the argument, the dimension of that vector is used instead.
---@return T vctr The resultant vector.
---@nodiscard
function vector.UnitW(dim) end

---@generic T : Vector2 | Vector3 | Vector4
---##### (READ-ONLY)
---#### Creates a unit vector in the `X` direction with the given dimension.
---@param dim T The dimension of the vector to produce. Assuming a vector is given as the argument, the dimension of that vector is used instead.
---@return T vctr The resultant vector.
---@nodiscard
function vector.UnitX(dim) end

---@generic T : Vector2 | Vector3 | Vector4
---##### (READ-ONLY)
---#### Creates a unit vector in the `Y` direction with the given dimension.
---@param dim T The dimension of the vector to produce. Assuming a vector is given as the argument, the dimension of that vector is used instead.
---@return T vctr The resultant vector.
---@nodiscard
function vector.UnitY(dim) end

---@generic T : Vector2 | Vector3 | Vector4
---##### (READ-ONLY)
---#### Creates a unit vector in the `Z` direction with the given dimension.
---@param dim T The dimension of the vector to produce. Assuming a vector is given as the argument, the dimension of that vector is used instead.
---@return T vctr The resultant vector.
---@nodiscard
function vector.UnitZ(dim) end

---@generic T : Vector2 | Vector3 | Vector4
---##### (READ-ONLY)
---#### Returns a vector of a requested dimension, with all elements being `0`.
---@param n T The dimension of the vector. Assuming a vector is given as the argument, the dimension of the given vector is used.
---@return T vctr A vector of dimension `n` with all elements being `0`.
---@nodiscard
function vector.Zero(n) end

---##### (READ-ONLY)
---#### Returns a [`Vector2`](lua://Vector2), with all elements being `0`.
---@param n number Any number.
---@return Vector2 vctr A [`Vector2`](lua://Vector2) with all elements being `0`.
---@nodiscard
function vector.Zero(n) end

actions = {}

---##### (READ-ONLY)
---#### Performs a given [editor action](lua://EditorAction).
---@param action EditorAction The [editor action](lua://EditorAction) to perform.
function actions.Perform(action) end

---##### (READ-ONLY)
---#### Performs a given set of [editor actions](lua://EditorAction).
---@param actionList EditorAction[] The [editor actions](lua://EditorAction) to perform.
function actions.PerformBatch(actionList) end

---##### (READ-ONLY)
---#### Undoes the most recent [editor action](lua://EditorAction).
function actions.Undo() end

---##### (READ-ONLY)
---#### Redoes the most recent undo.
function actions.Redo() end

---##### (READ-ONLY)
---#### Places a given [hit object](lua://HitObject), without the need to create an [editor action](lua://EditorAction).
---@param ho HitObject The [hit object](lua://HitObject) to place, which must be created via [`utils.CreateHitObject`](lua://utils.CreateHitObject).
function actions.PlaceHitObject(ho) end

---##### (READ-ONLY)
---#### Places a new [hit object](lua://HitObject), without the need to create an [editor action](lua://EditorAction).
---@param lane NoteLane The lane of the [hit object](lua://HitObject).
---@param startTime integer The start time of the [hit object](lua://HitObject).
---@param endTime? integer If placing a rice note, this value should be 0. Otherwise, this should be the time the long note ends.
---@param editorLayer? integer The id of the layer in which the [hit object](lua://HitObject) will lie.
---@param hitsounds? HitSounds The hitsounds attached to the [hit object](lua://HitObject).
---@param tgId? integer The id of the [timing group](lua://ScrollGroup) this [hit object](lua://HitObject) will be in.
function actions.PlaceHitObject(lane, startTime, endTime, editorLayer, hitsounds, tgId) end

---##### (READ-ONLY)
---#### Places a given set of [hit objects](lua://HitObject), without the need to create an [editor action](lua://EditorAction).
---@param hos HitObject[] The [hit objects](lua://HitObject) to place, which must be created via [`utils.CreateHitObject`](lua://utils.CreateHitObject).
function actions.PlaceHitObjectBatch(hos) end

---##### (READ-ONLY)
---#### Removes a given [hit object](lua://HitObject), assuming it already exists.
---@param ho HitObject The [hit object](lua://HitObject) to remove, which must be obtained via [`map.HitObjects`](lua://map.HitObjects) or something similar.
function actions.RemoveHitObject(ho) end

---##### (READ-ONLY)
---#### Removes a given set of [hit objects](lua://HitObject), assuming they already exist.
---@param hos HitObject[] The [hit objects](lua://HitObject) to remove, which must be obtained via [`map.HitObjects`](lua://map.HitObjects) or something similar.
function actions.RemoveHitObjectBatch(hos) end

---##### (READ-ONLY)
---#### Changes the length of a long-note type [hit object](lua://HitObject).
---@param ho HitObject The [hit object](lua://HitObject) to modify, which must be obtained via [`map.HitObjects`](lua://map.HitObjects) or something similar.
---@param oldEndTime integer The original end time of the [hit object](lua://HitObject), or `hitObject.endTime`.
---@param newEndTime integer The desired time to move the LN end to.
function actions.ResizeLongNote(ho, oldEndTime, newEndTime) end

---##### (READ-ONLY)
---#### Places a given [scroll velocity](lua://ScrollVelocity), without the need to create an [editor action](lua://EditorAction).
---@param sv ScrollVelocity The [scroll velocity](lua://ScrollVelocity) to place, which must be created via [`utils.CreateScrollVelocity`](lua://utils.CreateScrollVelocity).
function actions.PlaceScrollVelocity(sv) end

---##### (READ-ONLY)
---#### Places a given set of [scroll velocities](lua://ScrollVelocity), without the need to create an [editor action](lua://EditorAction).
---@param svs ScrollVelocity[] The [scroll velocities](lua://ScrollVelocity) to place, which must be created via [`utils.CreateScrollVelocity`](lua://utils.CreateScrollVelocity).
function actions.PlaceScrollVelocityBatch(svs) end

---##### (READ-ONLY)
---#### Removes a given [scroll velocity](lua://ScrollVelocity), assuming it already exists.
---@param sv ScrollVelocity The [scroll velocity](lua://ScrollVelocity) to remove, which must be obtained via [`map.ScrollVelocities`](lua://map.ScrollVelocities) or something similar.
function actions.RemoveScrollVelocity(sv) end

---##### (READ-ONLY)
---#### Removes a given set of [scroll velocities](lua://ScrollVelocity), assuming they already exist.
---@param svs ScrollVelocity[] The [scroll velocities](lua://ScrollVelocity) to remove, which must be obtained via [`map.ScrollVelocities`](lua://map.ScrollVelocities) or something similar.
function actions.RemoveScrollVelocityBatch(svs) end

---##### (READ-ONLY)
---#### Places a given [timing point](lua://TimingPoint), without the need to create an [editor action](lua://EditorAction).
---@param tp TimingPoint The [timing point](lua://TimingPoint) to place, which must be created via [`utils.CreateTimingPoint`](lua://utils.CreateTimingPoint).
function actions.PlaceTimingPoint(tp) end

---##### (READ-ONLY)
---#### Places a given set of [timing points](lua://TimingPoint), without the need to create an [editor action](lua://EditorAction).
---@param tps TimingPoint[] The [timing points](lua://TimingPoint) to place, which must be created via [`utils.CreateTimingPoint`](lua://utils.CreateTimingPoint).
function actions.PlaceTimingPointBatch(tps) end

---##### (READ-ONLY)
---#### Removes a given [timing point](lua://TimingPoint), assuming it already exists.
---@param tp TimingPoint The [timing point](lua://TimingPoint) to remove, which must be obtained via [`map.TimingPoints`](lua://map.TimingPoints) or something similar.
function actions.RemoveTimingPoint(tp) end

---##### (READ-ONLY)
---#### Removes a given set of [timing points](lua://TimingPoint), assuming they already exist.
---@param tps TimingPoint[] The [timing points](lua://TimingPoint) to remove, which must be obtained via [`map.TimingPoints`](lua://map.TimingPoints) or something similar.
function actions.RemoveTimingPointBatch(tps) end

---##### (READ-ONLY)
---#### Changes the `startTime` of a given [timing point](lua://TimingPoint).
---@param tp TimingPoint The [timing point](lua://TimingPoint) to modify, which must be obtained via [`map.TimingPoints`](lua://map.TimingPoints) or something similar.
---@param newTime number The new `startTime`.
function actions.ChangeTimingPointOffset(tp, newTime) end

---##### (READ-ONLY)
---#### Changes the `Bpm` of a given [timing point](lua://TimingPoint).
---@param tp TimingPoint The [timing point](lua://TimingPoint) to modify, which must be obtained via [`map.TimingPoints`](lua://map.TimingPoints) or something similar.
---@param newBpm number The new `Bpm`.
function actions.ChangeTimingPointBpm(tp, newBpm) end

---##### (READ-ONLY)
---#### Changes if a given [timing point](lua://TimingPoint) should be `Hidden`.
---@param tp TimingPoint The [timing point](lua://TimingPoint) to modify, which must be obtained via [`map.TimingPoints`](lua://map.TimingPoints) or something similar.
---@param newHidden boolean The new `Hidden` property.
function actions.ChangeTimingPointHidden(tp, newHidden) end

---##### (READ-ONLY)
---#### Changes the `startTime` of the given [timing points](lua://TimingPoint).
---@param tps TimingPoint[] The [timing points](lua://TimingPoint) to modify, which must be obtained via [`map.TimingPoints`](lua://map.TimingPoints) or something similar.
---@param newTime number The new `startTime`.
function actions.ChangeTimingPointOffsetBatch(tps, newTime) end

---##### (READ-ONLY)
---#### Changes the `Bpm` of the given [timing points](lua://TimingPoint).
---@param tps TimingPoint[] The [timing points](lua://TimingPoint) to modify, which must be obtained via [`map.TimingPoints`](lua://map.TimingPoints) or something similar.
---@param newBpm number The new `Bpm`.
function actions.ChangeTimingPointBpmBatch(tps, newBpm) end

---##### (READ-ONLY)
---#### Resets the given[timing point](lua://TimingPoint).
---@param tp TimingPoint The [timing point](lua://TimingPoint) to reset, which must be obtained via [`map.TimingPoints`](lua://map.TimingPoints) or something similar.
function actions.ResetTimingPoint(tp) end

---##### (READ-ONLY)
---#### Moves the [`song time`](lua://state.SongTime) to the designated objects.
---@param input string The input string with navigation directions, usually obtained from copying notes in-game.
function actions.GoToObjects(input) end

---##### (READ-ONLY)
---#### Sets the [hit object selection](lua://state.SelectedHitObjects) to be the [hit objects](lua://HitObject) passed as the argument.
---@param hos HitObject[] The [hit objects](lua://HitObject) to select, which must be obtained via [`map.HitObjects`](lua://map.HitObjects) or something similar.
function actions.SetHitObjectSelection(hos) end

---##### (READ-ONLY)
---#### Sets the preview time of the map.
---@param time integer The preview time, in milliseconds.
function actions.SetPreviewTime(time) end

---##### (READ-ONLY)
---#### Creates the given [editor layer](lua://EditorLayer), without the need to create an [editor action](lua://EditorAction).
---@param layer EditorLayer The [editor layer](lua://EditorLayer) to create, which must be created via [`utils.CreateEditorLayer`](lua://utils.CreateEditorLayer).
---@param index? integer An optional index for the [editor layer](lua://EditorLayer) to be placed in. If none is given, the next available index is used.
function actions.CreateLayer(layer, index) end

---##### (READ-ONLY)
---#### Removes the given [editor layer](lua://EditorLayer), assuming it exists.
---@param layer EditorLayer The [editor layer](lua://EditorLayer) to remove, which must be obtained via [`map.EditorLayers`](lua://map.EditorLayers) or something similar.
function actions.RemoveLayer(layer) end

---##### (READ-ONLY)
---#### Renames the given [editor layer](lua://EditorLayer), assuming it exists.
---@param layer EditorLayer The [editor layer](lua://EditorLayer) to rename, which must be obtained via [`map.EditorLayers`](lua://map.EditorLayers) or something similar.
---@param newName string The new name the [editor layer](lua://EditorLayer) should have.
function actions.RenameLayer(layer, newName) end

---##### (READ-ONLY)
---#### Moves the given [hit objects](lua://HitObject) to the given [editor layer](lua://EditorLayer).
---@param layer EditorLayer The [editor layer](lua://EditorLayer) to move the [hit objects](lua://HitObject) to, which must be obtained via [`map.EditorLayers`](lua://map.EditorLayers) or something similar.
---@param hos HitObject[] The [hit objects](lua://HitObject) to move, which must be obtained via [`map.HitObjects`](lua://map.HitObjects) or something similar.
function actions.MoveHitObjectsToLayer(layer, hos) end

---##### (READ-ONLY)
---#### Changes the color of the given [editor layer](lua://EditorLayer).
---@param layer EditorLayer The [editor layer](lua://EditorLayer) to alter the color of, which must be obtained via [`map.EditorLayers`](lua://map.EditorLayers) or something similar.
---@param r integer The strength of the red part of the color. Should be within [0-255].
---@param g integer The strength of the green part of the color. Should be within [0-255].
---@param b integer The strength of the blue part of the color. Should be within [0-255].
function actions.ChangeLayerColor(layer, r, g, b) end

---##### (READ-ONLY)
---#### Toggles the visibility of the given [editor layer](lua://EditorLayer).
---@param layer EditorLayer The [editor layer](lua://EditorLayer) to alter, which must be obtained via [`map.EditorLayers`](lua://map.EditorLayers) or something similar.
function actions.ToggleLayerVisibility(layer) end

---##### (READ-ONLY)
---#### Snaps the given [hit objects](lua://HitObject) to the nearest snap within the table of `snaps`.
---@param snaps integer[] The list of snap denominators to use.
---@param hos HitObject[] The [hit objects](lua://HitObject) to snap, which must be obtained via [`map.HitObjects`](lua://map.HitObjects) or something similar.
function actions.ResnapNotes(snaps, hos) end

---##### (READ-ONLY)
---#### Places a given [bookmark](lua://Bookmark), without the need to create an [editor action](lua://EditorAction).
---@param bm Bookmark The [bookmark](lua://Bookmark) to place, which must be created via [`utils.CreateBookmark`](lua://utils.CreateBookmark).
function actions.AddBookmark(bm) end

---##### (READ-ONLY)
---#### Places a new [bookmark](lua://Bookmark), without the need to create an [editor action](lua://EditorAction).
---@param time integer The time to place the [bookmark](lua://Bookmark).
---@param info string The content of the [bookmark](lua://Bookmark).
function actions.AddBookmark(time, info) end

---##### (READ-ONLY)
---#### Places a given set of [bookmarks](lua://Bookmark), without the need to create an [editor action](lua://EditorAction).
---@param bms Bookmark[] The [bookmarks](lua://Bookmark) to place, which must be created via [`utils.CreateBookmark`](lua://utils.CreateBookmark).
function actions.AddBookmarkBatch(bms) end

---##### (READ-ONLY)
---#### Removes a given [bookmark](lua://Bookmark), assuming it exists.
---@param bm Bookmark The [bookmark](lua://Bookmark) to remove, which must be obtained via [`map.Bookmarks`](lua://map.Bookmarks) or something similar.
function actions.RemoveBookmark(bm) end

---##### (READ-ONLY)
---#### Removes a given set of [bookmarks](lua://Bookmark), assuming they exist.
---@param bms Bookmark[] The [bookmarks](lua://Bookmark) to remove, which must be obtained via [`map.Bookmarks`](lua://map.Bookmarks) or something similar.
function actions.RemoveBookmarkBatch(bms) end

---##### (READ-ONLY)
---#### Changes the contents of a [bookmark](lua://Bookmark).
---@param bm Bookmark The [bookmark](lua://Bookmark) to edit, which must be obtained via [`map.Bookmarks`](lua://map.Bookmarks) or something similar.
---@param newNote string The new contents of the [bookmark](lua://Bookmark).
function actions.EditBookmark(bm, newNote) end

---##### (READ-ONLY)
---#### Changes the start time of the given [bookmarks](lua://Bookmark).
---@param bms Bookmark[] The [bookmarks](lua://Bookmark) to edit, which must be obtained via [`map.Bookmarks`](lua://map.Bookmarks) or something similar.
---@param offset integer The new `startTime` of the [bookmarks](lua://Bookmark).
function actions.ChangeBookmarkBatchOffset(bms, offset) end

---##### (READ-ONLY)
---#### Places the given [timing group](lua://ScrollGroup), without the need to create an [editor action](lua://EditorAction).
---@param id string The id of the [timing group](lua://ScrollGroup) to place, usually generated by [`utils.GenerateTimingGroupId`](lua://utils.GenerateTimingGroupId).
---@param tg ScrollGroup The [timing group](lua://ScrollGroup) to place, which must be created via [`utils.CreateScrollGroup`](lua://utils.CreateScrollGroup).
---@param hos HitObject[] A list of [hit objects](lua://HitObject) that should be placed within the [timing group](lua://ScrollGroup), which must be created via [`utils.CreateHitObject`](lua://utils.CreateHitObject), or obtained via [`map.HitObjects`](lua://map.HitObjects) or something similar.
function actions.PlaceTimingGroup(id, tg, hos) end

---##### (READ-ONLY)
---#### Removes the given [timing group](lua://ScrollGroup), assuming it exists.
---@param id string The id of the [timing group](lua://ScrollGroup) to remove, which must be obtained via [`state.SelectedScrollGroup`](lua://state.SelectedScrollGroup) or something similar.
function actions.RemoveTimingGroup(id) end

---##### (READ-ONLY)
---#### Renames the given [timing group](lua://ScrollGroup).
---@param id string The id of the [timing group](lua://ScrollGroup) to rename, which must be obtained via [`state.SelectedScrollGroup`](lua://state.SelectedScrollGroup) or something similar.
---@param newId string The new id.
function actions.RenameTimingGroup(id, newId) end

---##### (READ-ONLY)
---#### Changes the color of the given [timing group](lua://ScrollGroup).
---@param id string The id of the [timing group](lua://ScrollGroup) to alter the color of, which must be obtained via [`state.SelectedScrollGroup`](lua://state.SelectedScrollGroup) or something similar.
---@param r integer The strength of the red part of the color. Should be within [0-255].
---@param g integer The strength of the green part of the color. Should be within [0-255].
---@param b integer The strength of the blue part of the color. Should be within [0-255].
function actions.ChangeTimingGroupColor(id, r, g, b) end

---##### (READ-ONLY)
---#### Moves all given [hit objects](lua://HitObject) to the given [timing group](lua://ScrollGroup).
---@param hos HitObject[] The [hit objects](lua://HitObject) to move, which must be obtained via [`map.HitObjects`](lua://map.HitObjects) or something similar.
---@param id string The id of the [timing group](lua://ScrollGroup) to move the [hit objects](lua://HitObject) to, which must be obtained via [`state.SelectedScrollGroup`](lua://state.SelectedScrollGroup) or something similar.
function actions.MoveObjectsToTimingGroup(hos, id) end

state                          = {}

---##### (READ-ONLY)
---#### The current song time in milliseconds.
state.SongTime                 = 0.0 ---@type number

---##### (READ-ONLY)
---#### A list of all [hit objects](lua://HitObject) within the current selection.
---#### If multiple [hit objects](lua://HitObject) are selected at once, the table will be in order of their `StartTime`. If they were selected one at a time using <kbd>Ctrl-Click</kbd>, then the table will be in order of their selection order.
state.SelectedHitObjects       = {} ---@type HitObject[]

---#### The `id`, or name, of the current selected [scroll group](lua://ScrollGroup).
state.SelectedScrollGroupId    = "$Default" ---@type string

---##### (READ-ONLY)
---#### The current selected [scroll group](lua://ScrollGroup).
state.SelectedScrollGroup      = {} ---@type ScrollGroup

---##### (READ-ONLY)
---#### The nearest [bookmark](lua://Bookmark) before the current `state.SongTime`.
state.CurrentBookmark          = {} ---@type Bookmark

---##### (READ-ONLY)
---#### The nearest [scroll velocity](lua://ScrollVelocity) before the current `state.SongTime`.
state.CurrentScrollVelocity    = {} ---@type ScrollVelocity

---##### (READ-ONLY)
---#### The nearest [scroll speed factor](lua://ScrollSpeedFactor) before the current `state.SongTime`.
state.CurrentScrollSpeedFactor = {} ---@type ScrollSpeedFactor

---##### (READ-ONLY)
---#### The nearest [timing point](lua://TimingPoint) before the current `state.SongTime`.
state.CurrentTimingPoint       = {} ---@type TimingPoint

---##### (READ-ONLY)
---#### The current selected [editor layer](lua://EditorLayer).
state.CurrentEditorLayer       = {} ---@type EditorLayer

---##### (READ-ONLY)
---#### The selected snap's denominator. (e.g. 1/3 snap returns `3`, etc.)
state.CurrentSnap              = 1 ---@type integer

---##### (READ-ONLY)
---#### The time elapsed between the last frame and the current frame, in milliseconds.
state.DeltaTime                = 0 ---@type number

---##### (READ-ONLY)
---#### The current unix timestamp.
state.UnixTime                 = 0 ---@type integer

---#### MUST BE SET MANUALLY - Indicates to the game that the window is hovered.
state.IsWindowHovered          = false ---@type boolean

---##### (READ-ONLY)
---#### The current ImGui scale.
state.Scale                    = 1 ---@type number

---##### (READ-ONLY)
---#### The size of the Quaver window.
state.WindowSize               = { 69, 69 } ---@type [number, number] | Vector2

---##### (READ-ONLY)
---#### Stores a value that can be retrieved by [`state.GetValue`](lua://state.GetValue). Mainly used to persist data between hot-reloads.
---@param key string The identifier for this particular value.
---@param value any The value to store.
function state.SetValue(key, value) end

---@generic T
---##### (READ-ONLY)
---#### Gets a value previously stored by [`state.SetValue`](lua://state.SetValue). If the value doesn't exist, return `fallback` instead. Note that `nil` is considered a value, meaning if you store `nil` using [`state.SetValue`](lua://state.SetValue), then the `fallback` will not be used.
---@param key string The identifier for the value set by `state.SetValue`.
---@param fallback? T An optional term to return, if the result is `nil`.
---@return T value The stored value.
---@nodiscard
function state.GetValue(key, fallback) end

utils = {}

---##### (READ-ONLY)
---#### Creates a [scroll velocity](lua://ScrollVelocity), to later be placed into an [`EditorAction`](lua://utils.CreateEditorAction) and executed.
---@param startTime number The time to create the [scroll velocity](lua://ScrollVelocity), in milliseconds.
---@param multiplier number The factor at which to scale the player's [scroll velocity](lua://ScrollVelocity).
---@return ScrollVelocity sv The requested [scroll velocity](lua://ScrollVelocity).
---@nodiscard
function utils.CreateScrollVelocity(startTime, multiplier) end

---##### (READ-ONLY)
---#### Creates a [scroll speed factor](lua://ScrollSpeedFactor), to later be placed into an [`EditorAction`](lua://utils.CreateEditorAction) and executed.
---@param startTime number The time to create the [scroll speed factor](lua://ScrollSpeedFactor), in milliseconds.
---@param multiplier number The factor at which to scale the player's scroll speed.
---@return ScrollSpeedFactor ssf The requested [scroll speed factor](lua://ScrollSpeedFactor).
---@nodiscard
function utils.CreateScrollSpeedFactor(startTime, multiplier) end

---##### (READ-ONLY)
---#### Creates a [hit object](lua://HitObject), to later be placed into an [`EditorAction`](lua://utils.CreateEditorAction) and executed.
---@param startTime integer The time to create the note, in milliseconds.
---@param lane NoteLane The lane to create the note in.
---@param endTime? integer If given and non-zero, the note becomes a long note. This parameter determines when the long note will end.
---@param hitsounds? HitSounds The hitsounds that should be applied to the note.
---@param editorLayer? integer The index of the [editor layer](lua://EditorLayer) that this note should be added to.
---@return HitObject ho The requested note.
---@nodiscard
function utils.CreateHitObject(startTime, lane, endTime, hitsounds, editorLayer) end

---##### (READ-ONLY)
---#### Creates a [timing point](lua://TimingPoint), to later be placed into an [`EditorAction`](lua://utils.CreateEditorAction) and executed.
---@param startTime number The time to create the [timing point](lua://TimingPoint), in milliseconds.
---@param bpm number The beats per minute of the [timing point](lua://TimingPoint).
---@param signature? integer The time signature of the [timing point](lua://TimingPoint).
---@param hidden? boolean Whether or not to hide the timing lines in gameplay.
---@return TimingPoint tp The requested [timing point](lua://TimingPoint).
---@nodiscard
function utils.CreateTimingPoint(startTime, bpm, signature, hidden) end

---##### (READ-ONLY)
---#### Creates an [editor layer](lua://EditorLayer), to later be placed into an [`EditorAction`](lua://utils.CreateEditorAction) and executed.
---@param name string The name of this layer.
---@param hidden? boolean Whether or not to hide this layer in the editor.
---@param colorRgb? string The color of the [editor layer](lua://EditorLayer). This parameter should be a string of the form `r,g,b`, where `r`, `g`, and `b` are integers within [0,255].
---@return EditorLayer editorLayer The requested [editor layer](lua://EditorLayer).
---@nodiscard
function utils.CreateEditorLayer(name, hidden, colorRgb) end

---##### (READ-ONLY)
---#### Creates a [bookmark](lua://Bookmark), to later be placed into an [`EditorAction`](lua://utils.CreateEditorAction) and executed.
---@param startTime number The time to create the [bookmark](lua://Bookmark), in milliseconds.
---@param note string The contents of the [bookmark](lua://Bookmark).
---@return Bookmark bm The requested [bookmark](lua://Bookmark).
---@nodiscard
function utils.CreateBookmark(startTime, note) end

---##### (READ-ONLY)
---#### Creates a [scroll group](lua://ScrollGroup), to later be placed into an [`EditorAction`](lua://utils.CreateEditorAction) and executed.
---@param svs ScrollVelocity[] The [scroll velocities](lua://ScrollVelocity) to add to the [scroll group](lua://ScrollGroup).
---@param initialSV? number The initial [scroll velocity](lua://ScrollVelocity) of the [scroll group](lua://ScrollGroup).
---@param colorRgb? string The color of the [scroll group](lua://ScrollGroup). This parameter should be a string of the form `r,g,b`, where `r`, `g`, and `b` are integers within [0,255].
---@return ScrollGroup tg The requested [scroll group](lua://ScrollGroup).
---@nodiscard
function utils.CreateScrollGroup(svs, initialSV, colorRgb) end

---##### (READ-ONLY)
---#### Creates an [editor action](lua://EditorAction), to later be executed with [`actions.Perform`](lua://actions.Perform).
---@param type EditorActionType The type of action to perform.
---@vararg any The parameters of the action. Depending on the prefix of the action, different parameters should be passed in:
---- Place/Add/Remove // ... should only be one term, the object to add.
---- Place/Add/Remove Batch // ... should only be one term, a table of the objects to add.
---- Move/Swap/Flip/Change/Toggle // ... should be two terms, the first being the objects to manipulate, the second being the instruction for the manipulation.
---- CreateTimingGroup // ... should be three terms:
---    1. The id of the [timing group](lua://ScrollGroup).
---    2. The [timing group](lua://ScrollGroup) previously created by `utils.CreateScrollGroup`.
---    3. The [hit objects](lua://HitObject) to add to the [scroll group](lua://ScrollGroup).
---@return EditorAction editorAction The requested [editor action](lua://EditorAction).
---@nodiscard
function utils.CreateEditorAction(type, ...) end

---##### (READ-ONLY)
---#### Returns a formatted version of the inputted `time`.
---@param time number The elapsed time to format, in milliseconds.
---@return string str The formatted time.
---@nodiscard
function utils.MillisecondsToTime(time) end

---##### (READ-ONLY)
---#### Returns `true` if the given key is pressed within the given frame.
---@param key Key A key, from the `keys` enum.
---@return boolean keyPressed Whether or not the key has been pressed this frame.
---@nodiscard
function utils.IsKeyPressed(key) end

---##### (READ-ONLY)
---#### Returns `true` if the given key is released within the given frame.
---@param key Key A key, from the `keys` enum.
---@return boolean keyReleased Whether or not the key has been released this frame.
---@nodiscard
function utils.IsKeyReleased(key) end

---##### (READ-ONLY)
---#### Returns `true` if the given key is held down within the given frame.
---@param key Key A key, from the `keys` enum.
---@return boolean keyDown Whether or not the key is currently being held down.
---@nodiscard
function utils.IsKeyDown(key) end

---##### (READ-ONLY)
---#### Returns `true` if the given key is not held down within the given frame.
---@param key Key A key, from the `keys` enum.
---@return boolean keyUp Whether or not the key is currently not held down.
---@nodiscard
function utils.IsKeyUp(key) end

---##### (READ-ONLY)
---#### Returns a unique `tgId` with the given prefix. If no prefix is given, defaults to `SG_`.
---@param prefix? string An optional prefix to all of the ids.
---@return string tgId The new timing group id, to be passed into an [`EditorAction`](lua://EditorAction) (of type `CreateTimingGroup`).
---@nodiscard
function utils.GenerateTimingGroupId(prefix) end

---##### (READ-ONLY)
---#### Returns `count` number of `tgIds` with the given prefix. If no prefix is given, defaults to `SG_`.
---@param count integer The number of timing group ids to generate.
---@param prefix? string An optional prefix to all of the ids.
---@return string[] tgIds The new timing group ids, to be passed into some [`EditorActions`](lua://EditorAction) (of type `CreateTimingGroup`).
---@nodiscard
function utils.GenerateTimingGroupIds(count, prefix) end

map                       = {}

---##### (READ-ONLY)
---#### Returns `1` in 4k, `2` in 7k.
map.Mode                  = 1 ---@type number

---##### (READ-ONLY)
---#### `true` if BPM does not affect [scroll velocity](lua://ScrollVelocity).
map.Normalized            = true ---@type boolean

---##### (READ-ONLY)
---#### A table of all [scroll velocities](lua://ScrollVelocity) in the current timing group.
map.ScrollVelocities      = {} ---@type ScrollVelocity[]

---##### (READ-ONLY)
---#### A table of all [scroll speed factors](lua://ScrollSpeedFactor) in the current timing group.
map.ScrollSpeedFactors    = {} ---@type ScrollSpeedFactor[]

---##### (READ-ONLY)
---#### A table of all [timing groups](lua://ScrollGroup) in the map, where the keys are the identifiers of the scroll group.
map.TimingGroups          = {} ---@type { [string]: ScrollGroup}

---##### (READ-ONLY)
---#### The default [scroll group](lua://ScrollGroup).
map.DefaultScrollGroup    = {} ---@type ScrollGroup

---##### (READ-ONLY)
---#### The global [scroll group](lua://ScrollGroup).
map.GlobalScrollGroup     = {} ---@type ScrollGroup

---##### (READ-ONLY)
---#### A table of all [hit objects](lua://HitObject) in the map.
map.HitObjects            = {} ---@type HitObject[]

---##### (READ-ONLY)
---#### A table of all [timing points](lua://TimingPoint) in the map.
map.TimingPoints          = {} ---@type TimingPoint[]

---##### (READ-ONLY)
---#### A table of all [editor layers](lua://EditorLayer) in the map.
map.EditorLayers          = {} ---@type EditorLayer[]

---##### (READ-ONLY)
---#### A table of all [bookmarks](lua://Bookmark) in the map.
map.Bookmarks             = {} ---@type Bookmark[]

---##### (READ-ONLY)
---#### The default [editor layer](lua://EditorLayer).
map.DefaultLayer          = {} ---@type EditorLayer

---##### (READ-ONLY)
---#### The length of the song, in milliseconds.
map.TrackLength           = 0 ---@type number

---##### (READ-ONLY)
---#### `true` if the "Legacy LN Rendering" option is enabled.
map.LegacyLNRendering     = false ---@type boolean

---##### (READ-ONLY)
---#### The initial [scroll velocity](lua://ScrollVelocity) multiplier of the current [scroll group](lua://ScrollGroup). Defaults to 1.
map.InitialScrollVelocity = 1 ---@type number

---##### (READ-ONLY)
---#### Returns the map metadata in the form of `{Artist} - {Title} [{Difficulty}]`.
---@return string str The map metadata, as mentioned above.
---@nodiscard
function map.ToString() end

---##### (READ-ONLY)
---#### Returns the number of possible keys within the map.
---@param includeScratch? boolean Whether or not to include the scratch lane. This should almost never be true.
---@return integer keyCount The number of keys in the map, usually 4 or 7.
---@nodiscard
function map.GetKeyCount(includeScratch) end

---##### (READ-ONLY)
---#### Returns the most common BPM in the map, determined by how much time a particular BPM is used.
---@return number? Bpm The BPM. This number should be identical to the BPM displayed in the song select menu.
---@nodiscard
function map.GetCommonBpm() end

---##### (READ-ONLY)
---#### Returns the nearest [timing point](lua://TimingPoint) before the given `time`.
---@param time number The time to start looking from, in milliseconds.
---@return TimingPoint? tp The requested [timing point](lua://TimingPoint).
---@nodiscard
function map.GetTimingPointAt(time) end

---##### (READ-ONLY)
---#### Returns the nearest [scroll velocity](lua://ScrollVelocity) before the given `time`, within `tgId`. If `tgId` is not given, it will search within the currently selected [scroll group](lua://ScrollGroup).
---@param time number The time to start looking from, in milliseconds.
---@param tgId? string The [timing group](lua://ScrollGroup) to look within. If this option is omitted, the function will search within the currently selected [timing group](lua://ScrollGroup).
---@return ScrollVelocity? sv The requested [scroll velocity](lua://ScrollVelocity).
---@nodiscard
function map.GetScrollVelocityAt(time, tgId) end

---##### (READ-ONLY)
---#### Returns the nearest [scroll speed factor](lua://ScrollSpeedFactor) before the given `time`, within `tgId`. If `tgId` is not given, it will search within the currently selected [scroll group](lua://ScrollGroup).
---@param time number The time to start looking from, in milliseconds.
---@param tgId? string The [timing group](lua://ScrollGroup) to look within. If this option is omitted, the function will search within the currently selected [timing group](lua://ScrollGroup).
---@return ScrollSpeedFactor? ssf The requested [scroll speed factor](lua://ScrollSpeedFactor).
---@nodiscard
function map.GetScrollSpeedFactorAt(time, tgId) end

---##### (READ-ONLY)
---#### Returns the [timing group](lua://ScrollGroup) corresponding with the given id.
---@param tgId string The id to search with.
---@return ScrollGroup? tg The [timing group](lua://ScrollGroup) corresponding to the id.
---@nodiscard
function map.GetTimingGroup(tgId) end

---##### (READ-ONLY)
---#### Returns a list of all [timing group](lua://ScrollGroup) ids.
---@return string[] ids The list of [timing group](lua://ScrollGroup) ids.
---@nodiscard
function map.GetTimingGroupIds() end

---##### (READ-ONLY)
---#### Returns all [hit objects](lua://HitObject) within the id's corresponding [timing group](lua://ScrollGroup).
---@param tgId string The [timing group](lua://ScrollGroup) to look within.
---@return HitObject[]? hos All [hit objects](lua://HitObject) within the requested [timing group](lua://ScrollGroup).
---@nodiscard
function map.GetTimingGroupObjects(tgId) end

---##### (READ-ONLY)
---#### Returns the nearest [bookmark](lua://Bookmark) before the given `time`.
---@param time number The time to start looking from, in milliseconds.
---@return Bookmark? bm The requested [bookmark](lua://Bookmark).
---@nodiscard
function map.GetBookmarkAt(time) end

---##### (READ-ONLY)
---#### Returns the length of the given [timing point](lua://TimingPoint), in milliseconds.
---@param tp TimingPoint The timing point to use.
---@return number? duration The duration between the given [timing point](lua://TimingPoint) and the next [timing point](lua://TimingPoint).
---@nodiscard
function map.GetTimingPointLength(tp) end

---##### (READ-ONLY)
---#### Returns the nearest time where the snap lines up with the given snap.
---@param forwards boolean Whether or not the nearest snap should be searched forwards or backwards in time.
---@param snap integer The denominator of the desired snap.
---@param time number The time to start looking from, in milliseconds.
---@return number? snapTime The nearest time which follows the given snap.
---@nodiscard
function map.GetNearestSnapTimeFromTime(forwards, snap, time) end

bit32 = {}

---##### (READ-ONLY)
---### Arithmetically bit shifts a number to the right by `disp` places.
---@param x number The number to shift.
---@param disp integer Shifts the number to the right by this many places. If `disp` is negative, shifts to the left instead.
---@return integer n
function bit32.arshift(x, disp) end

---##### (READ-ONLY)
---### Returns the bitwise `AND` of the parameters.
---@param ... number[]
---@return integer n
function bit32.band(...) end

---##### (READ-ONLY)
---### Returns the bitwise `NOT` of the parameters.
---@param x number
---@return integer n
function bit32.bnot(x) end

---##### (READ-ONLY)
---### Returns the bitwise `OR` of the parameters.
---@param ... number[]
---@return integer n
function bit32.bor(...) end

---##### (READ-ONLY)
---### Returns true if the bitwise `AND` of the two parameters is nonzero.
---@param ... number[]
---@return boolean
function bit32.test(...) end

---##### (READ-ONLY)
---### Returns the bitwise `XOR` of the parameters.
---@param ... number[]
---@return integer n
function bit32.bxor(...) end

---##### (READ-ONLY)
---### (From [Lua 5.2 Manual](https://www.lua.org/manual/5.2/manual.html#6.7)): Returns the unsigned number formed by the bits `field` to `field + width - 1` from `n`. Bits are numbered from `0` (least significant) to `31` (most significant). All accessed bits must be in the range `[0, 31]`. The default for width is `1`.
---@param n integer
---@param field integer
---@param width? integer
---@return integer n
function bit32.extract(n, field, width) end

---##### (READ-ONLY)
---### (From [Lua 5.2 Manual](https://www.lua.org/manual/5.2/manual.html#6.7)): Returns a copy of `n` with the bits `field` to `field + width - 1` replaced by the value `v`. See [bit32.extract](lua://bit32.extract) for details about `field` and `width`.
---@param n integer
---@param v integer
---@param field integer
---@param width? integer
---@return integer n
function bit32.replace(n, v, field, width) end

---##### (READ-ONLY)
---### Rotationally bit shifts a number to the left by `disp` places.
---@param x number The number to shift.
---@param disp integer Shifts the number to the left by this many places. If `disp` is negative, shifts to the right instead.
---@return integer n
function bit32.lrotate(x, disp) end

---##### (READ-ONLY)
---### Logically bit shifts a number to the left by `disp` places.
---@param x number The number to shift.
---@param disp integer Shifts the number to the left by this many places. If `disp` is negative, shifts to the right instead.
---@return integer n
function bit32.lshift(x, disp) end

---##### (READ-ONLY)
---### Rotationally bit shifts a number to the right by `disp` places.
---@param x number The number to shift.
---@param disp integer Shifts the number to the right by this many places. If `disp` is negative, shifts to the left instead.
---@return integer n
function bit32.rrotate(x, disp) end

---##### (READ-ONLY)
---### Logically bit shifts a number to the right by `disp` places.
---@param x number The number to shift.
---@param disp integer Shifts the number to the right by this many places. If `disp` is negative, shifts to the left instead.
---@return integer n
function bit32.rshift(x, disp) end

---##### (READ-ONLY)
---#### Invokes the function whenever any [editor action](lua://EditorAction) has occurred. This includes actions invoked by this and other plugins.
---@param fn fun(action: EditorAction, type: HistoryType, fromLua: boolean): nil The function that will be invoked during any [editor action](lua://EditorAction).
function listen(fn) end

---##### (READ-ONLY)
---#### Returns the value stored in the `config.yaml` file located in the plugin's directory.
---@return any data The contents within `config.yaml`.
---@nodiscard
function read() end

---##### (READ-ONLY)
---#### Stores the given value in the `config.yaml` file located in the plugin's directory. If multiple arguments are given, they are packed as an array before being stored.
---@vararg any The contents that should be stored.
function write(...) end

---##### (READ-ONLY)
---#### Evaluates the string as Lua code, in the current context. This function is similar to `eval`, but is unable to make function calls and is guaranteed to be pure.
---@param str string The string to evaluate.
---@return any value The resultant value.
---@nodiscard
function expr(str) end

---##### (READ-ONLY)
---#### Evaluates the string as Lua code, in the current context. This function is capable of doing anything that the script already can.
---@param str string The string to evaluate.
---@return any value The resultant value.
---@nodiscard
function eval(str) end

---##### (READ-ONLY)
---#### Displays a notification in Quaver.
---@vararg any The notification contents.
function print(...) end

---##### (READ-ONLY)
---#### Displays a notification in Quaver with a specific color and icon.
---@param notificationType "info"|"success"|"warning"|"error"|"info!"|"success!"|"warning!"|"error!" The type of notification sent. Appending an `!` will omit the plugin name in the notification.
---@vararg any The contents of the notification.
function print(notificationType, ...) end

---@enum HitSounds
hitsounds    = {
    Normal = 1 << 0,  -- This is 1, but Normal should be played regardless if it's 0 or 1.
    Whistle = 1 << 1, -- 2
    Finish = 1 << 2,  -- 4
    Clap = 1 << 3     -- 8
}

---@enum EditorActionType
action_type  = {
    None = -1,
    PlaceHitObject = 0,
    RemoveHitObject = 1,
    ResizeLongNote = 2,
    RemoveHitObjectBatch = 3,
    PlaceHitObjectBatch = 4,
    FlipHitObjects = 5,
    SwapLanes = 6,
    MoveHitObjects = 7,
    AddHitsound = 8,
    RemoveHitsound = 9,
    CreateLayer = 10,
    RemoveLayer = 11,
    RenameLayer = 12,
    MoveToLayer = 13,
    ColorLayer = 14,
    ToggleLayerVisibility = 15,
    AddScrollVelocity = 16,
    RemoveScrollVelocity = 17,
    AddScrollVelocityBatch = 18,
    RemoveScrollVelocityBatch = 19,
    AddTimingPoint = 20,
    RemoveTimingPoint = 21,
    AddTimingPointBatch = 22,
    RemoveTimingPointBatch = 23,
    ChangePreviewTime = 24,
    ChangeTimingPointOffset = 25,
    ChangeTimingPointBpm = 26,
    ChangeTimingPointSignature = 27,
    ChangeTimingPointHidden = 28,
    ResetTimingPoint = 29,
    ChangeTimingPointBpmBatch = 30,
    ChangeTimingPointSignatureBatch = 31,
    ChangeTimingPointOffsetBatch = 32,
    ChangeScrollVelocityOffsetBatch = 33,
    ChangeScrollVelocityMultiplierBatch = 34,
    ApplyOffset = 35,
    ResnapHitObjects = 36,
    Batch = 37,
    ReverseHitObjects = 38,
    AddBookmark = 39,
    AddBookmarkBatch = 40,
    EditBookmark = 41,
    RemoveBookmark = 42,
    RemoveBookmarkBatch = 43,
    ChangeBookmarkOffsetBatch = 44,
    CreateTimingGroup = 45,
    RemoveTimingGroup = 46,
    RenameTimingGroup = 47,
    MoveObjectsToTimingGroup = 48,
    ColorTimingGroup = 49,
    AddTimingGroupBatch = 50,
    RemoveTimingGroupBatch = 51,
    AddScrollSpeedFactor = 52,
    AddScrollSpeedFactorBatch = 53,
    ChangeScrollSpeedFactorMultiplierBatch = 54,
    ChangeScrollSpeedFactorLaneMaskBatch = 55,
    ChangeScrollSpeedFactorOffsetBatch = 56,
    RemoveScrollSpeedFactor = 57,
    RemoveScrollSpeedFactorBatch = 58
}

---@enum Key
keys         = {
    None = 0,                  -- Reserved.
    Back = 8,                  -- BACKSPACE key.
    Tab = 9,                   -- TAB key.
    Enter = 13,                -- ENTER key.
    CapsLock = 20,             -- CAPS LOCK key.
    Escape = 27,               -- ESC key.
    Space = 32,                -- SPACEBAR key.
    PageUp = 33,               -- PAGE UP key.
    PageDown = 34,             -- PAGE DOWN key.
    End = 35,                  -- END key.
    Home = 36,                 -- HOME key.
    Left = 37,                 -- LEFT ARROW key.
    Up = 38,                   -- UP ARROW key.
    Right = 39,                -- RIGHT ARROW key.
    Down = 40,                 -- DOWN ARROW key.
    Select = 41,               -- SELECT key.
    Print = 42,                -- PRINT key.
    Execute = 43,              -- EXECUTE key.
    PrintScreen = 44,          -- PRINT SCREEN key.
    Insert = 45,               -- INS key.
    Delete = 46,               -- DEL key.
    Help = 47,                 -- HELP key.
    D0 = 48,                   -- Used for miscellaneous characters; it can vary by keyboard.
    D1 = 49,                   -- Used for miscellaneous characters; it can vary by keyboard.
    D2 = 50,                   -- Used for miscellaneous characters; it can vary by keyboard.
    D3 = 51,                   -- Used for miscellaneous characters; it can vary by keyboard.
    D4 = 52,                   -- Used for miscellaneous characters; it can vary by keyboard.
    D5 = 53,                   -- Used for miscellaneous characters; it can vary by keyboard.
    D6 = 54,                   -- Used for miscellaneous characters; it can vary by keyboard.
    D7 = 55,                   -- Used for miscellaneous characters; it can vary by keyboard.
    D8 = 56,                   -- Used for miscellaneous characters; it can vary by keyboard.
    D9 = 57,                   -- Used for miscellaneous characters; it can vary by keyboard.
    A = 65,                    -- A key.
    B = 66,                    -- B key.
    C = 67,                    -- C key.
    D = 68,                    -- D key.
    E = 69,                    -- E key.
    F = 70,                    -- F key.
    G = 71,                    -- G key.
    H = 72,                    -- H key.
    I = 73,                    -- I key.
    J = 74,                    -- J key.
    K = 75,                    -- K key.
    L = 76,                    -- L key.
    M = 77,                    -- M key.
    N = 78,                    -- N key.
    O = 79,                    -- O key.
    P = 80,                    -- P key.
    Q = 81,                    -- Q key.
    R = 82,                    -- R key.
    S = 83,                    -- S key.
    T = 84,                    -- T key.
    U = 85,                    -- U key.
    V = 86,                    -- V key.
    W = 87,                    -- W key.
    X = 88,                    -- X key.
    Y = 89,                    -- Y key.
    Z = 90,                    -- Z key.
    LeftWindows = 91,          -- Left Windows key.
    RightWindows = 92,         -- Right Windows key.
    Apps = 93,                 -- Applications key.
    Sleep = 95,                -- Computer Sleep key.
    NumPad0 = 96,              -- Numeric keypad 0 key.
    NumPad1 = 97,              -- Numeric keypad 1 key.
    NumPad2 = 98,              -- Numeric keypad 2 key.
    NumPad3 = 99,              -- Numeric keypad 3 key.
    NumPad4 = 100,             -- Numeric keypad 4 key.
    NumPad5 = 101,             -- Numeric keypad 5 key.
    NumPad6 = 102,             -- Numeric keypad 6 key.
    NumPad7 = 103,             -- Numeric keypad 7 key.
    NumPad8 = 104,             -- Numeric keypad 8 key.
    NumPad9 = 105,             -- Numeric keypad 9 key.
    Multiply = 106,            -- Multiply key.
    Add = 107,                 -- Add key.
    Separator = 108,           -- Separator key.
    Subtract = 109,            -- Subtract key.
    Decimal = 110,             -- Decimal key.
    Divide = 111,              -- Divide key.
    F1 = 112,                  -- F1 key.
    F2 = 113,                  -- F2 key.
    F3 = 114,                  -- F3 key.
    F4 = 115,                  -- F4 key.
    F5 = 116,                  -- F5 key.
    F6 = 117,                  -- F6 key.
    F7 = 118,                  -- F7 key.
    F8 = 119,                  -- F8 key.
    F9 = 120,                  -- F9 key.
    F10 = 121,                 -- F10 key.
    F11 = 122,                 -- F11 key.
    F12 = 123,                 -- F12 key.
    F13 = 124,                 -- F13 key.
    F14 = 125,                 -- F14 key.
    F15 = 126,                 -- F15 key.
    F16 = 127,                 -- F16 key.
    F17 = 128,                 -- F17 key.
    F18 = 129,                 -- F18 key.
    F19 = 130,                 -- F19 key.
    F20 = 131,                 -- F20 key.
    F21 = 132,                 -- F21 key.
    F22 = 133,                 -- F22 key.
    F23 = 134,                 -- F23 key.
    F24 = 135,                 -- F24 key.
    NumLock = 144,             -- NUM LOCK key.
    Scroll = 145,              -- SCROLL LOCK key.
    LeftShift = 160,           -- Left SHIFT key.
    RightShift = 161,          -- Right SHIFT key.
    LeftControl = 162,         -- Left CONTROL key.
    RightControl = 163,        -- Right CONTROL key.
    LeftAlt = 164,             -- Left ALT key.
    RightAlt = 165,            -- Right ALT key.
    BrowserBack = 166,         -- Browser Back key.
    BrowserForward = 167,      -- Browser Forward key.
    BrowserRefresh = 168,      -- Browser Refresh key.
    BrowserStop = 169,         -- Browser Stop key.
    BrowserSearch = 170,       -- Browser Search key.
    BrowserFavorites = 171,    -- Browser Favorites key.
    BrowserHome = 172,         -- Browser Start and Home key.
    VolumeMute = 173,          -- Volume Mute key.
    VolumeDown = 174,          -- Volume Down key.
    VolumeUp = 175,            -- Volume Up key.
    MediaNextTrack = 176,      -- Next Track key.
    MediaPreviousTrack = 177,  -- Previous Track key.
    MediaStop = 178,           -- Stop Media key.
    MediaPlayPause = 179,      -- Play/Pause Media key.
    LaunchMail = 180,          -- Start Mail key.
    SelectMedia = 181,         -- Select Media key.
    LaunchApplication1 = 182,  -- Start Application 1 key.
    LaunchApplication2 = 183,  -- Start Application 2 key.
    OemSemicolon = 186,        -- The OEM Semicolon key on a US standard keyboard.
    OemPlus = 187,             -- For any country/region, the '+' key.
    OemComma = 188,            -- For any country/region, the ',' key.
    OemMinus = 189,            -- For any country/region, the '-' key.
    OemPeriod = 190,           -- For any country/region, the '.' key.
    OemQuestion = 191,         -- The OEM question mark key on a US standard keyboard.
    OemTilde = 192,            -- The OEM tilde key on a US standard keyboard.
    OemColon = 193,            -- :
    OemExclamationMark = 194,  -- !
    PunctuatedU = 195,         -- ù
    Asterisk = 196,            -- *
    Caret = 197,               -- ^
    DollarSign = 198,          -- $
    OemCloseParenthesis = 199, -- )
    Squared = 200,             -- ²
    OemOpenBrackets = 219,     -- The OEM open bracket key on a US standard keyboard.
    OemPipe = 220,             -- The OEM pipe key on a US standard keyboard.
    OemCloseBrackets = 221,    -- The OEM close bracket key on a US standard keyboard.
    OemQuotes = 222,           -- The OEM singled/double quote key on a US standard keyboard.
    Oem8 = 223,                -- Used for miscellaneous characters; it can vary by keyboard.
    OemBackslash = 226,        -- The OEM angle bracket or backslash key on the RT 102 key keyboard.
    ProcessKey = 229,          -- IME PROCESS key.
    Attn = 246,                -- Attn key.
    Crsel = 247,               -- CrSel key.
    Exsel = 248,               -- ExSel key.
    EraseEof = 249,            -- Erase EOF key.
    Play = 250,                -- Play key.
    Zoom = 251,                -- Zoom key.
    Pa1 = 253,                 -- PA1 key.
    OemClear = 254,            -- CLEAR key.
    ChatPadGreen = 0xCA,       -- Green ChatPad key.
    ChatPadOrange = 0xCB,      -- Orange ChatPad key.
    Pause = 0x13,              -- PAUSE key.
    ImeConvert = 0x1c,         -- IME Convert key.
    ImeNoConvert = 0x1d,       -- IME NoConvert key.
    Kana = 0x15,               -- Kana key on Japanese keyboards.
    Kanji = 0x19,              -- Kanji key on Japanese keyboards.
    OemAuto = 0xf3,            -- OEM Auto key.
    OemCopy = 0xf2,            -- OEM Copy key.
    OemEnlW = 0xf4             -- OEM Enlarge Window key.
}

---@enum HistoryType
history_type = {
    New = 0,
    Redo = 1,
    Undo = 2,
}

-- END QUAVER, START IMGUI

---@class Type
imgui        = {}

---##### (READ-ONLY)
---@param type string
---@return ImGuiPayloadPtr
function imgui.AcceptDragDropPayload(type) end

---##### (READ-ONLY)
---@param type string
---@param flags ImGuiDragDropFlags|integer|"None"|"SourceNoPreviewTooltip"|"SourceNoDisableHover"|"SourceNoHoldToOpenOthers"|"SourceAllowNullID"|"SourceExtern"|"PayloadAutoExpire"|"PayloadNoCrossContext"|"PayloadNoCrossProcess"|"AcceptBeforeDelivery"|"AcceptNoDrawDefaultRect"|"AcceptPeekOnly"|"AcceptNoPreviewTooltip"
---@return ImGuiPayloadPtr
function imgui.AcceptDragDropPayload(type, flags) end

---##### (READ-ONLY)
function imgui.AlignTextToFramePadding() end

---##### (READ-ONLY)
---@param str_id string
---@param dir ImGuiDir|0|1|2|3|4|-1|"Left"|"Right"|"Up"|"Down"|"COUNT"|"None"
---@return boolean
function imgui.ArrowButton(str_id, dir) end

---##### (READ-ONLY)
---@param name string
---@return boolean
function imgui.Begin(name) end

---##### (READ-ONLY)
---@param name string
---@param p_open boolean
---@return boolean, boolean
function imgui.Begin(name, p_open) end

---##### (READ-ONLY)
---@param name string
---@param p_open boolean
---@param flags ImGuiWindowFlags|integer|"None"|"NoTitleBar"|"NoResize"|"NoMove"|"NoScrollbar"|"NoScrollWithMouse"|"NoCollapse"|"NoDecoration"|"AlwaysAutoResize"|"NoBackground"|"NoSavedSettings"|"NoMouseInputs"|"MenuBar"|"HorizontalScrollbar"|"NoFocusOnAppearing"|"NoBringToFrontOnFocus"|"AlwaysVerticalScrollbar"|"AlwaysHorizontalScrollbar"|"NoNavInputs"|"NoNavFocus"|"NoNav"|"NoInputs"|"UnsavedDocument"|"NoDocking"|"ChildWindow"|"Tooltip"|"Popup"|"Modal"|"ChildMenu"|"DockNodeHost"
---@return boolean, boolean
function imgui.Begin(name, p_open, flags) end

---##### (READ-ONLY)
---@param name string
---@param flags ImGuiWindowFlags|integer|"None"|"NoTitleBar"|"NoResize"|"NoMove"|"NoScrollbar"|"NoScrollWithMouse"|"NoCollapse"|"NoDecoration"|"AlwaysAutoResize"|"NoBackground"|"NoSavedSettings"|"NoMouseInputs"|"MenuBar"|"HorizontalScrollbar"|"NoFocusOnAppearing"|"NoBringToFrontOnFocus"|"AlwaysVerticalScrollbar"|"AlwaysHorizontalScrollbar"|"NoNavInputs"|"NoNavFocus"|"NoNav"|"NoInputs"|"UnsavedDocument"|"NoDocking"|"ChildWindow"|"Tooltip"|"Popup"|"Modal"|"ChildMenu"|"DockNodeHost"
---@return boolean
function imgui.Begin(name, flags) end

---##### (READ-ONLY)
---@param str_id string
---@return boolean
function imgui.BeginChild(str_id) end

---##### (READ-ONLY)
---@param str_id string
---@param size Vector2
---@return boolean
function imgui.BeginChild(str_id, size) end

---##### (READ-ONLY)
---@param str_id string
---@param size Vector2
---@param child_flags ImGuiChildFlags|integer|"None"|"Border"|"AlwaysUseWindowPadding"|"ResizeX"|"ResizeY"|"AutoResizeX"|"AutoResizeY"|"AlwaysAutoResize"|"FrameStyle"|"NavFlattened"
---@return boolean
function imgui.BeginChild(str_id, size, child_flags) end

---##### (READ-ONLY)
---@param str_id string
---@param size Vector2
---@param child_flags ImGuiChildFlags|integer|"None"|"Border"|"AlwaysUseWindowPadding"|"ResizeX"|"ResizeY"|"AutoResizeX"|"AutoResizeY"|"AlwaysAutoResize"|"FrameStyle"|"NavFlattened"
---@param window_flags ImGuiWindowFlags|integer|"None"|"NoTitleBar"|"NoResize"|"NoMove"|"NoScrollbar"|"NoScrollWithMouse"|"NoCollapse"|"NoDecoration"|"AlwaysAutoResize"|"NoBackground"|"NoSavedSettings"|"NoMouseInputs"|"MenuBar"|"HorizontalScrollbar"|"NoFocusOnAppearing"|"NoBringToFrontOnFocus"|"AlwaysVerticalScrollbar"|"AlwaysHorizontalScrollbar"|"NoNavInputs"|"NoNavFocus"|"NoNav"|"NoInputs"|"UnsavedDocument"|"NoDocking"|"ChildWindow"|"Tooltip"|"Popup"|"Modal"|"ChildMenu"|"DockNodeHost"
---@return boolean
function imgui.BeginChild(str_id, size, child_flags, window_flags) end

---##### (READ-ONLY)
---@param id integer
---@return boolean
function imgui.BeginChild(id) end

---##### (READ-ONLY)
---@param id integer
---@param size Vector2
---@return boolean
function imgui.BeginChild(id, size) end

---##### (READ-ONLY)
---@param id integer
---@param size Vector2
---@param child_flags ImGuiChildFlags|integer|"None"|"Border"|"AlwaysUseWindowPadding"|"ResizeX"|"ResizeY"|"AutoResizeX"|"AutoResizeY"|"AlwaysAutoResize"|"FrameStyle"|"NavFlattened"
---@return boolean
function imgui.BeginChild(id, size, child_flags) end

---##### (READ-ONLY)
---@param id integer
---@param size Vector2
---@param child_flags ImGuiChildFlags|integer|"None"|"Border"|"AlwaysUseWindowPadding"|"ResizeX"|"ResizeY"|"AutoResizeX"|"AutoResizeY"|"AlwaysAutoResize"|"FrameStyle"|"NavFlattened"
---@param window_flags ImGuiWindowFlags|integer|"None"|"NoTitleBar"|"NoResize"|"NoMove"|"NoScrollbar"|"NoScrollWithMouse"|"NoCollapse"|"NoDecoration"|"AlwaysAutoResize"|"NoBackground"|"NoSavedSettings"|"NoMouseInputs"|"MenuBar"|"HorizontalScrollbar"|"NoFocusOnAppearing"|"NoBringToFrontOnFocus"|"AlwaysVerticalScrollbar"|"AlwaysHorizontalScrollbar"|"NoNavInputs"|"NoNavFocus"|"NoNav"|"NoInputs"|"UnsavedDocument"|"NoDocking"|"ChildWindow"|"Tooltip"|"Popup"|"Modal"|"ChildMenu"|"DockNodeHost"
---@return boolean
function imgui.BeginChild(id, size, child_flags, window_flags) end

---##### (READ-ONLY)
---@param label string
---@param preview_value string
---@return boolean
function imgui.BeginCombo(label, preview_value) end

---##### (READ-ONLY)
---@param label string
---@param preview_value string
---@param flags ImGuiComboFlags|integer|"None"|"PopupAlignLeft"|"HeightSmall"|"HeightRegular"|"HeightLarge"|"HeightLargest"|"HeightMask"|"NoArrowButton"|"NoPreview"|"WidthFitPreview"
---@return boolean
function imgui.BeginCombo(label, preview_value, flags) end

---##### (READ-ONLY)
function imgui.BeginDisabled() end

---##### (READ-ONLY)
---@param disabled boolean
function imgui.BeginDisabled(disabled) end

---##### (READ-ONLY)
---@return boolean
function imgui.BeginDragDropSource() end

---##### (READ-ONLY)
---@param flags ImGuiDragDropFlags|integer|"None"|"SourceNoPreviewTooltip"|"SourceNoDisableHover"|"SourceNoHoldToOpenOthers"|"SourceAllowNullID"|"SourceExtern"|"PayloadAutoExpire"|"PayloadNoCrossContext"|"PayloadNoCrossProcess"|"AcceptBeforeDelivery"|"AcceptNoDrawDefaultRect"|"AcceptPeekOnly"|"AcceptNoPreviewTooltip"
---@return boolean
function imgui.BeginDragDropSource(flags) end

---##### (READ-ONLY)
---@return boolean
function imgui.BeginDragDropTarget() end

---##### (READ-ONLY)
function imgui.BeginGroup() end

---##### (READ-ONLY)
---@return boolean
function imgui.BeginItemTooltip() end

---##### (READ-ONLY)
---@param label string
---@return boolean
function imgui.BeginListBox(label) end

---##### (READ-ONLY)
---@param label string
---@param size Vector2
---@return boolean
function imgui.BeginListBox(label, size) end

---##### (READ-ONLY)
---@return boolean
function imgui.BeginMainMenuBar() end

---##### (READ-ONLY)
---@param label string
---@return boolean
function imgui.BeginMenu(label) end

---##### (READ-ONLY)
---@param label string
---@param enabled boolean
---@return boolean
function imgui.BeginMenu(label, enabled) end

---##### (READ-ONLY)
---@return boolean
function imgui.BeginMenuBar() end

---##### (READ-ONLY)
---@param flags ImGuiMultiSelectFlags|integer|"None"|"SingleSelect"|"NoSelectAll"|"NoRangeSelect"|"NoAutoSelect"|"NoAutoClear"|"NoAutoClearOnReselect"|"BoxSelect1d"|"BoxSelect2d"|"BoxSelectNoScroll"|"ClearOnEscape"|"ClearOnClickVoid"|"ScopeWindow"|"ScopeRect"|"SelectOnClick"|"SelectOnClickRelease"|"NavWrapX"
---@return ImGuiMultiSelectIOPtr
function imgui.BeginMultiSelect(flags) end

---##### (READ-ONLY)
---@param flags ImGuiMultiSelectFlags|integer|"None"|"SingleSelect"|"NoSelectAll"|"NoRangeSelect"|"NoAutoSelect"|"NoAutoClear"|"NoAutoClearOnReselect"|"BoxSelect1d"|"BoxSelect2d"|"BoxSelectNoScroll"|"ClearOnEscape"|"ClearOnClickVoid"|"ScopeWindow"|"ScopeRect"|"SelectOnClick"|"SelectOnClickRelease"|"NavWrapX"
---@param selection_size integer
---@return ImGuiMultiSelectIOPtr
function imgui.BeginMultiSelect(flags, selection_size) end

---##### (READ-ONLY)
---@param flags ImGuiMultiSelectFlags|integer|"None"|"SingleSelect"|"NoSelectAll"|"NoRangeSelect"|"NoAutoSelect"|"NoAutoClear"|"NoAutoClearOnReselect"|"BoxSelect1d"|"BoxSelect2d"|"BoxSelectNoScroll"|"ClearOnEscape"|"ClearOnClickVoid"|"ScopeWindow"|"ScopeRect"|"SelectOnClick"|"SelectOnClickRelease"|"NavWrapX"
---@param selection_size integer
---@param items_count integer
---@return ImGuiMultiSelectIOPtr
function imgui.BeginMultiSelect(flags, selection_size, items_count) end

---##### (READ-ONLY)
---@param str_id string
---@return boolean
function imgui.BeginPopup(str_id) end

---##### (READ-ONLY)
---@param str_id string
---@param flags ImGuiWindowFlags|integer|"None"|"NoTitleBar"|"NoResize"|"NoMove"|"NoScrollbar"|"NoScrollWithMouse"|"NoCollapse"|"NoDecoration"|"AlwaysAutoResize"|"NoBackground"|"NoSavedSettings"|"NoMouseInputs"|"MenuBar"|"HorizontalScrollbar"|"NoFocusOnAppearing"|"NoBringToFrontOnFocus"|"AlwaysVerticalScrollbar"|"AlwaysHorizontalScrollbar"|"NoNavInputs"|"NoNavFocus"|"NoNav"|"NoInputs"|"UnsavedDocument"|"NoDocking"|"ChildWindow"|"Tooltip"|"Popup"|"Modal"|"ChildMenu"|"DockNodeHost"
---@return boolean
function imgui.BeginPopup(str_id, flags) end

---##### (READ-ONLY)
---@return boolean
function imgui.BeginPopupContextItem() end

---##### (READ-ONLY)
---@param str_id string
---@return boolean
function imgui.BeginPopupContextItem(str_id) end

---##### (READ-ONLY)
---@param str_id string
---@param popup_flags ImGuiPopupFlags|integer|"None"|"MouseButtonLeft"|"MouseButtonRight"|"MouseButtonDefault"|"MouseButtonMiddle"|"MouseButtonMask"|"NoReopen"|"NoOpenOverExistingPopup"|"NoOpenOverItems"|"AnyPopupId"|"AnyPopupLevel"|"AnyPopup"
---@return boolean
function imgui.BeginPopupContextItem(str_id, popup_flags) end

---##### (READ-ONLY)
---@return boolean
function imgui.BeginPopupContextVoid() end

---##### (READ-ONLY)
---@param str_id string
---@return boolean
function imgui.BeginPopupContextVoid(str_id) end

---##### (READ-ONLY)
---@param str_id string
---@param popup_flags ImGuiPopupFlags|integer|"None"|"MouseButtonLeft"|"MouseButtonRight"|"MouseButtonDefault"|"MouseButtonMiddle"|"MouseButtonMask"|"NoReopen"|"NoOpenOverExistingPopup"|"NoOpenOverItems"|"AnyPopupId"|"AnyPopupLevel"|"AnyPopup"
---@return boolean
function imgui.BeginPopupContextVoid(str_id, popup_flags) end

---##### (READ-ONLY)
function imgui.BeginPopupContextWindow() end

---##### (READ-ONLY)
---@param str_id string
function imgui.BeginPopupContextWindow(str_id) end

---##### (READ-ONLY)
---@param str_id string
---@param popup_flags ImGuiPopupFlags|integer|"None"|"MouseButtonLeft"|"MouseButtonRight"|"MouseButtonDefault"|"MouseButtonMiddle"|"MouseButtonMask"|"NoReopen"|"NoOpenOverExistingPopup"|"NoOpenOverItems"|"AnyPopupId"|"AnyPopupLevel"|"AnyPopup"
function imgui.BeginPopupContextWindow(str_id, popup_flags) end

---##### (READ-ONLY)
---@param str_id string
---@param popup_flags ImGuiPopupFlags|integer|"None"|"MouseButtonLeft"|"MouseButtonRight"|"MouseButtonDefault"|"MouseButtonMiddle"|"MouseButtonMask"|"NoReopen"|"NoOpenOverExistingPopup"|"NoOpenOverItems"|"AnyPopupId"|"AnyPopupLevel"|"AnyPopup"
---@param also_over_items boolean
function imgui.BeginPopupContextWindow(str_id, popup_flags, also_over_items) end

---##### (READ-ONLY)
---@param name string
---@return boolean
function imgui.BeginPopupModal(name) end

---##### (READ-ONLY)
---@param name string
---@param p_open boolean
---@return boolean, boolean
function imgui.BeginPopupModal(name, p_open) end

---##### (READ-ONLY)
---@param name string
---@param p_open boolean
---@param flags ImGuiWindowFlags|integer|"None"|"NoTitleBar"|"NoResize"|"NoMove"|"NoScrollbar"|"NoScrollWithMouse"|"NoCollapse"|"NoDecoration"|"AlwaysAutoResize"|"NoBackground"|"NoSavedSettings"|"NoMouseInputs"|"MenuBar"|"HorizontalScrollbar"|"NoFocusOnAppearing"|"NoBringToFrontOnFocus"|"AlwaysVerticalScrollbar"|"AlwaysHorizontalScrollbar"|"NoNavInputs"|"NoNavFocus"|"NoNav"|"NoInputs"|"UnsavedDocument"|"NoDocking"|"ChildWindow"|"Tooltip"|"Popup"|"Modal"|"ChildMenu"|"DockNodeHost"
---@return boolean, boolean
function imgui.BeginPopupModal(name, p_open, flags) end

---##### (READ-ONLY)
---@param name string
---@param flags ImGuiWindowFlags|integer|"None"|"NoTitleBar"|"NoResize"|"NoMove"|"NoScrollbar"|"NoScrollWithMouse"|"NoCollapse"|"NoDecoration"|"AlwaysAutoResize"|"NoBackground"|"NoSavedSettings"|"NoMouseInputs"|"MenuBar"|"HorizontalScrollbar"|"NoFocusOnAppearing"|"NoBringToFrontOnFocus"|"AlwaysVerticalScrollbar"|"AlwaysHorizontalScrollbar"|"NoNavInputs"|"NoNavFocus"|"NoNav"|"NoInputs"|"UnsavedDocument"|"NoDocking"|"ChildWindow"|"Tooltip"|"Popup"|"Modal"|"ChildMenu"|"DockNodeHost"
---@return boolean
function imgui.BeginPopupModal(name, flags) end

---##### (READ-ONLY)
---@param str_id string
---@return boolean
function imgui.BeginTabBar(str_id) end

---##### (READ-ONLY)
---@param str_id string
---@param flags ImGuiTabBarFlags|integer|"None"|"Reorderable"|"AutoSelectNewTabs"|"TabListPopupButton"|"NoCloseWithMiddleMouseButton"|"NoTabListScrollingButtons"|"NoTooltip"|"DrawSelectedOverline"|"FittingPolicyResizeDown"|"FittingPolicyDefault"|"FittingPolicyScroll"|"FittingPolicyMask"
---@return boolean
function imgui.BeginTabBar(str_id, flags) end

---##### (READ-ONLY)
---@param label string
---@return boolean
function imgui.BeginTabItem(label) end

---##### (READ-ONLY)
---@param label string
---@param p_open boolean
---@return boolean, boolean
function imgui.BeginTabItem(label, p_open) end

---##### (READ-ONLY)
---@param label string
---@param p_open boolean
---@param flags ImGuiTabItemFlags|integer|"None"|"UnsavedDocument"|"SetSelected"|"NoCloseWithMiddleMouseButton"|"NoPushId"|"NoTooltip"|"NoReorder"|"Leading"|"Trailing"|"NoAssumedClosure"
---@return boolean, boolean
function imgui.BeginTabItem(label, p_open, flags) end

---##### (READ-ONLY)
---@param str_id string
---@param columns integer
---@return boolean
function imgui.BeginTable(str_id, columns) end

---##### (READ-ONLY)
---@param str_id string
---@param columns integer
---@param flags ImGuiTableFlags|integer|"None"|"Resizable"|"Reorderable"|"Hideable"|"Sortable"|"NoSavedSettings"|"ContextMenuInBody"|"RowBg"|"BordersInnerH"|"BordersOuterH"|"BordersH"|"BordersInnerV"|"BordersInner"|"BordersOuterV"|"BordersOuter"|"BordersV"|"Borders"|"NoBordersInBody"|"NoBordersInBodyUntilResize"|"SizingFixedFit"|"SizingFixedSame"|"SizingStretchProp"|"SizingStretchSame"|"SizingMask"|"NoHostExtendX"|"NoHostExtendY"|"NoKeepColumnsVisible"|"PreciseWidths"|"NoClip"|"PadOuterX"|"NoPadOuterX"|"NoPadInnerX"|"ScrollX"|"ScrollY"|"SortMulti"|"SortTristate"|"HighlightHoveredColumn"
---@return boolean
function imgui.BeginTable(str_id, columns, flags) end

---##### (READ-ONLY)
---@param str_id string
---@param columns integer
---@param flags ImGuiTableFlags|integer|"None"|"Resizable"|"Reorderable"|"Hideable"|"Sortable"|"NoSavedSettings"|"ContextMenuInBody"|"RowBg"|"BordersInnerH"|"BordersOuterH"|"BordersH"|"BordersInnerV"|"BordersInner"|"BordersOuterV"|"BordersOuter"|"BordersV"|"Borders"|"NoBordersInBody"|"NoBordersInBodyUntilResize"|"SizingFixedFit"|"SizingFixedSame"|"SizingStretchProp"|"SizingStretchSame"|"SizingMask"|"NoHostExtendX"|"NoHostExtendY"|"NoKeepColumnsVisible"|"PreciseWidths"|"NoClip"|"PadOuterX"|"NoPadOuterX"|"NoPadInnerX"|"ScrollX"|"ScrollY"|"SortMulti"|"SortTristate"|"HighlightHoveredColumn"
---@param outer_size Vector2
---@return boolean
function imgui.BeginTable(str_id, columns, flags, outer_size) end

---##### (READ-ONLY)
---@param str_id string
---@param columns integer
---@param flags ImGuiTableFlags|integer|"None"|"Resizable"|"Reorderable"|"Hideable"|"Sortable"|"NoSavedSettings"|"ContextMenuInBody"|"RowBg"|"BordersInnerH"|"BordersOuterH"|"BordersH"|"BordersInnerV"|"BordersInner"|"BordersOuterV"|"BordersOuter"|"BordersV"|"Borders"|"NoBordersInBody"|"NoBordersInBodyUntilResize"|"SizingFixedFit"|"SizingFixedSame"|"SizingStretchProp"|"SizingStretchSame"|"SizingMask"|"NoHostExtendX"|"NoHostExtendY"|"NoKeepColumnsVisible"|"PreciseWidths"|"NoClip"|"PadOuterX"|"NoPadOuterX"|"NoPadInnerX"|"ScrollX"|"ScrollY"|"SortMulti"|"SortTristate"|"HighlightHoveredColumn"
---@param outer_size Vector2
---@param inner_width number
---@return boolean
function imgui.BeginTable(str_id, columns, flags, outer_size, inner_width) end

---##### (READ-ONLY)
---@return boolean
function imgui.BeginTooltip() end

---##### (READ-ONLY)
function imgui.Bullet() end

---##### (READ-ONLY)
---@param fmt string
function imgui.BulletText(fmt) end

---##### (READ-ONLY)
---@param label string
---@return boolean
function imgui.Button(label) end

---##### (READ-ONLY)
---@param label string
---@param size Vector2
---@return boolean
function imgui.Button(label, size) end

---##### (READ-ONLY)
---@return number
function imgui.CalcItemWidth() end

---##### (READ-ONLY)
---@param text string
---@return Vector2
function imgui.CalcTextSize(text) end

---##### (READ-ONLY)
---@param text string
---@param hide_text_after_double_hash boolean
---@return Vector2
function imgui.CalcTextSize(text, hide_text_after_double_hash) end

---##### (READ-ONLY)
---@param text string
---@param hide_text_after_double_hash boolean
---@param wrap_width number
---@return Vector2
function imgui.CalcTextSize(text, hide_text_after_double_hash, wrap_width) end

---##### (READ-ONLY)
---@param text string
---@param start integer
---@return Vector2
function imgui.CalcTextSize(text, start) end

---##### (READ-ONLY)
---@param text string
---@param wrapWidth number
---@return Vector2
function imgui.CalcTextSize(text, wrapWidth) end

---##### (READ-ONLY)
---@param text string
---@param start integer
---@param length integer
---@return Vector2
function imgui.CalcTextSize(text, start, length) end

---##### (READ-ONLY)
---@param text string
---@param start integer
---@param hideTextAfterDoubleHash boolean
---@return Vector2
function imgui.CalcTextSize(text, start, hideTextAfterDoubleHash) end

---##### (READ-ONLY)
---@param text string
---@param start integer
---@param wrapWidth number
---@return Vector2
function imgui.CalcTextSize(text, start, wrapWidth) end

---##### (READ-ONLY)
---@param text string
---@param start integer
---@param length integer
---@param hideTextAfterDoubleHash boolean
---@return Vector2
function imgui.CalcTextSize(text, start, length, hideTextAfterDoubleHash) end

---##### (READ-ONLY)
---@param text string
---@param start integer
---@param length integer
---@param wrapWidth number
---@return Vector2
function imgui.CalcTextSize(text, start, length, wrapWidth) end

---##### (READ-ONLY)
---@param text string
---@param start integer
---@param length integer
---@param hideTextAfterDoubleHash boolean
---@param wrapWidth number
---@return Vector2
function imgui.CalcTextSize(text, start, length, hideTextAfterDoubleHash, wrapWidth) end

---##### (READ-ONLY)
---@param label string
---@param v boolean
---@return boolean, boolean
function imgui.Checkbox(label, v) end

---##### (READ-ONLY)
---@param label string
---@param flags integer
---@param flags_value integer
---@return boolean, integer
function imgui.CheckboxFlags(label, flags, flags_value) end

---##### (READ-ONLY)
---@param label string
---@param flags integer
---@param flags_value integer
---@return boolean, integer
function imgui.CheckboxFlags(label, flags, flags_value) end

---##### (READ-ONLY)
function imgui.CloseCurrentPopup() end

---##### (READ-ONLY)
---@param label string
---@return boolean
function imgui.CollapsingHeader(label) end

---##### (READ-ONLY)
---@param label string
---@param flags ImGuiTreeNodeFlags|integer|"None"|"Selected"|"Framed"|"AllowOverlap"|"NoTreePushOnOpen"|"NoAutoOpenOnLog"|"CollapsingHeader"|"DefaultOpen"|"OpenOnDoubleClick"|"OpenOnArrow"|"Leaf"|"Bullet"|"FramePadding"|"SpanAvailWidth"|"SpanFullWidth"|"SpanTextWidth"|"SpanAllColumns"|"NavLeftJumpsBackHere"
---@return boolean
function imgui.CollapsingHeader(label, flags) end

---##### (READ-ONLY)
---@param label string
---@param p_visible boolean
---@return boolean, boolean
function imgui.CollapsingHeader(label, p_visible) end

---##### (READ-ONLY)
---@param label string
---@param p_visible boolean
---@param flags ImGuiTreeNodeFlags|integer|"None"|"Selected"|"Framed"|"AllowOverlap"|"NoTreePushOnOpen"|"NoAutoOpenOnLog"|"CollapsingHeader"|"DefaultOpen"|"OpenOnDoubleClick"|"OpenOnArrow"|"Leaf"|"Bullet"|"FramePadding"|"SpanAvailWidth"|"SpanFullWidth"|"SpanTextWidth"|"SpanAllColumns"|"NavLeftJumpsBackHere"
---@return boolean, boolean
function imgui.CollapsingHeader(label, p_visible, flags) end

---##### (READ-ONLY)
---@param desc_id string
---@param col Vector4
---@return boolean
function imgui.ColorButton(desc_id, col) end

---##### (READ-ONLY)
---@param desc_id string
---@param col Vector4
---@param flags ImGuiColorEditFlags|integer|"None"|"NoAlpha"|"NoPicker"|"NoOptions"|"NoSmallPreview"|"NoInputs"|"NoTooltip"|"NoLabel"|"NoSidePreview"|"NoDragDrop"|"NoBorder"|"AlphaBar"|"AlphaPreview"|"AlphaPreviewHalf"|"HDR"|"DisplayRGB"|"DisplayHSV"|"DisplayHex"|"DisplayMask"|"Uint8"|"Float"|"DataTypeMask"|"PickerHueBar"|"PickerHueWheel"|"PickerMask"|"InputRGB"|"DefaultOptions"|"InputHSV"|"InputMask"
---@return boolean
function imgui.ColorButton(desc_id, col, flags) end

---##### (READ-ONLY)
---@param desc_id string
---@param col Vector4
---@param flags ImGuiColorEditFlags|integer|"None"|"NoAlpha"|"NoPicker"|"NoOptions"|"NoSmallPreview"|"NoInputs"|"NoTooltip"|"NoLabel"|"NoSidePreview"|"NoDragDrop"|"NoBorder"|"AlphaBar"|"AlphaPreview"|"AlphaPreviewHalf"|"HDR"|"DisplayRGB"|"DisplayHSV"|"DisplayHex"|"DisplayMask"|"Uint8"|"Float"|"DataTypeMask"|"PickerHueBar"|"PickerHueWheel"|"PickerMask"|"InputRGB"|"DefaultOptions"|"InputHSV"|"InputMask"
---@param size Vector2
---@return boolean
function imgui.ColorButton(desc_id, col, flags, size) end

---##### (READ-ONLY)
---@param input Vector4
---@return integer
function imgui.ColorConvertFloat4ToU32(input) end

---##### (READ-ONLY)
---@param h number
---@param s number
---@param v number
---@param out_r number
---@param out_g number
---@param out_b number
function imgui.ColorConvertHSVtoRGB(h, s, v, out_r, out_g, out_b) end

---##### (READ-ONLY)
---@param r number
---@param g number
---@param b number
---@param out_h number
---@param out_s number
---@param out_v number
function imgui.ColorConvertRGBtoHSV(r, g, b, out_h, out_s, out_v) end

---##### (READ-ONLY)
---@param input integer
---@return Vector4
function imgui.ColorConvertU32ToFloat4(input) end

---##### (READ-ONLY)
---@param label string
---@param col Vector3
---@return boolean, Vector3
function imgui.ColorEdit3(label, col) end

---##### (READ-ONLY)
---@param label string
---@param col Vector3
---@param flags ImGuiColorEditFlags|integer|"None"|"NoAlpha"|"NoPicker"|"NoOptions"|"NoSmallPreview"|"NoInputs"|"NoTooltip"|"NoLabel"|"NoSidePreview"|"NoDragDrop"|"NoBorder"|"AlphaBar"|"AlphaPreview"|"AlphaPreviewHalf"|"HDR"|"DisplayRGB"|"DisplayHSV"|"DisplayHex"|"DisplayMask"|"Uint8"|"Float"|"DataTypeMask"|"PickerHueBar"|"PickerHueWheel"|"PickerMask"|"InputRGB"|"DefaultOptions"|"InputHSV"|"InputMask"
---@return boolean, Vector3
function imgui.ColorEdit3(label, col, flags) end

---##### (READ-ONLY)
---@param label string
---@param col Vector4
---@return boolean, Vector4
function imgui.ColorEdit4(label, col) end

---##### (READ-ONLY)
---@param label string
---@param col Vector4
---@param flags ImGuiColorEditFlags|integer|"None"|"NoAlpha"|"NoPicker"|"NoOptions"|"NoSmallPreview"|"NoInputs"|"NoTooltip"|"NoLabel"|"NoSidePreview"|"NoDragDrop"|"NoBorder"|"AlphaBar"|"AlphaPreview"|"AlphaPreviewHalf"|"HDR"|"DisplayRGB"|"DisplayHSV"|"DisplayHex"|"DisplayMask"|"Uint8"|"Float"|"DataTypeMask"|"PickerHueBar"|"PickerHueWheel"|"PickerMask"|"InputRGB"|"DefaultOptions"|"InputHSV"|"InputMask"
---@return boolean, Vector4
function imgui.ColorEdit4(label, col, flags) end

---##### (READ-ONLY)
---@param label string
---@param col Vector3
---@return boolean, Vector3
function imgui.ColorPicker3(label, col) end

---##### (READ-ONLY)
---@param label string
---@param col Vector3
---@param flags ImGuiColorEditFlags|integer|"None"|"NoAlpha"|"NoPicker"|"NoOptions"|"NoSmallPreview"|"NoInputs"|"NoTooltip"|"NoLabel"|"NoSidePreview"|"NoDragDrop"|"NoBorder"|"AlphaBar"|"AlphaPreview"|"AlphaPreviewHalf"|"HDR"|"DisplayRGB"|"DisplayHSV"|"DisplayHex"|"DisplayMask"|"Uint8"|"Float"|"DataTypeMask"|"PickerHueBar"|"PickerHueWheel"|"PickerMask"|"InputRGB"|"DefaultOptions"|"InputHSV"|"InputMask"
---@return boolean, Vector3
function imgui.ColorPicker3(label, col, flags) end

---##### (READ-ONLY)
---@param label string
---@param col Vector4
---@return boolean, Vector4
function imgui.ColorPicker4(label, col) end

---##### (READ-ONLY)
---@param label string
---@param col Vector4
---@param flags ImGuiColorEditFlags|integer|"None"|"NoAlpha"|"NoPicker"|"NoOptions"|"NoSmallPreview"|"NoInputs"|"NoTooltip"|"NoLabel"|"NoSidePreview"|"NoDragDrop"|"NoBorder"|"AlphaBar"|"AlphaPreview"|"AlphaPreviewHalf"|"HDR"|"DisplayRGB"|"DisplayHSV"|"DisplayHex"|"DisplayMask"|"Uint8"|"Float"|"DataTypeMask"|"PickerHueBar"|"PickerHueWheel"|"PickerMask"|"InputRGB"|"DefaultOptions"|"InputHSV"|"InputMask"
---@return boolean, Vector4
function imgui.ColorPicker4(label, col, flags) end

---##### (READ-ONLY)
---@param label string
---@param col Vector4
---@param flags ImGuiColorEditFlags|integer|"None"|"NoAlpha"|"NoPicker"|"NoOptions"|"NoSmallPreview"|"NoInputs"|"NoTooltip"|"NoLabel"|"NoSidePreview"|"NoDragDrop"|"NoBorder"|"AlphaBar"|"AlphaPreview"|"AlphaPreviewHalf"|"HDR"|"DisplayRGB"|"DisplayHSV"|"DisplayHex"|"DisplayMask"|"Uint8"|"Float"|"DataTypeMask"|"PickerHueBar"|"PickerHueWheel"|"PickerMask"|"InputRGB"|"DefaultOptions"|"InputHSV"|"InputMask"
---@param ref_col number
---@return boolean, Vector4, number
function imgui.ColorPicker4(label, col, flags, ref_col) end

---##### (READ-ONLY)
function imgui.Columns() end

---##### (READ-ONLY)
---@param count integer
function imgui.Columns(count) end

---##### (READ-ONLY)
---@param count integer
---@param id string
function imgui.Columns(count, id) end

---##### (READ-ONLY)
---@param count integer
---@param id string
---@param border boolean
function imgui.Columns(count, id, border) end

---##### (READ-ONLY)
---@param label string
---@param current_item integer
---@param items string[]
---@param items_count integer
---@return boolean, integer
function imgui.Combo(label, current_item, items, items_count) end

---##### (READ-ONLY)
---@param label string
---@param current_item integer
---@param items string[]
---@param items_count integer
---@param popup_max_height_in_items integer
---@return boolean, integer
function imgui.Combo(label, current_item, items, items_count, popup_max_height_in_items) end

---##### (READ-ONLY)
---@param label string
---@param current_item integer
---@param items_separated_by_zeros string
---@return boolean, integer
function imgui.Combo(label, current_item, items_separated_by_zeros) end

---##### (READ-ONLY)
---@param label string
---@param current_item integer
---@param items_separated_by_zeros string
---@param popup_max_height_in_items integer
---@return boolean, integer
function imgui.Combo(label, current_item, items_separated_by_zeros, popup_max_height_in_items) end

---##### (READ-ONLY)
---@return lightuserdata
function imgui.CreateContext() end

---##### (READ-ONLY)
---@param shared_font_atlas ImFontAtlasPtr
---@return lightuserdata
function imgui.CreateContext(shared_font_atlas) end

---##### (READ-ONLY)
---@param values any[]
---@return any
function imgui.CreateVector2(values) end

---##### (READ-ONLY)
---@param values any[]
---@return any
function imgui.CreateVector3(values) end

---##### (READ-ONLY)
---@param values any[]
---@return any
function imgui.CreateVector4(values) end

---##### (READ-ONLY)
---@param version_str string
---@param sz_io integer
---@param sz_style integer
---@param sz_vec2 integer
---@param sz_vec4 integer
---@param sz_drawvert integer
---@param sz_drawidx integer
---@return boolean
function imgui.DebugCheckVersionAndDataLayout(version_str, sz_io, sz_style, sz_vec2, sz_vec4, sz_drawvert, sz_drawidx) end

---##### (READ-ONLY)
---@param idx ImGuiCol|0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|"Text"|"TextDisabled"|"WindowBg"|"ChildBg"|"PopupBg"|"Border"|"BorderShadow"|"FrameBg"|"FrameBgHovered"|"FrameBgActive"|"TitleBg"|"TitleBgActive"|"TitleBgCollapsed"|"MenuBarBg"|"ScrollbarBg"|"ScrollbarGrab"|"ScrollbarGrabHovered"|"ScrollbarGrabActive"|"CheckMark"|"SliderGrab"|"SliderGrabActive"|"Button"|"ButtonHovered"|"ButtonActive"|"Header"|"HeaderHovered"|"HeaderActive"|"Separator"|"SeparatorHovered"|"SeparatorActive"|"ResizeGrip"|"ResizeGripHovered"|"ResizeGripActive"|"TabHovered"|"Tab"|"TabSelected"|"TabSelectedOverline"|"TabDimmed"|"TabDimmedSelected"|"TabDimmedSelectedOverline"|"DockingPreview"|"DockingEmptyBg"|"PlotLines"|"PlotLinesHovered"|"PlotHistogram"|"PlotHistogramHovered"|"TableHeaderBg"|"TableBorderStrong"|"TableBorderLight"|"TableRowBg"|"TableRowBgAlt"|"TextLink"|"TextSelectedBg"|"DragDropTarget"|"NavHighlight"|"NavWindowingHighlight"|"NavWindowingDimBg"|"ModalWindowDimBg"|"COUNT"
function imgui.DebugFlashStyleColor(idx) end

---##### (READ-ONLY)
---@param fmt string
function imgui.DebugLog(fmt) end

---##### (READ-ONLY)
function imgui.DebugStartItemPicker() end

---##### (READ-ONLY)
---@param text string
function imgui.DebugTextEncoding(text) end

---##### (READ-ONLY)
function imgui.DestroyContext() end

---##### (READ-ONLY)
---@param ctx lightuserdata
function imgui.DestroyContext(ctx) end

---##### (READ-ONLY)
function imgui.DestroyPlatformWindows() end

---##### (READ-ONLY)
---@param dockspace_id integer
---@return integer
function imgui.DockSpace(dockspace_id) end

---##### (READ-ONLY)
---@param dockspace_id integer
---@param size Vector2
---@return integer
function imgui.DockSpace(dockspace_id, size) end

---##### (READ-ONLY)
---@param dockspace_id integer
---@param size Vector2
---@param flags ImGuiDockNodeFlags|integer|"None"|"KeepAliveOnly"|"NoDockingOverCentralNode"|"PassthruCentralNode"|"NoDockingSplit"|"NoResize"|"AutoHideTabBar"|"NoUndocking"
---@return integer
function imgui.DockSpace(dockspace_id, size, flags) end

---##### (READ-ONLY)
---@param dockspace_id integer
---@param size Vector2
---@param flags ImGuiDockNodeFlags|integer|"None"|"KeepAliveOnly"|"NoDockingOverCentralNode"|"PassthruCentralNode"|"NoDockingSplit"|"NoResize"|"AutoHideTabBar"|"NoUndocking"
---@param window_class ImGuiWindowClassPtr
---@return integer
function imgui.DockSpace(dockspace_id, size, flags, window_class) end

---##### (READ-ONLY)
---@return integer
function imgui.DockSpaceOverViewport() end

---##### (READ-ONLY)
---@param dockspace_id integer
---@return integer
function imgui.DockSpaceOverViewport(dockspace_id) end

---##### (READ-ONLY)
---@param dockspace_id integer
---@param viewport ImGuiViewportPtr
---@return integer
function imgui.DockSpaceOverViewport(dockspace_id, viewport) end

---##### (READ-ONLY)
---@param dockspace_id integer
---@param viewport ImGuiViewportPtr
---@param flags ImGuiDockNodeFlags|integer|"None"|"KeepAliveOnly"|"NoDockingOverCentralNode"|"PassthruCentralNode"|"NoDockingSplit"|"NoResize"|"AutoHideTabBar"|"NoUndocking"
---@return integer
function imgui.DockSpaceOverViewport(dockspace_id, viewport, flags) end

---##### (READ-ONLY)
---@param dockspace_id integer
---@param viewport ImGuiViewportPtr
---@param flags ImGuiDockNodeFlags|integer|"None"|"KeepAliveOnly"|"NoDockingOverCentralNode"|"PassthruCentralNode"|"NoDockingSplit"|"NoResize"|"AutoHideTabBar"|"NoUndocking"
---@param window_class ImGuiWindowClassPtr
---@return integer
function imgui.DockSpaceOverViewport(dockspace_id, viewport, flags, window_class) end

---##### (READ-ONLY)
---@param label string
---@param v number
---@return boolean, number
function imgui.DragFloat(label, v) end

---##### (READ-ONLY)
---@param label string
---@param v number
---@param v_speed number
---@return boolean, number
function imgui.DragFloat(label, v, v_speed) end

---##### (READ-ONLY)
---@param label string
---@param v number
---@param v_speed number
---@param v_min number
---@return boolean, number
function imgui.DragFloat(label, v, v_speed, v_min) end

---##### (READ-ONLY)
---@param label string
---@param v number
---@param v_speed number
---@param v_min number
---@param v_max number
---@return boolean, number
function imgui.DragFloat(label, v, v_speed, v_min, v_max) end

---##### (READ-ONLY)
---@param label string
---@param v number
---@param v_speed number
---@param v_min number
---@param v_max number
---@param format string
---@return boolean, number
function imgui.DragFloat(label, v, v_speed, v_min, v_max, format) end

---##### (READ-ONLY)
---@param label string
---@param v number
---@param v_speed number
---@param v_min number
---@param v_max number
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, number
function imgui.DragFloat(label, v, v_speed, v_min, v_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v Vector2
---@return boolean, Vector2
function imgui.DragFloat2(label, v) end

---##### (READ-ONLY)
---@param label string
---@param v Vector2
---@param v_speed number
---@return boolean, Vector2
function imgui.DragFloat2(label, v, v_speed) end

---##### (READ-ONLY)
---@param label string
---@param v Vector2
---@param v_speed number
---@param v_min number
---@return boolean, Vector2
function imgui.DragFloat2(label, v, v_speed, v_min) end

---##### (READ-ONLY)
---@param label string
---@param v Vector2
---@param v_speed number
---@param v_min number
---@param v_max number
---@return boolean, Vector2
function imgui.DragFloat2(label, v, v_speed, v_min, v_max) end

---##### (READ-ONLY)
---@param label string
---@param v Vector2
---@param v_speed number
---@param v_min number
---@param v_max number
---@param format string
---@return boolean, Vector2
function imgui.DragFloat2(label, v, v_speed, v_min, v_max, format) end

---##### (READ-ONLY)
---@param label string
---@param v Vector2
---@param v_speed number
---@param v_min number
---@param v_max number
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, Vector2
function imgui.DragFloat2(label, v, v_speed, v_min, v_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v Vector3
---@return boolean, Vector3
function imgui.DragFloat3(label, v) end

---##### (READ-ONLY)
---@param label string
---@param v Vector3
---@param v_speed number
---@return boolean, Vector3
function imgui.DragFloat3(label, v, v_speed) end

---##### (READ-ONLY)
---@param label string
---@param v Vector3
---@param v_speed number
---@param v_min number
---@return boolean, Vector3
function imgui.DragFloat3(label, v, v_speed, v_min) end

---##### (READ-ONLY)
---@param label string
---@param v Vector3
---@param v_speed number
---@param v_min number
---@param v_max number
---@return boolean, Vector3
function imgui.DragFloat3(label, v, v_speed, v_min, v_max) end

---##### (READ-ONLY)
---@param label string
---@param v Vector3
---@param v_speed number
---@param v_min number
---@param v_max number
---@param format string
---@return boolean, Vector3
function imgui.DragFloat3(label, v, v_speed, v_min, v_max, format) end

---##### (READ-ONLY)
---@param label string
---@param v Vector3
---@param v_speed number
---@param v_min number
---@param v_max number
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, Vector3
function imgui.DragFloat3(label, v, v_speed, v_min, v_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v Vector4
---@return boolean, Vector4
function imgui.DragFloat4(label, v) end

---##### (READ-ONLY)
---@param label string
---@param v Vector4
---@param v_speed number
---@return boolean, Vector4
function imgui.DragFloat4(label, v, v_speed) end

---##### (READ-ONLY)
---@param label string
---@param v Vector4
---@param v_speed number
---@param v_min number
---@return boolean, Vector4
function imgui.DragFloat4(label, v, v_speed, v_min) end

---##### (READ-ONLY)
---@param label string
---@param v Vector4
---@param v_speed number
---@param v_min number
---@param v_max number
---@return boolean, Vector4
function imgui.DragFloat4(label, v, v_speed, v_min, v_max) end

---##### (READ-ONLY)
---@param label string
---@param v Vector4
---@param v_speed number
---@param v_min number
---@param v_max number
---@param format string
---@return boolean, Vector4
function imgui.DragFloat4(label, v, v_speed, v_min, v_max, format) end

---##### (READ-ONLY)
---@param label string
---@param v Vector4
---@param v_speed number
---@param v_min number
---@param v_max number
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, Vector4
function imgui.DragFloat4(label, v, v_speed, v_min, v_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v_current_min number
---@param v_current_max number
---@return boolean, number, number
function imgui.DragFloatRange2(label, v_current_min, v_current_max) end

---##### (READ-ONLY)
---@param label string
---@param v_current_min number
---@param v_current_max number
---@param v_speed number
---@return boolean, number, number
function imgui.DragFloatRange2(label, v_current_min, v_current_max, v_speed) end

---##### (READ-ONLY)
---@param label string
---@param v_current_min number
---@param v_current_max number
---@param v_speed number
---@param v_min number
---@return boolean, number, number
function imgui.DragFloatRange2(label, v_current_min, v_current_max, v_speed, v_min) end

---##### (READ-ONLY)
---@param label string
---@param v_current_min number
---@param v_current_max number
---@param v_speed number
---@param v_min number
---@param v_max number
---@return boolean, number, number
function imgui.DragFloatRange2(label, v_current_min, v_current_max, v_speed, v_min, v_max) end

---##### (READ-ONLY)
---@param label string
---@param v_current_min number
---@param v_current_max number
---@param v_speed number
---@param v_min number
---@param v_max number
---@param format string
---@return boolean, number, number
function imgui.DragFloatRange2(label, v_current_min, v_current_max, v_speed, v_min, v_max, format) end

---##### (READ-ONLY)
---@param label string
---@param v_current_min number
---@param v_current_max number
---@param v_speed number
---@param v_min number
---@param v_max number
---@param format string
---@param format_max string
---@return boolean, number, number
function imgui.DragFloatRange2(label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max) end

---##### (READ-ONLY)
---@param label string
---@param v_current_min number
---@param v_current_max number
---@param v_speed number
---@param v_min number
---@param v_max number
---@param format string
---@param format_max string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, number, number
function imgui.DragFloatRange2(label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max, flags) end

---##### (READ-ONLY)
---@param label string
---@param v integer
---@return boolean, integer
function imgui.DragInt(label, v) end

---##### (READ-ONLY)
---@param label string
---@param v integer
---@param v_speed number
---@return boolean, integer
function imgui.DragInt(label, v, v_speed) end

---##### (READ-ONLY)
---@param label string
---@param v integer
---@param v_speed number
---@param v_min integer
---@return boolean, integer
function imgui.DragInt(label, v, v_speed, v_min) end

---##### (READ-ONLY)
---@param label string
---@param v integer
---@param v_speed number
---@param v_min integer
---@param v_max integer
---@return boolean, integer
function imgui.DragInt(label, v, v_speed, v_min, v_max) end

---##### (READ-ONLY)
---@param label string
---@param v integer
---@param v_speed number
---@param v_min integer
---@param v_max integer
---@param format string
---@return boolean, integer
function imgui.DragInt(label, v, v_speed, v_min, v_max, format) end

---##### (READ-ONLY)
---@param label string
---@param v integer
---@param v_speed number
---@param v_min integer
---@param v_max integer
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, integer
function imgui.DragInt(label, v, v_speed, v_min, v_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@return boolean, integer[]
function imgui.DragInt2(label, v) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param v_speed number
---@return boolean, integer[]
function imgui.DragInt2(label, v, v_speed) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param v_speed number
---@param v_min integer
---@return boolean, integer[]
function imgui.DragInt2(label, v, v_speed, v_min) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param v_speed number
---@param v_min integer
---@param v_max integer
---@return boolean, integer[]
function imgui.DragInt2(label, v, v_speed, v_min, v_max) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param v_speed number
---@param v_min integer
---@param v_max integer
---@param format string
---@return boolean, integer[]
function imgui.DragInt2(label, v, v_speed, v_min, v_max, format) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param v_speed number
---@param v_min integer
---@param v_max integer
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, integer[]
function imgui.DragInt2(label, v, v_speed, v_min, v_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v Vector2
---@param v_speed number
---@return boolean, Vector2
function imgui.DragInt2(label, v, v_speed) end

---##### (READ-ONLY)
---@param label string
---@param v Vector2
---@param v_speed number
---@param v_min integer
---@return boolean, Vector2
function imgui.DragInt2(label, v, v_speed, v_min) end

---##### (READ-ONLY)
---@param label string
---@param v Vector2
---@param v_speed number
---@param v_min integer
---@param v_max integer
---@return boolean, Vector2
function imgui.DragInt2(label, v, v_speed, v_min, v_max) end

---##### (READ-ONLY)
---@param label string
---@param v Vector2
---@param v_speed number
---@param v_min integer
---@param v_max integer
---@param format string
---@return boolean, Vector2
function imgui.DragInt2(label, v, v_speed, v_min, v_max, format) end

---##### (READ-ONLY)
---@param label string
---@param v Vector2
---@param v_speed number
---@param v_min integer
---@param v_max integer
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, Vector2
function imgui.DragInt2(label, v, v_speed, v_min, v_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@return boolean, integer[]
function imgui.DragInt3(label, v) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param v_speed number
---@return boolean, integer[]
function imgui.DragInt3(label, v, v_speed) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param v_speed number
---@param v_min integer
---@return boolean, integer[]
function imgui.DragInt3(label, v, v_speed, v_min) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param v_speed number
---@param v_min integer
---@param v_max integer
---@return boolean, integer[]
function imgui.DragInt3(label, v, v_speed, v_min, v_max) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param v_speed number
---@param v_min integer
---@param v_max integer
---@param format string
---@return boolean, integer[]
function imgui.DragInt3(label, v, v_speed, v_min, v_max, format) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param v_speed number
---@param v_min integer
---@param v_max integer
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, integer[]
function imgui.DragInt3(label, v, v_speed, v_min, v_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v Vector3
---@param v_speed number
---@return boolean, Vector3
function imgui.DragInt3(label, v, v_speed) end

---##### (READ-ONLY)
---@param label string
---@param v Vector3
---@param v_speed number
---@param v_min integer
---@return boolean, Vector3
function imgui.DragInt3(label, v, v_speed, v_min) end

---##### (READ-ONLY)
---@param label string
---@param v Vector3
---@param v_speed number
---@param v_min integer
---@param v_max integer
---@return boolean, Vector3
function imgui.DragInt3(label, v, v_speed, v_min, v_max) end

---##### (READ-ONLY)
---@param label string
---@param v Vector3
---@param v_speed number
---@param v_min integer
---@param v_max integer
---@param format string
---@return boolean, Vector3
function imgui.DragInt3(label, v, v_speed, v_min, v_max, format) end

---##### (READ-ONLY)
---@param label string
---@param v Vector3
---@param v_speed number
---@param v_min integer
---@param v_max integer
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, Vector3
function imgui.DragInt3(label, v, v_speed, v_min, v_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@return boolean, integer[]
function imgui.DragInt4(label, v) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param v_speed number
---@return boolean, integer[]
function imgui.DragInt4(label, v, v_speed) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param v_speed number
---@param v_min integer
---@return boolean, integer[]
function imgui.DragInt4(label, v, v_speed, v_min) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param v_speed number
---@param v_min integer
---@param v_max integer
---@return boolean, integer[]
function imgui.DragInt4(label, v, v_speed, v_min, v_max) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param v_speed number
---@param v_min integer
---@param v_max integer
---@param format string
---@return boolean, integer[]
function imgui.DragInt4(label, v, v_speed, v_min, v_max, format) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param v_speed number
---@param v_min integer
---@param v_max integer
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, integer[]
function imgui.DragInt4(label, v, v_speed, v_min, v_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v Vector4
---@param v_speed number
---@return boolean, Vector4
function imgui.DragInt4(label, v, v_speed) end

---##### (READ-ONLY)
---@param label string
---@param v Vector4
---@param v_speed number
---@param v_min integer
---@return boolean, Vector4
function imgui.DragInt4(label, v, v_speed, v_min) end

---##### (READ-ONLY)
---@param label string
---@param v Vector4
---@param v_speed number
---@param v_min integer
---@param v_max integer
---@return boolean, Vector4
function imgui.DragInt4(label, v, v_speed, v_min, v_max) end

---##### (READ-ONLY)
---@param label string
---@param v Vector4
---@param v_speed number
---@param v_min integer
---@param v_max integer
---@param format string
---@return boolean, Vector4
function imgui.DragInt4(label, v, v_speed, v_min, v_max, format) end

---##### (READ-ONLY)
---@param label string
---@param v Vector4
---@param v_speed number
---@param v_min integer
---@param v_max integer
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, Vector4
function imgui.DragInt4(label, v, v_speed, v_min, v_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v_current_min integer
---@param v_current_max integer
---@return boolean, integer, integer
function imgui.DragIntRange2(label, v_current_min, v_current_max) end

---##### (READ-ONLY)
---@param label string
---@param v_current_min integer
---@param v_current_max integer
---@param v_speed number
---@return boolean, integer, integer
function imgui.DragIntRange2(label, v_current_min, v_current_max, v_speed) end

---##### (READ-ONLY)
---@param label string
---@param v_current_min integer
---@param v_current_max integer
---@param v_speed number
---@param v_min integer
---@return boolean, integer, integer
function imgui.DragIntRange2(label, v_current_min, v_current_max, v_speed, v_min) end

---##### (READ-ONLY)
---@param label string
---@param v_current_min integer
---@param v_current_max integer
---@param v_speed number
---@param v_min integer
---@param v_max integer
---@return boolean, integer, integer
function imgui.DragIntRange2(label, v_current_min, v_current_max, v_speed, v_min, v_max) end

---##### (READ-ONLY)
---@param label string
---@param v_current_min integer
---@param v_current_max integer
---@param v_speed number
---@param v_min integer
---@param v_max integer
---@param format string
---@return boolean, integer, integer
function imgui.DragIntRange2(label, v_current_min, v_current_max, v_speed, v_min, v_max, format) end

---##### (READ-ONLY)
---@param label string
---@param v_current_min integer
---@param v_current_max integer
---@param v_speed number
---@param v_min integer
---@param v_max integer
---@param format string
---@param format_max string
---@return boolean, integer, integer
function imgui.DragIntRange2(label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max) end

---##### (READ-ONLY)
---@param label string
---@param v_current_min integer
---@param v_current_max integer
---@param v_speed number
---@param v_min integer
---@param v_max integer
---@param format string
---@param format_max string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, integer, integer
function imgui.DragIntRange2(label, v_current_min, v_current_max, v_speed, v_min, v_max, format, format_max, flags) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@return boolean
function imgui.DragScalar(label, data_type, p_data) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param v_speed number
---@return boolean
function imgui.DragScalar(label, data_type, p_data, v_speed) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param v_speed number
---@param p_min lightuserdata
---@return boolean
function imgui.DragScalar(label, data_type, p_data, v_speed, p_min) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param v_speed number
---@param p_min lightuserdata
---@param p_max lightuserdata
---@return boolean
function imgui.DragScalar(label, data_type, p_data, v_speed, p_min, p_max) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param v_speed number
---@param p_min lightuserdata
---@param p_max lightuserdata
---@param format string
---@return boolean
function imgui.DragScalar(label, data_type, p_data, v_speed, p_min, p_max, format) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param v_speed number
---@param p_min lightuserdata
---@param p_max lightuserdata
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean
function imgui.DragScalar(label, data_type, p_data, v_speed, p_min, p_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param components integer
---@return boolean
function imgui.DragScalarN(label, data_type, p_data, components) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param components integer
---@param v_speed number
---@return boolean
function imgui.DragScalarN(label, data_type, p_data, components, v_speed) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param components integer
---@param v_speed number
---@param p_min lightuserdata
---@return boolean
function imgui.DragScalarN(label, data_type, p_data, components, v_speed, p_min) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param components integer
---@param v_speed number
---@param p_min lightuserdata
---@param p_max lightuserdata
---@return boolean
function imgui.DragScalarN(label, data_type, p_data, components, v_speed, p_min, p_max) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param components integer
---@param v_speed number
---@param p_min lightuserdata
---@param p_max lightuserdata
---@param format string
---@return boolean
function imgui.DragScalarN(label, data_type, p_data, components, v_speed, p_min, p_max, format) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param components integer
---@param v_speed number
---@param p_min lightuserdata
---@param p_max lightuserdata
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean
function imgui.DragScalarN(label, data_type, p_data, components, v_speed, p_min, p_max, format, flags) end

---##### (READ-ONLY)
---@param size Vector2
function imgui.Dummy(size) end

---##### (READ-ONLY)
function imgui.End() end

---##### (READ-ONLY)
function imgui.EndChild() end

---##### (READ-ONLY)
function imgui.EndCombo() end

---##### (READ-ONLY)
function imgui.EndDisabled() end

---##### (READ-ONLY)
function imgui.EndDragDropSource() end

---##### (READ-ONLY)
function imgui.EndDragDropTarget() end

---##### (READ-ONLY)
function imgui.EndFrame() end

---##### (READ-ONLY)
function imgui.EndGroup() end

---##### (READ-ONLY)
function imgui.EndListBox() end

---##### (READ-ONLY)
function imgui.EndMainMenuBar() end

---##### (READ-ONLY)
function imgui.EndMenu() end

---##### (READ-ONLY)
function imgui.EndMenuBar() end

---##### (READ-ONLY)
---@return ImGuiMultiSelectIOPtr
function imgui.EndMultiSelect() end

---##### (READ-ONLY)
function imgui.EndPopup() end

---##### (READ-ONLY)
function imgui.EndTabBar() end

---##### (READ-ONLY)
function imgui.EndTabItem() end

---##### (READ-ONLY)
function imgui.EndTable() end

---##### (READ-ONLY)
function imgui.EndTooltip() end

---##### (READ-ONLY)
---@param id integer
---@return ImGuiViewportPtr
function imgui.FindViewportByID(id) end

---##### (READ-ONLY)
---@param platform_handle lightuserdata
---@return ImGuiViewportPtr
function imgui.FindViewportByPlatformHandle(platform_handle) end

---##### (READ-ONLY)
---@return ImDrawListPtr
function imgui.GetBackgroundDrawList() end

---##### (READ-ONLY)
---@param viewport ImGuiViewportPtr
---@return ImDrawListPtr
function imgui.GetBackgroundDrawList(viewport) end

---##### (READ-ONLY)
---@return string
function imgui.GetClipboardText() end

---##### (READ-ONLY)
---@param idx ImGuiCol|0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|"Text"|"TextDisabled"|"WindowBg"|"ChildBg"|"PopupBg"|"Border"|"BorderShadow"|"FrameBg"|"FrameBgHovered"|"FrameBgActive"|"TitleBg"|"TitleBgActive"|"TitleBgCollapsed"|"MenuBarBg"|"ScrollbarBg"|"ScrollbarGrab"|"ScrollbarGrabHovered"|"ScrollbarGrabActive"|"CheckMark"|"SliderGrab"|"SliderGrabActive"|"Button"|"ButtonHovered"|"ButtonActive"|"Header"|"HeaderHovered"|"HeaderActive"|"Separator"|"SeparatorHovered"|"SeparatorActive"|"ResizeGrip"|"ResizeGripHovered"|"ResizeGripActive"|"TabHovered"|"Tab"|"TabSelected"|"TabSelectedOverline"|"TabDimmed"|"TabDimmedSelected"|"TabDimmedSelectedOverline"|"DockingPreview"|"DockingEmptyBg"|"PlotLines"|"PlotLinesHovered"|"PlotHistogram"|"PlotHistogramHovered"|"TableHeaderBg"|"TableBorderStrong"|"TableBorderLight"|"TableRowBg"|"TableRowBgAlt"|"TextLink"|"TextSelectedBg"|"DragDropTarget"|"NavHighlight"|"NavWindowingHighlight"|"NavWindowingDimBg"|"ModalWindowDimBg"|"COUNT"
---@return integer
function imgui.GetColorU32(idx) end

---##### (READ-ONLY)
---@param idx ImGuiCol|0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|"Text"|"TextDisabled"|"WindowBg"|"ChildBg"|"PopupBg"|"Border"|"BorderShadow"|"FrameBg"|"FrameBgHovered"|"FrameBgActive"|"TitleBg"|"TitleBgActive"|"TitleBgCollapsed"|"MenuBarBg"|"ScrollbarBg"|"ScrollbarGrab"|"ScrollbarGrabHovered"|"ScrollbarGrabActive"|"CheckMark"|"SliderGrab"|"SliderGrabActive"|"Button"|"ButtonHovered"|"ButtonActive"|"Header"|"HeaderHovered"|"HeaderActive"|"Separator"|"SeparatorHovered"|"SeparatorActive"|"ResizeGrip"|"ResizeGripHovered"|"ResizeGripActive"|"TabHovered"|"Tab"|"TabSelected"|"TabSelectedOverline"|"TabDimmed"|"TabDimmedSelected"|"TabDimmedSelectedOverline"|"DockingPreview"|"DockingEmptyBg"|"PlotLines"|"PlotLinesHovered"|"PlotHistogram"|"PlotHistogramHovered"|"TableHeaderBg"|"TableBorderStrong"|"TableBorderLight"|"TableRowBg"|"TableRowBgAlt"|"TextLink"|"TextSelectedBg"|"DragDropTarget"|"NavHighlight"|"NavWindowingHighlight"|"NavWindowingDimBg"|"ModalWindowDimBg"|"COUNT"
---@param alpha_mul number
---@return integer
function imgui.GetColorU32(idx, alpha_mul) end

---##### (READ-ONLY)
---@param col Vector4
---@return integer
function imgui.GetColorU32(col) end

---##### (READ-ONLY)
---@param col integer
---@return integer
function imgui.GetColorU32(col) end

---##### (READ-ONLY)
---@param col integer
---@param alpha_mul number
---@return integer
function imgui.GetColorU32(col, alpha_mul) end

---##### (READ-ONLY)
---@return integer
function imgui.GetColumnIndex() end

---##### (READ-ONLY)
---@return number
function imgui.GetColumnOffset() end

---##### (READ-ONLY)
---@param column_index integer
---@return number
function imgui.GetColumnOffset(column_index) end

---##### (READ-ONLY)
---@return integer
function imgui.GetColumnsCount() end

---##### (READ-ONLY)
---@return number
function imgui.GetColumnWidth() end

---##### (READ-ONLY)
---@param column_index integer
---@return number
function imgui.GetColumnWidth(column_index) end

---##### (READ-ONLY)
---@return Vector2
function imgui.GetContentRegionAvail() end

---##### (READ-ONLY)
---@return number
function imgui.GetContentRegionAvailWidth() end

---##### (READ-ONLY)
---@return Vector2
function imgui.GetContentRegionMax() end

---##### (READ-ONLY)
---@return lightuserdata
function imgui.GetCurrentContext() end

---##### (READ-ONLY)
---@return Vector2
function imgui.GetCursorPos() end

---##### (READ-ONLY)
---@return number
function imgui.GetCursorPosX() end

---##### (READ-ONLY)
---@return number
function imgui.GetCursorPosY() end

---##### (READ-ONLY)
---@return Vector2
function imgui.GetCursorScreenPos() end

---##### (READ-ONLY)
---@return Vector2
function imgui.GetCursorStartPos() end

---##### (READ-ONLY)
---@return ImGuiPayloadPtr
function imgui.GetDragDropPayload() end

---##### (READ-ONLY)
---@return ImDrawDataPtr
function imgui.GetDrawData() end

---##### (READ-ONLY)
---@return lightuserdata
function imgui.GetDrawListSharedData() end

---##### (READ-ONLY)
---@return ImFontPtr
function imgui.GetFont() end

---##### (READ-ONLY)
---@return number
function imgui.GetFontSize() end

---##### (READ-ONLY)
---@return Vector2
function imgui.GetFontTexUvWhitePixel() end

---##### (READ-ONLY)
---@return ImDrawListPtr
function imgui.GetForegroundDrawList() end

---##### (READ-ONLY)
---@param viewport ImGuiViewportPtr
---@return ImDrawListPtr
function imgui.GetForegroundDrawList(viewport) end

---##### (READ-ONLY)
---@return integer
function imgui.GetFrameCount() end

---##### (READ-ONLY)
---@return number
function imgui.GetFrameHeight() end

---##### (READ-ONLY)
---@return number
function imgui.GetFrameHeightWithSpacing() end

---##### (READ-ONLY)
---@param str_id string
---@return integer
function imgui.GetID(str_id) end

---##### (READ-ONLY)
---@param ptr_id lightuserdata
---@return integer
function imgui.GetID(ptr_id) end

---##### (READ-ONLY)
---@param int_id integer
---@return integer
function imgui.GetID(int_id) end

---##### (READ-ONLY)
---@return ImGuiIOPtr
function imgui.GetIO() end

---##### (READ-ONLY)
---@return integer
function imgui.GetItemID() end

---##### (READ-ONLY)
---@return Vector2
function imgui.GetItemRectMax() end

---##### (READ-ONLY)
---@return Vector2
function imgui.GetItemRectMin() end

---##### (READ-ONLY)
---@return Vector2
function imgui.GetItemRectSize() end

---##### (READ-ONLY)
---@param key ImGuiKey|0|154|512|513|514|515|516|517|518|519|520|521|522|523|524|525|526|527|528|529|530|531|532|533|534|535|536|537|538|539|540|541|542|543|544|545|546|547|548|549|550|551|552|553|554|555|556|557|558|559|560|561|562|563|564|565|566|567|568|569|570|571|572|573|574|575|576|577|578|579|580|581|582|583|584|585|586|587|588|589|590|591|592|593|594|595|596|597|598|599|600|601|602|603|604|605|606|607|608|609|610|611|612|613|614|615|616|617|618|619|620|621|622|623|624|625|626|627|628|629|630|631|632|633|634|635|636|637|638|639|640|641|642|643|644|645|646|647|648|649|650|651|652|653|654|655|656|657|658|659|660|661|662|663|664|665|666|4096|8192|16384|32768|61440|"None"|"ModNone"|"NamedKey_COUNT"|"KeysData_SIZE"|"NamedKey_BEGIN"|"KeysData_OFFSET"|"Tab"|"LeftArrow"|"RightArrow"|"UpArrow"|"DownArrow"|"PageUp"|"PageDown"|"Home"|"End"|"Insert"|"Delete"|"Backspace"|"Space"|"Enter"|"Escape"|"LeftCtrl"|"LeftShift"|"LeftAlt"|"LeftSuper"|"RightCtrl"|"RightShift"|"RightAlt"|"RightSuper"|"Menu"|"_0"|"_1"|"_2"|"_3"|"_4"|"_5"|"_6"|"_7"|"_8"|"_9"|"A"|"B"|"C"|"D"|"E"|"F"|"G"|"H"|"I"|"J"|"K"|"L"|"M"|"N"|"O"|"P"|"Q"|"R"|"S"|"T"|"U"|"V"|"W"|"X"|"Y"|"Z"|"F1"|"F2"|"F3"|"F4"|"F5"|"F6"|"F7"|"F8"|"F9"|"F10"|"F11"|"F12"|"F13"|"F14"|"F15"|"F16"|"F17"|"F18"|"F19"|"F20"|"F21"|"F22"|"F23"|"F24"|"Apostrophe"|"Comma"|"Minus"|"Period"|"Slash"|"Semicolon"|"Equal"|"LeftBracket"|"Backslash"|"RightBracket"|"GraveAccent"|"CapsLock"|"ScrollLock"|"NumLock"|"PrintScreen"|"Pause"|"Keypad0"|"Keypad1"|"Keypad2"|"Keypad3"|"Keypad4"|"Keypad5"|"Keypad6"|"Keypad7"|"Keypad8"|"Keypad9"|"KeypadDecimal"|"KeypadDivide"|"KeypadMultiply"|"KeypadSubtract"|"KeypadAdd"|"KeypadEnter"|"KeypadEqual"|"AppBack"|"AppForward"|"GamepadStart"|"GamepadBack"|"GamepadFaceLeft"|"GamepadFaceRight"|"GamepadFaceUp"|"GamepadFaceDown"|"GamepadDpadLeft"|"GamepadDpadRight"|"GamepadDpadUp"|"GamepadDpadDown"|"GamepadL1"|"GamepadR1"|"GamepadL2"|"GamepadR2"|"GamepadL3"|"GamepadR3"|"GamepadLStickLeft"|"GamepadLStickRight"|"GamepadLStickUp"|"GamepadLStickDown"|"GamepadRStickLeft"|"GamepadRStickRight"|"GamepadRStickUp"|"GamepadRStickDown"|"MouseLeft"|"MouseRight"|"MouseMiddle"|"MouseX1"|"MouseX2"|"MouseWheelX"|"MouseWheelY"|"ReservedForModCtrl"|"ReservedForModShift"|"ReservedForModAlt"|"ReservedForModSuper"|"COUNT"|"NamedKey_END"|"ModCtrl"|"ModShift"|"ModAlt"|"ModSuper"|"ModMask"
---@return integer
function imgui.GetKeyIndex(key) end

---##### (READ-ONLY)
---@param key ImGuiKey|0|154|512|513|514|515|516|517|518|519|520|521|522|523|524|525|526|527|528|529|530|531|532|533|534|535|536|537|538|539|540|541|542|543|544|545|546|547|548|549|550|551|552|553|554|555|556|557|558|559|560|561|562|563|564|565|566|567|568|569|570|571|572|573|574|575|576|577|578|579|580|581|582|583|584|585|586|587|588|589|590|591|592|593|594|595|596|597|598|599|600|601|602|603|604|605|606|607|608|609|610|611|612|613|614|615|616|617|618|619|620|621|622|623|624|625|626|627|628|629|630|631|632|633|634|635|636|637|638|639|640|641|642|643|644|645|646|647|648|649|650|651|652|653|654|655|656|657|658|659|660|661|662|663|664|665|666|4096|8192|16384|32768|61440|"None"|"ModNone"|"NamedKey_COUNT"|"KeysData_SIZE"|"NamedKey_BEGIN"|"KeysData_OFFSET"|"Tab"|"LeftArrow"|"RightArrow"|"UpArrow"|"DownArrow"|"PageUp"|"PageDown"|"Home"|"End"|"Insert"|"Delete"|"Backspace"|"Space"|"Enter"|"Escape"|"LeftCtrl"|"LeftShift"|"LeftAlt"|"LeftSuper"|"RightCtrl"|"RightShift"|"RightAlt"|"RightSuper"|"Menu"|"_0"|"_1"|"_2"|"_3"|"_4"|"_5"|"_6"|"_7"|"_8"|"_9"|"A"|"B"|"C"|"D"|"E"|"F"|"G"|"H"|"I"|"J"|"K"|"L"|"M"|"N"|"O"|"P"|"Q"|"R"|"S"|"T"|"U"|"V"|"W"|"X"|"Y"|"Z"|"F1"|"F2"|"F3"|"F4"|"F5"|"F6"|"F7"|"F8"|"F9"|"F10"|"F11"|"F12"|"F13"|"F14"|"F15"|"F16"|"F17"|"F18"|"F19"|"F20"|"F21"|"F22"|"F23"|"F24"|"Apostrophe"|"Comma"|"Minus"|"Period"|"Slash"|"Semicolon"|"Equal"|"LeftBracket"|"Backslash"|"RightBracket"|"GraveAccent"|"CapsLock"|"ScrollLock"|"NumLock"|"PrintScreen"|"Pause"|"Keypad0"|"Keypad1"|"Keypad2"|"Keypad3"|"Keypad4"|"Keypad5"|"Keypad6"|"Keypad7"|"Keypad8"|"Keypad9"|"KeypadDecimal"|"KeypadDivide"|"KeypadMultiply"|"KeypadSubtract"|"KeypadAdd"|"KeypadEnter"|"KeypadEqual"|"AppBack"|"AppForward"|"GamepadStart"|"GamepadBack"|"GamepadFaceLeft"|"GamepadFaceRight"|"GamepadFaceUp"|"GamepadFaceDown"|"GamepadDpadLeft"|"GamepadDpadRight"|"GamepadDpadUp"|"GamepadDpadDown"|"GamepadL1"|"GamepadR1"|"GamepadL2"|"GamepadR2"|"GamepadL3"|"GamepadR3"|"GamepadLStickLeft"|"GamepadLStickRight"|"GamepadLStickUp"|"GamepadLStickDown"|"GamepadRStickLeft"|"GamepadRStickRight"|"GamepadRStickUp"|"GamepadRStickDown"|"MouseLeft"|"MouseRight"|"MouseMiddle"|"MouseX1"|"MouseX2"|"MouseWheelX"|"MouseWheelY"|"ReservedForModCtrl"|"ReservedForModShift"|"ReservedForModAlt"|"ReservedForModSuper"|"COUNT"|"NamedKey_END"|"ModCtrl"|"ModShift"|"ModAlt"|"ModSuper"|"ModMask"
---@return string
function imgui.GetKeyName(key) end

---##### (READ-ONLY)
---@param key ImGuiKey|0|154|512|513|514|515|516|517|518|519|520|521|522|523|524|525|526|527|528|529|530|531|532|533|534|535|536|537|538|539|540|541|542|543|544|545|546|547|548|549|550|551|552|553|554|555|556|557|558|559|560|561|562|563|564|565|566|567|568|569|570|571|572|573|574|575|576|577|578|579|580|581|582|583|584|585|586|587|588|589|590|591|592|593|594|595|596|597|598|599|600|601|602|603|604|605|606|607|608|609|610|611|612|613|614|615|616|617|618|619|620|621|622|623|624|625|626|627|628|629|630|631|632|633|634|635|636|637|638|639|640|641|642|643|644|645|646|647|648|649|650|651|652|653|654|655|656|657|658|659|660|661|662|663|664|665|666|4096|8192|16384|32768|61440|"None"|"ModNone"|"NamedKey_COUNT"|"KeysData_SIZE"|"NamedKey_BEGIN"|"KeysData_OFFSET"|"Tab"|"LeftArrow"|"RightArrow"|"UpArrow"|"DownArrow"|"PageUp"|"PageDown"|"Home"|"End"|"Insert"|"Delete"|"Backspace"|"Space"|"Enter"|"Escape"|"LeftCtrl"|"LeftShift"|"LeftAlt"|"LeftSuper"|"RightCtrl"|"RightShift"|"RightAlt"|"RightSuper"|"Menu"|"_0"|"_1"|"_2"|"_3"|"_4"|"_5"|"_6"|"_7"|"_8"|"_9"|"A"|"B"|"C"|"D"|"E"|"F"|"G"|"H"|"I"|"J"|"K"|"L"|"M"|"N"|"O"|"P"|"Q"|"R"|"S"|"T"|"U"|"V"|"W"|"X"|"Y"|"Z"|"F1"|"F2"|"F3"|"F4"|"F5"|"F6"|"F7"|"F8"|"F9"|"F10"|"F11"|"F12"|"F13"|"F14"|"F15"|"F16"|"F17"|"F18"|"F19"|"F20"|"F21"|"F22"|"F23"|"F24"|"Apostrophe"|"Comma"|"Minus"|"Period"|"Slash"|"Semicolon"|"Equal"|"LeftBracket"|"Backslash"|"RightBracket"|"GraveAccent"|"CapsLock"|"ScrollLock"|"NumLock"|"PrintScreen"|"Pause"|"Keypad0"|"Keypad1"|"Keypad2"|"Keypad3"|"Keypad4"|"Keypad5"|"Keypad6"|"Keypad7"|"Keypad8"|"Keypad9"|"KeypadDecimal"|"KeypadDivide"|"KeypadMultiply"|"KeypadSubtract"|"KeypadAdd"|"KeypadEnter"|"KeypadEqual"|"AppBack"|"AppForward"|"GamepadStart"|"GamepadBack"|"GamepadFaceLeft"|"GamepadFaceRight"|"GamepadFaceUp"|"GamepadFaceDown"|"GamepadDpadLeft"|"GamepadDpadRight"|"GamepadDpadUp"|"GamepadDpadDown"|"GamepadL1"|"GamepadR1"|"GamepadL2"|"GamepadR2"|"GamepadL3"|"GamepadR3"|"GamepadLStickLeft"|"GamepadLStickRight"|"GamepadLStickUp"|"GamepadLStickDown"|"GamepadRStickLeft"|"GamepadRStickRight"|"GamepadRStickUp"|"GamepadRStickDown"|"MouseLeft"|"MouseRight"|"MouseMiddle"|"MouseX1"|"MouseX2"|"MouseWheelX"|"MouseWheelY"|"ReservedForModCtrl"|"ReservedForModShift"|"ReservedForModAlt"|"ReservedForModSuper"|"COUNT"|"NamedKey_END"|"ModCtrl"|"ModShift"|"ModAlt"|"ModSuper"|"ModMask"
---@param repeat_delay number
---@param rate number
---@return integer
function imgui.GetKeyPressedAmount(key, repeat_delay, rate) end

---##### (READ-ONLY)
---@return ImGuiViewportPtr
function imgui.GetMainViewport() end

---##### (READ-ONLY)
---@param button ImGuiMouseButton|0|1|2|5|"Left"|"Right"|"Middle"|"COUNT"
---@return integer
function imgui.GetMouseClickedCount(button) end

---##### (READ-ONLY)
---@return ImGuiMouseCursor|0|1|2|3|4|5|6|7|8|9|-1|"Arrow"|"TextInput"|"ResizeAll"|"ResizeNS"|"ResizeEW"|"ResizeNESW"|"ResizeNWSE"|"Hand"|"NotAllowed"|"COUNT"|"None"
function imgui.GetMouseCursor() end

---##### (READ-ONLY)
---@return Vector2
function imgui.GetMouseDragDelta() end

---##### (READ-ONLY)
---@param button ImGuiMouseButton|0|1|2|5|"Left"|"Right"|"Middle"|"COUNT"
---@return Vector2
function imgui.GetMouseDragDelta(button) end

---##### (READ-ONLY)
---@param button ImGuiMouseButton|0|1|2|5|"Left"|"Right"|"Middle"|"COUNT"
---@param lock_threshold number
---@return Vector2
function imgui.GetMouseDragDelta(button, lock_threshold) end

---##### (READ-ONLY)
---@return Vector2
function imgui.GetMousePos() end

---##### (READ-ONLY)
---@return Vector2
function imgui.GetMousePosOnOpeningCurrentPopup() end

---##### (READ-ONLY)
---@return ImGuiPlatformIOPtr
function imgui.GetPlatformIO() end

---##### (READ-ONLY)
---@return number
function imgui.GetScrollMaxX() end

---##### (READ-ONLY)
---@return number
function imgui.GetScrollMaxY() end

---##### (READ-ONLY)
---@return number
function imgui.GetScrollX() end

---##### (READ-ONLY)
---@return number
function imgui.GetScrollY() end

---##### (READ-ONLY)
---@return ImGuiStoragePtr
function imgui.GetStateStorage() end

---##### (READ-ONLY)
---@return ImGuiStylePtr
function imgui.GetStyle() end

---##### (READ-ONLY)
---@param idx ImGuiCol|0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|"Text"|"TextDisabled"|"WindowBg"|"ChildBg"|"PopupBg"|"Border"|"BorderShadow"|"FrameBg"|"FrameBgHovered"|"FrameBgActive"|"TitleBg"|"TitleBgActive"|"TitleBgCollapsed"|"MenuBarBg"|"ScrollbarBg"|"ScrollbarGrab"|"ScrollbarGrabHovered"|"ScrollbarGrabActive"|"CheckMark"|"SliderGrab"|"SliderGrabActive"|"Button"|"ButtonHovered"|"ButtonActive"|"Header"|"HeaderHovered"|"HeaderActive"|"Separator"|"SeparatorHovered"|"SeparatorActive"|"ResizeGrip"|"ResizeGripHovered"|"ResizeGripActive"|"TabHovered"|"Tab"|"TabSelected"|"TabSelectedOverline"|"TabDimmed"|"TabDimmedSelected"|"TabDimmedSelectedOverline"|"DockingPreview"|"DockingEmptyBg"|"PlotLines"|"PlotLinesHovered"|"PlotHistogram"|"PlotHistogramHovered"|"TableHeaderBg"|"TableBorderStrong"|"TableBorderLight"|"TableRowBg"|"TableRowBgAlt"|"TextLink"|"TextSelectedBg"|"DragDropTarget"|"NavHighlight"|"NavWindowingHighlight"|"NavWindowingDimBg"|"ModalWindowDimBg"|"COUNT"
---@return string
function imgui.GetStyleColorName(idx) end

---##### (READ-ONLY)
---@return number
function imgui.GetTextLineHeight() end

---##### (READ-ONLY)
---@return number
function imgui.GetTextLineHeightWithSpacing() end

---##### (READ-ONLY)
---@return number
function imgui.GetTime() end

---##### (READ-ONLY)
---@return number
function imgui.GetTreeNodeToLabelSpacing() end

---##### (READ-ONLY)
---@return string
function imgui.GetVersion() end

---##### (READ-ONLY)
---@return Vector2
function imgui.GetWindowContentRegionMax() end

---##### (READ-ONLY)
---@return Vector2
function imgui.GetWindowContentRegionMin() end

---##### (READ-ONLY)
---@return integer
function imgui.GetWindowDockID() end

---##### (READ-ONLY)
---@return number
function imgui.GetWindowDpiScale() end

---##### (READ-ONLY)
---@return ImDrawListPtr
function imgui.GetWindowDrawList() end

---##### (READ-ONLY)
---@return number
function imgui.GetWindowHeight() end

---##### (READ-ONLY)
---@return Vector2
function imgui.GetWindowPos() end

---##### (READ-ONLY)
---@return number
function imgui.GetWindowRegionAvailWidth() end

---##### (READ-ONLY)
---@return Vector2
function imgui.GetWindowSize() end

---##### (READ-ONLY)
---@return ImGuiViewportPtr
function imgui.GetWindowViewport() end

---##### (READ-ONLY)
---@return number
function imgui.GetWindowWidth() end

---##### (READ-ONLY)
---@param user_texture_id lightuserdata
---@param image_size Vector2
function imgui.Image(user_texture_id, image_size) end

---##### (READ-ONLY)
---@param user_texture_id lightuserdata
---@param image_size Vector2
---@param uv0 Vector2
function imgui.Image(user_texture_id, image_size, uv0) end

---##### (READ-ONLY)
---@param user_texture_id lightuserdata
---@param image_size Vector2
---@param uv0 Vector2
---@param uv1 Vector2
function imgui.Image(user_texture_id, image_size, uv0, uv1) end

---##### (READ-ONLY)
---@param user_texture_id lightuserdata
---@param image_size Vector2
---@param uv0 Vector2
---@param uv1 Vector2
---@param tint_col Vector4
function imgui.Image(user_texture_id, image_size, uv0, uv1, tint_col) end

---##### (READ-ONLY)
---@param user_texture_id lightuserdata
---@param image_size Vector2
---@param uv0 Vector2
---@param uv1 Vector2
---@param tint_col Vector4
---@param border_col Vector4
function imgui.Image(user_texture_id, image_size, uv0, uv1, tint_col, border_col) end

---##### (READ-ONLY)
---@param str_id string
---@param user_texture_id lightuserdata
---@param image_size Vector2
---@return boolean
function imgui.ImageButton(str_id, user_texture_id, image_size) end

---##### (READ-ONLY)
---@param str_id string
---@param user_texture_id lightuserdata
---@param image_size Vector2
---@param uv0 Vector2
---@return boolean
function imgui.ImageButton(str_id, user_texture_id, image_size, uv0) end

---##### (READ-ONLY)
---@param str_id string
---@param user_texture_id lightuserdata
---@param image_size Vector2
---@param uv0 Vector2
---@param uv1 Vector2
---@return boolean
function imgui.ImageButton(str_id, user_texture_id, image_size, uv0, uv1) end

---##### (READ-ONLY)
---@param str_id string
---@param user_texture_id lightuserdata
---@param image_size Vector2
---@param uv0 Vector2
---@param uv1 Vector2
---@param bg_col Vector4
---@return boolean
function imgui.ImageButton(str_id, user_texture_id, image_size, uv0, uv1, bg_col) end

---##### (READ-ONLY)
---@param str_id string
---@param user_texture_id lightuserdata
---@param image_size Vector2
---@param uv0 Vector2
---@param uv1 Vector2
---@param bg_col Vector4
---@param tint_col Vector4
---@return boolean
function imgui.ImageButton(str_id, user_texture_id, image_size, uv0, uv1, bg_col, tint_col) end

---##### (READ-ONLY)
function imgui.Indent() end

---##### (READ-ONLY)
---@param indent_w number
function imgui.Indent(indent_w) end

---##### (READ-ONLY)
---@param label string
---@param v number
---@return boolean, number
function imgui.InputDouble(label, v) end

---##### (READ-ONLY)
---@param label string
---@param v number
---@param step number
---@return boolean, number
function imgui.InputDouble(label, v, step) end

---##### (READ-ONLY)
---@param label string
---@param v number
---@param step number
---@param step_fast number
---@return boolean, number
function imgui.InputDouble(label, v, step, step_fast) end

---##### (READ-ONLY)
---@param label string
---@param v number
---@param step number
---@param step_fast number
---@param format string
---@return boolean, number
function imgui.InputDouble(label, v, step, step_fast, format) end

---##### (READ-ONLY)
---@param label string
---@param v number
---@param step number
---@param step_fast number
---@param format string
---@param flags ImGuiInputTextFlags|integer|"None"|"CharsDecimal"|"CharsHexadecimal"|"CharsScientific"|"CharsUppercase"|"CharsNoBlank"|"AllowTabInput"|"EnterReturnsTrue"|"EscapeClearsAll"|"CtrlEnterForNewLine"|"ReadOnly"|"Password"|"AlwaysOverwrite"|"AutoSelectAll"|"ParseEmptyRefVal"|"DisplayEmptyRefVal"|"NoHorizontalScroll"|"NoUndoRedo"|"CallbackCompletion"|"CallbackHistory"|"CallbackAlways"|"CallbackCharFilter"|"CallbackResize"|"CallbackEdit"
---@return boolean, number
function imgui.InputDouble(label, v, step, step_fast, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v number
---@return boolean, number
function imgui.InputFloat(label, v) end

---##### (READ-ONLY)
---@param label string
---@param v number
---@param step number
---@return boolean, number
function imgui.InputFloat(label, v, step) end

---##### (READ-ONLY)
---@param label string
---@param v number
---@param step number
---@param step_fast number
---@return boolean, number
function imgui.InputFloat(label, v, step, step_fast) end

---##### (READ-ONLY)
---@param label string
---@param v number
---@param step number
---@param step_fast number
---@param format string
---@return boolean, number
function imgui.InputFloat(label, v, step, step_fast, format) end

---##### (READ-ONLY)
---@param label string
---@param v number
---@param step number
---@param step_fast number
---@param format string
---@param flags ImGuiInputTextFlags|integer|"None"|"CharsDecimal"|"CharsHexadecimal"|"CharsScientific"|"CharsUppercase"|"CharsNoBlank"|"AllowTabInput"|"EnterReturnsTrue"|"EscapeClearsAll"|"CtrlEnterForNewLine"|"ReadOnly"|"Password"|"AlwaysOverwrite"|"AutoSelectAll"|"ParseEmptyRefVal"|"DisplayEmptyRefVal"|"NoHorizontalScroll"|"NoUndoRedo"|"CallbackCompletion"|"CallbackHistory"|"CallbackAlways"|"CallbackCharFilter"|"CallbackResize"|"CallbackEdit"
---@return boolean, number
function imgui.InputFloat(label, v, step, step_fast, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v Vector2
---@return boolean, Vector2
function imgui.InputFloat2(label, v) end

---##### (READ-ONLY)
---@param label string
---@param v Vector2
---@param format string
---@return boolean, Vector2
function imgui.InputFloat2(label, v, format) end

---##### (READ-ONLY)
---@param label string
---@param v Vector2
---@param format string
---@param flags ImGuiInputTextFlags|integer|"None"|"CharsDecimal"|"CharsHexadecimal"|"CharsScientific"|"CharsUppercase"|"CharsNoBlank"|"AllowTabInput"|"EnterReturnsTrue"|"EscapeClearsAll"|"CtrlEnterForNewLine"|"ReadOnly"|"Password"|"AlwaysOverwrite"|"AutoSelectAll"|"ParseEmptyRefVal"|"DisplayEmptyRefVal"|"NoHorizontalScroll"|"NoUndoRedo"|"CallbackCompletion"|"CallbackHistory"|"CallbackAlways"|"CallbackCharFilter"|"CallbackResize"|"CallbackEdit"
---@return boolean, Vector2
function imgui.InputFloat2(label, v, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v Vector3
---@return boolean, Vector3
function imgui.InputFloat3(label, v) end

---##### (READ-ONLY)
---@param label string
---@param v Vector3
---@param format string
---@return boolean, Vector3
function imgui.InputFloat3(label, v, format) end

---##### (READ-ONLY)
---@param label string
---@param v Vector3
---@param format string
---@param flags ImGuiInputTextFlags|integer|"None"|"CharsDecimal"|"CharsHexadecimal"|"CharsScientific"|"CharsUppercase"|"CharsNoBlank"|"AllowTabInput"|"EnterReturnsTrue"|"EscapeClearsAll"|"CtrlEnterForNewLine"|"ReadOnly"|"Password"|"AlwaysOverwrite"|"AutoSelectAll"|"ParseEmptyRefVal"|"DisplayEmptyRefVal"|"NoHorizontalScroll"|"NoUndoRedo"|"CallbackCompletion"|"CallbackHistory"|"CallbackAlways"|"CallbackCharFilter"|"CallbackResize"|"CallbackEdit"
---@return boolean, Vector3
function imgui.InputFloat3(label, v, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v Vector4
---@return boolean, Vector4
function imgui.InputFloat4(label, v) end

---##### (READ-ONLY)
---@param label string
---@param v Vector4
---@param format string
---@return boolean, Vector4
function imgui.InputFloat4(label, v, format) end

---##### (READ-ONLY)
---@param label string
---@param v Vector4
---@param format string
---@param flags ImGuiInputTextFlags|integer|"None"|"CharsDecimal"|"CharsHexadecimal"|"CharsScientific"|"CharsUppercase"|"CharsNoBlank"|"AllowTabInput"|"EnterReturnsTrue"|"EscapeClearsAll"|"CtrlEnterForNewLine"|"ReadOnly"|"Password"|"AlwaysOverwrite"|"AutoSelectAll"|"ParseEmptyRefVal"|"DisplayEmptyRefVal"|"NoHorizontalScroll"|"NoUndoRedo"|"CallbackCompletion"|"CallbackHistory"|"CallbackAlways"|"CallbackCharFilter"|"CallbackResize"|"CallbackEdit"
---@return boolean, Vector4
function imgui.InputFloat4(label, v, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v integer
---@return boolean, integer
function imgui.InputInt(label, v) end

---##### (READ-ONLY)
---@param label string
---@param v integer
---@param step integer
---@return boolean, integer
function imgui.InputInt(label, v, step) end

---##### (READ-ONLY)
---@param label string
---@param v integer
---@param step integer
---@param step_fast integer
---@return boolean, integer
function imgui.InputInt(label, v, step, step_fast) end

---##### (READ-ONLY)
---@param label string
---@param v integer
---@param step integer
---@param step_fast integer
---@param flags ImGuiInputTextFlags|integer|"None"|"CharsDecimal"|"CharsHexadecimal"|"CharsScientific"|"CharsUppercase"|"CharsNoBlank"|"AllowTabInput"|"EnterReturnsTrue"|"EscapeClearsAll"|"CtrlEnterForNewLine"|"ReadOnly"|"Password"|"AlwaysOverwrite"|"AutoSelectAll"|"ParseEmptyRefVal"|"DisplayEmptyRefVal"|"NoHorizontalScroll"|"NoUndoRedo"|"CallbackCompletion"|"CallbackHistory"|"CallbackAlways"|"CallbackCharFilter"|"CallbackResize"|"CallbackEdit"
---@return boolean, integer
function imgui.InputInt(label, v, step, step_fast, flags) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@return boolean, Vector2
function imgui.InputInt2(label, v) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param flags ImGuiInputTextFlags|integer|"None"|"CharsDecimal"|"CharsHexadecimal"|"CharsScientific"|"CharsUppercase"|"CharsNoBlank"|"AllowTabInput"|"EnterReturnsTrue"|"EscapeClearsAll"|"CtrlEnterForNewLine"|"ReadOnly"|"Password"|"AlwaysOverwrite"|"AutoSelectAll"|"ParseEmptyRefVal"|"DisplayEmptyRefVal"|"NoHorizontalScroll"|"NoUndoRedo"|"CallbackCompletion"|"CallbackHistory"|"CallbackAlways"|"CallbackCharFilter"|"CallbackResize"|"CallbackEdit"
---@return boolean, Vector2
function imgui.InputInt2(label, v, flags) end

---##### (READ-ONLY)
---@param label string
---@param v Vector2
---@return boolean, Vector2
function imgui.InputInt2(label, v) end

---##### (READ-ONLY)
---@param label string
---@param v Vector2
---@param flags ImGuiInputTextFlags|integer|"None"|"CharsDecimal"|"CharsHexadecimal"|"CharsScientific"|"CharsUppercase"|"CharsNoBlank"|"AllowTabInput"|"EnterReturnsTrue"|"EscapeClearsAll"|"CtrlEnterForNewLine"|"ReadOnly"|"Password"|"AlwaysOverwrite"|"AutoSelectAll"|"ParseEmptyRefVal"|"DisplayEmptyRefVal"|"NoHorizontalScroll"|"NoUndoRedo"|"CallbackCompletion"|"CallbackHistory"|"CallbackAlways"|"CallbackCharFilter"|"CallbackResize"|"CallbackEdit"
---@return boolean, Vector2
function imgui.InputInt2(label, v, flags) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@return boolean, integer[]
function imgui.InputInt3(label, v) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param flags ImGuiInputTextFlags|integer|"None"|"CharsDecimal"|"CharsHexadecimal"|"CharsScientific"|"CharsUppercase"|"CharsNoBlank"|"AllowTabInput"|"EnterReturnsTrue"|"EscapeClearsAll"|"CtrlEnterForNewLine"|"ReadOnly"|"Password"|"AlwaysOverwrite"|"AutoSelectAll"|"ParseEmptyRefVal"|"DisplayEmptyRefVal"|"NoHorizontalScroll"|"NoUndoRedo"|"CallbackCompletion"|"CallbackHistory"|"CallbackAlways"|"CallbackCharFilter"|"CallbackResize"|"CallbackEdit"
---@return boolean, integer[]
function imgui.InputInt3(label, v, flags) end

---##### (READ-ONLY)
---@param label string
---@param v Vector3
---@return boolean, Vector3
function imgui.InputInt3(label, v) end

---##### (READ-ONLY)
---@param label string
---@param v Vector3
---@param flags ImGuiInputTextFlags|integer|"None"|"CharsDecimal"|"CharsHexadecimal"|"CharsScientific"|"CharsUppercase"|"CharsNoBlank"|"AllowTabInput"|"EnterReturnsTrue"|"EscapeClearsAll"|"CtrlEnterForNewLine"|"ReadOnly"|"Password"|"AlwaysOverwrite"|"AutoSelectAll"|"ParseEmptyRefVal"|"DisplayEmptyRefVal"|"NoHorizontalScroll"|"NoUndoRedo"|"CallbackCompletion"|"CallbackHistory"|"CallbackAlways"|"CallbackCharFilter"|"CallbackResize"|"CallbackEdit"
---@return boolean, Vector3
function imgui.InputInt3(label, v, flags) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@return boolean, integer[]
function imgui.InputInt4(label, v) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param flags ImGuiInputTextFlags|integer|"None"|"CharsDecimal"|"CharsHexadecimal"|"CharsScientific"|"CharsUppercase"|"CharsNoBlank"|"AllowTabInput"|"EnterReturnsTrue"|"EscapeClearsAll"|"CtrlEnterForNewLine"|"ReadOnly"|"Password"|"AlwaysOverwrite"|"AutoSelectAll"|"ParseEmptyRefVal"|"DisplayEmptyRefVal"|"NoHorizontalScroll"|"NoUndoRedo"|"CallbackCompletion"|"CallbackHistory"|"CallbackAlways"|"CallbackCharFilter"|"CallbackResize"|"CallbackEdit"
---@return boolean, integer[]
function imgui.InputInt4(label, v, flags) end

---##### (READ-ONLY)
---@param label string
---@param v Vector4
---@return boolean, Vector4
function imgui.InputInt4(label, v) end

---##### (READ-ONLY)
---@param label string
---@param v Vector4
---@param flags ImGuiInputTextFlags|integer|"None"|"CharsDecimal"|"CharsHexadecimal"|"CharsScientific"|"CharsUppercase"|"CharsNoBlank"|"AllowTabInput"|"EnterReturnsTrue"|"EscapeClearsAll"|"CtrlEnterForNewLine"|"ReadOnly"|"Password"|"AlwaysOverwrite"|"AutoSelectAll"|"ParseEmptyRefVal"|"DisplayEmptyRefVal"|"NoHorizontalScroll"|"NoUndoRedo"|"CallbackCompletion"|"CallbackHistory"|"CallbackAlways"|"CallbackCharFilter"|"CallbackResize"|"CallbackEdit"
---@return boolean, Vector4
function imgui.InputInt4(label, v, flags) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@return boolean
function imgui.InputScalar(label, data_type, p_data) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param p_step lightuserdata
---@return boolean
function imgui.InputScalar(label, data_type, p_data, p_step) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param p_step lightuserdata
---@param p_step_fast lightuserdata
---@return boolean
function imgui.InputScalar(label, data_type, p_data, p_step, p_step_fast) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param p_step lightuserdata
---@param p_step_fast lightuserdata
---@param format string
---@return boolean
function imgui.InputScalar(label, data_type, p_data, p_step, p_step_fast, format) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param p_step lightuserdata
---@param p_step_fast lightuserdata
---@param format string
---@param flags ImGuiInputTextFlags|integer|"None"|"CharsDecimal"|"CharsHexadecimal"|"CharsScientific"|"CharsUppercase"|"CharsNoBlank"|"AllowTabInput"|"EnterReturnsTrue"|"EscapeClearsAll"|"CtrlEnterForNewLine"|"ReadOnly"|"Password"|"AlwaysOverwrite"|"AutoSelectAll"|"ParseEmptyRefVal"|"DisplayEmptyRefVal"|"NoHorizontalScroll"|"NoUndoRedo"|"CallbackCompletion"|"CallbackHistory"|"CallbackAlways"|"CallbackCharFilter"|"CallbackResize"|"CallbackEdit"
---@return boolean
function imgui.InputScalar(label, data_type, p_data, p_step, p_step_fast, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param components integer
---@return boolean
function imgui.InputScalarN(label, data_type, p_data, components) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param components integer
---@param p_step lightuserdata
---@return boolean
function imgui.InputScalarN(label, data_type, p_data, components, p_step) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param components integer
---@param p_step lightuserdata
---@param p_step_fast lightuserdata
---@return boolean
function imgui.InputScalarN(label, data_type, p_data, components, p_step, p_step_fast) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param components integer
---@param p_step lightuserdata
---@param p_step_fast lightuserdata
---@param format string
---@return boolean
function imgui.InputScalarN(label, data_type, p_data, components, p_step, p_step_fast, format) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param components integer
---@param p_step lightuserdata
---@param p_step_fast lightuserdata
---@param format string
---@param flags ImGuiInputTextFlags|integer|"None"|"CharsDecimal"|"CharsHexadecimal"|"CharsScientific"|"CharsUppercase"|"CharsNoBlank"|"AllowTabInput"|"EnterReturnsTrue"|"EscapeClearsAll"|"CtrlEnterForNewLine"|"ReadOnly"|"Password"|"AlwaysOverwrite"|"AutoSelectAll"|"ParseEmptyRefVal"|"DisplayEmptyRefVal"|"NoHorizontalScroll"|"NoUndoRedo"|"CallbackCompletion"|"CallbackHistory"|"CallbackAlways"|"CallbackCharFilter"|"CallbackResize"|"CallbackEdit"
---@return boolean
function imgui.InputScalarN(label, data_type, p_data, components, p_step, p_step_fast, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param input string
---@param maxLength integer
---@return boolean, string
function imgui.InputText(label, input, maxLength) end

---##### (READ-ONLY)
---@param label string
---@param input string
---@param maxLength integer
---@param flags ImGuiInputTextFlags|integer|"None"|"CharsDecimal"|"CharsHexadecimal"|"CharsScientific"|"CharsUppercase"|"CharsNoBlank"|"AllowTabInput"|"EnterReturnsTrue"|"EscapeClearsAll"|"CtrlEnterForNewLine"|"ReadOnly"|"Password"|"AlwaysOverwrite"|"AutoSelectAll"|"ParseEmptyRefVal"|"DisplayEmptyRefVal"|"NoHorizontalScroll"|"NoUndoRedo"|"CallbackCompletion"|"CallbackHistory"|"CallbackAlways"|"CallbackCharFilter"|"CallbackResize"|"CallbackEdit"
---@return boolean, string
function imgui.InputText(label, input, maxLength, flags) end

---##### (READ-ONLY)
---@param label string
---@param input string
---@param maxLength integer
---@param size Vector2
---@return boolean, string
function imgui.InputTextMultiline(label, input, maxLength, size) end

---##### (READ-ONLY)
---@param label string
---@param input string
---@param maxLength integer
---@param size Vector2
---@param flags ImGuiInputTextFlags|integer|"None"|"CharsDecimal"|"CharsHexadecimal"|"CharsScientific"|"CharsUppercase"|"CharsNoBlank"|"AllowTabInput"|"EnterReturnsTrue"|"EscapeClearsAll"|"CtrlEnterForNewLine"|"ReadOnly"|"Password"|"AlwaysOverwrite"|"AutoSelectAll"|"ParseEmptyRefVal"|"DisplayEmptyRefVal"|"NoHorizontalScroll"|"NoUndoRedo"|"CallbackCompletion"|"CallbackHistory"|"CallbackAlways"|"CallbackCharFilter"|"CallbackResize"|"CallbackEdit"
---@return boolean, string
function imgui.InputTextMultiline(label, input, maxLength, size, flags) end

---##### (READ-ONLY)
---@param label string
---@param hint string
---@param input string
---@param maxLength integer
---@return boolean, string
function imgui.InputTextWithHint(label, hint, input, maxLength) end

---##### (READ-ONLY)
---@param label string
---@param hint string
---@param input string
---@param maxLength integer
---@param flags ImGuiInputTextFlags|integer|"None"|"CharsDecimal"|"CharsHexadecimal"|"CharsScientific"|"CharsUppercase"|"CharsNoBlank"|"AllowTabInput"|"EnterReturnsTrue"|"EscapeClearsAll"|"CtrlEnterForNewLine"|"ReadOnly"|"Password"|"AlwaysOverwrite"|"AutoSelectAll"|"ParseEmptyRefVal"|"DisplayEmptyRefVal"|"NoHorizontalScroll"|"NoUndoRedo"|"CallbackCompletion"|"CallbackHistory"|"CallbackAlways"|"CallbackCharFilter"|"CallbackResize"|"CallbackEdit"
---@return boolean, string
function imgui.InputTextWithHint(label, hint, input, maxLength, flags) end

---##### (READ-ONLY)
---@param str_id string
---@param size Vector2
---@return boolean
function imgui.InvisibleButton(str_id, size) end

---##### (READ-ONLY)
---@param str_id string
---@param size Vector2
---@param flags ImGuiButtonFlags|integer|"None"|"MouseButtonLeft"|"MouseButtonRight"|"MouseButtonMiddle"|"MouseButtonMask"
---@return boolean
function imgui.InvisibleButton(str_id, size, flags) end

---##### (READ-ONLY)
---@return boolean
function imgui.IsAnyItemActive() end

---##### (READ-ONLY)
---@return boolean
function imgui.IsAnyItemFocused() end

---##### (READ-ONLY)
---@return boolean
function imgui.IsAnyItemHovered() end

---##### (READ-ONLY)
---@return boolean
function imgui.IsAnyMouseDown() end

---##### (READ-ONLY)
---@return boolean
function imgui.IsItemActivated() end

---##### (READ-ONLY)
---@return boolean
function imgui.IsItemActive() end

---##### (READ-ONLY)
---@return boolean
function imgui.IsItemClicked() end

---##### (READ-ONLY)
---@param mouse_button ImGuiMouseButton|0|1|2|5|"Left"|"Right"|"Middle"|"COUNT"
---@return boolean
function imgui.IsItemClicked(mouse_button) end

---##### (READ-ONLY)
---@return boolean
function imgui.IsItemDeactivated() end

---##### (READ-ONLY)
---@return boolean
function imgui.IsItemDeactivatedAfterEdit() end

---##### (READ-ONLY)
---@return boolean
function imgui.IsItemEdited() end

---##### (READ-ONLY)
---@return boolean
function imgui.IsItemFocused() end

---##### (READ-ONLY)
---@return boolean
function imgui.IsItemHovered() end

---##### (READ-ONLY)
---@param flags ImGuiHoveredFlags|integer|"None"|"ChildWindows"|"RootWindow"|"RootAndChildWindows"|"AnyWindow"|"NoPopupHierarchy"|"DockHierarchy"|"AllowWhenBlockedByPopup"|"AllowWhenBlockedByActiveItem"|"AllowWhenOverlappedByItem"|"AllowWhenOverlappedByWindow"|"AllowWhenOverlapped"|"RectOnly"|"AllowWhenDisabled"|"NoNavOverride"|"ForTooltip"|"Stationary"|"DelayNone"|"DelayShort"|"DelayNormal"|"NoSharedDelay"
---@return boolean
function imgui.IsItemHovered(flags) end

---##### (READ-ONLY)
---@return boolean
function imgui.IsItemToggledOpen() end

---##### (READ-ONLY)
---@return boolean
function imgui.IsItemToggledSelection() end

---##### (READ-ONLY)
---@return boolean
function imgui.IsItemVisible() end

---##### (READ-ONLY)
---@param key_chord ImGuiKey|0|154|512|513|514|515|516|517|518|519|520|521|522|523|524|525|526|527|528|529|530|531|532|533|534|535|536|537|538|539|540|541|542|543|544|545|546|547|548|549|550|551|552|553|554|555|556|557|558|559|560|561|562|563|564|565|566|567|568|569|570|571|572|573|574|575|576|577|578|579|580|581|582|583|584|585|586|587|588|589|590|591|592|593|594|595|596|597|598|599|600|601|602|603|604|605|606|607|608|609|610|611|612|613|614|615|616|617|618|619|620|621|622|623|624|625|626|627|628|629|630|631|632|633|634|635|636|637|638|639|640|641|642|643|644|645|646|647|648|649|650|651|652|653|654|655|656|657|658|659|660|661|662|663|664|665|666|4096|8192|16384|32768|61440|"None"|"ModNone"|"NamedKey_COUNT"|"KeysData_SIZE"|"NamedKey_BEGIN"|"KeysData_OFFSET"|"Tab"|"LeftArrow"|"RightArrow"|"UpArrow"|"DownArrow"|"PageUp"|"PageDown"|"Home"|"End"|"Insert"|"Delete"|"Backspace"|"Space"|"Enter"|"Escape"|"LeftCtrl"|"LeftShift"|"LeftAlt"|"LeftSuper"|"RightCtrl"|"RightShift"|"RightAlt"|"RightSuper"|"Menu"|"_0"|"_1"|"_2"|"_3"|"_4"|"_5"|"_6"|"_7"|"_8"|"_9"|"A"|"B"|"C"|"D"|"E"|"F"|"G"|"H"|"I"|"J"|"K"|"L"|"M"|"N"|"O"|"P"|"Q"|"R"|"S"|"T"|"U"|"V"|"W"|"X"|"Y"|"Z"|"F1"|"F2"|"F3"|"F4"|"F5"|"F6"|"F7"|"F8"|"F9"|"F10"|"F11"|"F12"|"F13"|"F14"|"F15"|"F16"|"F17"|"F18"|"F19"|"F20"|"F21"|"F22"|"F23"|"F24"|"Apostrophe"|"Comma"|"Minus"|"Period"|"Slash"|"Semicolon"|"Equal"|"LeftBracket"|"Backslash"|"RightBracket"|"GraveAccent"|"CapsLock"|"ScrollLock"|"NumLock"|"PrintScreen"|"Pause"|"Keypad0"|"Keypad1"|"Keypad2"|"Keypad3"|"Keypad4"|"Keypad5"|"Keypad6"|"Keypad7"|"Keypad8"|"Keypad9"|"KeypadDecimal"|"KeypadDivide"|"KeypadMultiply"|"KeypadSubtract"|"KeypadAdd"|"KeypadEnter"|"KeypadEqual"|"AppBack"|"AppForward"|"GamepadStart"|"GamepadBack"|"GamepadFaceLeft"|"GamepadFaceRight"|"GamepadFaceUp"|"GamepadFaceDown"|"GamepadDpadLeft"|"GamepadDpadRight"|"GamepadDpadUp"|"GamepadDpadDown"|"GamepadL1"|"GamepadR1"|"GamepadL2"|"GamepadR2"|"GamepadL3"|"GamepadR3"|"GamepadLStickLeft"|"GamepadLStickRight"|"GamepadLStickUp"|"GamepadLStickDown"|"GamepadRStickLeft"|"GamepadRStickRight"|"GamepadRStickUp"|"GamepadRStickDown"|"MouseLeft"|"MouseRight"|"MouseMiddle"|"MouseX1"|"MouseX2"|"MouseWheelX"|"MouseWheelY"|"ReservedForModCtrl"|"ReservedForModShift"|"ReservedForModAlt"|"ReservedForModSuper"|"COUNT"|"NamedKey_END"|"ModCtrl"|"ModShift"|"ModAlt"|"ModSuper"|"ModMask"
---@return boolean
function imgui.IsKeyChordPressed(key_chord) end

---##### (READ-ONLY)
---@param key ImGuiKey|0|154|512|513|514|515|516|517|518|519|520|521|522|523|524|525|526|527|528|529|530|531|532|533|534|535|536|537|538|539|540|541|542|543|544|545|546|547|548|549|550|551|552|553|554|555|556|557|558|559|560|561|562|563|564|565|566|567|568|569|570|571|572|573|574|575|576|577|578|579|580|581|582|583|584|585|586|587|588|589|590|591|592|593|594|595|596|597|598|599|600|601|602|603|604|605|606|607|608|609|610|611|612|613|614|615|616|617|618|619|620|621|622|623|624|625|626|627|628|629|630|631|632|633|634|635|636|637|638|639|640|641|642|643|644|645|646|647|648|649|650|651|652|653|654|655|656|657|658|659|660|661|662|663|664|665|666|4096|8192|16384|32768|61440|"None"|"ModNone"|"NamedKey_COUNT"|"KeysData_SIZE"|"NamedKey_BEGIN"|"KeysData_OFFSET"|"Tab"|"LeftArrow"|"RightArrow"|"UpArrow"|"DownArrow"|"PageUp"|"PageDown"|"Home"|"End"|"Insert"|"Delete"|"Backspace"|"Space"|"Enter"|"Escape"|"LeftCtrl"|"LeftShift"|"LeftAlt"|"LeftSuper"|"RightCtrl"|"RightShift"|"RightAlt"|"RightSuper"|"Menu"|"_0"|"_1"|"_2"|"_3"|"_4"|"_5"|"_6"|"_7"|"_8"|"_9"|"A"|"B"|"C"|"D"|"E"|"F"|"G"|"H"|"I"|"J"|"K"|"L"|"M"|"N"|"O"|"P"|"Q"|"R"|"S"|"T"|"U"|"V"|"W"|"X"|"Y"|"Z"|"F1"|"F2"|"F3"|"F4"|"F5"|"F6"|"F7"|"F8"|"F9"|"F10"|"F11"|"F12"|"F13"|"F14"|"F15"|"F16"|"F17"|"F18"|"F19"|"F20"|"F21"|"F22"|"F23"|"F24"|"Apostrophe"|"Comma"|"Minus"|"Period"|"Slash"|"Semicolon"|"Equal"|"LeftBracket"|"Backslash"|"RightBracket"|"GraveAccent"|"CapsLock"|"ScrollLock"|"NumLock"|"PrintScreen"|"Pause"|"Keypad0"|"Keypad1"|"Keypad2"|"Keypad3"|"Keypad4"|"Keypad5"|"Keypad6"|"Keypad7"|"Keypad8"|"Keypad9"|"KeypadDecimal"|"KeypadDivide"|"KeypadMultiply"|"KeypadSubtract"|"KeypadAdd"|"KeypadEnter"|"KeypadEqual"|"AppBack"|"AppForward"|"GamepadStart"|"GamepadBack"|"GamepadFaceLeft"|"GamepadFaceRight"|"GamepadFaceUp"|"GamepadFaceDown"|"GamepadDpadLeft"|"GamepadDpadRight"|"GamepadDpadUp"|"GamepadDpadDown"|"GamepadL1"|"GamepadR1"|"GamepadL2"|"GamepadR2"|"GamepadL3"|"GamepadR3"|"GamepadLStickLeft"|"GamepadLStickRight"|"GamepadLStickUp"|"GamepadLStickDown"|"GamepadRStickLeft"|"GamepadRStickRight"|"GamepadRStickUp"|"GamepadRStickDown"|"MouseLeft"|"MouseRight"|"MouseMiddle"|"MouseX1"|"MouseX2"|"MouseWheelX"|"MouseWheelY"|"ReservedForModCtrl"|"ReservedForModShift"|"ReservedForModAlt"|"ReservedForModSuper"|"COUNT"|"NamedKey_END"|"ModCtrl"|"ModShift"|"ModAlt"|"ModSuper"|"ModMask"
---@return boolean
function imgui.IsKeyDown(key) end

---##### (READ-ONLY)
---@param key ImGuiKey|0|154|512|513|514|515|516|517|518|519|520|521|522|523|524|525|526|527|528|529|530|531|532|533|534|535|536|537|538|539|540|541|542|543|544|545|546|547|548|549|550|551|552|553|554|555|556|557|558|559|560|561|562|563|564|565|566|567|568|569|570|571|572|573|574|575|576|577|578|579|580|581|582|583|584|585|586|587|588|589|590|591|592|593|594|595|596|597|598|599|600|601|602|603|604|605|606|607|608|609|610|611|612|613|614|615|616|617|618|619|620|621|622|623|624|625|626|627|628|629|630|631|632|633|634|635|636|637|638|639|640|641|642|643|644|645|646|647|648|649|650|651|652|653|654|655|656|657|658|659|660|661|662|663|664|665|666|4096|8192|16384|32768|61440|"None"|"ModNone"|"NamedKey_COUNT"|"KeysData_SIZE"|"NamedKey_BEGIN"|"KeysData_OFFSET"|"Tab"|"LeftArrow"|"RightArrow"|"UpArrow"|"DownArrow"|"PageUp"|"PageDown"|"Home"|"End"|"Insert"|"Delete"|"Backspace"|"Space"|"Enter"|"Escape"|"LeftCtrl"|"LeftShift"|"LeftAlt"|"LeftSuper"|"RightCtrl"|"RightShift"|"RightAlt"|"RightSuper"|"Menu"|"_0"|"_1"|"_2"|"_3"|"_4"|"_5"|"_6"|"_7"|"_8"|"_9"|"A"|"B"|"C"|"D"|"E"|"F"|"G"|"H"|"I"|"J"|"K"|"L"|"M"|"N"|"O"|"P"|"Q"|"R"|"S"|"T"|"U"|"V"|"W"|"X"|"Y"|"Z"|"F1"|"F2"|"F3"|"F4"|"F5"|"F6"|"F7"|"F8"|"F9"|"F10"|"F11"|"F12"|"F13"|"F14"|"F15"|"F16"|"F17"|"F18"|"F19"|"F20"|"F21"|"F22"|"F23"|"F24"|"Apostrophe"|"Comma"|"Minus"|"Period"|"Slash"|"Semicolon"|"Equal"|"LeftBracket"|"Backslash"|"RightBracket"|"GraveAccent"|"CapsLock"|"ScrollLock"|"NumLock"|"PrintScreen"|"Pause"|"Keypad0"|"Keypad1"|"Keypad2"|"Keypad3"|"Keypad4"|"Keypad5"|"Keypad6"|"Keypad7"|"Keypad8"|"Keypad9"|"KeypadDecimal"|"KeypadDivide"|"KeypadMultiply"|"KeypadSubtract"|"KeypadAdd"|"KeypadEnter"|"KeypadEqual"|"AppBack"|"AppForward"|"GamepadStart"|"GamepadBack"|"GamepadFaceLeft"|"GamepadFaceRight"|"GamepadFaceUp"|"GamepadFaceDown"|"GamepadDpadLeft"|"GamepadDpadRight"|"GamepadDpadUp"|"GamepadDpadDown"|"GamepadL1"|"GamepadR1"|"GamepadL2"|"GamepadR2"|"GamepadL3"|"GamepadR3"|"GamepadLStickLeft"|"GamepadLStickRight"|"GamepadLStickUp"|"GamepadLStickDown"|"GamepadRStickLeft"|"GamepadRStickRight"|"GamepadRStickUp"|"GamepadRStickDown"|"MouseLeft"|"MouseRight"|"MouseMiddle"|"MouseX1"|"MouseX2"|"MouseWheelX"|"MouseWheelY"|"ReservedForModCtrl"|"ReservedForModShift"|"ReservedForModAlt"|"ReservedForModSuper"|"COUNT"|"NamedKey_END"|"ModCtrl"|"ModShift"|"ModAlt"|"ModSuper"|"ModMask"
---@return boolean
function imgui.IsKeyPressed(key) end

---##### (READ-ONLY)
---@param key ImGuiKey|0|154|512|513|514|515|516|517|518|519|520|521|522|523|524|525|526|527|528|529|530|531|532|533|534|535|536|537|538|539|540|541|542|543|544|545|546|547|548|549|550|551|552|553|554|555|556|557|558|559|560|561|562|563|564|565|566|567|568|569|570|571|572|573|574|575|576|577|578|579|580|581|582|583|584|585|586|587|588|589|590|591|592|593|594|595|596|597|598|599|600|601|602|603|604|605|606|607|608|609|610|611|612|613|614|615|616|617|618|619|620|621|622|623|624|625|626|627|628|629|630|631|632|633|634|635|636|637|638|639|640|641|642|643|644|645|646|647|648|649|650|651|652|653|654|655|656|657|658|659|660|661|662|663|664|665|666|4096|8192|16384|32768|61440|"None"|"ModNone"|"NamedKey_COUNT"|"KeysData_SIZE"|"NamedKey_BEGIN"|"KeysData_OFFSET"|"Tab"|"LeftArrow"|"RightArrow"|"UpArrow"|"DownArrow"|"PageUp"|"PageDown"|"Home"|"End"|"Insert"|"Delete"|"Backspace"|"Space"|"Enter"|"Escape"|"LeftCtrl"|"LeftShift"|"LeftAlt"|"LeftSuper"|"RightCtrl"|"RightShift"|"RightAlt"|"RightSuper"|"Menu"|"_0"|"_1"|"_2"|"_3"|"_4"|"_5"|"_6"|"_7"|"_8"|"_9"|"A"|"B"|"C"|"D"|"E"|"F"|"G"|"H"|"I"|"J"|"K"|"L"|"M"|"N"|"O"|"P"|"Q"|"R"|"S"|"T"|"U"|"V"|"W"|"X"|"Y"|"Z"|"F1"|"F2"|"F3"|"F4"|"F5"|"F6"|"F7"|"F8"|"F9"|"F10"|"F11"|"F12"|"F13"|"F14"|"F15"|"F16"|"F17"|"F18"|"F19"|"F20"|"F21"|"F22"|"F23"|"F24"|"Apostrophe"|"Comma"|"Minus"|"Period"|"Slash"|"Semicolon"|"Equal"|"LeftBracket"|"Backslash"|"RightBracket"|"GraveAccent"|"CapsLock"|"ScrollLock"|"NumLock"|"PrintScreen"|"Pause"|"Keypad0"|"Keypad1"|"Keypad2"|"Keypad3"|"Keypad4"|"Keypad5"|"Keypad6"|"Keypad7"|"Keypad8"|"Keypad9"|"KeypadDecimal"|"KeypadDivide"|"KeypadMultiply"|"KeypadSubtract"|"KeypadAdd"|"KeypadEnter"|"KeypadEqual"|"AppBack"|"AppForward"|"GamepadStart"|"GamepadBack"|"GamepadFaceLeft"|"GamepadFaceRight"|"GamepadFaceUp"|"GamepadFaceDown"|"GamepadDpadLeft"|"GamepadDpadRight"|"GamepadDpadUp"|"GamepadDpadDown"|"GamepadL1"|"GamepadR1"|"GamepadL2"|"GamepadR2"|"GamepadL3"|"GamepadR3"|"GamepadLStickLeft"|"GamepadLStickRight"|"GamepadLStickUp"|"GamepadLStickDown"|"GamepadRStickLeft"|"GamepadRStickRight"|"GamepadRStickUp"|"GamepadRStickDown"|"MouseLeft"|"MouseRight"|"MouseMiddle"|"MouseX1"|"MouseX2"|"MouseWheelX"|"MouseWheelY"|"ReservedForModCtrl"|"ReservedForModShift"|"ReservedForModAlt"|"ReservedForModSuper"|"COUNT"|"NamedKey_END"|"ModCtrl"|"ModShift"|"ModAlt"|"ModSuper"|"ModMask"
---@param repeating boolean
---@return boolean
function imgui.IsKeyPressed(key, repeating) end

---##### (READ-ONLY)
---@param key ImGuiKey|0|154|512|513|514|515|516|517|518|519|520|521|522|523|524|525|526|527|528|529|530|531|532|533|534|535|536|537|538|539|540|541|542|543|544|545|546|547|548|549|550|551|552|553|554|555|556|557|558|559|560|561|562|563|564|565|566|567|568|569|570|571|572|573|574|575|576|577|578|579|580|581|582|583|584|585|586|587|588|589|590|591|592|593|594|595|596|597|598|599|600|601|602|603|604|605|606|607|608|609|610|611|612|613|614|615|616|617|618|619|620|621|622|623|624|625|626|627|628|629|630|631|632|633|634|635|636|637|638|639|640|641|642|643|644|645|646|647|648|649|650|651|652|653|654|655|656|657|658|659|660|661|662|663|664|665|666|4096|8192|16384|32768|61440|"None"|"ModNone"|"NamedKey_COUNT"|"KeysData_SIZE"|"NamedKey_BEGIN"|"KeysData_OFFSET"|"Tab"|"LeftArrow"|"RightArrow"|"UpArrow"|"DownArrow"|"PageUp"|"PageDown"|"Home"|"End"|"Insert"|"Delete"|"Backspace"|"Space"|"Enter"|"Escape"|"LeftCtrl"|"LeftShift"|"LeftAlt"|"LeftSuper"|"RightCtrl"|"RightShift"|"RightAlt"|"RightSuper"|"Menu"|"_0"|"_1"|"_2"|"_3"|"_4"|"_5"|"_6"|"_7"|"_8"|"_9"|"A"|"B"|"C"|"D"|"E"|"F"|"G"|"H"|"I"|"J"|"K"|"L"|"M"|"N"|"O"|"P"|"Q"|"R"|"S"|"T"|"U"|"V"|"W"|"X"|"Y"|"Z"|"F1"|"F2"|"F3"|"F4"|"F5"|"F6"|"F7"|"F8"|"F9"|"F10"|"F11"|"F12"|"F13"|"F14"|"F15"|"F16"|"F17"|"F18"|"F19"|"F20"|"F21"|"F22"|"F23"|"F24"|"Apostrophe"|"Comma"|"Minus"|"Period"|"Slash"|"Semicolon"|"Equal"|"LeftBracket"|"Backslash"|"RightBracket"|"GraveAccent"|"CapsLock"|"ScrollLock"|"NumLock"|"PrintScreen"|"Pause"|"Keypad0"|"Keypad1"|"Keypad2"|"Keypad3"|"Keypad4"|"Keypad5"|"Keypad6"|"Keypad7"|"Keypad8"|"Keypad9"|"KeypadDecimal"|"KeypadDivide"|"KeypadMultiply"|"KeypadSubtract"|"KeypadAdd"|"KeypadEnter"|"KeypadEqual"|"AppBack"|"AppForward"|"GamepadStart"|"GamepadBack"|"GamepadFaceLeft"|"GamepadFaceRight"|"GamepadFaceUp"|"GamepadFaceDown"|"GamepadDpadLeft"|"GamepadDpadRight"|"GamepadDpadUp"|"GamepadDpadDown"|"GamepadL1"|"GamepadR1"|"GamepadL2"|"GamepadR2"|"GamepadL3"|"GamepadR3"|"GamepadLStickLeft"|"GamepadLStickRight"|"GamepadLStickUp"|"GamepadLStickDown"|"GamepadRStickLeft"|"GamepadRStickRight"|"GamepadRStickUp"|"GamepadRStickDown"|"MouseLeft"|"MouseRight"|"MouseMiddle"|"MouseX1"|"MouseX2"|"MouseWheelX"|"MouseWheelY"|"ReservedForModCtrl"|"ReservedForModShift"|"ReservedForModAlt"|"ReservedForModSuper"|"COUNT"|"NamedKey_END"|"ModCtrl"|"ModShift"|"ModAlt"|"ModSuper"|"ModMask"
---@return boolean
function imgui.IsKeyReleased(key) end

---##### (READ-ONLY)
---@param button ImGuiMouseButton|0|1|2|5|"Left"|"Right"|"Middle"|"COUNT"
---@return boolean
function imgui.IsMouseClicked(button) end

---##### (READ-ONLY)
---@param button ImGuiMouseButton|0|1|2|5|"Left"|"Right"|"Middle"|"COUNT"
---@param repeating boolean
---@return boolean
function imgui.IsMouseClicked(button, repeating) end

---##### (READ-ONLY)
---@param button ImGuiMouseButton|0|1|2|5|"Left"|"Right"|"Middle"|"COUNT"
---@return boolean
function imgui.IsMouseDoubleClicked(button) end

---##### (READ-ONLY)
---@param button ImGuiMouseButton|0|1|2|5|"Left"|"Right"|"Middle"|"COUNT"
---@return boolean
function imgui.IsMouseDown(button) end

---##### (READ-ONLY)
---@return boolean
function imgui.IsMouseDragging() end

---##### (READ-ONLY)
---@param button ImGuiMouseButton|0|1|2|5|"Left"|"Right"|"Middle"|"COUNT"
---@return boolean
function imgui.IsMouseDragging(button) end

---##### (READ-ONLY)
---@param button ImGuiMouseButton|0|1|2|5|"Left"|"Right"|"Middle"|"COUNT"
---@param lock_threshold number
---@return boolean
function imgui.IsMouseDragging(button, lock_threshold) end

---##### (READ-ONLY)
---@param r_min Vector2
---@param r_max Vector2
---@return boolean
function imgui.IsMouseHoveringRect(r_min, r_max) end

---##### (READ-ONLY)
---@param r_min Vector2
---@param r_max Vector2
---@param clip boolean
---@return boolean
function imgui.IsMouseHoveringRect(r_min, r_max, clip) end

---##### (READ-ONLY)
---@return boolean
function imgui.IsMousePosValid() end

---##### (READ-ONLY)
---@param mouse_pos Vector2
---@return boolean, Vector2
function imgui.IsMousePosValid(mouse_pos) end

---##### (READ-ONLY)
---@param button ImGuiMouseButton|0|1|2|5|"Left"|"Right"|"Middle"|"COUNT"
---@return boolean
function imgui.IsMouseReleased(button) end

---##### (READ-ONLY)
---@param str_id string
---@return boolean
function imgui.IsPopupOpen(str_id) end

---##### (READ-ONLY)
---@param str_id string
---@param flags ImGuiPopupFlags|integer|"None"|"MouseButtonLeft"|"MouseButtonRight"|"MouseButtonDefault"|"MouseButtonMiddle"|"MouseButtonMask"|"NoReopen"|"NoOpenOverExistingPopup"|"NoOpenOverItems"|"AnyPopupId"|"AnyPopupLevel"|"AnyPopup"
---@return boolean
function imgui.IsPopupOpen(str_id, flags) end

---##### (READ-ONLY)
---@param size Vector2
---@return boolean
function imgui.IsRectVisible(size) end

---##### (READ-ONLY)
---@param rect_min Vector2
---@param rect_max Vector2
---@return boolean
function imgui.IsRectVisible(rect_min, rect_max) end

---##### (READ-ONLY)
---@return boolean
function imgui.IsWindowAppearing() end

---##### (READ-ONLY)
---@return boolean
function imgui.IsWindowCollapsed() end

---##### (READ-ONLY)
---@return boolean
function imgui.IsWindowDocked() end

---##### (READ-ONLY)
---@return boolean
function imgui.IsWindowFocused() end

---##### (READ-ONLY)
---@param flags ImGuiFocusedFlags|integer|"None"|"ChildWindows"|"RootWindow"|"RootAndChildWindows"|"AnyWindow"|"NoPopupHierarchy"|"DockHierarchy"
---@return boolean
function imgui.IsWindowFocused(flags) end

---##### (READ-ONLY)
---@return boolean
function imgui.IsWindowHovered() end

---##### (READ-ONLY)
---@param flags ImGuiHoveredFlags|integer|"None"|"ChildWindows"|"RootWindow"|"RootAndChildWindows"|"AnyWindow"|"NoPopupHierarchy"|"DockHierarchy"|"AllowWhenBlockedByPopup"|"AllowWhenBlockedByActiveItem"|"AllowWhenOverlappedByItem"|"AllowWhenOverlappedByWindow"|"AllowWhenOverlapped"|"RectOnly"|"AllowWhenDisabled"|"NoNavOverride"|"ForTooltip"|"Stationary"|"DelayNone"|"DelayShort"|"DelayNormal"|"NoSharedDelay"
---@return boolean
function imgui.IsWindowHovered(flags) end

---##### (READ-ONLY)
---@param label string
---@param fmt string
function imgui.LabelText(label, fmt) end

---##### (READ-ONLY)
---@param label string
---@param current_item integer
---@param items string[]
---@param items_count integer
---@return boolean, integer
function imgui.ListBox(label, current_item, items, items_count) end

---##### (READ-ONLY)
---@param label string
---@param current_item integer
---@param items string[]
---@param items_count integer
---@param height_in_items integer
---@return boolean, integer
function imgui.ListBox(label, current_item, items, items_count, height_in_items) end

---##### (READ-ONLY)
---@param ini_filename string
function imgui.LoadIniSettingsFromDisk(ini_filename) end

---##### (READ-ONLY)
---@param ini_data string
function imgui.LoadIniSettingsFromMemory(ini_data) end

---##### (READ-ONLY)
---@param ini_data string
---@param ini_size integer
function imgui.LoadIniSettingsFromMemory(ini_data, ini_size) end

---##### (READ-ONLY)
function imgui.LogButtons() end

---##### (READ-ONLY)
function imgui.LogFinish() end

---##### (READ-ONLY)
---@param fmt string
function imgui.LogText(fmt) end

---##### (READ-ONLY)
function imgui.LogToClipboard() end

---##### (READ-ONLY)
---@param auto_open_depth integer
function imgui.LogToClipboard(auto_open_depth) end

---##### (READ-ONLY)
function imgui.LogToFile() end

---##### (READ-ONLY)
---@param auto_open_depth integer
function imgui.LogToFile(auto_open_depth) end

---##### (READ-ONLY)
---@param auto_open_depth integer
---@param filename string
function imgui.LogToFile(auto_open_depth, filename) end

---##### (READ-ONLY)
function imgui.LogToTTY() end

---##### (READ-ONLY)
---@param auto_open_depth integer
function imgui.LogToTTY(auto_open_depth) end

---##### (READ-ONLY)
---@param size integer
---@return lightuserdata
function imgui.MemAlloc(size) end

---##### (READ-ONLY)
---@param ptr lightuserdata
function imgui.MemFree(ptr) end

---##### (READ-ONLY)
---@param label string
---@return boolean
function imgui.MenuItem(label) end

---##### (READ-ONLY)
---@param label string
---@param shortcut string
---@return boolean
function imgui.MenuItem(label, shortcut) end

---##### (READ-ONLY)
---@param label string
---@param shortcut string
---@param selected boolean
---@return boolean
function imgui.MenuItem(label, shortcut, selected) end

---##### (READ-ONLY)
---@param label string
---@param shortcut string
---@param selected boolean
---@param enabled boolean
---@return boolean
function imgui.MenuItem(label, shortcut, selected, enabled) end

---##### (READ-ONLY)
---@param label string
---@param shortcut string
---@param p_selected boolean
---@return boolean, boolean
function imgui.MenuItem(label, shortcut, p_selected) end

---##### (READ-ONLY)
---@param label string
---@param shortcut string
---@param p_selected boolean
---@param enabled boolean
---@return boolean, boolean
function imgui.MenuItem(label, shortcut, p_selected, enabled) end

---##### (READ-ONLY)
---@param label string
---@param enabled boolean
---@return boolean
function imgui.MenuItem(label, enabled) end

---##### (READ-ONLY)
function imgui.NewFrame() end

---##### (READ-ONLY)
function imgui.NewLine() end

---##### (READ-ONLY)
function imgui.NextColumn() end

---##### (READ-ONLY)
---@param str_id string
function imgui.OpenPopup(str_id) end

---##### (READ-ONLY)
---@param str_id string
---@param popup_flags ImGuiPopupFlags|integer|"None"|"MouseButtonLeft"|"MouseButtonRight"|"MouseButtonDefault"|"MouseButtonMiddle"|"MouseButtonMask"|"NoReopen"|"NoOpenOverExistingPopup"|"NoOpenOverItems"|"AnyPopupId"|"AnyPopupLevel"|"AnyPopup"
function imgui.OpenPopup(str_id, popup_flags) end

---##### (READ-ONLY)
---@param id integer
function imgui.OpenPopup(id) end

---##### (READ-ONLY)
---@param id integer
---@param popup_flags ImGuiPopupFlags|integer|"None"|"MouseButtonLeft"|"MouseButtonRight"|"MouseButtonDefault"|"MouseButtonMiddle"|"MouseButtonMask"|"NoReopen"|"NoOpenOverExistingPopup"|"NoOpenOverItems"|"AnyPopupId"|"AnyPopupLevel"|"AnyPopup"
function imgui.OpenPopup(id, popup_flags) end

---##### (READ-ONLY)
function imgui.OpenPopupOnItemClick() end

---##### (READ-ONLY)
---@param str_id string
function imgui.OpenPopupOnItemClick(str_id) end

---##### (READ-ONLY)
---@param str_id string
---@param popup_flags ImGuiPopupFlags|integer|"None"|"MouseButtonLeft"|"MouseButtonRight"|"MouseButtonDefault"|"MouseButtonMiddle"|"MouseButtonMask"|"NoReopen"|"NoOpenOverExistingPopup"|"NoOpenOverItems"|"AnyPopupId"|"AnyPopupLevel"|"AnyPopup"
function imgui.OpenPopupOnItemClick(str_id, popup_flags) end

---##### (READ-ONLY)
---@param label string
---@param values number[]
function imgui.PlotHistogram(label, values) end

---##### (READ-ONLY)
---@param label string
---@param values number[]
---@param values_count integer
function imgui.PlotHistogram(label, values, values_count) end

---##### (READ-ONLY)
---@param label string
---@param values number[]
---@param values_count integer
---@param values_offset integer
function imgui.PlotHistogram(label, values, values_count, values_offset) end

---##### (READ-ONLY)
---@param label string
---@param values number[]
---@param values_count integer
---@param values_offset integer
---@param overlay_text string
function imgui.PlotHistogram(label, values, values_count, values_offset, overlay_text) end

---##### (READ-ONLY)
---@param label string
---@param values number[]
---@param values_count integer
---@param values_offset integer
---@param overlay_text string
---@param scale_min number
function imgui.PlotHistogram(label, values, values_count, values_offset, overlay_text, scale_min) end

---##### (READ-ONLY)
---@param label string
---@param values number[]
---@param values_count integer
---@param values_offset integer
---@param overlay_text string
---@param scale_min number
---@param scale_max number
function imgui.PlotHistogram(label, values, values_count, values_offset, overlay_text, scale_min, scale_max) end

---##### (READ-ONLY)
---@param label string
---@param values number[]
---@param values_count integer
---@param values_offset integer
---@param overlay_text string
---@param scale_min number
---@param scale_max number
---@param graph_size Vector2
function imgui.PlotHistogram(label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size) end

---##### (READ-ONLY)
---@param label string
---@param values number[]
---@param values_count integer
---@param values_offset integer
---@param overlay_text string
---@param scale_min number
---@param scale_max number
---@param graph_size Vector2
---@param stride integer
function imgui.PlotHistogram(label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size,
                             stride)
end

---##### (READ-ONLY)
---@param label string
---@param values number[]
function imgui.PlotLines(label, values) end

---##### (READ-ONLY)
---@param label string
---@param values number[]
---@param values_count integer
function imgui.PlotLines(label, values, values_count) end

---##### (READ-ONLY)
---@param label string
---@param values number[]
---@param values_count integer
---@param values_offset integer
function imgui.PlotLines(label, values, values_count, values_offset) end

---##### (READ-ONLY)
---@param label string
---@param values number[]
---@param values_count integer
---@param values_offset integer
---@param overlay_text string
function imgui.PlotLines(label, values, values_count, values_offset, overlay_text) end

---##### (READ-ONLY)
---@param label string
---@param values number[]
---@param values_count integer
---@param values_offset integer
---@param overlay_text string
---@param scale_min number
function imgui.PlotLines(label, values, values_count, values_offset, overlay_text, scale_min) end

---##### (READ-ONLY)
---@param label string
---@param values number[]
---@param values_count integer
---@param values_offset integer
---@param overlay_text string
---@param scale_min number
---@param scale_max number
function imgui.PlotLines(label, values, values_count, values_offset, overlay_text, scale_min, scale_max) end

---##### (READ-ONLY)
---@param label string
---@param values number[]
---@param values_count integer
---@param values_offset integer
---@param overlay_text string
---@param scale_min number
---@param scale_max number
---@param graph_size Vector2
function imgui.PlotLines(label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size) end

---##### (READ-ONLY)
---@param label string
---@param values number[]
---@param values_count integer
---@param values_offset integer
---@param overlay_text string
---@param scale_min number
---@param scale_max number
---@param graph_size Vector2
---@param stride integer
function imgui.PlotLines(label, values, values_count, values_offset, overlay_text, scale_min, scale_max, graph_size,
                         stride)
end

---##### (READ-ONLY)
function imgui.PopClipRect() end

---##### (READ-ONLY)
function imgui.PopFont() end

---##### (READ-ONLY)
function imgui.PopID() end

---##### (READ-ONLY)
function imgui.PopItemFlag() end

---##### (READ-ONLY)
function imgui.PopItemWidth() end

---##### (READ-ONLY)
function imgui.PopStyleColor() end

---##### (READ-ONLY)
---@param count integer
function imgui.PopStyleColor(count) end

---##### (READ-ONLY)
function imgui.PopStyleVar() end

---##### (READ-ONLY)
---@param count integer
function imgui.PopStyleVar(count) end

---##### (READ-ONLY)
function imgui.PopTextWrapPos() end

---##### (READ-ONLY)
---@param fraction number
function imgui.ProgressBar(fraction) end

---##### (READ-ONLY)
---@param fraction number
---@param size_arg Vector2
function imgui.ProgressBar(fraction, size_arg) end

---##### (READ-ONLY)
---@param fraction number
---@param size_arg Vector2
---@param overlay string
function imgui.ProgressBar(fraction, size_arg, overlay) end

---##### (READ-ONLY)
function imgui.PushAllowKeyboardFocus() end

---##### (READ-ONLY)
function imgui.PushButtonRepeat() end

---##### (READ-ONLY)
---@param clip_rect_min Vector2
---@param clip_rect_max Vector2
---@param intersect_with_current_clip_rect boolean
function imgui.PushClipRect(clip_rect_min, clip_rect_max, intersect_with_current_clip_rect) end

---##### (READ-ONLY)
---@param font ImFontPtr
function imgui.PushFont(font) end

---##### (READ-ONLY)
---@param str_id string
function imgui.PushID(str_id) end

---##### (READ-ONLY)
---@param ptr_id lightuserdata
function imgui.PushID(ptr_id) end

---##### (READ-ONLY)
---@param int_id integer
function imgui.PushID(int_id) end

---##### (READ-ONLY)
---@param option ImGuiItemFlags|integer|"None"|"NoTabStop"|"NoNav"|"NoNavDefaultFocus"|"ButtonRepeat"|"AutoClosePopups"
---@param enabled boolean
function imgui.PushItemFlag(option, enabled) end

---##### (READ-ONLY)
---@param item_width number
function imgui.PushItemWidth(item_width) end

---##### (READ-ONLY)
---@param idx ImGuiCol|0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|"Text"|"TextDisabled"|"WindowBg"|"ChildBg"|"PopupBg"|"Border"|"BorderShadow"|"FrameBg"|"FrameBgHovered"|"FrameBgActive"|"TitleBg"|"TitleBgActive"|"TitleBgCollapsed"|"MenuBarBg"|"ScrollbarBg"|"ScrollbarGrab"|"ScrollbarGrabHovered"|"ScrollbarGrabActive"|"CheckMark"|"SliderGrab"|"SliderGrabActive"|"Button"|"ButtonHovered"|"ButtonActive"|"Header"|"HeaderHovered"|"HeaderActive"|"Separator"|"SeparatorHovered"|"SeparatorActive"|"ResizeGrip"|"ResizeGripHovered"|"ResizeGripActive"|"TabHovered"|"Tab"|"TabSelected"|"TabSelectedOverline"|"TabDimmed"|"TabDimmedSelected"|"TabDimmedSelectedOverline"|"DockingPreview"|"DockingEmptyBg"|"PlotLines"|"PlotLinesHovered"|"PlotHistogram"|"PlotHistogramHovered"|"TableHeaderBg"|"TableBorderStrong"|"TableBorderLight"|"TableRowBg"|"TableRowBgAlt"|"TextLink"|"TextSelectedBg"|"DragDropTarget"|"NavHighlight"|"NavWindowingHighlight"|"NavWindowingDimBg"|"ModalWindowDimBg"|"COUNT"
---@param col integer
function imgui.PushStyleColor(idx, col) end

---##### (READ-ONLY)
---@param idx ImGuiCol|0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|"Text"|"TextDisabled"|"WindowBg"|"ChildBg"|"PopupBg"|"Border"|"BorderShadow"|"FrameBg"|"FrameBgHovered"|"FrameBgActive"|"TitleBg"|"TitleBgActive"|"TitleBgCollapsed"|"MenuBarBg"|"ScrollbarBg"|"ScrollbarGrab"|"ScrollbarGrabHovered"|"ScrollbarGrabActive"|"CheckMark"|"SliderGrab"|"SliderGrabActive"|"Button"|"ButtonHovered"|"ButtonActive"|"Header"|"HeaderHovered"|"HeaderActive"|"Separator"|"SeparatorHovered"|"SeparatorActive"|"ResizeGrip"|"ResizeGripHovered"|"ResizeGripActive"|"TabHovered"|"Tab"|"TabSelected"|"TabSelectedOverline"|"TabDimmed"|"TabDimmedSelected"|"TabDimmedSelectedOverline"|"DockingPreview"|"DockingEmptyBg"|"PlotLines"|"PlotLinesHovered"|"PlotHistogram"|"PlotHistogramHovered"|"TableHeaderBg"|"TableBorderStrong"|"TableBorderLight"|"TableRowBg"|"TableRowBgAlt"|"TextLink"|"TextSelectedBg"|"DragDropTarget"|"NavHighlight"|"NavWindowingHighlight"|"NavWindowingDimBg"|"ModalWindowDimBg"|"COUNT"
---@param col Vector4
function imgui.PushStyleColor(idx, col) end

---##### (READ-ONLY)
---@param idx ImGuiStyleVar|0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|"Alpha"|"DisabledAlpha"|"WindowPadding"|"WindowRounding"|"WindowBorderSize"|"WindowMinSize"|"WindowTitleAlign"|"ChildRounding"|"ChildBorderSize"|"PopupRounding"|"PopupBorderSize"|"FramePadding"|"FrameRounding"|"FrameBorderSize"|"ItemSpacing"|"ItemInnerSpacing"|"IndentSpacing"|"CellPadding"|"ScrollbarSize"|"ScrollbarRounding"|"GrabMinSize"|"GrabRounding"|"TabRounding"|"TabBorderSize"|"TabBarBorderSize"|"TabBarOverlineSize"|"TableAngledHeadersAngle"|"TableAngledHeadersTextAlign"|"ButtonTextAlign"|"SelectableTextAlign"|"SeparatorTextBorderSize"|"SeparatorTextAlign"|"SeparatorTextPadding"|"DockingSeparatorSize"|"COUNT"
---@param val number
function imgui.PushStyleVar(idx, val) end

---##### (READ-ONLY)
---@param idx ImGuiStyleVar|0|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|"Alpha"|"DisabledAlpha"|"WindowPadding"|"WindowRounding"|"WindowBorderSize"|"WindowMinSize"|"WindowTitleAlign"|"ChildRounding"|"ChildBorderSize"|"PopupRounding"|"PopupBorderSize"|"FramePadding"|"FrameRounding"|"FrameBorderSize"|"ItemSpacing"|"ItemInnerSpacing"|"IndentSpacing"|"CellPadding"|"ScrollbarSize"|"ScrollbarRounding"|"GrabMinSize"|"GrabRounding"|"TabRounding"|"TabBorderSize"|"TabBarBorderSize"|"TabBarOverlineSize"|"TableAngledHeadersAngle"|"TableAngledHeadersTextAlign"|"ButtonTextAlign"|"SelectableTextAlign"|"SeparatorTextBorderSize"|"SeparatorTextAlign"|"SeparatorTextPadding"|"DockingSeparatorSize"|"COUNT"
---@param val Vector2
function imgui.PushStyleVar(idx, val) end

---##### (READ-ONLY)
function imgui.PushTabStop() end

---##### (READ-ONLY)
function imgui.PushTextWrapPos() end

---##### (READ-ONLY)
---@param wrap_local_pos_x number
function imgui.PushTextWrapPos(wrap_local_pos_x) end

---##### (READ-ONLY)
---@param label string
---@param active boolean
---@return boolean
function imgui.RadioButton(label, active) end

---##### (READ-ONLY)
---@param label string
---@param v integer
---@param v_button integer
---@return boolean, integer
function imgui.RadioButton(label, v, v_button) end

---##### (READ-ONLY)
function imgui.Render() end

---##### (READ-ONLY)
function imgui.RenderPlatformWindowsDefault() end

---##### (READ-ONLY)
---@param platform_render_arg lightuserdata
function imgui.RenderPlatformWindowsDefault(platform_render_arg) end

---##### (READ-ONLY)
---@param platform_render_arg lightuserdata
---@param renderer_render_arg lightuserdata
function imgui.RenderPlatformWindowsDefault(platform_render_arg, renderer_render_arg) end

---##### (READ-ONLY)
function imgui.ResetMouseDragDelta() end

---##### (READ-ONLY)
---@param button ImGuiMouseButton|0|1|2|5|"Left"|"Right"|"Middle"|"COUNT"
function imgui.ResetMouseDragDelta(button) end

---##### (READ-ONLY)
function imgui.SameLine() end

---##### (READ-ONLY)
---@param offset_from_start_x number
function imgui.SameLine(offset_from_start_x) end

---##### (READ-ONLY)
---@param offset_from_start_x number
---@param spacing number
function imgui.SameLine(offset_from_start_x, spacing) end

---@deprecated
---##### (READ-ONLY)
---#### Use the `write()` global for persistent storage instead.
---@param ini_filename string
function imgui.SaveIniSettingsToDisk(ini_filename) end

---##### (READ-ONLY)
---@return string
function imgui.SaveIniSettingsToMemory() end

---##### (READ-ONLY)
---@param out_ini_size integer
---@return string, integer
function imgui.SaveIniSettingsToMemory(out_ini_size) end

---##### (READ-ONLY)
---@param label string
---@return boolean
function imgui.Selectable(label) end

---##### (READ-ONLY)
---@param label string
---@param selected boolean
---@return boolean
function imgui.Selectable(label, selected) end

---##### (READ-ONLY)
---@param label string
---@param selected boolean
---@param flags ImGuiSelectableFlags|integer|"None"|"NoAutoClosePopups"|"SpanAllColumns"|"AllowDoubleClick"|"Disabled"|"AllowOverlap"|"Highlight"
---@return boolean
function imgui.Selectable(label, selected, flags) end

---##### (READ-ONLY)
---@param label string
---@param selected boolean
---@param flags ImGuiSelectableFlags|integer|"None"|"NoAutoClosePopups"|"SpanAllColumns"|"AllowDoubleClick"|"Disabled"|"AllowOverlap"|"Highlight"
---@param size Vector2
---@return boolean
function imgui.Selectable(label, selected, flags, size) end

---##### (READ-ONLY)
---@param label string
---@param p_selected boolean
---@return boolean, boolean
function imgui.Selectable(label, p_selected) end

---##### (READ-ONLY)
---@param label string
---@param p_selected boolean
---@param flags ImGuiSelectableFlags|integer|"None"|"NoAutoClosePopups"|"SpanAllColumns"|"AllowDoubleClick"|"Disabled"|"AllowOverlap"|"Highlight"
---@return boolean, boolean
function imgui.Selectable(label, p_selected, flags) end

---##### (READ-ONLY)
---@param label string
---@param p_selected boolean
---@param flags ImGuiSelectableFlags|integer|"None"|"NoAutoClosePopups"|"SpanAllColumns"|"AllowDoubleClick"|"Disabled"|"AllowOverlap"|"Highlight"
---@param size Vector2
---@return boolean, boolean
function imgui.Selectable(label, p_selected, flags, size) end

---##### (READ-ONLY)
function imgui.Separator() end

---##### (READ-ONLY)
---@param label string
function imgui.SeparatorText(label) end

---##### (READ-ONLY)
---@param alloc_func lightuserdata
---@param free_func lightuserdata
function imgui.SetAllocatorFunctions(alloc_func, free_func) end

---##### (READ-ONLY)
---@param alloc_func lightuserdata
---@param free_func lightuserdata
---@param user_data lightuserdata
function imgui.SetAllocatorFunctions(alloc_func, free_func, user_data) end

---##### (READ-ONLY)
---@param text string
function imgui.SetClipboardText(text) end

---##### (READ-ONLY)
---@param flags ImGuiColorEditFlags|integer|"None"|"NoAlpha"|"NoPicker"|"NoOptions"|"NoSmallPreview"|"NoInputs"|"NoTooltip"|"NoLabel"|"NoSidePreview"|"NoDragDrop"|"NoBorder"|"AlphaBar"|"AlphaPreview"|"AlphaPreviewHalf"|"HDR"|"DisplayRGB"|"DisplayHSV"|"DisplayHex"|"DisplayMask"|"Uint8"|"Float"|"DataTypeMask"|"PickerHueBar"|"PickerHueWheel"|"PickerMask"|"InputRGB"|"DefaultOptions"|"InputHSV"|"InputMask"
function imgui.SetColorEditOptions(flags) end

---##### (READ-ONLY)
---@param column_index integer
---@param offset_x number
function imgui.SetColumnOffset(column_index, offset_x) end

---##### (READ-ONLY)
---@param column_index integer
---@param width number
function imgui.SetColumnWidth(column_index, width) end

---##### (READ-ONLY)
---@param ctx lightuserdata
function imgui.SetCurrentContext(ctx) end

---##### (READ-ONLY)
---@param local_pos Vector2
function imgui.SetCursorPos(local_pos) end

---##### (READ-ONLY)
---@param local_x number
function imgui.SetCursorPosX(local_x) end

---##### (READ-ONLY)
---@param local_y number
function imgui.SetCursorPosY(local_y) end

---##### (READ-ONLY)
---@param pos Vector2
function imgui.SetCursorScreenPos(pos) end

---##### (READ-ONLY)
---@param type string
---@param data lightuserdata
---@param sz integer
---@return boolean
function imgui.SetDragDropPayload(type, data, sz) end

---##### (READ-ONLY)
---@param type string
---@param data lightuserdata
---@param sz integer
---@param cond ImGuiCond|0|1|2|4|8|"None"|"Always"|"Once"|"FirstUseEver"|"Appearing"
---@return boolean
function imgui.SetDragDropPayload(type, data, sz, cond) end

---##### (READ-ONLY)
function imgui.SetItemDefaultFocus() end

---##### (READ-ONLY)
---@param key ImGuiKey|0|154|512|513|514|515|516|517|518|519|520|521|522|523|524|525|526|527|528|529|530|531|532|533|534|535|536|537|538|539|540|541|542|543|544|545|546|547|548|549|550|551|552|553|554|555|556|557|558|559|560|561|562|563|564|565|566|567|568|569|570|571|572|573|574|575|576|577|578|579|580|581|582|583|584|585|586|587|588|589|590|591|592|593|594|595|596|597|598|599|600|601|602|603|604|605|606|607|608|609|610|611|612|613|614|615|616|617|618|619|620|621|622|623|624|625|626|627|628|629|630|631|632|633|634|635|636|637|638|639|640|641|642|643|644|645|646|647|648|649|650|651|652|653|654|655|656|657|658|659|660|661|662|663|664|665|666|4096|8192|16384|32768|61440|"None"|"ModNone"|"NamedKey_COUNT"|"KeysData_SIZE"|"NamedKey_BEGIN"|"KeysData_OFFSET"|"Tab"|"LeftArrow"|"RightArrow"|"UpArrow"|"DownArrow"|"PageUp"|"PageDown"|"Home"|"End"|"Insert"|"Delete"|"Backspace"|"Space"|"Enter"|"Escape"|"LeftCtrl"|"LeftShift"|"LeftAlt"|"LeftSuper"|"RightCtrl"|"RightShift"|"RightAlt"|"RightSuper"|"Menu"|"_0"|"_1"|"_2"|"_3"|"_4"|"_5"|"_6"|"_7"|"_8"|"_9"|"A"|"B"|"C"|"D"|"E"|"F"|"G"|"H"|"I"|"J"|"K"|"L"|"M"|"N"|"O"|"P"|"Q"|"R"|"S"|"T"|"U"|"V"|"W"|"X"|"Y"|"Z"|"F1"|"F2"|"F3"|"F4"|"F5"|"F6"|"F7"|"F8"|"F9"|"F10"|"F11"|"F12"|"F13"|"F14"|"F15"|"F16"|"F17"|"F18"|"F19"|"F20"|"F21"|"F22"|"F23"|"F24"|"Apostrophe"|"Comma"|"Minus"|"Period"|"Slash"|"Semicolon"|"Equal"|"LeftBracket"|"Backslash"|"RightBracket"|"GraveAccent"|"CapsLock"|"ScrollLock"|"NumLock"|"PrintScreen"|"Pause"|"Keypad0"|"Keypad1"|"Keypad2"|"Keypad3"|"Keypad4"|"Keypad5"|"Keypad6"|"Keypad7"|"Keypad8"|"Keypad9"|"KeypadDecimal"|"KeypadDivide"|"KeypadMultiply"|"KeypadSubtract"|"KeypadAdd"|"KeypadEnter"|"KeypadEqual"|"AppBack"|"AppForward"|"GamepadStart"|"GamepadBack"|"GamepadFaceLeft"|"GamepadFaceRight"|"GamepadFaceUp"|"GamepadFaceDown"|"GamepadDpadLeft"|"GamepadDpadRight"|"GamepadDpadUp"|"GamepadDpadDown"|"GamepadL1"|"GamepadR1"|"GamepadL2"|"GamepadR2"|"GamepadL3"|"GamepadR3"|"GamepadLStickLeft"|"GamepadLStickRight"|"GamepadLStickUp"|"GamepadLStickDown"|"GamepadRStickLeft"|"GamepadRStickRight"|"GamepadRStickUp"|"GamepadRStickDown"|"MouseLeft"|"MouseRight"|"MouseMiddle"|"MouseX1"|"MouseX2"|"MouseWheelX"|"MouseWheelY"|"ReservedForModCtrl"|"ReservedForModShift"|"ReservedForModAlt"|"ReservedForModSuper"|"COUNT"|"NamedKey_END"|"ModCtrl"|"ModShift"|"ModAlt"|"ModSuper"|"ModMask"
function imgui.SetItemKeyOwner(key) end

---##### (READ-ONLY)
---@param fmt string
function imgui.SetItemTooltip(fmt) end

---##### (READ-ONLY)
function imgui.SetKeyboardFocusHere() end

---##### (READ-ONLY)
---@param offset integer
function imgui.SetKeyboardFocusHere(offset) end

---##### (READ-ONLY)
---@param cursor_type ImGuiMouseCursor|0|1|2|3|4|5|6|7|8|9|-1|"Arrow"|"TextInput"|"ResizeAll"|"ResizeNS"|"ResizeEW"|"ResizeNESW"|"ResizeNWSE"|"Hand"|"NotAllowed"|"COUNT"|"None"
function imgui.SetMouseCursor(cursor_type) end

---##### (READ-ONLY)
---@param want_capture_keyboard boolean
function imgui.SetNextFrameWantCaptureKeyboard(want_capture_keyboard) end

---##### (READ-ONLY)
---@param want_capture_mouse boolean
function imgui.SetNextFrameWantCaptureMouse(want_capture_mouse) end

---##### (READ-ONLY)
function imgui.SetNextItemAllowOverlap() end

---##### (READ-ONLY)
---@param is_open boolean
function imgui.SetNextItemOpen(is_open) end

---##### (READ-ONLY)
---@param is_open boolean
---@param cond ImGuiCond|0|1|2|4|8|"None"|"Always"|"Once"|"FirstUseEver"|"Appearing"
function imgui.SetNextItemOpen(is_open, cond) end

---##### (READ-ONLY)
---@param selection_user_data integer
function imgui.SetNextItemSelectionUserData(selection_user_data) end

---##### (READ-ONLY)
---@param key_chord ImGuiKey|0|154|512|513|514|515|516|517|518|519|520|521|522|523|524|525|526|527|528|529|530|531|532|533|534|535|536|537|538|539|540|541|542|543|544|545|546|547|548|549|550|551|552|553|554|555|556|557|558|559|560|561|562|563|564|565|566|567|568|569|570|571|572|573|574|575|576|577|578|579|580|581|582|583|584|585|586|587|588|589|590|591|592|593|594|595|596|597|598|599|600|601|602|603|604|605|606|607|608|609|610|611|612|613|614|615|616|617|618|619|620|621|622|623|624|625|626|627|628|629|630|631|632|633|634|635|636|637|638|639|640|641|642|643|644|645|646|647|648|649|650|651|652|653|654|655|656|657|658|659|660|661|662|663|664|665|666|4096|8192|16384|32768|61440|"None"|"ModNone"|"NamedKey_COUNT"|"KeysData_SIZE"|"NamedKey_BEGIN"|"KeysData_OFFSET"|"Tab"|"LeftArrow"|"RightArrow"|"UpArrow"|"DownArrow"|"PageUp"|"PageDown"|"Home"|"End"|"Insert"|"Delete"|"Backspace"|"Space"|"Enter"|"Escape"|"LeftCtrl"|"LeftShift"|"LeftAlt"|"LeftSuper"|"RightCtrl"|"RightShift"|"RightAlt"|"RightSuper"|"Menu"|"_0"|"_1"|"_2"|"_3"|"_4"|"_5"|"_6"|"_7"|"_8"|"_9"|"A"|"B"|"C"|"D"|"E"|"F"|"G"|"H"|"I"|"J"|"K"|"L"|"M"|"N"|"O"|"P"|"Q"|"R"|"S"|"T"|"U"|"V"|"W"|"X"|"Y"|"Z"|"F1"|"F2"|"F3"|"F4"|"F5"|"F6"|"F7"|"F8"|"F9"|"F10"|"F11"|"F12"|"F13"|"F14"|"F15"|"F16"|"F17"|"F18"|"F19"|"F20"|"F21"|"F22"|"F23"|"F24"|"Apostrophe"|"Comma"|"Minus"|"Period"|"Slash"|"Semicolon"|"Equal"|"LeftBracket"|"Backslash"|"RightBracket"|"GraveAccent"|"CapsLock"|"ScrollLock"|"NumLock"|"PrintScreen"|"Pause"|"Keypad0"|"Keypad1"|"Keypad2"|"Keypad3"|"Keypad4"|"Keypad5"|"Keypad6"|"Keypad7"|"Keypad8"|"Keypad9"|"KeypadDecimal"|"KeypadDivide"|"KeypadMultiply"|"KeypadSubtract"|"KeypadAdd"|"KeypadEnter"|"KeypadEqual"|"AppBack"|"AppForward"|"GamepadStart"|"GamepadBack"|"GamepadFaceLeft"|"GamepadFaceRight"|"GamepadFaceUp"|"GamepadFaceDown"|"GamepadDpadLeft"|"GamepadDpadRight"|"GamepadDpadUp"|"GamepadDpadDown"|"GamepadL1"|"GamepadR1"|"GamepadL2"|"GamepadR2"|"GamepadL3"|"GamepadR3"|"GamepadLStickLeft"|"GamepadLStickRight"|"GamepadLStickUp"|"GamepadLStickDown"|"GamepadRStickLeft"|"GamepadRStickRight"|"GamepadRStickUp"|"GamepadRStickDown"|"MouseLeft"|"MouseRight"|"MouseMiddle"|"MouseX1"|"MouseX2"|"MouseWheelX"|"MouseWheelY"|"ReservedForModCtrl"|"ReservedForModShift"|"ReservedForModAlt"|"ReservedForModSuper"|"COUNT"|"NamedKey_END"|"ModCtrl"|"ModShift"|"ModAlt"|"ModSuper"|"ModMask"
function imgui.SetNextItemShortcut(key_chord) end

---##### (READ-ONLY)
---@param key_chord ImGuiKey|0|154|512|513|514|515|516|517|518|519|520|521|522|523|524|525|526|527|528|529|530|531|532|533|534|535|536|537|538|539|540|541|542|543|544|545|546|547|548|549|550|551|552|553|554|555|556|557|558|559|560|561|562|563|564|565|566|567|568|569|570|571|572|573|574|575|576|577|578|579|580|581|582|583|584|585|586|587|588|589|590|591|592|593|594|595|596|597|598|599|600|601|602|603|604|605|606|607|608|609|610|611|612|613|614|615|616|617|618|619|620|621|622|623|624|625|626|627|628|629|630|631|632|633|634|635|636|637|638|639|640|641|642|643|644|645|646|647|648|649|650|651|652|653|654|655|656|657|658|659|660|661|662|663|664|665|666|4096|8192|16384|32768|61440|"None"|"ModNone"|"NamedKey_COUNT"|"KeysData_SIZE"|"NamedKey_BEGIN"|"KeysData_OFFSET"|"Tab"|"LeftArrow"|"RightArrow"|"UpArrow"|"DownArrow"|"PageUp"|"PageDown"|"Home"|"End"|"Insert"|"Delete"|"Backspace"|"Space"|"Enter"|"Escape"|"LeftCtrl"|"LeftShift"|"LeftAlt"|"LeftSuper"|"RightCtrl"|"RightShift"|"RightAlt"|"RightSuper"|"Menu"|"_0"|"_1"|"_2"|"_3"|"_4"|"_5"|"_6"|"_7"|"_8"|"_9"|"A"|"B"|"C"|"D"|"E"|"F"|"G"|"H"|"I"|"J"|"K"|"L"|"M"|"N"|"O"|"P"|"Q"|"R"|"S"|"T"|"U"|"V"|"W"|"X"|"Y"|"Z"|"F1"|"F2"|"F3"|"F4"|"F5"|"F6"|"F7"|"F8"|"F9"|"F10"|"F11"|"F12"|"F13"|"F14"|"F15"|"F16"|"F17"|"F18"|"F19"|"F20"|"F21"|"F22"|"F23"|"F24"|"Apostrophe"|"Comma"|"Minus"|"Period"|"Slash"|"Semicolon"|"Equal"|"LeftBracket"|"Backslash"|"RightBracket"|"GraveAccent"|"CapsLock"|"ScrollLock"|"NumLock"|"PrintScreen"|"Pause"|"Keypad0"|"Keypad1"|"Keypad2"|"Keypad3"|"Keypad4"|"Keypad5"|"Keypad6"|"Keypad7"|"Keypad8"|"Keypad9"|"KeypadDecimal"|"KeypadDivide"|"KeypadMultiply"|"KeypadSubtract"|"KeypadAdd"|"KeypadEnter"|"KeypadEqual"|"AppBack"|"AppForward"|"GamepadStart"|"GamepadBack"|"GamepadFaceLeft"|"GamepadFaceRight"|"GamepadFaceUp"|"GamepadFaceDown"|"GamepadDpadLeft"|"GamepadDpadRight"|"GamepadDpadUp"|"GamepadDpadDown"|"GamepadL1"|"GamepadR1"|"GamepadL2"|"GamepadR2"|"GamepadL3"|"GamepadR3"|"GamepadLStickLeft"|"GamepadLStickRight"|"GamepadLStickUp"|"GamepadLStickDown"|"GamepadRStickLeft"|"GamepadRStickRight"|"GamepadRStickUp"|"GamepadRStickDown"|"MouseLeft"|"MouseRight"|"MouseMiddle"|"MouseX1"|"MouseX2"|"MouseWheelX"|"MouseWheelY"|"ReservedForModCtrl"|"ReservedForModShift"|"ReservedForModAlt"|"ReservedForModSuper"|"COUNT"|"NamedKey_END"|"ModCtrl"|"ModShift"|"ModAlt"|"ModSuper"|"ModMask"
---@param flags ImGuiInputFlags|integer|"None"|"Repeat"|"RouteActive"|"RouteFocused"|"RouteGlobal"|"RouteAlways"|"RouteOverFocused"|"RouteOverActive"|"RouteUnlessBgFocused"|"RouteFromRootWindow"|"Tooltip"
function imgui.SetNextItemShortcut(key_chord, flags) end

---##### (READ-ONLY)
---@param storage_id integer
function imgui.SetNextItemStorageID(storage_id) end

---##### (READ-ONLY)
---@param item_width number
function imgui.SetNextItemWidth(item_width) end

---##### (READ-ONLY)
---@param alpha number
function imgui.SetNextWindowBgAlpha(alpha) end

---##### (READ-ONLY)
---@param window_class ImGuiWindowClassPtr
function imgui.SetNextWindowClass(window_class) end

---##### (READ-ONLY)
---@param collapsed boolean
function imgui.SetNextWindowCollapsed(collapsed) end

---##### (READ-ONLY)
---@param collapsed boolean
---@param cond ImGuiCond|0|1|2|4|8|"None"|"Always"|"Once"|"FirstUseEver"|"Appearing"
function imgui.SetNextWindowCollapsed(collapsed, cond) end

---##### (READ-ONLY)
---@param size Vector2
function imgui.SetNextWindowContentSize(size) end

---##### (READ-ONLY)
---@param dock_id integer
function imgui.SetNextWindowDockID(dock_id) end

---##### (READ-ONLY)
---@param dock_id integer
---@param cond ImGuiCond|0|1|2|4|8|"None"|"Always"|"Once"|"FirstUseEver"|"Appearing"
function imgui.SetNextWindowDockID(dock_id, cond) end

---##### (READ-ONLY)
function imgui.SetNextWindowFocus() end

---##### (READ-ONLY)
---@param pos Vector2
function imgui.SetNextWindowPos(pos) end

---##### (READ-ONLY)
---@param pos Vector2
---@param cond ImGuiCond|0|1|2|4|8|"None"|"Always"|"Once"|"FirstUseEver"|"Appearing"
function imgui.SetNextWindowPos(pos, cond) end

---##### (READ-ONLY)
---@param pos Vector2
---@param cond ImGuiCond|0|1|2|4|8|"None"|"Always"|"Once"|"FirstUseEver"|"Appearing"
---@param pivot Vector2
function imgui.SetNextWindowPos(pos, cond, pivot) end

---##### (READ-ONLY)
---@param scroll Vector2
function imgui.SetNextWindowScroll(scroll) end

---##### (READ-ONLY)
---@param size Vector2
function imgui.SetNextWindowSize(size) end

---##### (READ-ONLY)
---@param size Vector2
---@param cond ImGuiCond|0|1|2|4|8|"None"|"Always"|"Once"|"FirstUseEver"|"Appearing"
function imgui.SetNextWindowSize(size, cond) end

---##### (READ-ONLY)
---@param size_min Vector2
---@param size_max Vector2
function imgui.SetNextWindowSizeConstraints(size_min, size_max) end

---##### (READ-ONLY)
---@param viewport_id integer
function imgui.SetNextWindowViewport(viewport_id) end

---##### (READ-ONLY)
---@param local_x number
function imgui.SetScrollFromPosX(local_x) end

---##### (READ-ONLY)
---@param local_x number
---@param center_x_ratio number
function imgui.SetScrollFromPosX(local_x, center_x_ratio) end

---##### (READ-ONLY)
---@param local_y number
function imgui.SetScrollFromPosY(local_y) end

---##### (READ-ONLY)
---@param local_y number
---@param center_y_ratio number
function imgui.SetScrollFromPosY(local_y, center_y_ratio) end

---##### (READ-ONLY)
function imgui.SetScrollHereX() end

---##### (READ-ONLY)
---@param center_x_ratio number
function imgui.SetScrollHereX(center_x_ratio) end

---##### (READ-ONLY)
function imgui.SetScrollHereY() end

---##### (READ-ONLY)
---@param center_y_ratio number
function imgui.SetScrollHereY(center_y_ratio) end

---##### (READ-ONLY)
---@param scroll_x number
function imgui.SetScrollX(scroll_x) end

---##### (READ-ONLY)
---@param scroll_y number
function imgui.SetScrollY(scroll_y) end

---##### (READ-ONLY)
---@param storage ImGuiStoragePtr
function imgui.SetStateStorage(storage) end

---##### (READ-ONLY)
---@param tab_or_docked_window_label string
function imgui.SetTabItemClosed(tab_or_docked_window_label) end

---##### (READ-ONLY)
---@param fmt string
function imgui.SetTooltip(fmt) end

---##### (READ-ONLY)
---@param collapsed boolean
function imgui.SetWindowCollapsed(collapsed) end

---##### (READ-ONLY)
---@param collapsed boolean
---@param cond ImGuiCond|0|1|2|4|8|"None"|"Always"|"Once"|"FirstUseEver"|"Appearing"
function imgui.SetWindowCollapsed(collapsed, cond) end

---##### (READ-ONLY)
---@param name string
---@param collapsed boolean
function imgui.SetWindowCollapsed(name, collapsed) end

---##### (READ-ONLY)
---@param name string
---@param collapsed boolean
---@param cond ImGuiCond|0|1|2|4|8|"None"|"Always"|"Once"|"FirstUseEver"|"Appearing"
function imgui.SetWindowCollapsed(name, collapsed, cond) end

---##### (READ-ONLY)
function imgui.SetWindowFocus() end

---##### (READ-ONLY)
---@param name string
function imgui.SetWindowFocus(name) end

---##### (READ-ONLY)
---@param scale number
function imgui.SetWindowFontScale(scale) end

---##### (READ-ONLY)
---@param pos Vector2
function imgui.SetWindowPos(pos) end

---##### (READ-ONLY)
---@param pos Vector2
---@param cond ImGuiCond|0|1|2|4|8|"None"|"Always"|"Once"|"FirstUseEver"|"Appearing"
function imgui.SetWindowPos(pos, cond) end

---##### (READ-ONLY)
---@param name string
---@param pos Vector2
function imgui.SetWindowPos(name, pos) end

---##### (READ-ONLY)
---@param name string
---@param pos Vector2
---@param cond ImGuiCond|0|1|2|4|8|"None"|"Always"|"Once"|"FirstUseEver"|"Appearing"
function imgui.SetWindowPos(name, pos, cond) end

---##### (READ-ONLY)
---@param size Vector2
function imgui.SetWindowSize(size) end

---##### (READ-ONLY)
---@param size Vector2
---@param cond ImGuiCond|0|1|2|4|8|"None"|"Always"|"Once"|"FirstUseEver"|"Appearing"
function imgui.SetWindowSize(size, cond) end

---##### (READ-ONLY)
---@param name string
---@param size Vector2
function imgui.SetWindowSize(name, size) end

---##### (READ-ONLY)
---@param name string
---@param size Vector2
---@param cond ImGuiCond|0|1|2|4|8|"None"|"Always"|"Once"|"FirstUseEver"|"Appearing"
function imgui.SetWindowSize(name, size, cond) end

---##### (READ-ONLY)
---@param key_chord ImGuiKey|0|154|512|513|514|515|516|517|518|519|520|521|522|523|524|525|526|527|528|529|530|531|532|533|534|535|536|537|538|539|540|541|542|543|544|545|546|547|548|549|550|551|552|553|554|555|556|557|558|559|560|561|562|563|564|565|566|567|568|569|570|571|572|573|574|575|576|577|578|579|580|581|582|583|584|585|586|587|588|589|590|591|592|593|594|595|596|597|598|599|600|601|602|603|604|605|606|607|608|609|610|611|612|613|614|615|616|617|618|619|620|621|622|623|624|625|626|627|628|629|630|631|632|633|634|635|636|637|638|639|640|641|642|643|644|645|646|647|648|649|650|651|652|653|654|655|656|657|658|659|660|661|662|663|664|665|666|4096|8192|16384|32768|61440|"None"|"ModNone"|"NamedKey_COUNT"|"KeysData_SIZE"|"NamedKey_BEGIN"|"KeysData_OFFSET"|"Tab"|"LeftArrow"|"RightArrow"|"UpArrow"|"DownArrow"|"PageUp"|"PageDown"|"Home"|"End"|"Insert"|"Delete"|"Backspace"|"Space"|"Enter"|"Escape"|"LeftCtrl"|"LeftShift"|"LeftAlt"|"LeftSuper"|"RightCtrl"|"RightShift"|"RightAlt"|"RightSuper"|"Menu"|"_0"|"_1"|"_2"|"_3"|"_4"|"_5"|"_6"|"_7"|"_8"|"_9"|"A"|"B"|"C"|"D"|"E"|"F"|"G"|"H"|"I"|"J"|"K"|"L"|"M"|"N"|"O"|"P"|"Q"|"R"|"S"|"T"|"U"|"V"|"W"|"X"|"Y"|"Z"|"F1"|"F2"|"F3"|"F4"|"F5"|"F6"|"F7"|"F8"|"F9"|"F10"|"F11"|"F12"|"F13"|"F14"|"F15"|"F16"|"F17"|"F18"|"F19"|"F20"|"F21"|"F22"|"F23"|"F24"|"Apostrophe"|"Comma"|"Minus"|"Period"|"Slash"|"Semicolon"|"Equal"|"LeftBracket"|"Backslash"|"RightBracket"|"GraveAccent"|"CapsLock"|"ScrollLock"|"NumLock"|"PrintScreen"|"Pause"|"Keypad0"|"Keypad1"|"Keypad2"|"Keypad3"|"Keypad4"|"Keypad5"|"Keypad6"|"Keypad7"|"Keypad8"|"Keypad9"|"KeypadDecimal"|"KeypadDivide"|"KeypadMultiply"|"KeypadSubtract"|"KeypadAdd"|"KeypadEnter"|"KeypadEqual"|"AppBack"|"AppForward"|"GamepadStart"|"GamepadBack"|"GamepadFaceLeft"|"GamepadFaceRight"|"GamepadFaceUp"|"GamepadFaceDown"|"GamepadDpadLeft"|"GamepadDpadRight"|"GamepadDpadUp"|"GamepadDpadDown"|"GamepadL1"|"GamepadR1"|"GamepadL2"|"GamepadR2"|"GamepadL3"|"GamepadR3"|"GamepadLStickLeft"|"GamepadLStickRight"|"GamepadLStickUp"|"GamepadLStickDown"|"GamepadRStickLeft"|"GamepadRStickRight"|"GamepadRStickUp"|"GamepadRStickDown"|"MouseLeft"|"MouseRight"|"MouseMiddle"|"MouseX1"|"MouseX2"|"MouseWheelX"|"MouseWheelY"|"ReservedForModCtrl"|"ReservedForModShift"|"ReservedForModAlt"|"ReservedForModSuper"|"COUNT"|"NamedKey_END"|"ModCtrl"|"ModShift"|"ModAlt"|"ModSuper"|"ModMask"
---@return boolean
function imgui.Shortcut(key_chord) end

---##### (READ-ONLY)
---@param key_chord ImGuiKey|0|154|512|513|514|515|516|517|518|519|520|521|522|523|524|525|526|527|528|529|530|531|532|533|534|535|536|537|538|539|540|541|542|543|544|545|546|547|548|549|550|551|552|553|554|555|556|557|558|559|560|561|562|563|564|565|566|567|568|569|570|571|572|573|574|575|576|577|578|579|580|581|582|583|584|585|586|587|588|589|590|591|592|593|594|595|596|597|598|599|600|601|602|603|604|605|606|607|608|609|610|611|612|613|614|615|616|617|618|619|620|621|622|623|624|625|626|627|628|629|630|631|632|633|634|635|636|637|638|639|640|641|642|643|644|645|646|647|648|649|650|651|652|653|654|655|656|657|658|659|660|661|662|663|664|665|666|4096|8192|16384|32768|61440|"None"|"ModNone"|"NamedKey_COUNT"|"KeysData_SIZE"|"NamedKey_BEGIN"|"KeysData_OFFSET"|"Tab"|"LeftArrow"|"RightArrow"|"UpArrow"|"DownArrow"|"PageUp"|"PageDown"|"Home"|"End"|"Insert"|"Delete"|"Backspace"|"Space"|"Enter"|"Escape"|"LeftCtrl"|"LeftShift"|"LeftAlt"|"LeftSuper"|"RightCtrl"|"RightShift"|"RightAlt"|"RightSuper"|"Menu"|"_0"|"_1"|"_2"|"_3"|"_4"|"_5"|"_6"|"_7"|"_8"|"_9"|"A"|"B"|"C"|"D"|"E"|"F"|"G"|"H"|"I"|"J"|"K"|"L"|"M"|"N"|"O"|"P"|"Q"|"R"|"S"|"T"|"U"|"V"|"W"|"X"|"Y"|"Z"|"F1"|"F2"|"F3"|"F4"|"F5"|"F6"|"F7"|"F8"|"F9"|"F10"|"F11"|"F12"|"F13"|"F14"|"F15"|"F16"|"F17"|"F18"|"F19"|"F20"|"F21"|"F22"|"F23"|"F24"|"Apostrophe"|"Comma"|"Minus"|"Period"|"Slash"|"Semicolon"|"Equal"|"LeftBracket"|"Backslash"|"RightBracket"|"GraveAccent"|"CapsLock"|"ScrollLock"|"NumLock"|"PrintScreen"|"Pause"|"Keypad0"|"Keypad1"|"Keypad2"|"Keypad3"|"Keypad4"|"Keypad5"|"Keypad6"|"Keypad7"|"Keypad8"|"Keypad9"|"KeypadDecimal"|"KeypadDivide"|"KeypadMultiply"|"KeypadSubtract"|"KeypadAdd"|"KeypadEnter"|"KeypadEqual"|"AppBack"|"AppForward"|"GamepadStart"|"GamepadBack"|"GamepadFaceLeft"|"GamepadFaceRight"|"GamepadFaceUp"|"GamepadFaceDown"|"GamepadDpadLeft"|"GamepadDpadRight"|"GamepadDpadUp"|"GamepadDpadDown"|"GamepadL1"|"GamepadR1"|"GamepadL2"|"GamepadR2"|"GamepadL3"|"GamepadR3"|"GamepadLStickLeft"|"GamepadLStickRight"|"GamepadLStickUp"|"GamepadLStickDown"|"GamepadRStickLeft"|"GamepadRStickRight"|"GamepadRStickUp"|"GamepadRStickDown"|"MouseLeft"|"MouseRight"|"MouseMiddle"|"MouseX1"|"MouseX2"|"MouseWheelX"|"MouseWheelY"|"ReservedForModCtrl"|"ReservedForModShift"|"ReservedForModAlt"|"ReservedForModSuper"|"COUNT"|"NamedKey_END"|"ModCtrl"|"ModShift"|"ModAlt"|"ModSuper"|"ModMask"
---@param flags ImGuiInputFlags|integer|"None"|"Repeat"|"RouteActive"|"RouteFocused"|"RouteGlobal"|"RouteAlways"|"RouteOverFocused"|"RouteOverActive"|"RouteUnlessBgFocused"|"RouteFromRootWindow"|"Tooltip"
---@return boolean
function imgui.Shortcut(key_chord, flags) end

---##### (READ-ONLY)
function imgui.ShowAboutWindow() end

---##### (READ-ONLY)
---@param p_open boolean
function imgui.ShowAboutWindow(p_open) end

---##### (READ-ONLY)
function imgui.ShowDebugLogWindow() end

---##### (READ-ONLY)
---@param p_open boolean
function imgui.ShowDebugLogWindow(p_open) end

---##### (READ-ONLY)
function imgui.ShowDemoWindow() end

---##### (READ-ONLY)
---@param p_open boolean
function imgui.ShowDemoWindow(p_open) end

---##### (READ-ONLY)
---@param label string
function imgui.ShowFontSelector(label) end

---##### (READ-ONLY)
function imgui.ShowIDStackToolWindow() end

---##### (READ-ONLY)
---@param p_open boolean
function imgui.ShowIDStackToolWindow(p_open) end

---##### (READ-ONLY)
function imgui.ShowMetricsWindow() end

---##### (READ-ONLY)
---@param p_open boolean
function imgui.ShowMetricsWindow(p_open) end

---##### (READ-ONLY)
function imgui.ShowStyleEditor() end

---##### (READ-ONLY)
---@param ref ImGuiStylePtr
function imgui.ShowStyleEditor(ref) end

---##### (READ-ONLY)
---@param label string
---@return boolean
function imgui.ShowStyleSelector(label) end

---##### (READ-ONLY)
function imgui.ShowUserGuide() end

---##### (READ-ONLY)
---@param label string
---@param v_rad number
---@return boolean, number
function imgui.SliderAngle(label, v_rad) end

---##### (READ-ONLY)
---@param label string
---@param v_rad number
---@param v_degrees_min number
---@return boolean, number
function imgui.SliderAngle(label, v_rad, v_degrees_min) end

---##### (READ-ONLY)
---@param label string
---@param v_rad number
---@param v_degrees_min number
---@param v_degrees_max number
---@return boolean, number
function imgui.SliderAngle(label, v_rad, v_degrees_min, v_degrees_max) end

---##### (READ-ONLY)
---@param label string
---@param v_rad number
---@param v_degrees_min number
---@param v_degrees_max number
---@param format string
---@return boolean, number
function imgui.SliderAngle(label, v_rad, v_degrees_min, v_degrees_max, format) end

---##### (READ-ONLY)
---@param label string
---@param v_rad number
---@param v_degrees_min number
---@param v_degrees_max number
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, number
function imgui.SliderAngle(label, v_rad, v_degrees_min, v_degrees_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v number
---@param v_min number
---@param v_max number
---@return boolean, number
function imgui.SliderFloat(label, v, v_min, v_max) end

---##### (READ-ONLY)
---@param label string
---@param v number
---@param v_min number
---@param v_max number
---@param format string
---@return boolean, number
function imgui.SliderFloat(label, v, v_min, v_max, format) end

---##### (READ-ONLY)
---@param label string
---@param v number
---@param v_min number
---@param v_max number
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, number
function imgui.SliderFloat(label, v, v_min, v_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v Vector2
---@param v_min number
---@param v_max number
---@return boolean, Vector2
function imgui.SliderFloat2(label, v, v_min, v_max) end

---##### (READ-ONLY)
---@param label string
---@param v Vector2
---@param v_min number
---@param v_max number
---@param format string
---@return boolean, Vector2
function imgui.SliderFloat2(label, v, v_min, v_max, format) end

---##### (READ-ONLY)
---@param label string
---@param v Vector2
---@param v_min number
---@param v_max number
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, Vector2
function imgui.SliderFloat2(label, v, v_min, v_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v Vector3
---@param v_min number
---@param v_max number
---@return boolean, Vector3
function imgui.SliderFloat3(label, v, v_min, v_max) end

---##### (READ-ONLY)
---@param label string
---@param v Vector3
---@param v_min number
---@param v_max number
---@param format string
---@return boolean, Vector3
function imgui.SliderFloat3(label, v, v_min, v_max, format) end

---##### (READ-ONLY)
---@param label string
---@param v Vector3
---@param v_min number
---@param v_max number
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, Vector3
function imgui.SliderFloat3(label, v, v_min, v_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v Vector4
---@param v_min number
---@param v_max number
---@return boolean, Vector4
function imgui.SliderFloat4(label, v, v_min, v_max) end

---##### (READ-ONLY)
---@param label string
---@param v Vector4
---@param v_min number
---@param v_max number
---@param format string
---@return boolean, Vector4
function imgui.SliderFloat4(label, v, v_min, v_max, format) end

---##### (READ-ONLY)
---@param label string
---@param v Vector4
---@param v_min number
---@param v_max number
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, Vector4
function imgui.SliderFloat4(label, v, v_min, v_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v integer
---@param v_min integer
---@param v_max integer
---@return boolean, integer
function imgui.SliderInt(label, v, v_min, v_max) end

---##### (READ-ONLY)
---@param label string
---@param v integer
---@param v_min integer
---@param v_max integer
---@param format string
---@return boolean, integer
function imgui.SliderInt(label, v, v_min, v_max, format) end

---##### (READ-ONLY)
---@param label string
---@param v integer
---@param v_min integer
---@param v_max integer
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, integer
function imgui.SliderInt(label, v, v_min, v_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param v_min integer
---@param v_max integer
---@return boolean, integer[]
function imgui.SliderInt2(label, v, v_min, v_max) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param v_min integer
---@param v_max integer
---@param format string
---@return boolean, integer[]
function imgui.SliderInt2(label, v, v_min, v_max, format) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param v_min integer
---@param v_max integer
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, integer[]
function imgui.SliderInt2(label, v, v_min, v_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v Vector2
---@param v_min integer
---@param v_max integer
---@return boolean, Vector2
function imgui.SliderInt2(label, v, v_min, v_max) end

---##### (READ-ONLY)
---@param label string
---@param v Vector2
---@param v_min integer
---@param v_max integer
---@param format string
---@return boolean, Vector2
function imgui.SliderInt2(label, v, v_min, v_max, format) end

---##### (READ-ONLY)
---@param label string
---@param v Vector2
---@param v_min integer
---@param v_max integer
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, Vector2
function imgui.SliderInt2(label, v, v_min, v_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param v_min integer
---@param v_max integer
---@return boolean, integer[]
function imgui.SliderInt3(label, v, v_min, v_max) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param v_min integer
---@param v_max integer
---@param format string
---@return boolean, integer[]
function imgui.SliderInt3(label, v, v_min, v_max, format) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param v_min integer
---@param v_max integer
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, integer[]
function imgui.SliderInt3(label, v, v_min, v_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v Vector3
---@param v_min integer
---@param v_max integer
---@return boolean, Vector3
function imgui.SliderInt3(label, v, v_min, v_max) end

---##### (READ-ONLY)
---@param label string
---@param v Vector3
---@param v_min integer
---@param v_max integer
---@param format string
---@return boolean, Vector3
function imgui.SliderInt3(label, v, v_min, v_max, format) end

---##### (READ-ONLY)
---@param label string
---@param v Vector3
---@param v_min integer
---@param v_max integer
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, Vector3
function imgui.SliderInt3(label, v, v_min, v_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param v_min integer
---@param v_max integer
---@return boolean, integer[]
function imgui.SliderInt4(label, v, v_min, v_max) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param v_min integer
---@param v_max integer
---@param format string
---@return boolean, integer[]
function imgui.SliderInt4(label, v, v_min, v_max, format) end

---##### (READ-ONLY)
---@param label string
---@param v integer[]
---@param v_min integer
---@param v_max integer
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, integer[]
function imgui.SliderInt4(label, v, v_min, v_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param v Vector4
---@param v_min integer
---@param v_max integer
---@return boolean, Vector4
function imgui.SliderInt4(label, v, v_min, v_max) end

---##### (READ-ONLY)
---@param label string
---@param v Vector4
---@param v_min integer
---@param v_max integer
---@param format string
---@return boolean, Vector4
function imgui.SliderInt4(label, v, v_min, v_max, format) end

---##### (READ-ONLY)
---@param label string
---@param v Vector4
---@param v_min integer
---@param v_max integer
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, Vector4
function imgui.SliderInt4(label, v, v_min, v_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param p_min lightuserdata
---@param p_max lightuserdata
---@return boolean
function imgui.SliderScalar(label, data_type, p_data, p_min, p_max) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param p_min lightuserdata
---@param p_max lightuserdata
---@param format string
---@return boolean
function imgui.SliderScalar(label, data_type, p_data, p_min, p_max, format) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param p_min lightuserdata
---@param p_max lightuserdata
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean
function imgui.SliderScalar(label, data_type, p_data, p_min, p_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param components integer
---@param p_min lightuserdata
---@param p_max lightuserdata
---@return boolean
function imgui.SliderScalarN(label, data_type, p_data, components, p_min, p_max) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param components integer
---@param p_min lightuserdata
---@param p_max lightuserdata
---@param format string
---@return boolean
function imgui.SliderScalarN(label, data_type, p_data, components, p_min, p_max, format) end

---##### (READ-ONLY)
---@param label string
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param components integer
---@param p_min lightuserdata
---@param p_max lightuserdata
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean
function imgui.SliderScalarN(label, data_type, p_data, components, p_min, p_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@return boolean
function imgui.SmallButton(label) end

---##### (READ-ONLY)
function imgui.Spacing() end

---##### (READ-ONLY)
function imgui.StyleColorsClassic() end

---##### (READ-ONLY)
---@param dst ImGuiStylePtr
function imgui.StyleColorsClassic(dst) end

---##### (READ-ONLY)
function imgui.StyleColorsDark() end

---##### (READ-ONLY)
---@param dst ImGuiStylePtr
function imgui.StyleColorsDark(dst) end

---##### (READ-ONLY)
function imgui.StyleColorsLight() end

---##### (READ-ONLY)
---@param dst ImGuiStylePtr
function imgui.StyleColorsLight(dst) end

---##### (READ-ONLY)
---@param label string
---@return boolean
function imgui.TabItemButton(label) end

---##### (READ-ONLY)
---@param label string
---@param flags ImGuiTabItemFlags|integer|"None"|"UnsavedDocument"|"SetSelected"|"NoCloseWithMiddleMouseButton"|"NoPushId"|"NoTooltip"|"NoReorder"|"Leading"|"Trailing"|"NoAssumedClosure"
---@return boolean
function imgui.TabItemButton(label, flags) end

---##### (READ-ONLY)
function imgui.TableAngledHeadersRow() end

---##### (READ-ONLY)
---@return integer
function imgui.TableGetColumnCount() end

---##### (READ-ONLY)
---@return ImGuiTableColumnFlags|integer|"None"|"Disabled"|"DefaultHide"|"DefaultSort"|"WidthStretch"|"WidthFixed"|"WidthMask"|"NoResize"|"NoReorder"|"NoHide"|"NoClip"|"NoSort"|"NoSortAscending"|"NoSortDescending"|"NoHeaderLabel"|"NoHeaderWidth"|"PreferSortAscending"|"PreferSortDescending"|"IndentEnable"|"IndentDisable"|"IndentMask"|"AngledHeader"|"IsEnabled"|"IsVisible"|"IsSorted"|"IsHovered"|"StatusMask"|"NoDirectResize"
function imgui.TableGetColumnFlags() end

---##### (READ-ONLY)
---@param column_n integer
---@return ImGuiTableColumnFlags|integer|"None"|"Disabled"|"DefaultHide"|"DefaultSort"|"WidthStretch"|"WidthFixed"|"WidthMask"|"NoResize"|"NoReorder"|"NoHide"|"NoClip"|"NoSort"|"NoSortAscending"|"NoSortDescending"|"NoHeaderLabel"|"NoHeaderWidth"|"PreferSortAscending"|"PreferSortDescending"|"IndentEnable"|"IndentDisable"|"IndentMask"|"AngledHeader"|"IsEnabled"|"IsVisible"|"IsSorted"|"IsHovered"|"StatusMask"|"NoDirectResize"
function imgui.TableGetColumnFlags(column_n) end

---##### (READ-ONLY)
---@return integer
function imgui.TableGetColumnIndex() end

---##### (READ-ONLY)
---@return string
function imgui.TableGetColumnName() end

---##### (READ-ONLY)
---@param column_n integer
---@return string
function imgui.TableGetColumnName(column_n) end

---##### (READ-ONLY)
---@return integer
function imgui.TableGetHoveredColumn() end

---##### (READ-ONLY)
---@return integer
function imgui.TableGetRowIndex() end

---##### (READ-ONLY)
---@return ImGuiTableSortSpecsPtr
function imgui.TableGetSortSpecs() end

---##### (READ-ONLY)
---@param label string
function imgui.TableHeader(label) end

---##### (READ-ONLY)
function imgui.TableHeadersRow() end

---##### (READ-ONLY)
---@return boolean
function imgui.TableNextColumn() end

---##### (READ-ONLY)
function imgui.TableNextRow() end

---##### (READ-ONLY)
---@param row_flags ImGuiTableRowFlags|integer|"None"|"Headers"
function imgui.TableNextRow(row_flags) end

---##### (READ-ONLY)
---@param row_flags ImGuiTableRowFlags|integer|"None"|"Headers"
---@param min_row_height number
function imgui.TableNextRow(row_flags, min_row_height) end

---##### (READ-ONLY)
---@param target ImGuiTableBgTarget|0|1|2|3|"None"|"RowBg0"|"RowBg1"|"CellBg"
---@param color integer
function imgui.TableSetBgColor(target, color) end

---##### (READ-ONLY)
---@param target ImGuiTableBgTarget|0|1|2|3|"None"|"RowBg0"|"RowBg1"|"CellBg"
---@param color integer
---@param column_n integer
function imgui.TableSetBgColor(target, color, column_n) end

---##### (READ-ONLY)
---@param column_n integer
---@param v boolean
function imgui.TableSetColumnEnabled(column_n, v) end

---##### (READ-ONLY)
---@param column_n integer
---@return boolean
function imgui.TableSetColumnIndex(column_n) end

---##### (READ-ONLY)
---@param label string
function imgui.TableSetupColumn(label) end

---##### (READ-ONLY)
---@param label string
---@param flags ImGuiTableColumnFlags|integer|"None"|"Disabled"|"DefaultHide"|"DefaultSort"|"WidthStretch"|"WidthFixed"|"WidthMask"|"NoResize"|"NoReorder"|"NoHide"|"NoClip"|"NoSort"|"NoSortAscending"|"NoSortDescending"|"NoHeaderLabel"|"NoHeaderWidth"|"PreferSortAscending"|"PreferSortDescending"|"IndentEnable"|"IndentDisable"|"IndentMask"|"AngledHeader"|"IsEnabled"|"IsVisible"|"IsSorted"|"IsHovered"|"StatusMask"|"NoDirectResize"
function imgui.TableSetupColumn(label, flags) end

---##### (READ-ONLY)
---@param label string
---@param flags ImGuiTableColumnFlags|integer|"None"|"Disabled"|"DefaultHide"|"DefaultSort"|"WidthStretch"|"WidthFixed"|"WidthMask"|"NoResize"|"NoReorder"|"NoHide"|"NoClip"|"NoSort"|"NoSortAscending"|"NoSortDescending"|"NoHeaderLabel"|"NoHeaderWidth"|"PreferSortAscending"|"PreferSortDescending"|"IndentEnable"|"IndentDisable"|"IndentMask"|"AngledHeader"|"IsEnabled"|"IsVisible"|"IsSorted"|"IsHovered"|"StatusMask"|"NoDirectResize"
---@param init_width_or_weight number
function imgui.TableSetupColumn(label, flags, init_width_or_weight) end

---##### (READ-ONLY)
---@param label string
---@param flags ImGuiTableColumnFlags|integer|"None"|"Disabled"|"DefaultHide"|"DefaultSort"|"WidthStretch"|"WidthFixed"|"WidthMask"|"NoResize"|"NoReorder"|"NoHide"|"NoClip"|"NoSort"|"NoSortAscending"|"NoSortDescending"|"NoHeaderLabel"|"NoHeaderWidth"|"PreferSortAscending"|"PreferSortDescending"|"IndentEnable"|"IndentDisable"|"IndentMask"|"AngledHeader"|"IsEnabled"|"IsVisible"|"IsSorted"|"IsHovered"|"StatusMask"|"NoDirectResize"
---@param init_width_or_weight number
---@param user_id integer
function imgui.TableSetupColumn(label, flags, init_width_or_weight, user_id) end

---##### (READ-ONLY)
---@param cols integer
---@param rows integer
function imgui.TableSetupScrollFreeze(cols, rows) end

---##### (READ-ONLY)
---@param fmt string
function imgui.Text(fmt) end

---##### (READ-ONLY)
---@param col Vector4
---@param fmt string
function imgui.TextColored(col, fmt) end

---##### (READ-ONLY)
---@param fmt string
function imgui.TextDisabled(fmt) end

---##### (READ-ONLY)
---@param label string
---@return boolean
function imgui.TextLink(label) end

---##### (READ-ONLY)
---@param label string
function imgui.TextLinkOpenURL(label) end

---##### (READ-ONLY)
---@param label string
---@param url string
function imgui.TextLinkOpenURL(label, url) end

---##### (READ-ONLY)
---@param text string
function imgui.TextUnformatted(text) end

---##### (READ-ONLY)
---@param fmt string
function imgui.TextWrapped(fmt) end

---##### (READ-ONLY)
function imgui.TreeAdvanceToLabelPos() end

---##### (READ-ONLY)
---@param label string
---@return boolean
function imgui.TreeNode(label) end

---##### (READ-ONLY)
---@param str_id string
---@param fmt string
---@return boolean
function imgui.TreeNode(str_id, fmt) end

---##### (READ-ONLY)
---@param ptr_id lightuserdata
---@param fmt string
---@return boolean
function imgui.TreeNode(ptr_id, fmt) end

---##### (READ-ONLY)
---@param label string
---@return boolean
function imgui.TreeNodeEx(label) end

---##### (READ-ONLY)
---@param label string
---@param flags ImGuiTreeNodeFlags|integer|"None"|"Selected"|"Framed"|"AllowOverlap"|"NoTreePushOnOpen"|"NoAutoOpenOnLog"|"CollapsingHeader"|"DefaultOpen"|"OpenOnDoubleClick"|"OpenOnArrow"|"Leaf"|"Bullet"|"FramePadding"|"SpanAvailWidth"|"SpanFullWidth"|"SpanTextWidth"|"SpanAllColumns"|"NavLeftJumpsBackHere"
---@return boolean
function imgui.TreeNodeEx(label, flags) end

---##### (READ-ONLY)
---@param str_id string
---@param flags ImGuiTreeNodeFlags|integer|"None"|"Selected"|"Framed"|"AllowOverlap"|"NoTreePushOnOpen"|"NoAutoOpenOnLog"|"CollapsingHeader"|"DefaultOpen"|"OpenOnDoubleClick"|"OpenOnArrow"|"Leaf"|"Bullet"|"FramePadding"|"SpanAvailWidth"|"SpanFullWidth"|"SpanTextWidth"|"SpanAllColumns"|"NavLeftJumpsBackHere"
---@param fmt string
---@return boolean
function imgui.TreeNodeEx(str_id, flags, fmt) end

---##### (READ-ONLY)
---@param ptr_id lightuserdata
---@param flags ImGuiTreeNodeFlags|integer|"None"|"Selected"|"Framed"|"AllowOverlap"|"NoTreePushOnOpen"|"NoAutoOpenOnLog"|"CollapsingHeader"|"DefaultOpen"|"OpenOnDoubleClick"|"OpenOnArrow"|"Leaf"|"Bullet"|"FramePadding"|"SpanAvailWidth"|"SpanFullWidth"|"SpanTextWidth"|"SpanAllColumns"|"NavLeftJumpsBackHere"
---@param fmt string
---@return boolean
function imgui.TreeNodeEx(ptr_id, flags, fmt) end

---##### (READ-ONLY)
function imgui.TreePop() end

---##### (READ-ONLY)
function imgui.TreePush() end

---##### (READ-ONLY)
---@param ptr_id lightuserdata
function imgui.TreePush(ptr_id) end

---##### (READ-ONLY)
---@param str_id string
function imgui.TreePush(str_id) end

---##### (READ-ONLY)
function imgui.Unindent() end

---##### (READ-ONLY)
---@param indent_w number
function imgui.Unindent(indent_w) end

---##### (READ-ONLY)
function imgui.UpdatePlatformWindows() end

---##### (READ-ONLY)
---@param prefix string
---@param b boolean
function imgui.Value(prefix, b) end

---##### (READ-ONLY)
---@param prefix string
---@param v integer
function imgui.Value(prefix, v) end

---##### (READ-ONLY)
---@param prefix string
---@param v integer
function imgui.Value(prefix, v) end

---##### (READ-ONLY)
---@param prefix string
---@param v number
function imgui.Value(prefix, v) end

---##### (READ-ONLY)
---@param prefix string
---@param v number
---@param float_format string
function imgui.Value(prefix, v, float_format) end

---##### (READ-ONLY)
---@param label string
---@param size Vector2
---@param v number
---@param v_min number
---@param v_max number
---@return boolean, number
function imgui.VSliderFloat(label, size, v, v_min, v_max) end

---##### (READ-ONLY)
---@param label string
---@param size Vector2
---@param v number
---@param v_min number
---@param v_max number
---@param format string
---@return boolean, number
function imgui.VSliderFloat(label, size, v, v_min, v_max, format) end

---##### (READ-ONLY)
---@param label string
---@param size Vector2
---@param v number
---@param v_min number
---@param v_max number
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, number
function imgui.VSliderFloat(label, size, v, v_min, v_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param size Vector2
---@param v integer
---@param v_min integer
---@param v_max integer
---@return boolean, integer
function imgui.VSliderInt(label, size, v, v_min, v_max) end

---##### (READ-ONLY)
---@param label string
---@param size Vector2
---@param v integer
---@param v_min integer
---@param v_max integer
---@param format string
---@return boolean, integer
function imgui.VSliderInt(label, size, v, v_min, v_max, format) end

---##### (READ-ONLY)
---@param label string
---@param size Vector2
---@param v integer
---@param v_min integer
---@param v_max integer
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean, integer
function imgui.VSliderInt(label, size, v, v_min, v_max, format, flags) end

---##### (READ-ONLY)
---@param label string
---@param size Vector2
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param p_min lightuserdata
---@param p_max lightuserdata
---@return boolean
function imgui.VSliderScalar(label, size, data_type, p_data, p_min, p_max) end

---##### (READ-ONLY)
---@param label string
---@param size Vector2
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param p_min lightuserdata
---@param p_max lightuserdata
---@param format string
---@return boolean
function imgui.VSliderScalar(label, size, data_type, p_data, p_min, p_max, format) end

---##### (READ-ONLY)
---@param label string
---@param size Vector2
---@param data_type ImGuiDataType|0|1|2|3|4|5|6|7|8|9|10|11|"S8"|"U8"|"S16"|"U16"|"S32"|"U32"|"S64"|"U64"|"Float"|"Double"|"Bool"|"COUNT"
---@param p_data lightuserdata
---@param p_min lightuserdata
---@param p_max lightuserdata
---@param format string
---@param flags ImGuiSliderFlags|integer|"None"|"AlwaysClamp"|"Logarithmic"|"NoRoundToFormat"|"NoInput"|"WrapAround"|"InvalidMask"
---@return boolean
function imgui.VSliderScalar(label, size, data_type, p_data, p_min, p_max, format, flags) end

---@enum ImDrawFlags
imdraw_flags = {
    None = 0,
    Closed = 1,
    RoundCornersTopLeft = 16,
    RoundCornersTopRight = 32,
    RoundCornersTop = 48,
    RoundCornersBottomLeft = 64,
    RoundCornersLeft = 80,
    RoundCornersBottomRight = 128,
    RoundCornersRight = 160,
    RoundCornersBottom = 192,
    RoundCornersAll = 240,
    RoundCornersDefault = 240,
    RoundCornersNone = 256,
    RoundCornersMask = 496,
}

---@enum ImDrawListFlags
imdraw_list_flags = {
    None = 0,
    AntiAliasedLines = 1,
    AntiAliasedLinesUseTex = 2,
    AntiAliasedFill = 4,
    AllowVtxOffset = 8,
}

---@enum ImFontAtlasFlags
imfont_atlas_flags = {
    None = 0,
    NoPowerOfTwoHeight = 1,
    NoMouseCursors = 2,
    NoBakedLines = 4,
}

---@enum ImGuiBackendFlags
imgui_backend_flags = {
    None = 0,
    HasGamepad = 1,
    HasMouseCursors = 2,
    HasSetMousePos = 4,
    RendererHasVtxOffset = 8,
    PlatformHasViewports = 1024,
    HasMouseHoveredViewport = 2048,
    RendererHasViewports = 4096,
}

---@enum ImGuiButtonFlags
imgui_button_flags = {
    None = 0,
    MouseButtonLeft = 1,
    MouseButtonRight = 2,
    MouseButtonMiddle = 4,
    MouseButtonMask = 7,
}

---@enum ImGuiChildFlags
imgui_child_flags = {
    None = 0,
    Border = 1,
    AlwaysUseWindowPadding = 2,
    ResizeX = 4,
    ResizeY = 8,
    AutoResizeX = 16,
    AutoResizeY = 32,
    AlwaysAutoResize = 64,
    FrameStyle = 128,
    NavFlattened = 256,
}

---@enum ImGuiCol
imgui_col = {
    Text = 0,
    TextDisabled = 1,
    WindowBg = 2,
    ChildBg = 3,
    PopupBg = 4,
    Border = 5,
    BorderShadow = 6,
    FrameBg = 7,
    FrameBgHovered = 8,
    FrameBgActive = 9,
    TitleBg = 10,
    TitleBgActive = 11,
    TitleBgCollapsed = 12,
    MenuBarBg = 13,
    ScrollbarBg = 14,
    ScrollbarGrab = 15,
    ScrollbarGrabHovered = 16,
    ScrollbarGrabActive = 17,
    CheckMark = 18,
    SliderGrab = 19,
    SliderGrabActive = 20,
    Button = 21,
    ButtonHovered = 22,
    ButtonActive = 23,
    Header = 24,
    HeaderHovered = 25,
    HeaderActive = 26,
    Separator = 27,
    SeparatorHovered = 28,
    SeparatorActive = 29,
    ResizeGrip = 30,
    ResizeGripHovered = 31,
    ResizeGripActive = 32,
    TabHovered = 33,
    Tab = 34,
    TabActive = 35,
    TabSelected = 36,
    TabSelectedOverline = 37,
    TabDimmed = 38,
    TabDimmedSelected = 39,
    TabDimmedSelectedOverline = 40,
    DockingPreview = 41,
    DockingEmptyBg = 42,
    PlotLines = 43,
    PlotLinesHovered = 44,
    PlotHistogram = 45,
    PlotHistogramHovered = 46,
    TableHeaderBg = 47,
    TableBorderStrong = 48,
    TableBorderLight = 49,
    TableRowBg = 50,
    TableRowBgAlt = 21,
    TextLink = 52,
    TextSelectedBg = 53,
    DragDropTarget = 54,
    NavHighlight = 55,
    NavWindowingHighlight = 56,
    NavWindowingDimBg = 57,
    ModalWindowDimBg = 58,
    COUNT = 59,
}

---@enum ImGuiColorEditFlags
imgui_color_edit_flags = {
    None = 0,
    NoAlpha = 2,
    NoPicker = 4,
    NoOptions = 8,
    NoSmallPreview = 16,
    NoInputs = 32,
    NoTooltip = 64,
    NoLabel = 128,
    NoSidePreview = 256,
    NoDragDrop = 512,
    NoBorder = 1024,
    AlphaBar = 65536,
    AlphaPreview = 131072,
    AlphaPreviewHalf = 262144,
    HDR = 524288,
    DisplayRGB = 1048576,
    DisplayHSV = 2097152,
    DisplayHex = 4194304,
    DisplayMask = 7340032,
    Uint8 = 8388608,
    Float = 16777216,
    DataTypeMask = 25165824,
    PickerHueBar = 33554432,
    PickerHueWheel = 67108864,
    PickerMask = 100663296,
    InputRGB = 134217728,
    DefaultOptions = 177209344,
    InputHSV = 268435456,
    InputMask = 402653184,
}

---@enum ImGuiComboFlags
imgui_combo_flags = {
    None = 0,
    PopupAlignLeft = 1,
    HeightSmall = 2,
    HeightRegular = 4,
    HeightLarge = 8,
    HeightLargest = 16,
    HeightMask = 30,
    NoArrowButton = 32,
    NoPreview = 64,
    WidthFitPreview = 128,
}

---@enum ImGuiCond
imgui_cond = {
    None = 0,
    Always = 1,
    Once = 2,
    FirstUseEver = 4,
    Appearing = 8,
}

---@enum ImGuiConfigFlags
imgui_config_flags = {
    None = 0,
    NavEnableKeyboard = 1,
    NavEnableGamepad = 2,
    NavEnableSetMousePos = 4,
    NavNoCaptureKeyboard = 8,
    NoMouse = 16,
    NoMouseCursorChange = 32,
    NoKeyboard = 64,
    DockingEnable = 128,
    ViewportsEnable = 1024,
    DpiEnableScaleViewports = 16384,
    DpiEnableScaleFonts = 32768,
    IsSRGB = 1048576,
    IsTouchScreen = 2097152,
}

---@enum ImGuiDataType
imgui_data_type = {
    S8 = 0,
    U8 = 1,
    S16 = 2,
    U16 = 3,
    S32 = 4,
    U32 = 5,
    S64 = 6,
    U64 = 7,
    Float = 8,
    Double = 9,
    Bool = 10,
    COUNT = 11,
}

---@enum ImGuiDir
imgui_dir = {
    Left = 0,
    Right = 1,
    Up = 2,
    Down = 3,
    COUNT = 4,
    None = -1,
}

---@enum ImGuiDockNodeFlags
imgui_dock_node_flags = {
    None = 0,
    KeepAliveOnly = 1,
    NoDockingOverCentralNode = 4,
    PassthruCentralNode = 8,
    NoDockingSplit = 16,
    NoResize = 32,
    AutoHideTabBar = 64,
    NoUndocking = 128,
}

---@enum ImGuiDragDropFlags
imgui_drag_drop_flags = {
    None = 0,
    SourceNoPreviewTooltip = 1,
    SourceNoDisableHover = 2,
    SourceNoHoldToOpenOthers = 4,
    SourceAllowNullID = 8,
    SourceExtern = 16,
    PayloadAutoExpire = 32,
    PayloadNoCrossContext = 64,
    PayloadNoCrossProcess = 128,
    AcceptBeforeDelivery = 1024,
    AcceptNoDrawDefaultRect = 2048,
    AcceptPeekOnly = 3072,
    AcceptNoPreviewTooltip = 4096,
}

---@enum ImGuiFocusedFlags
imgui_focused_flags = {
    None = 0,
    ChildWindows = 1,
    RootWindow = 2,
    RootAndChildWindows = 3,
    AnyWindow = 4,
    NoPopupHierarchy = 8,
    DockHierarchy = 16,
}

---@enum ImGuiHoveredFlags
imgui_hovered_flags = {
    None = 0,
    ChildWindows = 1,
    RootWindow = 2,
    RootAndChildWindows = 3,
    AnyWindow = 4,
    NoPopupHierarchy = 8,
    DockHierarchy = 16,
    AllowWhenBlockedByPopup = 32,
    AllowWhenBlockedByActiveItem = 128,
    AllowWhenOverlappedByItem = 256,
    AllowWhenOverlappedByWindow = 512,
    AllowWhenOverlapped = 768,
    RectOnly = 928,
    AllowWhenDisabled = 1024,
    NoNavOverride = 2048,
    ForTooltip = 4096,
    Stationary = 8192,
    DelayNone = 16384,
    DelayShort = 32768,
    DelayNormal = 65536,
    NoSharedDelay = 131072,
}

---@enum ImGuiInputFlags
imgui_input_flags = {
    None = 0,
    Repeat = 1,
    RouteActive = 1024,
    RouteFocused = 2048,
    RouteGlobal = 4096,
    RouteAlways = 8192,
    RouteOverFocused = 16384,
    RouteOverActive = 32768,
    RouteUnlessBgFocused = 65536,
    RouteFromRootWindow = 131072,
    Tooltip = 262144,
}

---@enum ImGuiInputTextFlags
imgui_input_text_flags = {
    None = 0,
    CharsDecimal = 1,
    CharsHexadecimal = 2,
    CharsScientific = 4,
    CharsUppercase = 8,
    CharsNoBlank = 16,
    AllowTabInput = 32,
    EnterReturnsTrue = 64,
    EscapeClearsAll = 128,
    CtrlEnterForNewLine = 256,
    ReadOnly = 512,
    Password = 1024,
    AlwaysOverwrite = 2048,
    AutoSelectAll = 4096,
    ParseEmptyRefVal = 8192,
    DisplayEmptyRefVal = 16384,
    NoHorizontalScroll = 32768,
    NoUndoRedo = 65536,
    CallbackCompletion = 131072,
    CallbackHistory = 262144,
    CallbackAlways = 524288,
    CallbackCharFilter = 1048576,
    CallbackResize = 2097152,
    CallbackEdit = 4194304,
}

---@enum ImGuiItemFlags
imgui_item_flags = {
    None = 0,
    NoTabStop = 1,
    NoNav = 2,
    NoNavDefaultFocus = 4,
    ButtonRepeat = 8,
    AutoClosePopups = 16,
}

---@enum ImGuiKey
imgui_key = {
    None = 0,
    ModNone = 0,
    NamedKey_COUNT = 154,
    KeysData_SIZE = 154,
    NamedKey_BEGIN = 512,
    KeysData_OFFSET = 512,
    Tab = 512,
    LeftArrow = 513,
    RightArrow = 514,
    UpArrow = 515,
    DownArrow = 516,
    PageUp = 517,
    PageDown = 518,
    Home = 519,
    End = 520,
    Insert = 521,
    Delete = 522,
    Backspace = 523,
    Space = 524,
    Enter = 525,
    Escape = 526,
    LeftCtrl = 527,
    LeftShift = 528,
    LeftAlt = 529,
    LeftSuper = 530,
    RightCtrl = 531,
    RightShift = 532,
    RightAlt = 533,
    RightSuper = 534,
    Menu = 535,
    _0 = 536,
    _1 = 537,
    _2 = 538,
    _3 = 539,
    _4 = 540,
    _5 = 541,
    _6 = 542,
    _7 = 543,
    _8 = 544,
    _9 = 545,
    A = 546,
    B = 547,
    C = 548,
    D = 549,
    E = 550,
    F = 551,
    G = 552,
    H = 553,
    I = 554,
    J = 555,
    K = 556,
    L = 557,
    M = 558,
    N = 559,
    O = 560,
    P = 561,
    Q = 562,
    R = 563,
    S = 564,
    T = 565,
    U = 566,
    V = 567,
    W = 568,
    X = 569,
    Y = 570,
    Z = 571,
    F1 = 572,
    F2 = 573,
    F3 = 574,
    F4 = 575,
    F5 = 576,
    F6 = 577,
    F7 = 578,
    F8 = 579,
    F9 = 580,
    F10 = 581,
    F11 = 582,
    F12 = 583,
    F13 = 584,
    F14 = 585,
    F15 = 586,
    F16 = 587,
    F17 = 588,
    F18 = 589,
    F19 = 590,
    F20 = 591,
    F21 = 592,
    F22 = 593,
    F23 = 594,
    F24 = 595,
    Apostrophe = 596,
    Comma = 597,
    Minus = 598,
    Period = 599,
    Slash = 600,
    Semicolon = 601,
    Equal = 602,
    LeftBracket = 603,
    Backslash = 604,
    RightBracket = 605,
    GraveAccent = 606,
    CapsLock = 607,
    ScrollLock = 608,
    NumLock = 609,
    PrintScreen = 610,
    Pause = 611,
    Keypad0 = 612,
    Keypad1 = 613,
    Keypad2 = 614,
    Keypad3 = 615,
    Keypad4 = 616,
    Keypad5 = 617,
    Keypad6 = 618,
    Keypad7 = 619,
    Keypad8 = 620,
    Keypad9 = 621,
    KeypadDecimal = 622,
    KeypadDivide = 623,
    KeypadMultiply = 624,
    KeypadSubtract = 625,
    KeypadAdd = 626,
    KeypadEnter = 627,
    KeypadEqual = 628,
    AppBack = 629,
    AppForward = 630,
    GamepadStart = 631,
    GamepadBack = 632,
    GamepadFaceLeft = 633,
    GamepadFaceRight = 634,
    GamepadFaceUp = 635,
    GamepadFaceDown = 636,
    GamepadDpadLeft = 637,
    GamepadDpadRight = 638,
    GamepadDpadUp = 639,
    GamepadDpadDown = 640,
    GamepadL1 = 641,
    GamepadR1 = 642,
    GamepadL2 = 643,
    GamepadR2 = 644,
    GamepadL3 = 645,
    GamepadR3 = 646,
    GamepadLStickLeft = 647,
    GamepadLStickRight = 648,
    GamepadLStickUp = 649,
    GamepadLStickDown = 650,
    GamepadRStickLeft = 651,
    GamepadRStickRight = 652,
    GamepadRStickUp = 653,
    GamepadRStickDown = 654,
    MouseLeft = 655,
    MouseRight = 656,
    MouseMiddle = 657,
    MouseX1 = 658,
    MouseX2 = 659,
    MouseWheelX = 660,
    MouseWheelY = 661,
    ReservedForModCtrl = 662,
    ReservedForModShift = 663,
    ReservedForModAlt = 664,
    ReservedForModSuper = 665,
    COUNT = 666,
    NamedKey_END = 666,
    ModCtrl = 4096,
    ModShift = 8192,
    ModAlt = 16384,
    ModSuper = 32768,
    ModMask = 61440,
}

---@enum ImGuiModFlags
imgui_mod_flags = {
    None = 0,
    Ctrl = 1,
    Shift = 2,
    Alt = 4,
    Super = 8,
}

---@enum ImGuiMouseButton
imgui_mouse_button = {
    Left = 0,
    Right = 1,
    Middle = 2,
    COUNT = 5,
}

---@enum ImGuiMouseCursor
imgui_mouse_cursor = {
    Arrow = 0,
    TextInput = 1,
    ResizeAll = 2,
    ResizeNS = 3,
    ResizeEW = 4,
    ResizeNESW = 5,
    ResizeNWSE = 6,
    Hand = 7,
    NotAllowed = 8,
    COUNT = 9,
    None = -1,
}

---@enum ImGuiMouseSource
imgui_mouse_source = {
    Mouse = 0,
    TouchScreen = 1,
    Pen = 2,
    COUNT = 3,
}

---@enum ImGuiMultiSelectFlags
imgui_multi_select_flags = {
    None = 0,
    SingleSelect = 1,
    NoSelectAll = 2,
    NoRangeSelect = 4,
    NoAutoSelect = 8,
    NoAutoClear = 16,
    NoAutoClearOnReselect = 32,
    BoxSelect1d = 64,
    BoxSelect2d = 128,
    BoxSelectNoScroll = 256,
    ClearOnEscape = 512,
    ClearOnClickVoid = 1024,
    ScopeWindow = 2048,
    ScopeRect = 4096,
    SelectOnClick = 8192,
    SelectOnClickRelease = 16384,
    NavWrapX = 65536,
}

---@enum ImGuiPopupFlags
imgui_popup_flags = {
    None = 0,
    MouseButtonLeft = 0,
    MouseButtonRight = 1,
    MouseButtonDefault = 1,
    MouseButtonMiddle = 2,
    MouseButtonMask = 31,
    NoReopen = 32,
    NoOpenOverExistingPopup = 128,
    NoOpenOverItems = 256,
    AnyPopupId = 1024,
    AnyPopupLevel = 2048,
    AnyPopup = 3072,
}

---@enum ImGuiSelectableFlags
imgui_selectable_flags = {
    None = 0,
    NoAutoClosePopups = 1,
    SpanAllColumns = 2,
    AllowDoubleClick = 4,
    Disabled = 8,
    AllowOverlap = 16,
    Highlight = 32,
}

---@enum ImGuiSelectionRequestType
imgui_selection_request_type = {
    None = 0,
    SetAll = 1,
    SetRange = 2,
}

---@enum ImGuiSliderFlags
imgui_slider_flags = {
    None = 0,
    AlwaysClamp = 16,
    Logarithmic = 32,
    NoRoundToFormat = 64,
    NoInput = 128,
    WrapAround = 256,
    InvalidMask = 1879048207,
}

---@enum ImGuiSortDirection
imgui_sort_direction = {
    None = 0,
    Ascending = 1,
    Descending = 2,
}

---@enum ImGuiStyleVar
imgui_style_var = {
    Alpha = 0,
    DisabledAlpha = 1,
    WindowPadding = 2,
    WindowRounding = 3,
    WindowBorderSize = 4,
    WindowMinSize = 5,
    WindowTitleAlign = 6,
    ChildRounding = 7,
    ChildBorderSize = 8,
    PopupRounding = 9,
    PopupBorderSize = 10,
    FramePadding = 11,
    FrameRounding = 12,
    FrameBorderSize = 13,
    ItemSpacing = 14,
    ItemInnerSpacing = 15,
    IndentSpacing = 16,
    CellPadding = 17,
    ScrollbarSize = 18,
    ScrollbarRounding = 19,
    GrabMinSize = 20,
    GrabRounding = 21,
    TabRounding = 22,
    TabBorderSize = 23,
    TabBarBorderSize = 24,
    TabBarOverlineSize = 25,
    TableAngledHeadersAngle = 26,
    TableAngledHeadersTextAlign = 27,
    ButtonTextAlign = 28,
    SelectableTextAlign = 29,
    SeparatorTextBorderSize = 30,
    SeparatorTextAlign = 31,
    SeparatorTextPadding = 32,
    DockingSeparatorSize = 33,
    COUNT = 34,
}

---@enum ImGuiTabBarFlags
imgui_tab_bar_flags = {
    None = 0,
    Reorderable = 1,
    AutoSelectNewTabs = 2,
    TabListPopupButton = 4,
    NoCloseWithMiddleMouseButton = 8,
    NoTabListScrollingButtons = 16,
    NoTooltip = 32,
    DrawSelectedOverline = 64,
    FittingPolicyResizeDown = 128,
    FittingPolicyDefault = 128,
    FittingPolicyScroll = 256,
    FittingPolicyMask = 384,
}

---@enum ImGuiTabItemFlags
imgui_tab_item_flags = {
    None = 0,
    UnsavedDocument = 1,
    SetSelected = 2,
    NoCloseWithMiddleMouseButton = 4,
    NoPushId = 8,
    NoTooltip = 16,
    NoReorder = 32,
    Leading = 64,
    Trailing = 128,
    NoAssumedClosure = 256,
}

---@enum ImGuiTableBgTarget
imgui_table_bg_target = {
    None = 0,
    RowBg0 = 1,
    RowBg1 = 2,
    CellBg = 3,
}

---@enum ImGuiTableColumnFlags
imgui_table_column_flags = {
    None = 0,
    Disabled = 1,
    DefaultHide = 2,
    DefaultSort = 4,
    WidthStretch = 8,
    WidthFixed = 16,
    WidthMask = 24,
    NoResize = 32,
    NoReorder = 64,
    NoHide = 128,
    NoClip = 256,
    NoSort = 512,
    NoSortAscending = 1024,
    NoSortDescending = 2048,
    NoHeaderLabel = 4096,
    NoHeaderWidth = 8192,
    PreferSortAscending = 16384,
    PreferSortDescending = 32768,
    IndentEnable = 65536,
    IndentDisable = 131072,
    IndentMask = 196608,
    AngledHeader = 262144,
    IsEnabled = 16777216,
    IsVisible = 33554432,
    IsSorted = 67108864,
    IsHovered = 134217728,
    StatusMask = 251658240,
    NoDirectResize = 1073741824,
}

---@enum ImGuiTableFlags
imgui_table_flags = {
    None = 0,
    Resizable = 1,
    Reorderable = 2,
    Hideable = 4,
    Sortable = 8,
    NoSavedSettings = 16,
    ContextMenuInBody = 32,
    RowBg = 64,
    BordersInnerH = 128,
    BordersOuterH = 256,
    BordersH = 384,
    BordersInnerV = 512,
    BordersInner = 640,
    BordersOuterV = 1024,
    BordersOuter = 1280,
    BordersV = 1536,
    Borders = 1920,
    NoBordersInBody = 2048,
    NoBordersInBodyUntilResize = 4096,
    SizingFixedFit = 8192,
    SizingFixedSame = 16384,
    SizingStretchProp = 24576,
    SizingStretchSame = 32768,
    SizingMask = 57344,
    NoHostExtendX = 65536,
    NoHostExtendY = 131072,
    NoKeepColumnsVisible = 262144,
    PreciseWidths = 524288,
    NoClip = 1048576,
    PadOuterX = 2097152,
    NoPadOuterX = 4194304,
    NoPadInnerX = 8388608,
    ScrollX = 16777216,
    ScrollY = 33554432,
    SortMulti = 67108864,
    SortTristate = 134217728,
    HighlightHoveredColumn = 268435456,
}

---@enum ImGuiTableRowFlags
imgui_table_row_flags = {
    None = 0,
    Headers = 1,
}

---@enum ImGuiTreeNodeFlags
imgui_tree_node_flags = {
    None = 0,
    Selected = 1,
    Framed = 2,
    AllowOverlap = 4,
    NoTreePushOnOpen = 8,
    NoAutoOpenOnLog = 16,
    CollapsingHeader = 26,
    DefaultOpen = 32,
    OpenOnDoubleClick = 64,
    OpenOnArrow = 128,
    Leaf = 256,
    Bullet = 512,
    FramePadding = 1024,
    SpanAvailWidth = 2048,
    SpanFullWidth = 4096,
    SpanTextWidth = 8192,
    SpanAllColumns = 16384,
    NavLeftJumpsBackHere = 32768,
}

---@enum ImGuiViewportFlags
imgui_viewport_flags = {
    None = 0,
    IsPlatformWindow = 1,
    IsPlatformMonitor = 2,
    OwnedByApp = 4,
    NoDecoration = 8,
    NoTaskBarIcon = 16,
    NoFocusOnAppearing = 32,
    NoFocusOnClick = 64,
    NoInputs = 128,
    NoRendererClear = 256,
    NoAutoMerge = 512,
    TopMost = 1024,
    CanHostOtherWindows = 2048,
    IsMinimized = 4096,
    IsFocused = 8192,
}

---@enum ImGuiWindowFlags
imgui_window_flags = {
    None = 0,
    NoTitleBar = 1,
    NoResize = 2,
    NoMove = 4,
    NoScrollbar = 8,
    NoScrollWithMouse = 16,
    NoCollapse = 32,
    NoDecoration = 43,
    AlwaysAutoResize = 64,
    NoBackground = 128,
    NoSavedSettings = 256,
    NoMouseInputs = 512,
    MenuBar = 1024,
    HorizontalScrollbar = 2048,
    NoFocusOnAppearing = 4096,
    NoBringToFrontOnFocus = 8192,
    AlwaysVerticalScrollbar = 16384,
    AlwaysHorizontalScrollbar = 32768,
    NoNavInputs = 65536,
    NoNavFocus = 131072,
    NoNav = 196608,
    NoInputs = 197120,
    UnsavedDocument = 262144,
    NoDocking = 524288,
    ChildWindow = 16777216,
    Tooltip = 33554432,
    Popup = 67108864,
    Modal = 134217728,
    ChildMenu = 268435456,
    DockNodeHost = 536870912,
}

---@class ImColor
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field Value Vector4

---@class ImColorPtr
---@field get_Value fun(): Vector4 READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field HSV fun(h: number, s: number, v: number): ImColor READ-ONLY
---@field HSV fun(h: number, s: number, v: number, a: number): ImColor READ-ONLY
---@field SetHSV fun(h: number, s: number, v: number): nil READ-ONLY
---@field SetHSV fun(h: number, s: number, v: number, a: number): nil READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field Value Vector4

---@class ImDrawChannel
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field _CmdBuffer ImVector
---@field _IdxBuffer ImVector

---@class ImDrawChannelPtr
---@field get__CmdBuffer fun(): ImPtrVector<ImDrawCmdPtr> READ-ONLY
---@field get__IdxBuffer fun(): ImVector<integer> READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field _CmdBuffer ImPtrVector<ImDrawCmdPtr>
---@field _IdxBuffer ImVector<integer>

---@class ImDrawCmd
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field ClipRect Vector4
---@field TextureId lightuserdata
---@field VtxOffset integer
---@field IdxOffset integer
---@field ElemCount integer
---@field UserCallback lightuserdata

---@class ImDrawCmdHeader
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field ClipRect Vector4
---@field TextureId lightuserdata
---@field VtxOffset integer

---@class ImDrawCmdHeaderPtr
---@field get_ClipRect fun(): Vector4 READ-ONLY
---@field get_TextureId fun(): lightuserdata READ-ONLY
---@field get_VtxOffset fun(): integer READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field ClipRect Vector4
---@field TextureId lightuserdata
---@field VtxOffset integer

---@class ImDrawCmdPtr
---@field get_ClipRect fun(): Vector4 READ-ONLY
---@field get_TextureId fun(): lightuserdata READ-ONLY
---@field get_VtxOffset fun(): integer READ-ONLY
---@field get_IdxOffset fun(): integer READ-ONLY
---@field get_ElemCount fun(): integer READ-ONLY
---@field get_UserCallback fun(): lightuserdata READ-ONLY
---@field get_UserCallbackData fun(): lightuserdata READ-ONLY
---@field set_UserCallbackData fun(value: lightuserdata): nil READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field GetTexID fun(): lightuserdata READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field ClipRect Vector4
---@field TextureId lightuserdata
---@field VtxOffset integer
---@field IdxOffset integer
---@field ElemCount integer
---@field UserCallback lightuserdata
---@field UserCallbackData lightuserdata

---@class ImDrawData
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field Valid integer
---@field CmdListsCount integer
---@field TotalIdxCount integer
---@field TotalVtxCount integer
---@field CmdLists ImVector
---@field DisplayPos Vector2
---@field DisplaySize Vector2
---@field FramebufferScale Vector2

---@class ImDrawDataPtr
---@field get_Valid fun(): boolean READ-ONLY
---@field get_CmdListsCount fun(): integer READ-ONLY
---@field get_TotalIdxCount fun(): integer READ-ONLY
---@field get_TotalVtxCount fun(): integer READ-ONLY
---@field get_CmdLists fun(): ImVector<ImDrawListPtr> READ-ONLY
---@field get_DisplayPos fun(): Vector2 READ-ONLY
---@field get_DisplaySize fun(): Vector2 READ-ONLY
---@field get_FramebufferScale fun(): Vector2 READ-ONLY
---@field get_OwnerViewport fun(): ImGuiViewportPtr READ-ONLY
---@field AddDrawList fun(draw_list: ImDrawListPtr): nil READ-ONLY
---@field Clear fun(): nil READ-ONLY
---@field DeIndexAllBuffers fun(): nil READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field ScaleClipRects fun(fb_scale: Vector2): nil READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field Valid boolean
---@field CmdListsCount integer
---@field TotalIdxCount integer
---@field TotalVtxCount integer
---@field CmdLists ImVector<ImDrawListPtr>
---@field DisplayPos Vector2
---@field DisplaySize Vector2
---@field FramebufferScale Vector2
---@field OwnerViewport ImGuiViewportPtr

---@class ImDrawList
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field CmdBuffer ImVector
---@field IdxBuffer ImVector
---@field VtxBuffer ImVector
---@field Flags ImDrawListFlags|integer|"None"|"AntiAliasedLines"|"AntiAliasedLinesUseTex"|"AntiAliasedFill"|"AllowVtxOffset"
---@field _VtxCurrentIdx integer
---@field _Data lightuserdata
---@field _Path ImVector
---@field _CmdHeader ImDrawCmdHeader
---@field _Splitter ImDrawListSplitter
---@field _ClipRectStack ImVector
---@field _TextureIdStack ImVector
---@field _FringeScale number

---@class ImDrawListPtr
---@field get_CmdBuffer fun(): ImPtrVector<ImDrawCmdPtr> READ-ONLY
---@field get_IdxBuffer fun(): ImVector<integer> READ-ONLY
---@field get_VtxBuffer fun(): ImPtrVector<ImDrawVertPtr> READ-ONLY
---@field get_Flags fun(): ImDrawListFlags|integer|"None"|"AntiAliasedLines"|"AntiAliasedLinesUseTex"|"AntiAliasedFill"|"AllowVtxOffset" READ-ONLY
---@field get__VtxCurrentIdx fun(): integer READ-ONLY
---@field get__Data fun(): lightuserdata READ-ONLY
---@field get__VtxWritePtr fun(): ImDrawVertPtr READ-ONLY
---@field get__IdxWritePtr fun(): lightuserdata READ-ONLY
---@field set__IdxWritePtr fun(value: lightuserdata): nil READ-ONLY
---@field get__Path fun(): ImVector<Vector2> READ-ONLY
---@field get__CmdHeader fun(): ImDrawCmdHeader READ-ONLY
---@field get__Splitter fun(): ImDrawListSplitter READ-ONLY
---@field get__ClipRectStack fun(): ImVector<Vector4> READ-ONLY
---@field get__TextureIdStack fun(): ImVector<lightuserdata> READ-ONLY
---@field get__FringeScale fun(): number READ-ONLY
---@field get__OwnerName fun(): NullTerminatedString READ-ONLY
---@field _CalcCircleAutoSegmentCount fun(radius: number): integer READ-ONLY
---@field _ClearFreeMemory fun(): nil READ-ONLY
---@field _OnChangedClipRect fun(): nil READ-ONLY
---@field _OnChangedTextureID fun(): nil READ-ONLY
---@field _OnChangedVtxOffset fun(): nil READ-ONLY
---@field _PathArcToFastEx fun(center: Vector2, radius: number, a_min_sample: integer, a_max_sample: integer, a_step: integer): nil READ-ONLY
---@field _PathArcToN fun(center: Vector2, radius: number, a_min: number, a_max: number, num_segments: integer): nil READ-ONLY
---@field _PopUnusedDrawCmd fun(): nil READ-ONLY
---@field _ResetForNewFrame fun(): nil READ-ONLY
---@field _TryMergeDrawCmds fun(): nil READ-ONLY
---@field AddBezierCubic fun(p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, col: integer, thickness: number): nil READ-ONLY
---@field AddBezierCubic fun(p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, col: integer, thickness: number, num_segments: integer): nil READ-ONLY
---@field AddBezierQuadratic fun(p1: Vector2, p2: Vector2, p3: Vector2, col: integer, thickness: number): nil READ-ONLY
---@field AddBezierQuadratic fun(p1: Vector2, p2: Vector2, p3: Vector2, col: integer, thickness: number, num_segments: integer): nil READ-ONLY
---@field AddCallback fun(callback: lightuserdata, callback_data: lightuserdata): nil READ-ONLY
---@field AddCircle fun(center: Vector2, radius: number, col: integer): nil READ-ONLY
---@field AddCircle fun(center: Vector2, radius: number, col: integer, num_segments: integer): nil READ-ONLY
---@field AddCircle fun(center: Vector2, radius: number, col: integer, num_segments: integer, thickness: number): nil READ-ONLY
---@field AddCircleFilled fun(center: Vector2, radius: number, col: integer): nil READ-ONLY
---@field AddCircleFilled fun(center: Vector2, radius: number, col: integer, num_segments: integer): nil READ-ONLY
---@field AddConcavePolyFilled fun(points: Vector2, num_points: integer, col: integer): nil READ-ONLY
---@field AddConvexPolyFilled fun(points: Vector2, num_points: integer, col: integer): nil READ-ONLY
---@field AddDrawCmd fun(): nil READ-ONLY
---@field AddEllipse fun(center: Vector2, radius: Vector2, col: integer): nil READ-ONLY
---@field AddEllipse fun(center: Vector2, radius: Vector2, col: integer, rot: number): nil READ-ONLY
---@field AddEllipse fun(center: Vector2, radius: Vector2, col: integer, rot: number, num_segments: integer): nil READ-ONLY
---@field AddEllipse fun(center: Vector2, radius: Vector2, col: integer, rot: number, num_segments: integer, thickness: number): nil READ-ONLY
---@field AddEllipseFilled fun(center: Vector2, radius: Vector2, col: integer): nil READ-ONLY
---@field AddEllipseFilled fun(center: Vector2, radius: Vector2, col: integer, rot: number): nil READ-ONLY
---@field AddEllipseFilled fun(center: Vector2, radius: Vector2, col: integer, rot: number, num_segments: integer): nil READ-ONLY
---@field AddImage fun(user_texture_id: lightuserdata, p_min: Vector2, p_max: Vector2): nil READ-ONLY
---@field AddImage fun(user_texture_id: lightuserdata, p_min: Vector2, p_max: Vector2, uv_min: Vector2): nil READ-ONLY
---@field AddImage fun(user_texture_id: lightuserdata, p_min: Vector2, p_max: Vector2, uv_min: Vector2, uv_max: Vector2): nil READ-ONLY
---@field AddImage fun(user_texture_id: lightuserdata, p_min: Vector2, p_max: Vector2, uv_min: Vector2, uv_max: Vector2, col: integer): nil READ-ONLY
---@field AddImageQuad fun(user_texture_id: lightuserdata, p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2): nil READ-ONLY
---@field AddImageQuad fun(user_texture_id: lightuserdata, p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, uv1: Vector2): nil READ-ONLY
---@field AddImageQuad fun(user_texture_id: lightuserdata, p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, uv1: Vector2, uv2: Vector2): nil READ-ONLY
---@field AddImageQuad fun(user_texture_id: lightuserdata, p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, uv1: Vector2, uv2: Vector2, uv3: Vector2): nil READ-ONLY
---@field AddImageQuad fun(user_texture_id: lightuserdata, p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, uv1: Vector2, uv2: Vector2, uv3: Vector2, uv4: Vector2): nil READ-ONLY
---@field AddImageQuad fun(user_texture_id: lightuserdata, p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, uv1: Vector2, uv2: Vector2, uv3: Vector2, uv4: Vector2, col: integer): nil READ-ONLY
---@field AddImageRounded fun(user_texture_id: lightuserdata, p_min: Vector2, p_max: Vector2, uv_min: Vector2, uv_max: Vector2, col: integer, rounding: number): nil READ-ONLY
---@field AddImageRounded fun(user_texture_id: lightuserdata, p_min: Vector2, p_max: Vector2, uv_min: Vector2, uv_max: Vector2, col: integer, rounding: number, flags: ImDrawFlags|integer|"None"|"Closed"|"RoundCornersTopLeft"|"RoundCornersTopRight"|"RoundCornersTop"|"RoundCornersBottomLeft"|"RoundCornersLeft"|"RoundCornersBottomRight"|"RoundCornersRight"|"RoundCornersBottom"|"RoundCornersAll"|"RoundCornersDefault"|"RoundCornersNone"|"RoundCornersMask"): nil READ-ONLY
---@field AddLine fun(p1: Vector2, p2: Vector2, col: integer): nil READ-ONLY
---@field AddLine fun(p1: Vector2, p2: Vector2, col: integer, thickness: number): nil READ-ONLY
---@field AddNgon fun(center: Vector2, radius: number, col: integer, num_segments: integer): nil READ-ONLY
---@field AddNgon fun(center: Vector2, radius: number, col: integer, num_segments: integer, thickness: number): nil READ-ONLY
---@field AddNgonFilled fun(center: Vector2, radius: number, col: integer, num_segments: integer): nil READ-ONLY
---@field AddPolyline fun(points: Vector2, num_points: integer, col: integer, flags: ImDrawFlags|integer|"None"|"Closed"|"RoundCornersTopLeft"|"RoundCornersTopRight"|"RoundCornersTop"|"RoundCornersBottomLeft"|"RoundCornersLeft"|"RoundCornersBottomRight"|"RoundCornersRight"|"RoundCornersBottom"|"RoundCornersAll"|"RoundCornersDefault"|"RoundCornersNone"|"RoundCornersMask", thickness: number): nil READ-ONLY
---@field AddQuad fun(p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, col: integer): nil READ-ONLY
---@field AddQuad fun(p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, col: integer, thickness: number): nil READ-ONLY
---@field AddQuadFilled fun(p1: Vector2, p2: Vector2, p3: Vector2, p4: Vector2, col: integer): nil READ-ONLY
---@field AddRect fun(p_min: Vector2, p_max: Vector2, col: integer): nil READ-ONLY
---@field AddRect fun(p_min: Vector2, p_max: Vector2, col: integer, rounding: number): nil READ-ONLY
---@field AddRect fun(p_min: Vector2, p_max: Vector2, col: integer, rounding: number, flags: ImDrawFlags|integer|"None"|"Closed"|"RoundCornersTopLeft"|"RoundCornersTopRight"|"RoundCornersTop"|"RoundCornersBottomLeft"|"RoundCornersLeft"|"RoundCornersBottomRight"|"RoundCornersRight"|"RoundCornersBottom"|"RoundCornersAll"|"RoundCornersDefault"|"RoundCornersNone"|"RoundCornersMask"): nil READ-ONLY
---@field AddRect fun(p_min: Vector2, p_max: Vector2, col: integer, rounding: number, flags: ImDrawFlags|integer|"None"|"Closed"|"RoundCornersTopLeft"|"RoundCornersTopRight"|"RoundCornersTop"|"RoundCornersBottomLeft"|"RoundCornersLeft"|"RoundCornersBottomRight"|"RoundCornersRight"|"RoundCornersBottom"|"RoundCornersAll"|"RoundCornersDefault"|"RoundCornersNone"|"RoundCornersMask", thickness: number): nil READ-ONLY
---@field AddRectFilled fun(p_min: Vector2, p_max: Vector2, col: integer): nil READ-ONLY
---@field AddRectFilled fun(p_min: Vector2, p_max: Vector2, col: integer, rounding: number): nil READ-ONLY
---@field AddRectFilled fun(p_min: Vector2, p_max: Vector2, col: integer, rounding: number, flags: ImDrawFlags|integer|"None"|"Closed"|"RoundCornersTopLeft"|"RoundCornersTopRight"|"RoundCornersTop"|"RoundCornersBottomLeft"|"RoundCornersLeft"|"RoundCornersBottomRight"|"RoundCornersRight"|"RoundCornersBottom"|"RoundCornersAll"|"RoundCornersDefault"|"RoundCornersNone"|"RoundCornersMask"): nil READ-ONLY
---@field AddRectFilledMultiColor fun(p_min: Vector2, p_max: Vector2, col_upr_left: integer, col_upr_right: integer, col_bot_right: integer, col_bot_left: integer): nil READ-ONLY
---@field AddText fun(pos: Vector2, col: integer, text_begin: string): nil READ-ONLY
---@field AddText fun(font: ImFontPtr, font_size: number, pos: Vector2, col: integer, text_begin: string): nil READ-ONLY
---@field AddText fun(font: ImFontPtr, font_size: number, pos: Vector2, col: integer, text_begin: string, wrap_width: number): nil READ-ONLY
---@field AddText fun(font: ImFontPtr, font_size: number, pos: Vector2, col: integer, text_begin: string, wrap_width: number, cpu_fine_clip_rect: Vector4): nil READ-ONLY
---@field AddTriangle fun(p1: Vector2, p2: Vector2, p3: Vector2, col: integer): nil READ-ONLY
---@field AddTriangle fun(p1: Vector2, p2: Vector2, p3: Vector2, col: integer, thickness: number): nil READ-ONLY
---@field AddTriangleFilled fun(p1: Vector2, p2: Vector2, p3: Vector2, col: integer): nil READ-ONLY
---@field ChannelsMerge fun(): nil READ-ONLY
---@field ChannelsSetCurrent fun(n: integer): nil READ-ONLY
---@field ChannelsSplit fun(count: integer): nil READ-ONLY
---@field CloneOutput fun(): ImDrawListPtr READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field GetClipRectMax fun(): Vector2 READ-ONLY
---@field GetClipRectMin fun(): Vector2 READ-ONLY
---@field PathArcTo fun(center: Vector2, radius: number, a_min: number, a_max: number): nil READ-ONLY
---@field PathArcTo fun(center: Vector2, radius: number, a_min: number, a_max: number, num_segments: integer): nil READ-ONLY
---@field PathArcToFast fun(center: Vector2, radius: number, a_min_of_12: integer, a_max_of_12: integer): nil READ-ONLY
---@field PathBezierCubicCurveTo fun(p2: Vector2, p3: Vector2, p4: Vector2): nil READ-ONLY
---@field PathBezierCubicCurveTo fun(p2: Vector2, p3: Vector2, p4: Vector2, num_segments: integer): nil READ-ONLY
---@field PathBezierQuadraticCurveTo fun(p2: Vector2, p3: Vector2): nil READ-ONLY
---@field PathBezierQuadraticCurveTo fun(p2: Vector2, p3: Vector2, num_segments: integer): nil READ-ONLY
---@field PathClear fun(): nil READ-ONLY
---@field PathEllipticalArcTo fun(center: Vector2, radius: Vector2, rot: number, a_min: number, a_max: number): nil READ-ONLY
---@field PathEllipticalArcTo fun(center: Vector2, radius: Vector2, rot: number, a_min: number, a_max: number, num_segments: integer): nil READ-ONLY
---@field PathFillConcave fun(col: integer): nil READ-ONLY
---@field PathFillConvex fun(col: integer): nil READ-ONLY
---@field PathLineTo fun(pos: Vector2): nil READ-ONLY
---@field PathLineToMergeDuplicate fun(pos: Vector2): nil READ-ONLY
---@field PathRect fun(rect_min: Vector2, rect_max: Vector2): nil READ-ONLY
---@field PathRect fun(rect_min: Vector2, rect_max: Vector2, rounding: number): nil READ-ONLY
---@field PathRect fun(rect_min: Vector2, rect_max: Vector2, rounding: number, flags: ImDrawFlags|integer|"None"|"Closed"|"RoundCornersTopLeft"|"RoundCornersTopRight"|"RoundCornersTop"|"RoundCornersBottomLeft"|"RoundCornersLeft"|"RoundCornersBottomRight"|"RoundCornersRight"|"RoundCornersBottom"|"RoundCornersAll"|"RoundCornersDefault"|"RoundCornersNone"|"RoundCornersMask"): nil READ-ONLY
---@field PathStroke fun(col: integer): nil READ-ONLY
---@field PathStroke fun(col: integer, flags: ImDrawFlags|integer|"None"|"Closed"|"RoundCornersTopLeft"|"RoundCornersTopRight"|"RoundCornersTop"|"RoundCornersBottomLeft"|"RoundCornersLeft"|"RoundCornersBottomRight"|"RoundCornersRight"|"RoundCornersBottom"|"RoundCornersAll"|"RoundCornersDefault"|"RoundCornersNone"|"RoundCornersMask"): nil READ-ONLY
---@field PathStroke fun(col: integer, flags: ImDrawFlags|integer|"None"|"Closed"|"RoundCornersTopLeft"|"RoundCornersTopRight"|"RoundCornersTop"|"RoundCornersBottomLeft"|"RoundCornersLeft"|"RoundCornersBottomRight"|"RoundCornersRight"|"RoundCornersBottom"|"RoundCornersAll"|"RoundCornersDefault"|"RoundCornersNone"|"RoundCornersMask", thickness: number): nil READ-ONLY
---@field PopClipRect fun(): nil READ-ONLY
---@field PopTextureID fun(): nil READ-ONLY
---@field PrimQuadUV fun(a: Vector2, b: Vector2, c: Vector2, d: Vector2, uv_a: Vector2, uv_b: Vector2, uv_c: Vector2, uv_d: Vector2, col: integer): nil READ-ONLY
---@field PrimRect fun(a: Vector2, b: Vector2, col: integer): nil READ-ONLY
---@field PrimRectUV fun(a: Vector2, b: Vector2, uv_a: Vector2, uv_b: Vector2, col: integer): nil READ-ONLY
---@field PrimReserve fun(idx_count: integer, vtx_count: integer): nil READ-ONLY
---@field PrimUnreserve fun(idx_count: integer, vtx_count: integer): nil READ-ONLY
---@field PrimVtx fun(pos: Vector2, uv: Vector2, col: integer): nil READ-ONLY
---@field PrimWriteIdx fun(idx: integer): nil READ-ONLY
---@field PrimWriteVtx fun(pos: Vector2, uv: Vector2, col: integer): nil READ-ONLY
---@field PushClipRect fun(clip_rect_min: Vector2, clip_rect_max: Vector2): nil READ-ONLY
---@field PushClipRect fun(clip_rect_min: Vector2, clip_rect_max: Vector2, intersect_with_current_clip_rect: boolean): nil READ-ONLY
---@field PushClipRectFullScreen fun(): nil READ-ONLY
---@field PushTextureID fun(texture_id: lightuserdata): nil READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field CmdBuffer ImPtrVector<ImDrawCmdPtr>
---@field IdxBuffer ImVector<integer>
---@field VtxBuffer ImPtrVector<ImDrawVertPtr>
---@field Flags ImDrawListFlags|integer|"None"|"AntiAliasedLines"|"AntiAliasedLinesUseTex"|"AntiAliasedFill"|"AllowVtxOffset"
---@field _VtxCurrentIdx integer
---@field _Data lightuserdata
---@field _VtxWritePtr ImDrawVertPtr
---@field _IdxWritePtr lightuserdata
---@field _Path ImVector<Vector2>
---@field _CmdHeader ImDrawCmdHeader
---@field _Splitter ImDrawListSplitter
---@field _ClipRectStack ImVector<Vector4>
---@field _TextureIdStack ImVector<lightuserdata>
---@field _FringeScale number
---@field _OwnerName NullTerminatedString

---@class ImDrawListSplitter
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field _Current integer
---@field _Count integer
---@field _Channels ImVector

---@class ImDrawListSplitterPtr
---@field get__Current fun(): integer READ-ONLY
---@field get__Count fun(): integer READ-ONLY
---@field get__Channels fun(): ImPtrVector<ImDrawChannelPtr> READ-ONLY
---@field Clear fun(): nil READ-ONLY
---@field ClearFreeMemory fun(): nil READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field Merge fun(draw_list: ImDrawListPtr): nil READ-ONLY
---@field SetCurrentChannel fun(draw_list: ImDrawListPtr, channel_idx: integer): nil READ-ONLY
---@field Split fun(draw_list: ImDrawListPtr, count: integer): nil READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field _Current integer
---@field _Count integer
---@field _Channels ImPtrVector<ImDrawChannelPtr>

---@class ImDrawVert
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field pos Vector2
---@field uv Vector2
---@field col integer

---@class ImDrawVertPtr
---@field get_pos fun(): Vector2 READ-ONLY
---@field get_uv fun(): Vector2 READ-ONLY
---@field get_col fun(): integer READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field pos Vector2
---@field uv Vector2
---@field col integer

---@class ImFont
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field IndexAdvanceX ImVector
---@field FallbackAdvanceX number
---@field FontSize number
---@field IndexLookup ImVector
---@field Glyphs ImVector
---@field ConfigDataCount integer
---@field FallbackChar integer
---@field EllipsisChar integer
---@field EllipsisCharCount integer
---@field EllipsisWidth number
---@field EllipsisCharStep number
---@field DirtyLookupTables integer
---@field Scale number
---@field Ascent number
---@field Descent number
---@field MetricsTotalSurface integer

---@class ImFontAtlas
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field Flags ImFontAtlasFlags|integer|"None"|"NoPowerOfTwoHeight"|"NoMouseCursors"|"NoBakedLines"
---@field TexID lightuserdata
---@field TexDesiredWidth integer
---@field TexGlyphPadding integer
---@field Locked integer
---@field TexReady integer
---@field TexPixelsUseColors integer
---@field TexWidth integer
---@field TexHeight integer
---@field TexUvScale Vector2
---@field TexUvWhitePixel Vector2
---@field Fonts ImVector
---@field CustomRects ImVector
---@field ConfigData ImVector
---@field TexUvLines_0 Vector4
---@field TexUvLines_1 Vector4
---@field TexUvLines_2 Vector4
---@field TexUvLines_3 Vector4
---@field TexUvLines_4 Vector4
---@field TexUvLines_5 Vector4
---@field TexUvLines_6 Vector4
---@field TexUvLines_7 Vector4
---@field TexUvLines_8 Vector4
---@field TexUvLines_9 Vector4
---@field TexUvLines_10 Vector4
---@field TexUvLines_11 Vector4
---@field TexUvLines_12 Vector4
---@field TexUvLines_13 Vector4
---@field TexUvLines_14 Vector4
---@field TexUvLines_15 Vector4
---@field TexUvLines_16 Vector4
---@field TexUvLines_17 Vector4
---@field TexUvLines_18 Vector4
---@field TexUvLines_19 Vector4
---@field TexUvLines_20 Vector4
---@field TexUvLines_21 Vector4
---@field TexUvLines_22 Vector4
---@field TexUvLines_23 Vector4
---@field TexUvLines_24 Vector4
---@field TexUvLines_25 Vector4
---@field TexUvLines_26 Vector4
---@field TexUvLines_27 Vector4
---@field TexUvLines_28 Vector4
---@field TexUvLines_29 Vector4
---@field TexUvLines_30 Vector4
---@field TexUvLines_31 Vector4
---@field TexUvLines_32 Vector4
---@field TexUvLines_33 Vector4
---@field TexUvLines_34 Vector4
---@field TexUvLines_35 Vector4
---@field TexUvLines_36 Vector4
---@field TexUvLines_37 Vector4
---@field TexUvLines_38 Vector4
---@field TexUvLines_39 Vector4
---@field TexUvLines_40 Vector4
---@field TexUvLines_41 Vector4
---@field TexUvLines_42 Vector4
---@field TexUvLines_43 Vector4
---@field TexUvLines_44 Vector4
---@field TexUvLines_45 Vector4
---@field TexUvLines_46 Vector4
---@field TexUvLines_47 Vector4
---@field TexUvLines_48 Vector4
---@field TexUvLines_49 Vector4
---@field TexUvLines_50 Vector4
---@field TexUvLines_51 Vector4
---@field TexUvLines_52 Vector4
---@field TexUvLines_53 Vector4
---@field TexUvLines_54 Vector4
---@field TexUvLines_55 Vector4
---@field TexUvLines_56 Vector4
---@field TexUvLines_57 Vector4
---@field TexUvLines_58 Vector4
---@field TexUvLines_59 Vector4
---@field TexUvLines_60 Vector4
---@field TexUvLines_61 Vector4
---@field TexUvLines_62 Vector4
---@field TexUvLines_63 Vector4
---@field FontBuilderFlags integer
---@field PackIdMouseCursors integer
---@field PackIdLines integer

---@class ImFontAtlasCustomRect
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field Width integer
---@field Height integer
---@field X integer
---@field Y integer
---@field GlyphID integer
---@field GlyphAdvanceX number
---@field GlyphOffset Vector2

---@class ImFontAtlasCustomRectPtr
---@field get_Width fun(): integer READ-ONLY
---@field get_Height fun(): integer READ-ONLY
---@field get_X fun(): integer READ-ONLY
---@field get_Y fun(): integer READ-ONLY
---@field get_GlyphID fun(): integer READ-ONLY
---@field get_GlyphAdvanceX fun(): number READ-ONLY
---@field get_GlyphOffset fun(): Vector2 READ-ONLY
---@field get_Font fun(): ImFontPtr READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field IsPacked fun(): boolean READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field Width integer
---@field Height integer
---@field X integer
---@field Y integer
---@field GlyphID integer
---@field GlyphAdvanceX number
---@field GlyphOffset Vector2
---@field Font ImFontPtr

---@class ImFontAtlasPtr
---@field get_Flags fun(): ImFontAtlasFlags|integer|"None"|"NoPowerOfTwoHeight"|"NoMouseCursors"|"NoBakedLines" READ-ONLY
---@field get_TexID fun(): lightuserdata READ-ONLY
---@field get_TexDesiredWidth fun(): integer READ-ONLY
---@field get_TexGlyphPadding fun(): integer READ-ONLY
---@field get_Locked fun(): boolean READ-ONLY
---@field get_UserData fun(): lightuserdata READ-ONLY
---@field set_UserData fun(value: lightuserdata): nil READ-ONLY
---@field get_TexReady fun(): boolean READ-ONLY
---@field get_TexPixelsUseColors fun(): boolean READ-ONLY
---@field get_TexPixelsAlpha8 fun(): lightuserdata READ-ONLY
---@field set_TexPixelsAlpha8 fun(value: lightuserdata): nil READ-ONLY
---@field get_TexPixelsRGBA32 fun(): lightuserdata READ-ONLY
---@field set_TexPixelsRGBA32 fun(value: lightuserdata): nil READ-ONLY
---@field get_TexWidth fun(): integer READ-ONLY
---@field get_TexHeight fun(): integer READ-ONLY
---@field get_TexUvScale fun(): Vector2 READ-ONLY
---@field get_TexUvWhitePixel fun(): Vector2 READ-ONLY
---@field get_Fonts fun(): ImVector<ImFontPtr> READ-ONLY
---@field get_CustomRects fun(): ImPtrVector<ImFontAtlasCustomRectPtr> READ-ONLY
---@field get_ConfigData fun(): ImPtrVector<ImFontConfigPtr> READ-ONLY
---@field get_TexUvLines fun(): RangeAccessor<Vector4> READ-ONLY
---@field get_FontBuilderIO fun(): lightuserdata READ-ONLY
---@field set_FontBuilderIO fun(value: lightuserdata): nil READ-ONLY
---@field get_FontBuilderFlags fun(): integer READ-ONLY
---@field get_PackIdMouseCursors fun(): integer READ-ONLY
---@field get_PackIdLines fun(): integer READ-ONLY
---@field AddCustomRectFontGlyph fun(font: ImFontPtr, id: integer, width: integer, height: integer, advance_x: number): integer READ-ONLY
---@field AddCustomRectFontGlyph fun(font: ImFontPtr, id: integer, width: integer, height: integer, advance_x: number, offset: Vector2): integer READ-ONLY
---@field AddCustomRectRegular fun(width: integer, height: integer): integer READ-ONLY
---@field AddFont fun(font_cfg: ImFontConfigPtr): ImFontPtr READ-ONLY
---@field AddFontDefault fun(): ImFontPtr READ-ONLY
---@field AddFontDefault fun(font_cfg: ImFontConfigPtr): ImFontPtr READ-ONLY
---@field AddFontFromFileTTF fun(filename: string, size_pixels: number): ImFontPtr READ-ONLY
---@field AddFontFromFileTTF fun(filename: string, size_pixels: number, font_cfg: ImFontConfigPtr): ImFontPtr READ-ONLY
---@field AddFontFromFileTTF fun(filename: string, size_pixels: number, font_cfg: ImFontConfigPtr, glyph_ranges: lightuserdata): ImFontPtr READ-ONLY
---@field AddFontFromMemoryCompressedBase85TTF fun(compressed_font_data_base85: string, size_pixels: number): ImFontPtr READ-ONLY
---@field AddFontFromMemoryCompressedBase85TTF fun(compressed_font_data_base85: string, size_pixels: number, font_cfg: ImFontConfigPtr): ImFontPtr READ-ONLY
---@field AddFontFromMemoryCompressedBase85TTF fun(compressed_font_data_base85: string, size_pixels: number, font_cfg: ImFontConfigPtr, glyph_ranges: lightuserdata): ImFontPtr READ-ONLY
---@field AddFontFromMemoryCompressedTTF fun(compressed_font_data: lightuserdata, compressed_font_data_size: integer, size_pixels: number): ImFontPtr READ-ONLY
---@field AddFontFromMemoryCompressedTTF fun(compressed_font_data: lightuserdata, compressed_font_data_size: integer, size_pixels: number, font_cfg: ImFontConfigPtr): ImFontPtr READ-ONLY
---@field AddFontFromMemoryCompressedTTF fun(compressed_font_data: lightuserdata, compressed_font_data_size: integer, size_pixels: number, font_cfg: ImFontConfigPtr, glyph_ranges: lightuserdata): ImFontPtr READ-ONLY
---@field AddFontFromMemoryTTF fun(font_data: lightuserdata, font_data_size: integer, size_pixels: number): ImFontPtr READ-ONLY
---@field AddFontFromMemoryTTF fun(font_data: lightuserdata, font_data_size: integer, size_pixels: number, font_cfg: ImFontConfigPtr): ImFontPtr READ-ONLY
---@field AddFontFromMemoryTTF fun(font_data: lightuserdata, font_data_size: integer, size_pixels: number, font_cfg: ImFontConfigPtr, glyph_ranges: lightuserdata): ImFontPtr READ-ONLY
---@field Build fun(): boolean READ-ONLY
---@field CalcCustomRectUV fun(rect: ImFontAtlasCustomRectPtr, out_uv_min: Vector2, out_uv_max: Vector2): nil READ-ONLY
---@field Clear fun(): nil READ-ONLY
---@field ClearFonts fun(): nil READ-ONLY
---@field ClearInputData fun(): nil READ-ONLY
---@field ClearTexData fun(): nil READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field GetCustomRectByIndex fun(index: integer): ImFontAtlasCustomRectPtr READ-ONLY
---@field GetGlyphRangesChineseFull fun(): lightuserdata READ-ONLY
---@field GetGlyphRangesChineseSimplifiedCommon fun(): lightuserdata READ-ONLY
---@field GetGlyphRangesCyrillic fun(): lightuserdata READ-ONLY
---@field GetGlyphRangesDefault fun(): lightuserdata READ-ONLY
---@field GetGlyphRangesGreek fun(): lightuserdata READ-ONLY
---@field GetGlyphRangesJapanese fun(): lightuserdata READ-ONLY
---@field GetGlyphRangesKorean fun(): lightuserdata READ-ONLY
---@field GetGlyphRangesThai fun(): lightuserdata READ-ONLY
---@field GetGlyphRangesVietnamese fun(): lightuserdata READ-ONLY
---@field GetMouseCursorTexData fun(cursor: ImGuiMouseCursor|0|1|2|3|4|5|6|7|8|9|-1|"Arrow"|"TextInput"|"ResizeAll"|"ResizeNS"|"ResizeEW"|"ResizeNESW"|"ResizeNWSE"|"Hand"|"NotAllowed"|"COUNT"|"None", out_offset: Vector2, out_size: Vector2, out_uv_border: Vector2, out_uv_fill: Vector2): boolean READ-ONLY
---@field GetTexDataAsAlpha8 fun(out_pixels: lightuserdata, out_width: integer, out_height: integer): nil READ-ONLY
---@field GetTexDataAsAlpha8 fun(out_pixels: lightuserdata, out_width: integer, out_height: integer, out_bytes_per_pixel: integer): nil READ-ONLY
---@field GetTexDataAsRGBA32 fun(out_pixels: lightuserdata, out_width: integer, out_height: integer): nil READ-ONLY
---@field GetTexDataAsRGBA32 fun(out_pixels: lightuserdata, out_width: integer, out_height: integer, out_bytes_per_pixel: integer): nil READ-ONLY
---@field IsBuilt fun(): boolean READ-ONLY
---@field SetTexID fun(id: lightuserdata): nil READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field Flags ImFontAtlasFlags|integer|"None"|"NoPowerOfTwoHeight"|"NoMouseCursors"|"NoBakedLines"
---@field TexID lightuserdata
---@field TexDesiredWidth integer
---@field TexGlyphPadding integer
---@field Locked boolean
---@field UserData lightuserdata
---@field TexReady boolean
---@field TexPixelsUseColors boolean
---@field TexPixelsAlpha8 lightuserdata
---@field TexPixelsRGBA32 lightuserdata
---@field TexWidth integer
---@field TexHeight integer
---@field TexUvScale Vector2
---@field TexUvWhitePixel Vector2
---@field Fonts ImVector<ImFontPtr>
---@field CustomRects ImPtrVector<ImFontAtlasCustomRectPtr>
---@field ConfigData ImPtrVector<ImFontConfigPtr>
---@field TexUvLines RangeAccessor<Vector4>
---@field FontBuilderIO lightuserdata
---@field FontBuilderFlags integer
---@field PackIdMouseCursors integer
---@field PackIdLines integer

---@class ImFontConfig
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field FontDataSize integer
---@field FontDataOwnedByAtlas integer
---@field FontNo integer
---@field SizePixels number
---@field OversampleH integer
---@field OversampleV integer
---@field PixelSnapH integer
---@field GlyphExtraSpacing Vector2
---@field GlyphOffset Vector2
---@field GlyphMinAdvanceX number
---@field GlyphMaxAdvanceX number
---@field MergeMode integer
---@field FontBuilderFlags integer
---@field RasterizerMultiply number
---@field RasterizerDensity number
---@field EllipsisChar integer

---@class ImFontConfigPtr
---@field get_FontData fun(): lightuserdata READ-ONLY
---@field set_FontData fun(value: lightuserdata): nil READ-ONLY
---@field get_FontDataSize fun(): integer READ-ONLY
---@field get_FontDataOwnedByAtlas fun(): boolean READ-ONLY
---@field get_FontNo fun(): integer READ-ONLY
---@field get_SizePixels fun(): number READ-ONLY
---@field get_OversampleH fun(): integer READ-ONLY
---@field get_OversampleV fun(): integer READ-ONLY
---@field get_PixelSnapH fun(): boolean READ-ONLY
---@field get_GlyphExtraSpacing fun(): Vector2 READ-ONLY
---@field get_GlyphOffset fun(): Vector2 READ-ONLY
---@field get_GlyphRanges fun(): lightuserdata READ-ONLY
---@field set_GlyphRanges fun(value: lightuserdata): nil READ-ONLY
---@field get_GlyphMinAdvanceX fun(): number READ-ONLY
---@field get_GlyphMaxAdvanceX fun(): number READ-ONLY
---@field get_MergeMode fun(): boolean READ-ONLY
---@field get_FontBuilderFlags fun(): integer READ-ONLY
---@field get_RasterizerMultiply fun(): number READ-ONLY
---@field get_RasterizerDensity fun(): number READ-ONLY
---@field get_EllipsisChar fun(): integer READ-ONLY
---@field get_Name fun(): RangeAccessor<integer> READ-ONLY
---@field get_DstFont fun(): ImFontPtr READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field FontData lightuserdata
---@field FontDataSize integer
---@field FontDataOwnedByAtlas boolean
---@field FontNo integer
---@field SizePixels number
---@field OversampleH integer
---@field OversampleV integer
---@field PixelSnapH boolean
---@field GlyphExtraSpacing Vector2
---@field GlyphOffset Vector2
---@field GlyphRanges lightuserdata
---@field GlyphMinAdvanceX number
---@field GlyphMaxAdvanceX number
---@field MergeMode boolean
---@field FontBuilderFlags integer
---@field RasterizerMultiply number
---@field RasterizerDensity number
---@field EllipsisChar integer
---@field Name RangeAccessor<integer>
---@field DstFont ImFontPtr

---@class ImFontGlyph
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field Colored integer
---@field Visible integer
---@field Codepoint integer
---@field AdvanceX number
---@field X0 number
---@field Y0 number
---@field X1 number
---@field Y1 number
---@field U0 number
---@field V0 number
---@field U1 number
---@field V1 number

---@class ImFontGlyphPtr
---@field get_Colored fun(): integer READ-ONLY
---@field get_Visible fun(): integer READ-ONLY
---@field get_Codepoint fun(): integer READ-ONLY
---@field get_AdvanceX fun(): number READ-ONLY
---@field get_X0 fun(): number READ-ONLY
---@field get_Y0 fun(): number READ-ONLY
---@field get_X1 fun(): number READ-ONLY
---@field get_Y1 fun(): number READ-ONLY
---@field get_U0 fun(): number READ-ONLY
---@field get_V0 fun(): number READ-ONLY
---@field get_U1 fun(): number READ-ONLY
---@field get_V1 fun(): number READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field Colored integer
---@field Visible integer
---@field Codepoint integer
---@field AdvanceX number
---@field X0 number
---@field Y0 number
---@field X1 number
---@field Y1 number
---@field U0 number
---@field V0 number
---@field U1 number
---@field V1 number

---@class ImFontGlyphRangesBuilder
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field UsedChars ImVector

---@class ImFontGlyphRangesBuilderPtr
---@field get_UsedChars fun(): ImVector<integer> READ-ONLY
---@field AddChar fun(c: integer): nil READ-ONLY
---@field AddRanges fun(ranges: lightuserdata): nil READ-ONLY
---@field AddText fun(text: string): nil READ-ONLY
---@field BuildRanges fun(out_ranges: ImVector): nil READ-ONLY
---@field Clear fun(): nil READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field GetBit fun(n: integer): boolean READ-ONLY
---@field SetBit fun(n: integer): nil READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field UsedChars ImVector<integer>

---@class ImFontPtr
---@field get_IndexAdvanceX fun(): ImVector<number> READ-ONLY
---@field get_FallbackAdvanceX fun(): number READ-ONLY
---@field get_FontSize fun(): number READ-ONLY
---@field get_IndexLookup fun(): ImVector<integer> READ-ONLY
---@field get_Glyphs fun(): ImPtrVector<ImFontGlyphPtr> READ-ONLY
---@field get_FallbackGlyph fun(): ImFontGlyphPtr READ-ONLY
---@field get_ContainerAtlas fun(): ImFontAtlasPtr READ-ONLY
---@field get_ConfigData fun(): ImFontConfigPtr READ-ONLY
---@field get_ConfigDataCount fun(): integer READ-ONLY
---@field get_FallbackChar fun(): integer READ-ONLY
---@field get_EllipsisChar fun(): integer READ-ONLY
---@field get_EllipsisCharCount fun(): integer READ-ONLY
---@field get_EllipsisWidth fun(): number READ-ONLY
---@field get_EllipsisCharStep fun(): number READ-ONLY
---@field get_DirtyLookupTables fun(): boolean READ-ONLY
---@field get_Scale fun(): number READ-ONLY
---@field get_Ascent fun(): number READ-ONLY
---@field get_Descent fun(): number READ-ONLY
---@field get_MetricsTotalSurface fun(): integer READ-ONLY
---@field get_Used4kPagesMap fun(): RangeAccessor<integer> READ-ONLY
---@field AddGlyph fun(src_cfg: ImFontConfigPtr, c: integer, x0: number, y0: number, x1: number, y1: number, u0: number, v0: number, u1: number, v1: number, advance_x: number): nil READ-ONLY
---@field AddRemapChar fun(dst: integer, src: integer): nil READ-ONLY
---@field AddRemapChar fun(dst: integer, src: integer, overwrite_dst: boolean): nil READ-ONLY
---@field BuildLookupTable fun(): nil READ-ONLY
---@field CalcTextSizeA fun(size: number, max_width: number, wrap_width: number, text_begin: string): Vector2 READ-ONLY
---@field CalcWordWrapPositionA fun(scale: number, text: string, wrap_width: number): string READ-ONLY
---@field ClearOutputData fun(): nil READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field FindGlyph fun(c: integer): ImFontGlyphPtr READ-ONLY
---@field FindGlyphNoFallback fun(c: integer): ImFontGlyphPtr READ-ONLY
---@field GetCharAdvance fun(c: integer): number READ-ONLY
---@field GetDebugName fun(): string READ-ONLY
---@field GrowIndex fun(new_size: integer): nil READ-ONLY
---@field IsLoaded fun(): boolean READ-ONLY
---@field RenderChar fun(draw_list: ImDrawListPtr, size: number, pos: Vector2, col: integer, c: integer): nil READ-ONLY
---@field RenderText fun(draw_list: ImDrawListPtr, size: number, pos: Vector2, col: integer, clip_rect: Vector4, text_begin: string): nil READ-ONLY
---@field RenderText fun(draw_list: ImDrawListPtr, size: number, pos: Vector2, col: integer, clip_rect: Vector4, text_begin: string, wrap_width: number): nil READ-ONLY
---@field RenderText fun(draw_list: ImDrawListPtr, size: number, pos: Vector2, col: integer, clip_rect: Vector4, text_begin: string, wrap_width: number, cpu_fine_clip: boolean): nil READ-ONLY
---@field SetGlyphVisible fun(c: integer, visible: boolean): nil READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field IndexAdvanceX ImVector<number>
---@field FallbackAdvanceX number
---@field FontSize number
---@field IndexLookup ImVector<integer>
---@field Glyphs ImPtrVector<ImFontGlyphPtr>
---@field FallbackGlyph ImFontGlyphPtr
---@field ContainerAtlas ImFontAtlasPtr
---@field ConfigData ImFontConfigPtr
---@field ConfigDataCount integer
---@field FallbackChar integer
---@field EllipsisChar integer
---@field EllipsisCharCount integer
---@field EllipsisWidth number
---@field EllipsisCharStep number
---@field DirtyLookupTables boolean
---@field Scale number
---@field Ascent number
---@field Descent number
---@field MetricsTotalSurface integer
---@field Used4kPagesMap RangeAccessor<integer>

---@class ImGuiInputTextCallbackData
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field Ctx lightuserdata
---@field EventFlag ImGuiInputTextFlags|integer|"None"|"CharsDecimal"|"CharsHexadecimal"|"CharsScientific"|"CharsUppercase"|"CharsNoBlank"|"AllowTabInput"|"EnterReturnsTrue"|"EscapeClearsAll"|"CtrlEnterForNewLine"|"ReadOnly"|"Password"|"AlwaysOverwrite"|"AutoSelectAll"|"ParseEmptyRefVal"|"DisplayEmptyRefVal"|"NoHorizontalScroll"|"NoUndoRedo"|"CallbackCompletion"|"CallbackHistory"|"CallbackAlways"|"CallbackCharFilter"|"CallbackResize"|"CallbackEdit"
---@field Flags ImGuiInputTextFlags|integer|"None"|"CharsDecimal"|"CharsHexadecimal"|"CharsScientific"|"CharsUppercase"|"CharsNoBlank"|"AllowTabInput"|"EnterReturnsTrue"|"EscapeClearsAll"|"CtrlEnterForNewLine"|"ReadOnly"|"Password"|"AlwaysOverwrite"|"AutoSelectAll"|"ParseEmptyRefVal"|"DisplayEmptyRefVal"|"NoHorizontalScroll"|"NoUndoRedo"|"CallbackCompletion"|"CallbackHistory"|"CallbackAlways"|"CallbackCharFilter"|"CallbackResize"|"CallbackEdit"
---@field EventChar integer
---@field EventKey ImGuiKey|0|154|512|513|514|515|516|517|518|519|520|521|522|523|524|525|526|527|528|529|530|531|532|533|534|535|536|537|538|539|540|541|542|543|544|545|546|547|548|549|550|551|552|553|554|555|556|557|558|559|560|561|562|563|564|565|566|567|568|569|570|571|572|573|574|575|576|577|578|579|580|581|582|583|584|585|586|587|588|589|590|591|592|593|594|595|596|597|598|599|600|601|602|603|604|605|606|607|608|609|610|611|612|613|614|615|616|617|618|619|620|621|622|623|624|625|626|627|628|629|630|631|632|633|634|635|636|637|638|639|640|641|642|643|644|645|646|647|648|649|650|651|652|653|654|655|656|657|658|659|660|661|662|663|664|665|666|4096|8192|16384|32768|61440|"None"|"ModNone"|"NamedKey_COUNT"|"KeysData_SIZE"|"NamedKey_BEGIN"|"KeysData_OFFSET"|"Tab"|"LeftArrow"|"RightArrow"|"UpArrow"|"DownArrow"|"PageUp"|"PageDown"|"Home"|"End"|"Insert"|"Delete"|"Backspace"|"Space"|"Enter"|"Escape"|"LeftCtrl"|"LeftShift"|"LeftAlt"|"LeftSuper"|"RightCtrl"|"RightShift"|"RightAlt"|"RightSuper"|"Menu"|"_0"|"_1"|"_2"|"_3"|"_4"|"_5"|"_6"|"_7"|"_8"|"_9"|"A"|"B"|"C"|"D"|"E"|"F"|"G"|"H"|"I"|"J"|"K"|"L"|"M"|"N"|"O"|"P"|"Q"|"R"|"S"|"T"|"U"|"V"|"W"|"X"|"Y"|"Z"|"F1"|"F2"|"F3"|"F4"|"F5"|"F6"|"F7"|"F8"|"F9"|"F10"|"F11"|"F12"|"F13"|"F14"|"F15"|"F16"|"F17"|"F18"|"F19"|"F20"|"F21"|"F22"|"F23"|"F24"|"Apostrophe"|"Comma"|"Minus"|"Period"|"Slash"|"Semicolon"|"Equal"|"LeftBracket"|"Backslash"|"RightBracket"|"GraveAccent"|"CapsLock"|"ScrollLock"|"NumLock"|"PrintScreen"|"Pause"|"Keypad0"|"Keypad1"|"Keypad2"|"Keypad3"|"Keypad4"|"Keypad5"|"Keypad6"|"Keypad7"|"Keypad8"|"Keypad9"|"KeypadDecimal"|"KeypadDivide"|"KeypadMultiply"|"KeypadSubtract"|"KeypadAdd"|"KeypadEnter"|"KeypadEqual"|"AppBack"|"AppForward"|"GamepadStart"|"GamepadBack"|"GamepadFaceLeft"|"GamepadFaceRight"|"GamepadFaceUp"|"GamepadFaceDown"|"GamepadDpadLeft"|"GamepadDpadRight"|"GamepadDpadUp"|"GamepadDpadDown"|"GamepadL1"|"GamepadR1"|"GamepadL2"|"GamepadR2"|"GamepadL3"|"GamepadR3"|"GamepadLStickLeft"|"GamepadLStickRight"|"GamepadLStickUp"|"GamepadLStickDown"|"GamepadRStickLeft"|"GamepadRStickRight"|"GamepadRStickUp"|"GamepadRStickDown"|"MouseLeft"|"MouseRight"|"MouseMiddle"|"MouseX1"|"MouseX2"|"MouseWheelX"|"MouseWheelY"|"ReservedForModCtrl"|"ReservedForModShift"|"ReservedForModAlt"|"ReservedForModSuper"|"COUNT"|"NamedKey_END"|"ModCtrl"|"ModShift"|"ModAlt"|"ModSuper"|"ModMask"
---@field BufTextLen integer
---@field BufSize integer
---@field BufDirty integer
---@field CursorPos integer
---@field SelectionStart integer
---@field SelectionEnd integer

---@class ImGuiInputTextCallbackDataPtr
---@field get_Ctx fun(): lightuserdata READ-ONLY
---@field get_EventFlag fun(): ImGuiInputTextFlags|integer|"None"|"CharsDecimal"|"CharsHexadecimal"|"CharsScientific"|"CharsUppercase"|"CharsNoBlank"|"AllowTabInput"|"EnterReturnsTrue"|"EscapeClearsAll"|"CtrlEnterForNewLine"|"ReadOnly"|"Password"|"AlwaysOverwrite"|"AutoSelectAll"|"ParseEmptyRefVal"|"DisplayEmptyRefVal"|"NoHorizontalScroll"|"NoUndoRedo"|"CallbackCompletion"|"CallbackHistory"|"CallbackAlways"|"CallbackCharFilter"|"CallbackResize"|"CallbackEdit" READ-ONLY
---@field get_Flags fun(): ImGuiInputTextFlags|integer|"None"|"CharsDecimal"|"CharsHexadecimal"|"CharsScientific"|"CharsUppercase"|"CharsNoBlank"|"AllowTabInput"|"EnterReturnsTrue"|"EscapeClearsAll"|"CtrlEnterForNewLine"|"ReadOnly"|"Password"|"AlwaysOverwrite"|"AutoSelectAll"|"ParseEmptyRefVal"|"DisplayEmptyRefVal"|"NoHorizontalScroll"|"NoUndoRedo"|"CallbackCompletion"|"CallbackHistory"|"CallbackAlways"|"CallbackCharFilter"|"CallbackResize"|"CallbackEdit" READ-ONLY
---@field get_UserData fun(): lightuserdata READ-ONLY
---@field set_UserData fun(value: lightuserdata): nil READ-ONLY
---@field get_EventChar fun(): integer READ-ONLY
---@field get_EventKey fun(): ImGuiKey|0|154|512|513|514|515|516|517|518|519|520|521|522|523|524|525|526|527|528|529|530|531|532|533|534|535|536|537|538|539|540|541|542|543|544|545|546|547|548|549|550|551|552|553|554|555|556|557|558|559|560|561|562|563|564|565|566|567|568|569|570|571|572|573|574|575|576|577|578|579|580|581|582|583|584|585|586|587|588|589|590|591|592|593|594|595|596|597|598|599|600|601|602|603|604|605|606|607|608|609|610|611|612|613|614|615|616|617|618|619|620|621|622|623|624|625|626|627|628|629|630|631|632|633|634|635|636|637|638|639|640|641|642|643|644|645|646|647|648|649|650|651|652|653|654|655|656|657|658|659|660|661|662|663|664|665|666|4096|8192|16384|32768|61440|"None"|"ModNone"|"NamedKey_COUNT"|"KeysData_SIZE"|"NamedKey_BEGIN"|"KeysData_OFFSET"|"Tab"|"LeftArrow"|"RightArrow"|"UpArrow"|"DownArrow"|"PageUp"|"PageDown"|"Home"|"End"|"Insert"|"Delete"|"Backspace"|"Space"|"Enter"|"Escape"|"LeftCtrl"|"LeftShift"|"LeftAlt"|"LeftSuper"|"RightCtrl"|"RightShift"|"RightAlt"|"RightSuper"|"Menu"|"_0"|"_1"|"_2"|"_3"|"_4"|"_5"|"_6"|"_7"|"_8"|"_9"|"A"|"B"|"C"|"D"|"E"|"F"|"G"|"H"|"I"|"J"|"K"|"L"|"M"|"N"|"O"|"P"|"Q"|"R"|"S"|"T"|"U"|"V"|"W"|"X"|"Y"|"Z"|"F1"|"F2"|"F3"|"F4"|"F5"|"F6"|"F7"|"F8"|"F9"|"F10"|"F11"|"F12"|"F13"|"F14"|"F15"|"F16"|"F17"|"F18"|"F19"|"F20"|"F21"|"F22"|"F23"|"F24"|"Apostrophe"|"Comma"|"Minus"|"Period"|"Slash"|"Semicolon"|"Equal"|"LeftBracket"|"Backslash"|"RightBracket"|"GraveAccent"|"CapsLock"|"ScrollLock"|"NumLock"|"PrintScreen"|"Pause"|"Keypad0"|"Keypad1"|"Keypad2"|"Keypad3"|"Keypad4"|"Keypad5"|"Keypad6"|"Keypad7"|"Keypad8"|"Keypad9"|"KeypadDecimal"|"KeypadDivide"|"KeypadMultiply"|"KeypadSubtract"|"KeypadAdd"|"KeypadEnter"|"KeypadEqual"|"AppBack"|"AppForward"|"GamepadStart"|"GamepadBack"|"GamepadFaceLeft"|"GamepadFaceRight"|"GamepadFaceUp"|"GamepadFaceDown"|"GamepadDpadLeft"|"GamepadDpadRight"|"GamepadDpadUp"|"GamepadDpadDown"|"GamepadL1"|"GamepadR1"|"GamepadL2"|"GamepadR2"|"GamepadL3"|"GamepadR3"|"GamepadLStickLeft"|"GamepadLStickRight"|"GamepadLStickUp"|"GamepadLStickDown"|"GamepadRStickLeft"|"GamepadRStickRight"|"GamepadRStickUp"|"GamepadRStickDown"|"MouseLeft"|"MouseRight"|"MouseMiddle"|"MouseX1"|"MouseX2"|"MouseWheelX"|"MouseWheelY"|"ReservedForModCtrl"|"ReservedForModShift"|"ReservedForModAlt"|"ReservedForModSuper"|"COUNT"|"NamedKey_END"|"ModCtrl"|"ModShift"|"ModAlt"|"ModSuper"|"ModMask" READ-ONLY
---@field get_Buf fun(): lightuserdata READ-ONLY
---@field set_Buf fun(value: lightuserdata): nil READ-ONLY
---@field get_BufTextLen fun(): integer READ-ONLY
---@field get_BufSize fun(): integer READ-ONLY
---@field get_BufDirty fun(): boolean READ-ONLY
---@field get_CursorPos fun(): integer READ-ONLY
---@field get_SelectionStart fun(): integer READ-ONLY
---@field get_SelectionEnd fun(): integer READ-ONLY
---@field ClearSelection fun(): nil READ-ONLY
---@field DeleteChars fun(pos: integer, bytes_count: integer): nil READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field HasSelection fun(): boolean READ-ONLY
---@field InsertChars fun(pos: integer, text: string): nil READ-ONLY
---@field SelectAll fun(): nil READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field Ctx lightuserdata
---@field EventFlag ImGuiInputTextFlags|integer|"None"|"CharsDecimal"|"CharsHexadecimal"|"CharsScientific"|"CharsUppercase"|"CharsNoBlank"|"AllowTabInput"|"EnterReturnsTrue"|"EscapeClearsAll"|"CtrlEnterForNewLine"|"ReadOnly"|"Password"|"AlwaysOverwrite"|"AutoSelectAll"|"ParseEmptyRefVal"|"DisplayEmptyRefVal"|"NoHorizontalScroll"|"NoUndoRedo"|"CallbackCompletion"|"CallbackHistory"|"CallbackAlways"|"CallbackCharFilter"|"CallbackResize"|"CallbackEdit"
---@field Flags ImGuiInputTextFlags|integer|"None"|"CharsDecimal"|"CharsHexadecimal"|"CharsScientific"|"CharsUppercase"|"CharsNoBlank"|"AllowTabInput"|"EnterReturnsTrue"|"EscapeClearsAll"|"CtrlEnterForNewLine"|"ReadOnly"|"Password"|"AlwaysOverwrite"|"AutoSelectAll"|"ParseEmptyRefVal"|"DisplayEmptyRefVal"|"NoHorizontalScroll"|"NoUndoRedo"|"CallbackCompletion"|"CallbackHistory"|"CallbackAlways"|"CallbackCharFilter"|"CallbackResize"|"CallbackEdit"
---@field UserData lightuserdata
---@field EventChar integer
---@field EventKey ImGuiKey|0|154|512|513|514|515|516|517|518|519|520|521|522|523|524|525|526|527|528|529|530|531|532|533|534|535|536|537|538|539|540|541|542|543|544|545|546|547|548|549|550|551|552|553|554|555|556|557|558|559|560|561|562|563|564|565|566|567|568|569|570|571|572|573|574|575|576|577|578|579|580|581|582|583|584|585|586|587|588|589|590|591|592|593|594|595|596|597|598|599|600|601|602|603|604|605|606|607|608|609|610|611|612|613|614|615|616|617|618|619|620|621|622|623|624|625|626|627|628|629|630|631|632|633|634|635|636|637|638|639|640|641|642|643|644|645|646|647|648|649|650|651|652|653|654|655|656|657|658|659|660|661|662|663|664|665|666|4096|8192|16384|32768|61440|"None"|"ModNone"|"NamedKey_COUNT"|"KeysData_SIZE"|"NamedKey_BEGIN"|"KeysData_OFFSET"|"Tab"|"LeftArrow"|"RightArrow"|"UpArrow"|"DownArrow"|"PageUp"|"PageDown"|"Home"|"End"|"Insert"|"Delete"|"Backspace"|"Space"|"Enter"|"Escape"|"LeftCtrl"|"LeftShift"|"LeftAlt"|"LeftSuper"|"RightCtrl"|"RightShift"|"RightAlt"|"RightSuper"|"Menu"|"_0"|"_1"|"_2"|"_3"|"_4"|"_5"|"_6"|"_7"|"_8"|"_9"|"A"|"B"|"C"|"D"|"E"|"F"|"G"|"H"|"I"|"J"|"K"|"L"|"M"|"N"|"O"|"P"|"Q"|"R"|"S"|"T"|"U"|"V"|"W"|"X"|"Y"|"Z"|"F1"|"F2"|"F3"|"F4"|"F5"|"F6"|"F7"|"F8"|"F9"|"F10"|"F11"|"F12"|"F13"|"F14"|"F15"|"F16"|"F17"|"F18"|"F19"|"F20"|"F21"|"F22"|"F23"|"F24"|"Apostrophe"|"Comma"|"Minus"|"Period"|"Slash"|"Semicolon"|"Equal"|"LeftBracket"|"Backslash"|"RightBracket"|"GraveAccent"|"CapsLock"|"ScrollLock"|"NumLock"|"PrintScreen"|"Pause"|"Keypad0"|"Keypad1"|"Keypad2"|"Keypad3"|"Keypad4"|"Keypad5"|"Keypad6"|"Keypad7"|"Keypad8"|"Keypad9"|"KeypadDecimal"|"KeypadDivide"|"KeypadMultiply"|"KeypadSubtract"|"KeypadAdd"|"KeypadEnter"|"KeypadEqual"|"AppBack"|"AppForward"|"GamepadStart"|"GamepadBack"|"GamepadFaceLeft"|"GamepadFaceRight"|"GamepadFaceUp"|"GamepadFaceDown"|"GamepadDpadLeft"|"GamepadDpadRight"|"GamepadDpadUp"|"GamepadDpadDown"|"GamepadL1"|"GamepadR1"|"GamepadL2"|"GamepadR2"|"GamepadL3"|"GamepadR3"|"GamepadLStickLeft"|"GamepadLStickRight"|"GamepadLStickUp"|"GamepadLStickDown"|"GamepadRStickLeft"|"GamepadRStickRight"|"GamepadRStickUp"|"GamepadRStickDown"|"MouseLeft"|"MouseRight"|"MouseMiddle"|"MouseX1"|"MouseX2"|"MouseWheelX"|"MouseWheelY"|"ReservedForModCtrl"|"ReservedForModShift"|"ReservedForModAlt"|"ReservedForModSuper"|"COUNT"|"NamedKey_END"|"ModCtrl"|"ModShift"|"ModAlt"|"ModSuper"|"ModMask"
---@field Buf lightuserdata
---@field BufTextLen integer
---@field BufSize integer
---@field BufDirty boolean
---@field CursorPos integer
---@field SelectionStart integer
---@field SelectionEnd integer

---@class ImGuiIO
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field ConfigFlags ImGuiConfigFlags|integer|"None"|"NavEnableKeyboard"|"NavEnableGamepad"|"NavEnableSetMousePos"|"NavNoCaptureKeyboard"|"NoMouse"|"NoMouseCursorChange"|"NoKeyboard"|"DockingEnable"|"ViewportsEnable"|"DpiEnableScaleViewports"|"DpiEnableScaleFonts"|"IsSRGB"|"IsTouchScreen"
---@field BackendFlags ImGuiBackendFlags|integer|"None"|"HasGamepad"|"HasMouseCursors"|"HasSetMousePos"|"RendererHasVtxOffset"|"PlatformHasViewports"|"HasMouseHoveredViewport"|"RendererHasViewports"
---@field DisplaySize Vector2
---@field DeltaTime number
---@field IniSavingRate number
---@field FontGlobalScale number
---@field FontAllowUserScaling integer
---@field DisplayFramebufferScale Vector2
---@field ConfigDockingNoSplit integer
---@field ConfigDockingWithShift integer
---@field ConfigDockingAlwaysTabBar integer
---@field ConfigDockingTransparentPayload integer
---@field ConfigViewportsNoAutoMerge integer
---@field ConfigViewportsNoTaskBarIcon integer
---@field ConfigViewportsNoDecoration integer
---@field ConfigViewportsNoDefaultParent integer
---@field MouseDrawCursor integer
---@field ConfigMacOSXBehaviors integer
---@field ConfigNavSwapGamepadButtons integer
---@field ConfigInputTrickleEventQueue integer
---@field ConfigInputTextCursorBlink integer
---@field ConfigInputTextEnterKeepActive integer
---@field ConfigDragClickToInputText integer
---@field ConfigWindowsResizeFromEdges integer
---@field ConfigWindowsMoveFromTitleBarOnly integer
---@field ConfigMemoryCompactTimer number
---@field MouseDoubleClickTime number
---@field MouseDoubleClickMaxDist number
---@field MouseDragThreshold number
---@field KeyRepeatDelay number
---@field KeyRepeatRate number
---@field ConfigDebugIsDebuggerPresent integer
---@field ConfigDebugBeginReturnValueOnce integer
---@field ConfigDebugBeginReturnValueLoop integer
---@field ConfigDebugIgnoreFocusLoss integer
---@field ConfigDebugIniSettings integer
---@field GetClipboardTextFn lightuserdata
---@field SetClipboardTextFn lightuserdata
---@field PlatformOpenInShellFn lightuserdata
---@field PlatformSetImeDataFn lightuserdata
---@field PlatformLocaleDecimalPoint integer
---@field WantCaptureMouse integer
---@field WantCaptureKeyboard integer
---@field WantTextInput integer
---@field WantSetMousePos integer
---@field WantSaveIniSettings integer
---@field NavActive integer
---@field NavVisible integer
---@field Framerate number
---@field MetricsRenderVertices integer
---@field MetricsRenderIndices integer
---@field MetricsRenderWindows integer
---@field MetricsActiveWindows integer
---@field MouseDelta Vector2
---@field Ctx lightuserdata
---@field MousePos Vector2
---@field MouseWheel number
---@field MouseWheelH number
---@field MouseSource ImGuiMouseSource|0|1|2|3|"Mouse"|"TouchScreen"|"Pen"|"COUNT"
---@field MouseHoveredViewport integer
---@field KeyCtrl integer
---@field KeyShift integer
---@field KeyAlt integer
---@field KeySuper integer
---@field KeyMods ImGuiKey|0|154|512|513|514|515|516|517|518|519|520|521|522|523|524|525|526|527|528|529|530|531|532|533|534|535|536|537|538|539|540|541|542|543|544|545|546|547|548|549|550|551|552|553|554|555|556|557|558|559|560|561|562|563|564|565|566|567|568|569|570|571|572|573|574|575|576|577|578|579|580|581|582|583|584|585|586|587|588|589|590|591|592|593|594|595|596|597|598|599|600|601|602|603|604|605|606|607|608|609|610|611|612|613|614|615|616|617|618|619|620|621|622|623|624|625|626|627|628|629|630|631|632|633|634|635|636|637|638|639|640|641|642|643|644|645|646|647|648|649|650|651|652|653|654|655|656|657|658|659|660|661|662|663|664|665|666|4096|8192|16384|32768|61440|"None"|"ModNone"|"NamedKey_COUNT"|"KeysData_SIZE"|"NamedKey_BEGIN"|"KeysData_OFFSET"|"Tab"|"LeftArrow"|"RightArrow"|"UpArrow"|"DownArrow"|"PageUp"|"PageDown"|"Home"|"End"|"Insert"|"Delete"|"Backspace"|"Space"|"Enter"|"Escape"|"LeftCtrl"|"LeftShift"|"LeftAlt"|"LeftSuper"|"RightCtrl"|"RightShift"|"RightAlt"|"RightSuper"|"Menu"|"_0"|"_1"|"_2"|"_3"|"_4"|"_5"|"_6"|"_7"|"_8"|"_9"|"A"|"B"|"C"|"D"|"E"|"F"|"G"|"H"|"I"|"J"|"K"|"L"|"M"|"N"|"O"|"P"|"Q"|"R"|"S"|"T"|"U"|"V"|"W"|"X"|"Y"|"Z"|"F1"|"F2"|"F3"|"F4"|"F5"|"F6"|"F7"|"F8"|"F9"|"F10"|"F11"|"F12"|"F13"|"F14"|"F15"|"F16"|"F17"|"F18"|"F19"|"F20"|"F21"|"F22"|"F23"|"F24"|"Apostrophe"|"Comma"|"Minus"|"Period"|"Slash"|"Semicolon"|"Equal"|"LeftBracket"|"Backslash"|"RightBracket"|"GraveAccent"|"CapsLock"|"ScrollLock"|"NumLock"|"PrintScreen"|"Pause"|"Keypad0"|"Keypad1"|"Keypad2"|"Keypad3"|"Keypad4"|"Keypad5"|"Keypad6"|"Keypad7"|"Keypad8"|"Keypad9"|"KeypadDecimal"|"KeypadDivide"|"KeypadMultiply"|"KeypadSubtract"|"KeypadAdd"|"KeypadEnter"|"KeypadEqual"|"AppBack"|"AppForward"|"GamepadStart"|"GamepadBack"|"GamepadFaceLeft"|"GamepadFaceRight"|"GamepadFaceUp"|"GamepadFaceDown"|"GamepadDpadLeft"|"GamepadDpadRight"|"GamepadDpadUp"|"GamepadDpadDown"|"GamepadL1"|"GamepadR1"|"GamepadL2"|"GamepadR2"|"GamepadL3"|"GamepadR3"|"GamepadLStickLeft"|"GamepadLStickRight"|"GamepadLStickUp"|"GamepadLStickDown"|"GamepadRStickLeft"|"GamepadRStickRight"|"GamepadRStickUp"|"GamepadRStickDown"|"MouseLeft"|"MouseRight"|"MouseMiddle"|"MouseX1"|"MouseX2"|"MouseWheelX"|"MouseWheelY"|"ReservedForModCtrl"|"ReservedForModShift"|"ReservedForModAlt"|"ReservedForModSuper"|"COUNT"|"NamedKey_END"|"ModCtrl"|"ModShift"|"ModAlt"|"ModSuper"|"ModMask"
---@field KeysData_0 ImGuiKeyData
---@field KeysData_1 ImGuiKeyData
---@field KeysData_2 ImGuiKeyData
---@field KeysData_3 ImGuiKeyData
---@field KeysData_4 ImGuiKeyData
---@field KeysData_5 ImGuiKeyData
---@field KeysData_6 ImGuiKeyData
---@field KeysData_7 ImGuiKeyData
---@field KeysData_8 ImGuiKeyData
---@field KeysData_9 ImGuiKeyData
---@field KeysData_10 ImGuiKeyData
---@field KeysData_11 ImGuiKeyData
---@field KeysData_12 ImGuiKeyData
---@field KeysData_13 ImGuiKeyData
---@field KeysData_14 ImGuiKeyData
---@field KeysData_15 ImGuiKeyData
---@field KeysData_16 ImGuiKeyData
---@field KeysData_17 ImGuiKeyData
---@field KeysData_18 ImGuiKeyData
---@field KeysData_19 ImGuiKeyData
---@field KeysData_20 ImGuiKeyData
---@field KeysData_21 ImGuiKeyData
---@field KeysData_22 ImGuiKeyData
---@field KeysData_23 ImGuiKeyData
---@field KeysData_24 ImGuiKeyData
---@field KeysData_25 ImGuiKeyData
---@field KeysData_26 ImGuiKeyData
---@field KeysData_27 ImGuiKeyData
---@field KeysData_28 ImGuiKeyData
---@field KeysData_29 ImGuiKeyData
---@field KeysData_30 ImGuiKeyData
---@field KeysData_31 ImGuiKeyData
---@field KeysData_32 ImGuiKeyData
---@field KeysData_33 ImGuiKeyData
---@field KeysData_34 ImGuiKeyData
---@field KeysData_35 ImGuiKeyData
---@field KeysData_36 ImGuiKeyData
---@field KeysData_37 ImGuiKeyData
---@field KeysData_38 ImGuiKeyData
---@field KeysData_39 ImGuiKeyData
---@field KeysData_40 ImGuiKeyData
---@field KeysData_41 ImGuiKeyData
---@field KeysData_42 ImGuiKeyData
---@field KeysData_43 ImGuiKeyData
---@field KeysData_44 ImGuiKeyData
---@field KeysData_45 ImGuiKeyData
---@field KeysData_46 ImGuiKeyData
---@field KeysData_47 ImGuiKeyData
---@field KeysData_48 ImGuiKeyData
---@field KeysData_49 ImGuiKeyData
---@field KeysData_50 ImGuiKeyData
---@field KeysData_51 ImGuiKeyData
---@field KeysData_52 ImGuiKeyData
---@field KeysData_53 ImGuiKeyData
---@field KeysData_54 ImGuiKeyData
---@field KeysData_55 ImGuiKeyData
---@field KeysData_56 ImGuiKeyData
---@field KeysData_57 ImGuiKeyData
---@field KeysData_58 ImGuiKeyData
---@field KeysData_59 ImGuiKeyData
---@field KeysData_60 ImGuiKeyData
---@field KeysData_61 ImGuiKeyData
---@field KeysData_62 ImGuiKeyData
---@field KeysData_63 ImGuiKeyData
---@field KeysData_64 ImGuiKeyData
---@field KeysData_65 ImGuiKeyData
---@field KeysData_66 ImGuiKeyData
---@field KeysData_67 ImGuiKeyData
---@field KeysData_68 ImGuiKeyData
---@field KeysData_69 ImGuiKeyData
---@field KeysData_70 ImGuiKeyData
---@field KeysData_71 ImGuiKeyData
---@field KeysData_72 ImGuiKeyData
---@field KeysData_73 ImGuiKeyData
---@field KeysData_74 ImGuiKeyData
---@field KeysData_75 ImGuiKeyData
---@field KeysData_76 ImGuiKeyData
---@field KeysData_77 ImGuiKeyData
---@field KeysData_78 ImGuiKeyData
---@field KeysData_79 ImGuiKeyData
---@field KeysData_80 ImGuiKeyData
---@field KeysData_81 ImGuiKeyData
---@field KeysData_82 ImGuiKeyData
---@field KeysData_83 ImGuiKeyData
---@field KeysData_84 ImGuiKeyData
---@field KeysData_85 ImGuiKeyData
---@field KeysData_86 ImGuiKeyData
---@field KeysData_87 ImGuiKeyData
---@field KeysData_88 ImGuiKeyData
---@field KeysData_89 ImGuiKeyData
---@field KeysData_90 ImGuiKeyData
---@field KeysData_91 ImGuiKeyData
---@field KeysData_92 ImGuiKeyData
---@field KeysData_93 ImGuiKeyData
---@field KeysData_94 ImGuiKeyData
---@field KeysData_95 ImGuiKeyData
---@field KeysData_96 ImGuiKeyData
---@field KeysData_97 ImGuiKeyData
---@field KeysData_98 ImGuiKeyData
---@field KeysData_99 ImGuiKeyData
---@field KeysData_100 ImGuiKeyData
---@field KeysData_101 ImGuiKeyData
---@field KeysData_102 ImGuiKeyData
---@field KeysData_103 ImGuiKeyData
---@field KeysData_104 ImGuiKeyData
---@field KeysData_105 ImGuiKeyData
---@field KeysData_106 ImGuiKeyData
---@field KeysData_107 ImGuiKeyData
---@field KeysData_108 ImGuiKeyData
---@field KeysData_109 ImGuiKeyData
---@field KeysData_110 ImGuiKeyData
---@field KeysData_111 ImGuiKeyData
---@field KeysData_112 ImGuiKeyData
---@field KeysData_113 ImGuiKeyData
---@field KeysData_114 ImGuiKeyData
---@field KeysData_115 ImGuiKeyData
---@field KeysData_116 ImGuiKeyData
---@field KeysData_117 ImGuiKeyData
---@field KeysData_118 ImGuiKeyData
---@field KeysData_119 ImGuiKeyData
---@field KeysData_120 ImGuiKeyData
---@field KeysData_121 ImGuiKeyData
---@field KeysData_122 ImGuiKeyData
---@field KeysData_123 ImGuiKeyData
---@field KeysData_124 ImGuiKeyData
---@field KeysData_125 ImGuiKeyData
---@field KeysData_126 ImGuiKeyData
---@field KeysData_127 ImGuiKeyData
---@field KeysData_128 ImGuiKeyData
---@field KeysData_129 ImGuiKeyData
---@field KeysData_130 ImGuiKeyData
---@field KeysData_131 ImGuiKeyData
---@field KeysData_132 ImGuiKeyData
---@field KeysData_133 ImGuiKeyData
---@field KeysData_134 ImGuiKeyData
---@field KeysData_135 ImGuiKeyData
---@field KeysData_136 ImGuiKeyData
---@field KeysData_137 ImGuiKeyData
---@field KeysData_138 ImGuiKeyData
---@field KeysData_139 ImGuiKeyData
---@field KeysData_140 ImGuiKeyData
---@field KeysData_141 ImGuiKeyData
---@field KeysData_142 ImGuiKeyData
---@field KeysData_143 ImGuiKeyData
---@field KeysData_144 ImGuiKeyData
---@field KeysData_145 ImGuiKeyData
---@field KeysData_146 ImGuiKeyData
---@field KeysData_147 ImGuiKeyData
---@field KeysData_148 ImGuiKeyData
---@field KeysData_149 ImGuiKeyData
---@field KeysData_150 ImGuiKeyData
---@field KeysData_151 ImGuiKeyData
---@field KeysData_152 ImGuiKeyData
---@field KeysData_153 ImGuiKeyData
---@field WantCaptureMouseUnlessPopupClose integer
---@field MousePosPrev Vector2
---@field MouseClickedPos_0 Vector2
---@field MouseClickedPos_1 Vector2
---@field MouseClickedPos_2 Vector2
---@field MouseClickedPos_3 Vector2
---@field MouseClickedPos_4 Vector2
---@field MouseWheelRequestAxisSwap integer
---@field MouseCtrlLeftAsRightClick integer
---@field MouseDragMaxDistanceAbs_0 Vector2
---@field MouseDragMaxDistanceAbs_1 Vector2
---@field MouseDragMaxDistanceAbs_2 Vector2
---@field MouseDragMaxDistanceAbs_3 Vector2
---@field MouseDragMaxDistanceAbs_4 Vector2
---@field PenPressure number
---@field AppFocusLost integer
---@field AppAcceptingEvents integer
---@field BackendUsingLegacyKeyArrays integer
---@field BackendUsingLegacyNavInputArray integer
---@field InputQueueSurrogate integer
---@field InputQueueCharacters ImVector

---@class ImGuiIOPtr
---@field get_ConfigFlags fun(): ImGuiConfigFlags|integer|"None"|"NavEnableKeyboard"|"NavEnableGamepad"|"NavEnableSetMousePos"|"NavNoCaptureKeyboard"|"NoMouse"|"NoMouseCursorChange"|"NoKeyboard"|"DockingEnable"|"ViewportsEnable"|"DpiEnableScaleViewports"|"DpiEnableScaleFonts"|"IsSRGB"|"IsTouchScreen" READ-ONLY
---@field get_BackendFlags fun(): ImGuiBackendFlags|integer|"None"|"HasGamepad"|"HasMouseCursors"|"HasSetMousePos"|"RendererHasVtxOffset"|"PlatformHasViewports"|"HasMouseHoveredViewport"|"RendererHasViewports" READ-ONLY
---@field get_DisplaySize fun(): Vector2 READ-ONLY
---@field get_DeltaTime fun(): number READ-ONLY
---@field get_IniSavingRate fun(): number READ-ONLY
---@field get_IniFilename fun(): NullTerminatedString READ-ONLY
---@field get_LogFilename fun(): NullTerminatedString READ-ONLY
---@field get_UserData fun(): lightuserdata READ-ONLY
---@field set_UserData fun(value: lightuserdata): nil READ-ONLY
---@field get_Fonts fun(): ImFontAtlasPtr READ-ONLY
---@field get_FontGlobalScale fun(): number READ-ONLY
---@field get_FontAllowUserScaling fun(): boolean READ-ONLY
---@field get_FontDefault fun(): ImFontPtr READ-ONLY
---@field get_DisplayFramebufferScale fun(): Vector2 READ-ONLY
---@field get_ConfigDockingNoSplit fun(): boolean READ-ONLY
---@field get_ConfigDockingWithShift fun(): boolean READ-ONLY
---@field get_ConfigDockingAlwaysTabBar fun(): boolean READ-ONLY
---@field get_ConfigDockingTransparentPayload fun(): boolean READ-ONLY
---@field get_ConfigViewportsNoAutoMerge fun(): boolean READ-ONLY
---@field get_ConfigViewportsNoTaskBarIcon fun(): boolean READ-ONLY
---@field get_ConfigViewportsNoDecoration fun(): boolean READ-ONLY
---@field get_ConfigViewportsNoDefaultParent fun(): boolean READ-ONLY
---@field get_MouseDrawCursor fun(): boolean READ-ONLY
---@field get_ConfigMacOSXBehaviors fun(): boolean READ-ONLY
---@field get_ConfigNavSwapGamepadButtons fun(): boolean READ-ONLY
---@field get_ConfigInputTrickleEventQueue fun(): boolean READ-ONLY
---@field get_ConfigInputTextCursorBlink fun(): boolean READ-ONLY
---@field get_ConfigInputTextEnterKeepActive fun(): boolean READ-ONLY
---@field get_ConfigDragClickToInputText fun(): boolean READ-ONLY
---@field get_ConfigWindowsResizeFromEdges fun(): boolean READ-ONLY
---@field get_ConfigWindowsMoveFromTitleBarOnly fun(): boolean READ-ONLY
---@field get_ConfigMemoryCompactTimer fun(): number READ-ONLY
---@field get_MouseDoubleClickTime fun(): number READ-ONLY
---@field get_MouseDoubleClickMaxDist fun(): number READ-ONLY
---@field get_MouseDragThreshold fun(): number READ-ONLY
---@field get_KeyRepeatDelay fun(): number READ-ONLY
---@field get_KeyRepeatRate fun(): number READ-ONLY
---@field get_ConfigDebugIsDebuggerPresent fun(): boolean READ-ONLY
---@field get_ConfigDebugBeginReturnValueOnce fun(): boolean READ-ONLY
---@field get_ConfigDebugBeginReturnValueLoop fun(): boolean READ-ONLY
---@field get_ConfigDebugIgnoreFocusLoss fun(): boolean READ-ONLY
---@field get_ConfigDebugIniSettings fun(): boolean READ-ONLY
---@field get_BackendPlatformName fun(): NullTerminatedString READ-ONLY
---@field get_BackendRendererName fun(): NullTerminatedString READ-ONLY
---@field get_BackendPlatformUserData fun(): lightuserdata READ-ONLY
---@field set_BackendPlatformUserData fun(value: lightuserdata): nil READ-ONLY
---@field get_BackendRendererUserData fun(): lightuserdata READ-ONLY
---@field set_BackendRendererUserData fun(value: lightuserdata): nil READ-ONLY
---@field get_BackendLanguageUserData fun(): lightuserdata READ-ONLY
---@field set_BackendLanguageUserData fun(value: lightuserdata): nil READ-ONLY
---@field get_GetClipboardTextFn fun(): lightuserdata READ-ONLY
---@field get_SetClipboardTextFn fun(): lightuserdata READ-ONLY
---@field get_ClipboardUserData fun(): lightuserdata READ-ONLY
---@field set_ClipboardUserData fun(value: lightuserdata): nil READ-ONLY
---@field get_PlatformOpenInShellFn fun(): lightuserdata READ-ONLY
---@field get_PlatformOpenInShellUserData fun(): lightuserdata READ-ONLY
---@field set_PlatformOpenInShellUserData fun(value: lightuserdata): nil READ-ONLY
---@field get_PlatformSetImeDataFn fun(): lightuserdata READ-ONLY
---@field get_PlatformLocaleDecimalPoint fun(): integer READ-ONLY
---@field get_WantCaptureMouse fun(): boolean READ-ONLY
---@field get_WantCaptureKeyboard fun(): boolean READ-ONLY
---@field get_WantTextInput fun(): boolean READ-ONLY
---@field get_WantSetMousePos fun(): boolean READ-ONLY
---@field get_WantSaveIniSettings fun(): boolean READ-ONLY
---@field get_NavActive fun(): boolean READ-ONLY
---@field get_NavVisible fun(): boolean READ-ONLY
---@field get_Framerate fun(): number READ-ONLY
---@field get_MetricsRenderVertices fun(): integer READ-ONLY
---@field get_MetricsRenderIndices fun(): integer READ-ONLY
---@field get_MetricsRenderWindows fun(): integer READ-ONLY
---@field get_MetricsActiveWindows fun(): integer READ-ONLY
---@field get_MouseDelta fun(): Vector2 READ-ONLY
---@field get_Ctx fun(): lightuserdata READ-ONLY
---@field get_MousePos fun(): Vector2 READ-ONLY
---@field get_MouseDown fun(): RangeAccessor<boolean> READ-ONLY
---@field get_MouseWheel fun(): number READ-ONLY
---@field get_MouseWheelH fun(): number READ-ONLY
---@field get_MouseSource fun(): ImGuiMouseSource|0|1|2|3|"Mouse"|"TouchScreen"|"Pen"|"COUNT" READ-ONLY
---@field get_MouseHoveredViewport fun(): integer READ-ONLY
---@field get_KeyCtrl fun(): boolean READ-ONLY
---@field get_KeyShift fun(): boolean READ-ONLY
---@field get_KeyAlt fun(): boolean READ-ONLY
---@field get_KeySuper fun(): boolean READ-ONLY
---@field get_KeyMods fun(): ImGuiKey|0|154|512|513|514|515|516|517|518|519|520|521|522|523|524|525|526|527|528|529|530|531|532|533|534|535|536|537|538|539|540|541|542|543|544|545|546|547|548|549|550|551|552|553|554|555|556|557|558|559|560|561|562|563|564|565|566|567|568|569|570|571|572|573|574|575|576|577|578|579|580|581|582|583|584|585|586|587|588|589|590|591|592|593|594|595|596|597|598|599|600|601|602|603|604|605|606|607|608|609|610|611|612|613|614|615|616|617|618|619|620|621|622|623|624|625|626|627|628|629|630|631|632|633|634|635|636|637|638|639|640|641|642|643|644|645|646|647|648|649|650|651|652|653|654|655|656|657|658|659|660|661|662|663|664|665|666|4096|8192|16384|32768|61440|"None"|"ModNone"|"NamedKey_COUNT"|"KeysData_SIZE"|"NamedKey_BEGIN"|"KeysData_OFFSET"|"Tab"|"LeftArrow"|"RightArrow"|"UpArrow"|"DownArrow"|"PageUp"|"PageDown"|"Home"|"End"|"Insert"|"Delete"|"Backspace"|"Space"|"Enter"|"Escape"|"LeftCtrl"|"LeftShift"|"LeftAlt"|"LeftSuper"|"RightCtrl"|"RightShift"|"RightAlt"|"RightSuper"|"Menu"|"_0"|"_1"|"_2"|"_3"|"_4"|"_5"|"_6"|"_7"|"_8"|"_9"|"A"|"B"|"C"|"D"|"E"|"F"|"G"|"H"|"I"|"J"|"K"|"L"|"M"|"N"|"O"|"P"|"Q"|"R"|"S"|"T"|"U"|"V"|"W"|"X"|"Y"|"Z"|"F1"|"F2"|"F3"|"F4"|"F5"|"F6"|"F7"|"F8"|"F9"|"F10"|"F11"|"F12"|"F13"|"F14"|"F15"|"F16"|"F17"|"F18"|"F19"|"F20"|"F21"|"F22"|"F23"|"F24"|"Apostrophe"|"Comma"|"Minus"|"Period"|"Slash"|"Semicolon"|"Equal"|"LeftBracket"|"Backslash"|"RightBracket"|"GraveAccent"|"CapsLock"|"ScrollLock"|"NumLock"|"PrintScreen"|"Pause"|"Keypad0"|"Keypad1"|"Keypad2"|"Keypad3"|"Keypad4"|"Keypad5"|"Keypad6"|"Keypad7"|"Keypad8"|"Keypad9"|"KeypadDecimal"|"KeypadDivide"|"KeypadMultiply"|"KeypadSubtract"|"KeypadAdd"|"KeypadEnter"|"KeypadEqual"|"AppBack"|"AppForward"|"GamepadStart"|"GamepadBack"|"GamepadFaceLeft"|"GamepadFaceRight"|"GamepadFaceUp"|"GamepadFaceDown"|"GamepadDpadLeft"|"GamepadDpadRight"|"GamepadDpadUp"|"GamepadDpadDown"|"GamepadL1"|"GamepadR1"|"GamepadL2"|"GamepadR2"|"GamepadL3"|"GamepadR3"|"GamepadLStickLeft"|"GamepadLStickRight"|"GamepadLStickUp"|"GamepadLStickDown"|"GamepadRStickLeft"|"GamepadRStickRight"|"GamepadRStickUp"|"GamepadRStickDown"|"MouseLeft"|"MouseRight"|"MouseMiddle"|"MouseX1"|"MouseX2"|"MouseWheelX"|"MouseWheelY"|"ReservedForModCtrl"|"ReservedForModShift"|"ReservedForModAlt"|"ReservedForModSuper"|"COUNT"|"NamedKey_END"|"ModCtrl"|"ModShift"|"ModAlt"|"ModSuper"|"ModMask" READ-ONLY
---@field get_KeysData fun(): RangeAccessor<ImGuiKeyData> READ-ONLY
---@field get_WantCaptureMouseUnlessPopupClose fun(): boolean READ-ONLY
---@field get_MousePosPrev fun(): Vector2 READ-ONLY
---@field get_MouseClickedPos fun(): RangeAccessor<Vector2> READ-ONLY
---@field get_MouseClickedTime fun(): RangeAccessor<number> READ-ONLY
---@field get_MouseClicked fun(): RangeAccessor<boolean> READ-ONLY
---@field get_MouseDoubleClicked fun(): RangeAccessor<boolean> READ-ONLY
---@field get_MouseClickedCount fun(): RangeAccessor<integer> READ-ONLY
---@field get_MouseClickedLastCount fun(): RangeAccessor<integer> READ-ONLY
---@field get_MouseReleased fun(): RangeAccessor<boolean> READ-ONLY
---@field get_MouseDownOwned fun(): RangeAccessor<boolean> READ-ONLY
---@field get_MouseDownOwnedUnlessPopupClose fun(): RangeAccessor<boolean> READ-ONLY
---@field get_MouseWheelRequestAxisSwap fun(): boolean READ-ONLY
---@field get_MouseCtrlLeftAsRightClick fun(): boolean READ-ONLY
---@field get_MouseDownDuration fun(): RangeAccessor<number> READ-ONLY
---@field get_MouseDownDurationPrev fun(): RangeAccessor<number> READ-ONLY
---@field get_MouseDragMaxDistanceAbs fun(): RangeAccessor<Vector2> READ-ONLY
---@field get_MouseDragMaxDistanceSqr fun(): RangeAccessor<number> READ-ONLY
---@field get_PenPressure fun(): number READ-ONLY
---@field get_AppFocusLost fun(): boolean READ-ONLY
---@field get_AppAcceptingEvents fun(): boolean READ-ONLY
---@field get_BackendUsingLegacyKeyArrays fun(): integer READ-ONLY
---@field get_BackendUsingLegacyNavInputArray fun(): boolean READ-ONLY
---@field get_InputQueueSurrogate fun(): integer READ-ONLY
---@field get_InputQueueCharacters fun(): ImVector<integer> READ-ONLY
---@field AddFocusEvent fun(focused: boolean): nil READ-ONLY
---@field AddInputCharacter fun(c: integer): nil READ-ONLY
---@field AddInputCharactersUTF8 fun(str: string): nil READ-ONLY
---@field AddInputCharacterUTF16 fun(c: integer): nil READ-ONLY
---@field AddKeyAnalogEvent fun(key: ImGuiKey|0|154|512|513|514|515|516|517|518|519|520|521|522|523|524|525|526|527|528|529|530|531|532|533|534|535|536|537|538|539|540|541|542|543|544|545|546|547|548|549|550|551|552|553|554|555|556|557|558|559|560|561|562|563|564|565|566|567|568|569|570|571|572|573|574|575|576|577|578|579|580|581|582|583|584|585|586|587|588|589|590|591|592|593|594|595|596|597|598|599|600|601|602|603|604|605|606|607|608|609|610|611|612|613|614|615|616|617|618|619|620|621|622|623|624|625|626|627|628|629|630|631|632|633|634|635|636|637|638|639|640|641|642|643|644|645|646|647|648|649|650|651|652|653|654|655|656|657|658|659|660|661|662|663|664|665|666|4096|8192|16384|32768|61440|"None"|"ModNone"|"NamedKey_COUNT"|"KeysData_SIZE"|"NamedKey_BEGIN"|"KeysData_OFFSET"|"Tab"|"LeftArrow"|"RightArrow"|"UpArrow"|"DownArrow"|"PageUp"|"PageDown"|"Home"|"End"|"Insert"|"Delete"|"Backspace"|"Space"|"Enter"|"Escape"|"LeftCtrl"|"LeftShift"|"LeftAlt"|"LeftSuper"|"RightCtrl"|"RightShift"|"RightAlt"|"RightSuper"|"Menu"|"_0"|"_1"|"_2"|"_3"|"_4"|"_5"|"_6"|"_7"|"_8"|"_9"|"A"|"B"|"C"|"D"|"E"|"F"|"G"|"H"|"I"|"J"|"K"|"L"|"M"|"N"|"O"|"P"|"Q"|"R"|"S"|"T"|"U"|"V"|"W"|"X"|"Y"|"Z"|"F1"|"F2"|"F3"|"F4"|"F5"|"F6"|"F7"|"F8"|"F9"|"F10"|"F11"|"F12"|"F13"|"F14"|"F15"|"F16"|"F17"|"F18"|"F19"|"F20"|"F21"|"F22"|"F23"|"F24"|"Apostrophe"|"Comma"|"Minus"|"Period"|"Slash"|"Semicolon"|"Equal"|"LeftBracket"|"Backslash"|"RightBracket"|"GraveAccent"|"CapsLock"|"ScrollLock"|"NumLock"|"PrintScreen"|"Pause"|"Keypad0"|"Keypad1"|"Keypad2"|"Keypad3"|"Keypad4"|"Keypad5"|"Keypad6"|"Keypad7"|"Keypad8"|"Keypad9"|"KeypadDecimal"|"KeypadDivide"|"KeypadMultiply"|"KeypadSubtract"|"KeypadAdd"|"KeypadEnter"|"KeypadEqual"|"AppBack"|"AppForward"|"GamepadStart"|"GamepadBack"|"GamepadFaceLeft"|"GamepadFaceRight"|"GamepadFaceUp"|"GamepadFaceDown"|"GamepadDpadLeft"|"GamepadDpadRight"|"GamepadDpadUp"|"GamepadDpadDown"|"GamepadL1"|"GamepadR1"|"GamepadL2"|"GamepadR2"|"GamepadL3"|"GamepadR3"|"GamepadLStickLeft"|"GamepadLStickRight"|"GamepadLStickUp"|"GamepadLStickDown"|"GamepadRStickLeft"|"GamepadRStickRight"|"GamepadRStickUp"|"GamepadRStickDown"|"MouseLeft"|"MouseRight"|"MouseMiddle"|"MouseX1"|"MouseX2"|"MouseWheelX"|"MouseWheelY"|"ReservedForModCtrl"|"ReservedForModShift"|"ReservedForModAlt"|"ReservedForModSuper"|"COUNT"|"NamedKey_END"|"ModCtrl"|"ModShift"|"ModAlt"|"ModSuper"|"ModMask", down: boolean, v: number): nil READ-ONLY
---@field AddKeyEvent fun(key: ImGuiKey|0|154|512|513|514|515|516|517|518|519|520|521|522|523|524|525|526|527|528|529|530|531|532|533|534|535|536|537|538|539|540|541|542|543|544|545|546|547|548|549|550|551|552|553|554|555|556|557|558|559|560|561|562|563|564|565|566|567|568|569|570|571|572|573|574|575|576|577|578|579|580|581|582|583|584|585|586|587|588|589|590|591|592|593|594|595|596|597|598|599|600|601|602|603|604|605|606|607|608|609|610|611|612|613|614|615|616|617|618|619|620|621|622|623|624|625|626|627|628|629|630|631|632|633|634|635|636|637|638|639|640|641|642|643|644|645|646|647|648|649|650|651|652|653|654|655|656|657|658|659|660|661|662|663|664|665|666|4096|8192|16384|32768|61440|"None"|"ModNone"|"NamedKey_COUNT"|"KeysData_SIZE"|"NamedKey_BEGIN"|"KeysData_OFFSET"|"Tab"|"LeftArrow"|"RightArrow"|"UpArrow"|"DownArrow"|"PageUp"|"PageDown"|"Home"|"End"|"Insert"|"Delete"|"Backspace"|"Space"|"Enter"|"Escape"|"LeftCtrl"|"LeftShift"|"LeftAlt"|"LeftSuper"|"RightCtrl"|"RightShift"|"RightAlt"|"RightSuper"|"Menu"|"_0"|"_1"|"_2"|"_3"|"_4"|"_5"|"_6"|"_7"|"_8"|"_9"|"A"|"B"|"C"|"D"|"E"|"F"|"G"|"H"|"I"|"J"|"K"|"L"|"M"|"N"|"O"|"P"|"Q"|"R"|"S"|"T"|"U"|"V"|"W"|"X"|"Y"|"Z"|"F1"|"F2"|"F3"|"F4"|"F5"|"F6"|"F7"|"F8"|"F9"|"F10"|"F11"|"F12"|"F13"|"F14"|"F15"|"F16"|"F17"|"F18"|"F19"|"F20"|"F21"|"F22"|"F23"|"F24"|"Apostrophe"|"Comma"|"Minus"|"Period"|"Slash"|"Semicolon"|"Equal"|"LeftBracket"|"Backslash"|"RightBracket"|"GraveAccent"|"CapsLock"|"ScrollLock"|"NumLock"|"PrintScreen"|"Pause"|"Keypad0"|"Keypad1"|"Keypad2"|"Keypad3"|"Keypad4"|"Keypad5"|"Keypad6"|"Keypad7"|"Keypad8"|"Keypad9"|"KeypadDecimal"|"KeypadDivide"|"KeypadMultiply"|"KeypadSubtract"|"KeypadAdd"|"KeypadEnter"|"KeypadEqual"|"AppBack"|"AppForward"|"GamepadStart"|"GamepadBack"|"GamepadFaceLeft"|"GamepadFaceRight"|"GamepadFaceUp"|"GamepadFaceDown"|"GamepadDpadLeft"|"GamepadDpadRight"|"GamepadDpadUp"|"GamepadDpadDown"|"GamepadL1"|"GamepadR1"|"GamepadL2"|"GamepadR2"|"GamepadL3"|"GamepadR3"|"GamepadLStickLeft"|"GamepadLStickRight"|"GamepadLStickUp"|"GamepadLStickDown"|"GamepadRStickLeft"|"GamepadRStickRight"|"GamepadRStickUp"|"GamepadRStickDown"|"MouseLeft"|"MouseRight"|"MouseMiddle"|"MouseX1"|"MouseX2"|"MouseWheelX"|"MouseWheelY"|"ReservedForModCtrl"|"ReservedForModShift"|"ReservedForModAlt"|"ReservedForModSuper"|"COUNT"|"NamedKey_END"|"ModCtrl"|"ModShift"|"ModAlt"|"ModSuper"|"ModMask", down: boolean): nil READ-ONLY
---@field AddMouseButtonEvent fun(button: integer, down: boolean): nil READ-ONLY
---@field AddMousePosEvent fun(x: number, y: number): nil READ-ONLY
---@field AddMouseSourceEvent fun(source: ImGuiMouseSource|0|1|2|3|"Mouse"|"TouchScreen"|"Pen"|"COUNT"): nil READ-ONLY
---@field AddMouseViewportEvent fun(id: integer): nil READ-ONLY
---@field AddMouseWheelEvent fun(wheel_x: number, wheel_y: number): nil READ-ONLY
---@field ClearEventsQueue fun(): nil READ-ONLY
---@field ClearInputKeys fun(): nil READ-ONLY
---@field ClearInputMouse fun(): nil READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field SetAppAcceptingEvents fun(accepting_events: boolean): nil READ-ONLY
---@field SetKeyEventNativeData fun(key: ImGuiKey|0|154|512|513|514|515|516|517|518|519|520|521|522|523|524|525|526|527|528|529|530|531|532|533|534|535|536|537|538|539|540|541|542|543|544|545|546|547|548|549|550|551|552|553|554|555|556|557|558|559|560|561|562|563|564|565|566|567|568|569|570|571|572|573|574|575|576|577|578|579|580|581|582|583|584|585|586|587|588|589|590|591|592|593|594|595|596|597|598|599|600|601|602|603|604|605|606|607|608|609|610|611|612|613|614|615|616|617|618|619|620|621|622|623|624|625|626|627|628|629|630|631|632|633|634|635|636|637|638|639|640|641|642|643|644|645|646|647|648|649|650|651|652|653|654|655|656|657|658|659|660|661|662|663|664|665|666|4096|8192|16384|32768|61440|"None"|"ModNone"|"NamedKey_COUNT"|"KeysData_SIZE"|"NamedKey_BEGIN"|"KeysData_OFFSET"|"Tab"|"LeftArrow"|"RightArrow"|"UpArrow"|"DownArrow"|"PageUp"|"PageDown"|"Home"|"End"|"Insert"|"Delete"|"Backspace"|"Space"|"Enter"|"Escape"|"LeftCtrl"|"LeftShift"|"LeftAlt"|"LeftSuper"|"RightCtrl"|"RightShift"|"RightAlt"|"RightSuper"|"Menu"|"_0"|"_1"|"_2"|"_3"|"_4"|"_5"|"_6"|"_7"|"_8"|"_9"|"A"|"B"|"C"|"D"|"E"|"F"|"G"|"H"|"I"|"J"|"K"|"L"|"M"|"N"|"O"|"P"|"Q"|"R"|"S"|"T"|"U"|"V"|"W"|"X"|"Y"|"Z"|"F1"|"F2"|"F3"|"F4"|"F5"|"F6"|"F7"|"F8"|"F9"|"F10"|"F11"|"F12"|"F13"|"F14"|"F15"|"F16"|"F17"|"F18"|"F19"|"F20"|"F21"|"F22"|"F23"|"F24"|"Apostrophe"|"Comma"|"Minus"|"Period"|"Slash"|"Semicolon"|"Equal"|"LeftBracket"|"Backslash"|"RightBracket"|"GraveAccent"|"CapsLock"|"ScrollLock"|"NumLock"|"PrintScreen"|"Pause"|"Keypad0"|"Keypad1"|"Keypad2"|"Keypad3"|"Keypad4"|"Keypad5"|"Keypad6"|"Keypad7"|"Keypad8"|"Keypad9"|"KeypadDecimal"|"KeypadDivide"|"KeypadMultiply"|"KeypadSubtract"|"KeypadAdd"|"KeypadEnter"|"KeypadEqual"|"AppBack"|"AppForward"|"GamepadStart"|"GamepadBack"|"GamepadFaceLeft"|"GamepadFaceRight"|"GamepadFaceUp"|"GamepadFaceDown"|"GamepadDpadLeft"|"GamepadDpadRight"|"GamepadDpadUp"|"GamepadDpadDown"|"GamepadL1"|"GamepadR1"|"GamepadL2"|"GamepadR2"|"GamepadL3"|"GamepadR3"|"GamepadLStickLeft"|"GamepadLStickRight"|"GamepadLStickUp"|"GamepadLStickDown"|"GamepadRStickLeft"|"GamepadRStickRight"|"GamepadRStickUp"|"GamepadRStickDown"|"MouseLeft"|"MouseRight"|"MouseMiddle"|"MouseX1"|"MouseX2"|"MouseWheelX"|"MouseWheelY"|"ReservedForModCtrl"|"ReservedForModShift"|"ReservedForModAlt"|"ReservedForModSuper"|"COUNT"|"NamedKey_END"|"ModCtrl"|"ModShift"|"ModAlt"|"ModSuper"|"ModMask", native_keycode: integer, native_scancode: integer): nil READ-ONLY
---@field SetKeyEventNativeData fun(key: ImGuiKey|0|154|512|513|514|515|516|517|518|519|520|521|522|523|524|525|526|527|528|529|530|531|532|533|534|535|536|537|538|539|540|541|542|543|544|545|546|547|548|549|550|551|552|553|554|555|556|557|558|559|560|561|562|563|564|565|566|567|568|569|570|571|572|573|574|575|576|577|578|579|580|581|582|583|584|585|586|587|588|589|590|591|592|593|594|595|596|597|598|599|600|601|602|603|604|605|606|607|608|609|610|611|612|613|614|615|616|617|618|619|620|621|622|623|624|625|626|627|628|629|630|631|632|633|634|635|636|637|638|639|640|641|642|643|644|645|646|647|648|649|650|651|652|653|654|655|656|657|658|659|660|661|662|663|664|665|666|4096|8192|16384|32768|61440|"None"|"ModNone"|"NamedKey_COUNT"|"KeysData_SIZE"|"NamedKey_BEGIN"|"KeysData_OFFSET"|"Tab"|"LeftArrow"|"RightArrow"|"UpArrow"|"DownArrow"|"PageUp"|"PageDown"|"Home"|"End"|"Insert"|"Delete"|"Backspace"|"Space"|"Enter"|"Escape"|"LeftCtrl"|"LeftShift"|"LeftAlt"|"LeftSuper"|"RightCtrl"|"RightShift"|"RightAlt"|"RightSuper"|"Menu"|"_0"|"_1"|"_2"|"_3"|"_4"|"_5"|"_6"|"_7"|"_8"|"_9"|"A"|"B"|"C"|"D"|"E"|"F"|"G"|"H"|"I"|"J"|"K"|"L"|"M"|"N"|"O"|"P"|"Q"|"R"|"S"|"T"|"U"|"V"|"W"|"X"|"Y"|"Z"|"F1"|"F2"|"F3"|"F4"|"F5"|"F6"|"F7"|"F8"|"F9"|"F10"|"F11"|"F12"|"F13"|"F14"|"F15"|"F16"|"F17"|"F18"|"F19"|"F20"|"F21"|"F22"|"F23"|"F24"|"Apostrophe"|"Comma"|"Minus"|"Period"|"Slash"|"Semicolon"|"Equal"|"LeftBracket"|"Backslash"|"RightBracket"|"GraveAccent"|"CapsLock"|"ScrollLock"|"NumLock"|"PrintScreen"|"Pause"|"Keypad0"|"Keypad1"|"Keypad2"|"Keypad3"|"Keypad4"|"Keypad5"|"Keypad6"|"Keypad7"|"Keypad8"|"Keypad9"|"KeypadDecimal"|"KeypadDivide"|"KeypadMultiply"|"KeypadSubtract"|"KeypadAdd"|"KeypadEnter"|"KeypadEqual"|"AppBack"|"AppForward"|"GamepadStart"|"GamepadBack"|"GamepadFaceLeft"|"GamepadFaceRight"|"GamepadFaceUp"|"GamepadFaceDown"|"GamepadDpadLeft"|"GamepadDpadRight"|"GamepadDpadUp"|"GamepadDpadDown"|"GamepadL1"|"GamepadR1"|"GamepadL2"|"GamepadR2"|"GamepadL3"|"GamepadR3"|"GamepadLStickLeft"|"GamepadLStickRight"|"GamepadLStickUp"|"GamepadLStickDown"|"GamepadRStickLeft"|"GamepadRStickRight"|"GamepadRStickUp"|"GamepadRStickDown"|"MouseLeft"|"MouseRight"|"MouseMiddle"|"MouseX1"|"MouseX2"|"MouseWheelX"|"MouseWheelY"|"ReservedForModCtrl"|"ReservedForModShift"|"ReservedForModAlt"|"ReservedForModSuper"|"COUNT"|"NamedKey_END"|"ModCtrl"|"ModShift"|"ModAlt"|"ModSuper"|"ModMask", native_keycode: integer, native_scancode: integer, native_legacy_index: integer): nil READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field ConfigFlags ImGuiConfigFlags|integer|"None"|"NavEnableKeyboard"|"NavEnableGamepad"|"NavEnableSetMousePos"|"NavNoCaptureKeyboard"|"NoMouse"|"NoMouseCursorChange"|"NoKeyboard"|"DockingEnable"|"ViewportsEnable"|"DpiEnableScaleViewports"|"DpiEnableScaleFonts"|"IsSRGB"|"IsTouchScreen"
---@field BackendFlags ImGuiBackendFlags|integer|"None"|"HasGamepad"|"HasMouseCursors"|"HasSetMousePos"|"RendererHasVtxOffset"|"PlatformHasViewports"|"HasMouseHoveredViewport"|"RendererHasViewports"
---@field DisplaySize Vector2
---@field DeltaTime number
---@field IniSavingRate number
---@field IniFilename NullTerminatedString
---@field LogFilename NullTerminatedString
---@field UserData lightuserdata
---@field Fonts ImFontAtlasPtr
---@field FontGlobalScale number
---@field FontAllowUserScaling boolean
---@field FontDefault ImFontPtr
---@field DisplayFramebufferScale Vector2
---@field ConfigDockingNoSplit boolean
---@field ConfigDockingWithShift boolean
---@field ConfigDockingAlwaysTabBar boolean
---@field ConfigDockingTransparentPayload boolean
---@field ConfigViewportsNoAutoMerge boolean
---@field ConfigViewportsNoTaskBarIcon boolean
---@field ConfigViewportsNoDecoration boolean
---@field ConfigViewportsNoDefaultParent boolean
---@field MouseDrawCursor boolean
---@field ConfigMacOSXBehaviors boolean
---@field ConfigNavSwapGamepadButtons boolean
---@field ConfigInputTrickleEventQueue boolean
---@field ConfigInputTextCursorBlink boolean
---@field ConfigInputTextEnterKeepActive boolean
---@field ConfigDragClickToInputText boolean
---@field ConfigWindowsResizeFromEdges boolean
---@field ConfigWindowsMoveFromTitleBarOnly boolean
---@field ConfigMemoryCompactTimer number
---@field MouseDoubleClickTime number
---@field MouseDoubleClickMaxDist number
---@field MouseDragThreshold number
---@field KeyRepeatDelay number
---@field KeyRepeatRate number
---@field ConfigDebugIsDebuggerPresent boolean
---@field ConfigDebugBeginReturnValueOnce boolean
---@field ConfigDebugBeginReturnValueLoop boolean
---@field ConfigDebugIgnoreFocusLoss boolean
---@field ConfigDebugIniSettings boolean
---@field BackendPlatformName NullTerminatedString
---@field BackendRendererName NullTerminatedString
---@field BackendPlatformUserData lightuserdata
---@field BackendRendererUserData lightuserdata
---@field BackendLanguageUserData lightuserdata
---@field GetClipboardTextFn lightuserdata
---@field SetClipboardTextFn lightuserdata
---@field ClipboardUserData lightuserdata
---@field PlatformOpenInShellFn lightuserdata
---@field PlatformOpenInShellUserData lightuserdata
---@field PlatformSetImeDataFn lightuserdata
---@field PlatformLocaleDecimalPoint integer
---@field WantCaptureMouse boolean
---@field WantCaptureKeyboard boolean
---@field WantTextInput boolean
---@field WantSetMousePos boolean
---@field WantSaveIniSettings boolean
---@field NavActive boolean
---@field NavVisible boolean
---@field Framerate number
---@field MetricsRenderVertices integer
---@field MetricsRenderIndices integer
---@field MetricsRenderWindows integer
---@field MetricsActiveWindows integer
---@field MouseDelta Vector2
---@field Ctx lightuserdata
---@field MousePos Vector2
---@field MouseDown RangeAccessor<boolean>
---@field MouseWheel number
---@field MouseWheelH number
---@field MouseSource ImGuiMouseSource|0|1|2|3|"Mouse"|"TouchScreen"|"Pen"|"COUNT"
---@field MouseHoveredViewport integer
---@field KeyCtrl boolean
---@field KeyShift boolean
---@field KeyAlt boolean
---@field KeySuper boolean
---@field KeyMods ImGuiKey|0|154|512|513|514|515|516|517|518|519|520|521|522|523|524|525|526|527|528|529|530|531|532|533|534|535|536|537|538|539|540|541|542|543|544|545|546|547|548|549|550|551|552|553|554|555|556|557|558|559|560|561|562|563|564|565|566|567|568|569|570|571|572|573|574|575|576|577|578|579|580|581|582|583|584|585|586|587|588|589|590|591|592|593|594|595|596|597|598|599|600|601|602|603|604|605|606|607|608|609|610|611|612|613|614|615|616|617|618|619|620|621|622|623|624|625|626|627|628|629|630|631|632|633|634|635|636|637|638|639|640|641|642|643|644|645|646|647|648|649|650|651|652|653|654|655|656|657|658|659|660|661|662|663|664|665|666|4096|8192|16384|32768|61440|"None"|"ModNone"|"NamedKey_COUNT"|"KeysData_SIZE"|"NamedKey_BEGIN"|"KeysData_OFFSET"|"Tab"|"LeftArrow"|"RightArrow"|"UpArrow"|"DownArrow"|"PageUp"|"PageDown"|"Home"|"End"|"Insert"|"Delete"|"Backspace"|"Space"|"Enter"|"Escape"|"LeftCtrl"|"LeftShift"|"LeftAlt"|"LeftSuper"|"RightCtrl"|"RightShift"|"RightAlt"|"RightSuper"|"Menu"|"_0"|"_1"|"_2"|"_3"|"_4"|"_5"|"_6"|"_7"|"_8"|"_9"|"A"|"B"|"C"|"D"|"E"|"F"|"G"|"H"|"I"|"J"|"K"|"L"|"M"|"N"|"O"|"P"|"Q"|"R"|"S"|"T"|"U"|"V"|"W"|"X"|"Y"|"Z"|"F1"|"F2"|"F3"|"F4"|"F5"|"F6"|"F7"|"F8"|"F9"|"F10"|"F11"|"F12"|"F13"|"F14"|"F15"|"F16"|"F17"|"F18"|"F19"|"F20"|"F21"|"F22"|"F23"|"F24"|"Apostrophe"|"Comma"|"Minus"|"Period"|"Slash"|"Semicolon"|"Equal"|"LeftBracket"|"Backslash"|"RightBracket"|"GraveAccent"|"CapsLock"|"ScrollLock"|"NumLock"|"PrintScreen"|"Pause"|"Keypad0"|"Keypad1"|"Keypad2"|"Keypad3"|"Keypad4"|"Keypad5"|"Keypad6"|"Keypad7"|"Keypad8"|"Keypad9"|"KeypadDecimal"|"KeypadDivide"|"KeypadMultiply"|"KeypadSubtract"|"KeypadAdd"|"KeypadEnter"|"KeypadEqual"|"AppBack"|"AppForward"|"GamepadStart"|"GamepadBack"|"GamepadFaceLeft"|"GamepadFaceRight"|"GamepadFaceUp"|"GamepadFaceDown"|"GamepadDpadLeft"|"GamepadDpadRight"|"GamepadDpadUp"|"GamepadDpadDown"|"GamepadL1"|"GamepadR1"|"GamepadL2"|"GamepadR2"|"GamepadL3"|"GamepadR3"|"GamepadLStickLeft"|"GamepadLStickRight"|"GamepadLStickUp"|"GamepadLStickDown"|"GamepadRStickLeft"|"GamepadRStickRight"|"GamepadRStickUp"|"GamepadRStickDown"|"MouseLeft"|"MouseRight"|"MouseMiddle"|"MouseX1"|"MouseX2"|"MouseWheelX"|"MouseWheelY"|"ReservedForModCtrl"|"ReservedForModShift"|"ReservedForModAlt"|"ReservedForModSuper"|"COUNT"|"NamedKey_END"|"ModCtrl"|"ModShift"|"ModAlt"|"ModSuper"|"ModMask"
---@field KeysData RangeAccessor<ImGuiKeyData>
---@field WantCaptureMouseUnlessPopupClose boolean
---@field MousePosPrev Vector2
---@field MouseClickedPos RangeAccessor<Vector2>
---@field MouseClickedTime RangeAccessor<number>
---@field MouseClicked RangeAccessor<boolean>
---@field MouseDoubleClicked RangeAccessor<boolean>
---@field MouseClickedCount RangeAccessor<integer>
---@field MouseClickedLastCount RangeAccessor<integer>
---@field MouseReleased RangeAccessor<boolean>
---@field MouseDownOwned RangeAccessor<boolean>
---@field MouseDownOwnedUnlessPopupClose RangeAccessor<boolean>
---@field MouseWheelRequestAxisSwap boolean
---@field MouseCtrlLeftAsRightClick boolean
---@field MouseDownDuration RangeAccessor<number>
---@field MouseDownDurationPrev RangeAccessor<number>
---@field MouseDragMaxDistanceAbs RangeAccessor<Vector2>
---@field MouseDragMaxDistanceSqr RangeAccessor<number>
---@field PenPressure number
---@field AppFocusLost boolean
---@field AppAcceptingEvents boolean
---@field BackendUsingLegacyKeyArrays integer
---@field BackendUsingLegacyNavInputArray boolean
---@field InputQueueSurrogate integer
---@field InputQueueCharacters ImVector<integer>

---@class ImGuiKeyData
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field Down integer
---@field DownDuration number
---@field DownDurationPrev number
---@field AnalogValue number

---@class ImGuiKeyDataPtr
---@field get_Down fun(): boolean READ-ONLY
---@field get_DownDuration fun(): number READ-ONLY
---@field get_DownDurationPrev fun(): number READ-ONLY
---@field get_AnalogValue fun(): number READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field Down boolean
---@field DownDuration number
---@field DownDurationPrev number
---@field AnalogValue number

---@class ImGuiListClipper
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field Ctx lightuserdata
---@field DisplayStart integer
---@field DisplayEnd integer
---@field ItemsCount integer
---@field ItemsHeight number
---@field StartPosY number
---@field StartSeekOffsetY number

---@class ImGuiListClipperPtr
---@field get_Ctx fun(): lightuserdata READ-ONLY
---@field get_DisplayStart fun(): integer READ-ONLY
---@field get_DisplayEnd fun(): integer READ-ONLY
---@field get_ItemsCount fun(): integer READ-ONLY
---@field get_ItemsHeight fun(): number READ-ONLY
---@field get_StartPosY fun(): number READ-ONLY
---@field get_StartSeekOffsetY fun(): number READ-ONLY
---@field get_TempData fun(): lightuserdata READ-ONLY
---@field set_TempData fun(value: lightuserdata): nil READ-ONLY
---@field Begin fun(items_count: integer): nil READ-ONLY
---@field Begin fun(items_count: integer, items_height: number): nil READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field End fun(): nil READ-ONLY
---@field IncludeItemByIndex fun(item_index: integer): nil READ-ONLY
---@field SeekCursorForItem fun(item_index: integer): nil READ-ONLY
---@field Step fun(): boolean READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field Ctx lightuserdata
---@field DisplayStart integer
---@field DisplayEnd integer
---@field ItemsCount integer
---@field ItemsHeight number
---@field StartPosY number
---@field StartSeekOffsetY number
---@field TempData lightuserdata

---@class ImGuiMultiSelectIO
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field Requests ImVector
---@field RangeSrcItem integer
---@field NavIdItem integer
---@field NavIdSelected integer
---@field RangeSrcReset integer
---@field ItemsCount integer

---@class ImGuiMultiSelectIOPtr
---@field get_Requests fun(): ImPtrVector<ImGuiSelectionRequestPtr> READ-ONLY
---@field get_RangeSrcItem fun(): integer READ-ONLY
---@field get_NavIdItem fun(): integer READ-ONLY
---@field get_NavIdSelected fun(): boolean READ-ONLY
---@field get_RangeSrcReset fun(): boolean READ-ONLY
---@field get_ItemsCount fun(): integer READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field Requests ImPtrVector<ImGuiSelectionRequestPtr>
---@field RangeSrcItem integer
---@field NavIdItem integer
---@field NavIdSelected boolean
---@field RangeSrcReset boolean
---@field ItemsCount integer

---@class ImGuiNative
---@field GetType fun(): Type READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY

---@class ImGuiOnceUponAFrame
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field RefFrame integer

---@class ImGuiOnceUponAFramePtr
---@field get_RefFrame fun(): integer READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field RefFrame integer

---@class ImGuiPayload
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field DataSize integer
---@field SourceId integer
---@field SourceParentId integer
---@field DataFrameCount integer
---@field Preview integer
---@field Delivery integer

---@class ImGuiPayloadPtr
---@field get_Data fun(): lightuserdata READ-ONLY
---@field set_Data fun(value: lightuserdata): nil READ-ONLY
---@field get_DataSize fun(): integer READ-ONLY
---@field get_SourceId fun(): integer READ-ONLY
---@field get_SourceParentId fun(): integer READ-ONLY
---@field get_DataFrameCount fun(): integer READ-ONLY
---@field get_DataType fun(): RangeAccessor<integer> READ-ONLY
---@field get_Preview fun(): boolean READ-ONLY
---@field get_Delivery fun(): boolean READ-ONLY
---@field Clear fun(): nil READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field IsDataType fun(type: string): boolean READ-ONLY
---@field IsDelivery fun(): boolean READ-ONLY
---@field IsPreview fun(): boolean READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field Data lightuserdata
---@field DataSize integer
---@field SourceId integer
---@field SourceParentId integer
---@field DataFrameCount integer
---@field DataType RangeAccessor<integer>
---@field Preview boolean
---@field Delivery boolean

---@class ImGuiPlatformImeData
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field WantVisible integer
---@field InputPos Vector2
---@field InputLineHeight number

---@class ImGuiPlatformImeDataPtr
---@field get_WantVisible fun(): boolean READ-ONLY
---@field get_InputPos fun(): Vector2 READ-ONLY
---@field get_InputLineHeight fun(): number READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field WantVisible boolean
---@field InputPos Vector2
---@field InputLineHeight number

---@class ImGuiPlatformIO
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field Platform_CreateWindow lightuserdata
---@field Platform_DestroyWindow lightuserdata
---@field Platform_ShowWindow lightuserdata
---@field Platform_SetWindowPos lightuserdata
---@field Platform_GetWindowPos lightuserdata
---@field Platform_SetWindowSize lightuserdata
---@field Platform_GetWindowSize lightuserdata
---@field Platform_SetWindowFocus lightuserdata
---@field Platform_GetWindowFocus lightuserdata
---@field Platform_GetWindowMinimized lightuserdata
---@field Platform_SetWindowTitle lightuserdata
---@field Platform_SetWindowAlpha lightuserdata
---@field Platform_UpdateWindow lightuserdata
---@field Platform_RenderWindow lightuserdata
---@field Platform_SwapBuffers lightuserdata
---@field Platform_GetWindowDpiScale lightuserdata
---@field Platform_OnChangedViewport lightuserdata
---@field Platform_CreateVkSurface lightuserdata
---@field Renderer_CreateWindow lightuserdata
---@field Renderer_DestroyWindow lightuserdata
---@field Renderer_SetWindowSize lightuserdata
---@field Renderer_RenderWindow lightuserdata
---@field Renderer_SwapBuffers lightuserdata
---@field Monitors ImVector
---@field Viewports ImVector

---@class ImGuiPlatformIOPtr
---@field get_Platform_CreateWindow fun(): lightuserdata READ-ONLY
---@field get_Platform_DestroyWindow fun(): lightuserdata READ-ONLY
---@field get_Platform_ShowWindow fun(): lightuserdata READ-ONLY
---@field get_Platform_SetWindowPos fun(): lightuserdata READ-ONLY
---@field get_Platform_GetWindowPos fun(): lightuserdata READ-ONLY
---@field get_Platform_SetWindowSize fun(): lightuserdata READ-ONLY
---@field get_Platform_GetWindowSize fun(): lightuserdata READ-ONLY
---@field get_Platform_SetWindowFocus fun(): lightuserdata READ-ONLY
---@field get_Platform_GetWindowFocus fun(): lightuserdata READ-ONLY
---@field get_Platform_GetWindowMinimized fun(): lightuserdata READ-ONLY
---@field get_Platform_SetWindowTitle fun(): lightuserdata READ-ONLY
---@field get_Platform_SetWindowAlpha fun(): lightuserdata READ-ONLY
---@field get_Platform_UpdateWindow fun(): lightuserdata READ-ONLY
---@field get_Platform_RenderWindow fun(): lightuserdata READ-ONLY
---@field get_Platform_SwapBuffers fun(): lightuserdata READ-ONLY
---@field get_Platform_GetWindowDpiScale fun(): lightuserdata READ-ONLY
---@field get_Platform_OnChangedViewport fun(): lightuserdata READ-ONLY
---@field get_Platform_CreateVkSurface fun(): lightuserdata READ-ONLY
---@field get_Renderer_CreateWindow fun(): lightuserdata READ-ONLY
---@field get_Renderer_DestroyWindow fun(): lightuserdata READ-ONLY
---@field get_Renderer_SetWindowSize fun(): lightuserdata READ-ONLY
---@field get_Renderer_RenderWindow fun(): lightuserdata READ-ONLY
---@field get_Renderer_SwapBuffers fun(): lightuserdata READ-ONLY
---@field get_Monitors fun(): ImPtrVector<ImGuiPlatformMonitorPtr> READ-ONLY
---@field get_Viewports fun(): ImVector<ImGuiViewportPtr> READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field Platform_CreateWindow lightuserdata
---@field Platform_DestroyWindow lightuserdata
---@field Platform_ShowWindow lightuserdata
---@field Platform_SetWindowPos lightuserdata
---@field Platform_GetWindowPos lightuserdata
---@field Platform_SetWindowSize lightuserdata
---@field Platform_GetWindowSize lightuserdata
---@field Platform_SetWindowFocus lightuserdata
---@field Platform_GetWindowFocus lightuserdata
---@field Platform_GetWindowMinimized lightuserdata
---@field Platform_SetWindowTitle lightuserdata
---@field Platform_SetWindowAlpha lightuserdata
---@field Platform_UpdateWindow lightuserdata
---@field Platform_RenderWindow lightuserdata
---@field Platform_SwapBuffers lightuserdata
---@field Platform_GetWindowDpiScale lightuserdata
---@field Platform_OnChangedViewport lightuserdata
---@field Platform_CreateVkSurface lightuserdata
---@field Renderer_CreateWindow lightuserdata
---@field Renderer_DestroyWindow lightuserdata
---@field Renderer_SetWindowSize lightuserdata
---@field Renderer_RenderWindow lightuserdata
---@field Renderer_SwapBuffers lightuserdata
---@field Monitors ImPtrVector<ImGuiPlatformMonitorPtr>
---@field Viewports ImVector<ImGuiViewportPtr>

---@class ImGuiPlatformMonitor
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field MainPos Vector2
---@field MainSize Vector2
---@field WorkPos Vector2
---@field WorkSize Vector2
---@field DpiScale number

---@class ImGuiPlatformMonitorPtr
---@field get_MainPos fun(): Vector2 READ-ONLY
---@field get_MainSize fun(): Vector2 READ-ONLY
---@field get_WorkPos fun(): Vector2 READ-ONLY
---@field get_WorkSize fun(): Vector2 READ-ONLY
---@field get_DpiScale fun(): number READ-ONLY
---@field get_PlatformHandle fun(): lightuserdata READ-ONLY
---@field set_PlatformHandle fun(value: lightuserdata): nil READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field MainPos Vector2
---@field MainSize Vector2
---@field WorkPos Vector2
---@field WorkSize Vector2
---@field DpiScale number
---@field PlatformHandle lightuserdata

---@class ImGuiSelectionBasicStorage
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field Size integer
---@field PreserveOrder integer
---@field AdapterIndexToStorageId lightuserdata
---@field _SelectionOrder integer
---@field _Storage ImGuiStorage

---@class ImGuiSelectionBasicStoragePtr
---@field get_Size fun(): integer READ-ONLY
---@field get_PreserveOrder fun(): boolean READ-ONLY
---@field get_UserData fun(): lightuserdata READ-ONLY
---@field set_UserData fun(value: lightuserdata): nil READ-ONLY
---@field get_AdapterIndexToStorageId fun(): lightuserdata READ-ONLY
---@field get__SelectionOrder fun(): integer READ-ONLY
---@field get__Storage fun(): ImGuiStorage READ-ONLY
---@field ApplyRequests fun(ms_io: ImGuiMultiSelectIOPtr): nil READ-ONLY
---@field Clear fun(): nil READ-ONLY
---@field Contains fun(id: integer): boolean READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field GetStorageIdFromIndex fun(idx: integer): integer READ-ONLY
---@field SetItemSelected fun(id: integer, selected: boolean): nil READ-ONLY
---@field Swap fun(r: ImGuiSelectionBasicStoragePtr): nil READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field Size integer
---@field PreserveOrder boolean
---@field UserData lightuserdata
---@field AdapterIndexToStorageId lightuserdata
---@field _SelectionOrder integer
---@field _Storage ImGuiStorage

---@class ImGuiSelectionExternalStorage
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field AdapterSetItemSelected lightuserdata

---@class ImGuiSelectionExternalStoragePtr
---@field get_UserData fun(): lightuserdata READ-ONLY
---@field set_UserData fun(value: lightuserdata): nil READ-ONLY
---@field get_AdapterSetItemSelected fun(): lightuserdata READ-ONLY
---@field ApplyRequests fun(ms_io: ImGuiMultiSelectIOPtr): nil READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field UserData lightuserdata
---@field AdapterSetItemSelected lightuserdata

---@class ImGuiSelectionRequest
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field Type ImGuiSelectionRequestType|0|1|2|"None"|"SetAll"|"SetRange"
---@field Selected integer
---@field RangeDirection integer
---@field RangeFirstItem integer
---@field RangeLastItem integer

---@class ImGuiSelectionRequestPtr
---@field get_Type fun(): ImGuiSelectionRequestType|0|1|2|"None"|"SetAll"|"SetRange" READ-ONLY
---@field get_Selected fun(): boolean READ-ONLY
---@field get_RangeDirection fun(): integer READ-ONLY
---@field get_RangeFirstItem fun(): integer READ-ONLY
---@field get_RangeLastItem fun(): integer READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field Type ImGuiSelectionRequestType|0|1|2|"None"|"SetAll"|"SetRange"
---@field Selected boolean
---@field RangeDirection integer
---@field RangeFirstItem integer
---@field RangeLastItem integer

---@class ImGuiSizeCallbackData
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field Pos Vector2
---@field CurrentSize Vector2
---@field DesiredSize Vector2

---@class ImGuiSizeCallbackDataPtr
---@field get_UserData fun(): lightuserdata READ-ONLY
---@field set_UserData fun(value: lightuserdata): nil READ-ONLY
---@field get_Pos fun(): Vector2 READ-ONLY
---@field get_CurrentSize fun(): Vector2 READ-ONLY
---@field get_DesiredSize fun(): Vector2 READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field UserData lightuserdata
---@field Pos Vector2
---@field CurrentSize Vector2
---@field DesiredSize Vector2

---@class ImGuiStorage
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field Data ImVector

---@class ImGuiStoragePair
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field Key integer
---@field Value UnionValue

---@class ImGuiStoragePairPtr
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY

---@class ImGuiStoragePtr
---@field get_Data fun(): ImPtrVector<ImGuiStoragePairPtr> READ-ONLY
---@field BuildSortByKey fun(): nil READ-ONLY
---@field Clear fun(): nil READ-ONLY
---@field GetBool fun(key: integer): boolean READ-ONLY
---@field GetBool fun(key: integer, default_val: boolean): boolean READ-ONLY
---@field GetFloat fun(key: integer): number READ-ONLY
---@field GetFloat fun(key: integer, default_val: number): number READ-ONLY
---@field GetInt fun(key: integer): integer READ-ONLY
---@field GetInt fun(key: integer, default_val: integer): integer READ-ONLY
---@field GetVoidPtr fun(key: integer): lightuserdata READ-ONLY
---@field SetAllInt fun(val: integer): nil READ-ONLY
---@field SetBool fun(key: integer, val: boolean): nil READ-ONLY
---@field SetFloat fun(key: integer, val: number): nil READ-ONLY
---@field SetInt fun(key: integer, val: integer): nil READ-ONLY
---@field SetVoidPtr fun(key: integer, val: lightuserdata): nil READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field Data ImPtrVector<ImGuiStoragePairPtr>

---@class ImGuiStyle
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field Alpha number
---@field DisabledAlpha number
---@field WindowPadding Vector2
---@field WindowRounding number
---@field WindowBorderSize number
---@field WindowMinSize Vector2
---@field WindowTitleAlign Vector2
---@field WindowMenuButtonPosition ImGuiDir|0|1|2|3|4|-1|"Left"|"Right"|"Up"|"Down"|"COUNT"|"None"
---@field ChildRounding number
---@field ChildBorderSize number
---@field PopupRounding number
---@field PopupBorderSize number
---@field FramePadding Vector2
---@field FrameRounding number
---@field FrameBorderSize number
---@field ItemSpacing Vector2
---@field ItemInnerSpacing Vector2
---@field CellPadding Vector2
---@field TouchExtraPadding Vector2
---@field IndentSpacing number
---@field ColumnsMinSpacing number
---@field ScrollbarSize number
---@field ScrollbarRounding number
---@field GrabMinSize number
---@field GrabRounding number
---@field LogSliderDeadzone number
---@field TabRounding number
---@field TabBorderSize number
---@field TabMinWidthForCloseButton number
---@field TabBarBorderSize number
---@field TabBarOverlineSize number
---@field TableAngledHeadersAngle number
---@field TableAngledHeadersTextAlign Vector2
---@field ColorButtonPosition ImGuiDir|0|1|2|3|4|-1|"Left"|"Right"|"Up"|"Down"|"COUNT"|"None"
---@field ButtonTextAlign Vector2
---@field SelectableTextAlign Vector2
---@field SeparatorTextBorderSize number
---@field SeparatorTextAlign Vector2
---@field SeparatorTextPadding Vector2
---@field DisplayWindowPadding Vector2
---@field DisplaySafeAreaPadding Vector2
---@field DockingSeparatorSize number
---@field MouseCursorScale number
---@field AntiAliasedLines integer
---@field AntiAliasedLinesUseTex integer
---@field AntiAliasedFill integer
---@field CurveTessellationTol number
---@field CircleTessellationMaxError number
---@field Colors_0 Vector4
---@field Colors_1 Vector4
---@field Colors_2 Vector4
---@field Colors_3 Vector4
---@field Colors_4 Vector4
---@field Colors_5 Vector4
---@field Colors_6 Vector4
---@field Colors_7 Vector4
---@field Colors_8 Vector4
---@field Colors_9 Vector4
---@field Colors_10 Vector4
---@field Colors_11 Vector4
---@field Colors_12 Vector4
---@field Colors_13 Vector4
---@field Colors_14 Vector4
---@field Colors_15 Vector4
---@field Colors_16 Vector4
---@field Colors_17 Vector4
---@field Colors_18 Vector4
---@field Colors_19 Vector4
---@field Colors_20 Vector4
---@field Colors_21 Vector4
---@field Colors_22 Vector4
---@field Colors_23 Vector4
---@field Colors_24 Vector4
---@field Colors_25 Vector4
---@field Colors_26 Vector4
---@field Colors_27 Vector4
---@field Colors_28 Vector4
---@field Colors_29 Vector4
---@field Colors_30 Vector4
---@field Colors_31 Vector4
---@field Colors_32 Vector4
---@field Colors_33 Vector4
---@field Colors_34 Vector4
---@field Colors_35 Vector4
---@field Colors_36 Vector4
---@field Colors_37 Vector4
---@field Colors_38 Vector4
---@field Colors_39 Vector4
---@field Colors_40 Vector4
---@field Colors_41 Vector4
---@field Colors_42 Vector4
---@field Colors_43 Vector4
---@field Colors_44 Vector4
---@field Colors_45 Vector4
---@field Colors_46 Vector4
---@field Colors_47 Vector4
---@field Colors_48 Vector4
---@field Colors_49 Vector4
---@field Colors_50 Vector4
---@field Colors_51 Vector4
---@field Colors_52 Vector4
---@field Colors_53 Vector4
---@field Colors_54 Vector4
---@field Colors_55 Vector4
---@field Colors_56 Vector4
---@field Colors_57 Vector4
---@field HoverStationaryDelay number
---@field HoverDelayShort number
---@field HoverDelayNormal number
---@field HoverFlagsForTooltipMouse ImGuiHoveredFlags|integer|"None"|"ChildWindows"|"RootWindow"|"RootAndChildWindows"|"AnyWindow"|"NoPopupHierarchy"|"DockHierarchy"|"AllowWhenBlockedByPopup"|"AllowWhenBlockedByActiveItem"|"AllowWhenOverlappedByItem"|"AllowWhenOverlappedByWindow"|"AllowWhenOverlapped"|"RectOnly"|"AllowWhenDisabled"|"NoNavOverride"|"ForTooltip"|"Stationary"|"DelayNone"|"DelayShort"|"DelayNormal"|"NoSharedDelay"
---@field HoverFlagsForTooltipNav ImGuiHoveredFlags|integer|"None"|"ChildWindows"|"RootWindow"|"RootAndChildWindows"|"AnyWindow"|"NoPopupHierarchy"|"DockHierarchy"|"AllowWhenBlockedByPopup"|"AllowWhenBlockedByActiveItem"|"AllowWhenOverlappedByItem"|"AllowWhenOverlappedByWindow"|"AllowWhenOverlapped"|"RectOnly"|"AllowWhenDisabled"|"NoNavOverride"|"ForTooltip"|"Stationary"|"DelayNone"|"DelayShort"|"DelayNormal"|"NoSharedDelay"

---@class ImGuiStylePtr
---@field get_Alpha fun(): number READ-ONLY
---@field get_DisabledAlpha fun(): number READ-ONLY
---@field get_WindowPadding fun(): Vector2 READ-ONLY
---@field get_WindowRounding fun(): number READ-ONLY
---@field get_WindowBorderSize fun(): number READ-ONLY
---@field get_WindowMinSize fun(): Vector2 READ-ONLY
---@field get_WindowTitleAlign fun(): Vector2 READ-ONLY
---@field get_WindowMenuButtonPosition fun(): ImGuiDir|0|1|2|3|4|-1|"Left"|"Right"|"Up"|"Down"|"COUNT"|"None" READ-ONLY
---@field get_ChildRounding fun(): number READ-ONLY
---@field get_ChildBorderSize fun(): number READ-ONLY
---@field get_PopupRounding fun(): number READ-ONLY
---@field get_PopupBorderSize fun(): number READ-ONLY
---@field get_FramePadding fun(): Vector2 READ-ONLY
---@field get_FrameRounding fun(): number READ-ONLY
---@field get_FrameBorderSize fun(): number READ-ONLY
---@field get_ItemSpacing fun(): Vector2 READ-ONLY
---@field get_ItemInnerSpacing fun(): Vector2 READ-ONLY
---@field get_CellPadding fun(): Vector2 READ-ONLY
---@field get_TouchExtraPadding fun(): Vector2 READ-ONLY
---@field get_IndentSpacing fun(): number READ-ONLY
---@field get_ColumnsMinSpacing fun(): number READ-ONLY
---@field get_ScrollbarSize fun(): number READ-ONLY
---@field get_ScrollbarRounding fun(): number READ-ONLY
---@field get_GrabMinSize fun(): number READ-ONLY
---@field get_GrabRounding fun(): number READ-ONLY
---@field get_LogSliderDeadzone fun(): number READ-ONLY
---@field get_TabRounding fun(): number READ-ONLY
---@field get_TabBorderSize fun(): number READ-ONLY
---@field get_TabMinWidthForCloseButton fun(): number READ-ONLY
---@field get_TabBarBorderSize fun(): number READ-ONLY
---@field get_TabBarOverlineSize fun(): number READ-ONLY
---@field get_TableAngledHeadersAngle fun(): number READ-ONLY
---@field get_TableAngledHeadersTextAlign fun(): Vector2 READ-ONLY
---@field get_ColorButtonPosition fun(): ImGuiDir|0|1|2|3|4|-1|"Left"|"Right"|"Up"|"Down"|"COUNT"|"None" READ-ONLY
---@field get_ButtonTextAlign fun(): Vector2 READ-ONLY
---@field get_SelectableTextAlign fun(): Vector2 READ-ONLY
---@field get_SeparatorTextBorderSize fun(): number READ-ONLY
---@field get_SeparatorTextAlign fun(): Vector2 READ-ONLY
---@field get_SeparatorTextPadding fun(): Vector2 READ-ONLY
---@field get_DisplayWindowPadding fun(): Vector2 READ-ONLY
---@field get_DisplaySafeAreaPadding fun(): Vector2 READ-ONLY
---@field get_DockingSeparatorSize fun(): number READ-ONLY
---@field get_MouseCursorScale fun(): number READ-ONLY
---@field get_AntiAliasedLines fun(): boolean READ-ONLY
---@field get_AntiAliasedLinesUseTex fun(): boolean READ-ONLY
---@field get_AntiAliasedFill fun(): boolean READ-ONLY
---@field get_CurveTessellationTol fun(): number READ-ONLY
---@field get_CircleTessellationMaxError fun(): number READ-ONLY
---@field get_Colors fun(): RangeAccessor<Vector4> READ-ONLY
---@field get_HoverStationaryDelay fun(): number READ-ONLY
---@field get_HoverDelayShort fun(): number READ-ONLY
---@field get_HoverDelayNormal fun(): number READ-ONLY
---@field get_HoverFlagsForTooltipMouse fun(): ImGuiHoveredFlags|integer|"None"|"ChildWindows"|"RootWindow"|"RootAndChildWindows"|"AnyWindow"|"NoPopupHierarchy"|"DockHierarchy"|"AllowWhenBlockedByPopup"|"AllowWhenBlockedByActiveItem"|"AllowWhenOverlappedByItem"|"AllowWhenOverlappedByWindow"|"AllowWhenOverlapped"|"RectOnly"|"AllowWhenDisabled"|"NoNavOverride"|"ForTooltip"|"Stationary"|"DelayNone"|"DelayShort"|"DelayNormal"|"NoSharedDelay" READ-ONLY
---@field get_HoverFlagsForTooltipNav fun(): ImGuiHoveredFlags|integer|"None"|"ChildWindows"|"RootWindow"|"RootAndChildWindows"|"AnyWindow"|"NoPopupHierarchy"|"DockHierarchy"|"AllowWhenBlockedByPopup"|"AllowWhenBlockedByActiveItem"|"AllowWhenOverlappedByItem"|"AllowWhenOverlappedByWindow"|"AllowWhenOverlapped"|"RectOnly"|"AllowWhenDisabled"|"NoNavOverride"|"ForTooltip"|"Stationary"|"DelayNone"|"DelayShort"|"DelayNormal"|"NoSharedDelay" READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field ScaleAllSizes fun(scale_factor: number): nil READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field Alpha number
---@field DisabledAlpha number
---@field WindowPadding Vector2
---@field WindowRounding number
---@field WindowBorderSize number
---@field WindowMinSize Vector2
---@field WindowTitleAlign Vector2
---@field WindowMenuButtonPosition ImGuiDir|0|1|2|3|4|-1|"Left"|"Right"|"Up"|"Down"|"COUNT"|"None"
---@field ChildRounding number
---@field ChildBorderSize number
---@field PopupRounding number
---@field PopupBorderSize number
---@field FramePadding Vector2
---@field FrameRounding number
---@field FrameBorderSize number
---@field ItemSpacing Vector2
---@field ItemInnerSpacing Vector2
---@field CellPadding Vector2
---@field TouchExtraPadding Vector2
---@field IndentSpacing number
---@field ColumnsMinSpacing number
---@field ScrollbarSize number
---@field ScrollbarRounding number
---@field GrabMinSize number
---@field GrabRounding number
---@field LogSliderDeadzone number
---@field TabRounding number
---@field TabBorderSize number
---@field TabMinWidthForCloseButton number
---@field TabBarBorderSize number
---@field TabBarOverlineSize number
---@field TableAngledHeadersAngle number
---@field TableAngledHeadersTextAlign Vector2
---@field ColorButtonPosition ImGuiDir|0|1|2|3|4|-1|"Left"|"Right"|"Up"|"Down"|"COUNT"|"None"
---@field ButtonTextAlign Vector2
---@field SelectableTextAlign Vector2
---@field SeparatorTextBorderSize number
---@field SeparatorTextAlign Vector2
---@field SeparatorTextPadding Vector2
---@field DisplayWindowPadding Vector2
---@field DisplaySafeAreaPadding Vector2
---@field DockingSeparatorSize number
---@field MouseCursorScale number
---@field AntiAliasedLines boolean
---@field AntiAliasedLinesUseTex boolean
---@field AntiAliasedFill boolean
---@field CurveTessellationTol number
---@field CircleTessellationMaxError number
---@field Colors RangeAccessor<Vector4>
---@field HoverStationaryDelay number
---@field HoverDelayShort number
---@field HoverDelayNormal number
---@field HoverFlagsForTooltipMouse ImGuiHoveredFlags|integer|"None"|"ChildWindows"|"RootWindow"|"RootAndChildWindows"|"AnyWindow"|"NoPopupHierarchy"|"DockHierarchy"|"AllowWhenBlockedByPopup"|"AllowWhenBlockedByActiveItem"|"AllowWhenOverlappedByItem"|"AllowWhenOverlappedByWindow"|"AllowWhenOverlapped"|"RectOnly"|"AllowWhenDisabled"|"NoNavOverride"|"ForTooltip"|"Stationary"|"DelayNone"|"DelayShort"|"DelayNormal"|"NoSharedDelay"
---@field HoverFlagsForTooltipNav ImGuiHoveredFlags|integer|"None"|"ChildWindows"|"RootWindow"|"RootAndChildWindows"|"AnyWindow"|"NoPopupHierarchy"|"DockHierarchy"|"AllowWhenBlockedByPopup"|"AllowWhenBlockedByActiveItem"|"AllowWhenOverlappedByItem"|"AllowWhenOverlappedByWindow"|"AllowWhenOverlapped"|"RectOnly"|"AllowWhenDisabled"|"NoNavOverride"|"ForTooltip"|"Stationary"|"DelayNone"|"DelayShort"|"DelayNormal"|"NoSharedDelay"

---@class ImGuiTableColumnSortSpecs
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field ColumnUserID integer
---@field ColumnIndex integer
---@field SortOrder integer
---@field SortDirection ImGuiSortDirection|0|1|2|"None"|"Ascending"|"Descending"

---@class ImGuiTableColumnSortSpecsPtr
---@field get_ColumnUserID fun(): integer READ-ONLY
---@field get_ColumnIndex fun(): integer READ-ONLY
---@field get_SortOrder fun(): integer READ-ONLY
---@field get_SortDirection fun(): ImGuiSortDirection|0|1|2|"None"|"Ascending"|"Descending" READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field ColumnUserID integer
---@field ColumnIndex integer
---@field SortOrder integer
---@field SortDirection ImGuiSortDirection|0|1|2|"None"|"Ascending"|"Descending"

---@class ImGuiTableSortSpecs
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field SpecsCount integer
---@field SpecsDirty integer

---@class ImGuiTableSortSpecsPtr
---@field get_Specs fun(): ImGuiTableColumnSortSpecsPtr READ-ONLY
---@field get_SpecsCount fun(): integer READ-ONLY
---@field get_SpecsDirty fun(): boolean READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field Specs ImGuiTableColumnSortSpecsPtr
---@field SpecsCount integer
---@field SpecsDirty boolean

---@class ImGuiTextBuffer
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field Buf ImVector

---@class ImGuiTextBufferPtr
---@field get_Buf fun(): ImVector<integer> READ-ONLY
---@field append fun(str: string): nil READ-ONLY
---@field appendf fun(fmt: string): nil READ-ONLY
---@field begin fun(): string READ-ONLY
---@field c_str fun(): string READ-ONLY
---@field clear fun(): nil READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field empty fun(): boolean READ-ONLY
---@field end fun(): string READ-ONLY
---@field reserve fun(capacity: integer): nil READ-ONLY
---@field size fun(): integer READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field Buf ImVector<integer>

---@class ImGuiTextFilter
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field Filters ImVector
---@field CountGrep integer

---@class ImGuiTextFilterPtr
---@field get_InputBuf fun(): RangeAccessor<integer> READ-ONLY
---@field get_Filters fun(): ImPtrVector<ImGuiTextRangePtr> READ-ONLY
---@field get_CountGrep fun(): integer READ-ONLY
---@field Build fun(): nil READ-ONLY
---@field Clear fun(): nil READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field Draw fun(): boolean READ-ONLY
---@field Draw fun(label: string): boolean READ-ONLY
---@field Draw fun(label: string, width: number): boolean READ-ONLY
---@field IsActive fun(): boolean READ-ONLY
---@field PassFilter fun(text: string): boolean READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field InputBuf RangeAccessor<integer>
---@field Filters ImPtrVector<ImGuiTextRangePtr>
---@field CountGrep integer

---@class ImGuiTextRange
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY

---@class ImGuiTextRangePtr
---@field get_b fun(): lightuserdata READ-ONLY
---@field set_b fun(value: lightuserdata): nil READ-ONLY
---@field get_e fun(): lightuserdata READ-ONLY
---@field set_e fun(value: lightuserdata): nil READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field empty fun(): boolean READ-ONLY
---@field split fun(separator: integer, out: ImVector): nil READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field b lightuserdata
---@field e lightuserdata

---@class ImGuiViewport
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field ID integer
---@field Flags ImGuiViewportFlags|integer|"None"|"IsPlatformWindow"|"IsPlatformMonitor"|"OwnedByApp"|"NoDecoration"|"NoTaskBarIcon"|"NoFocusOnAppearing"|"NoFocusOnClick"|"NoInputs"|"NoRendererClear"|"NoAutoMerge"|"TopMost"|"CanHostOtherWindows"|"IsMinimized"|"IsFocused"
---@field Pos Vector2
---@field Size Vector2
---@field WorkPos Vector2
---@field WorkSize Vector2
---@field DpiScale number
---@field ParentViewportId integer
---@field PlatformWindowCreated integer
---@field PlatformRequestMove integer
---@field PlatformRequestResize integer
---@field PlatformRequestClose integer

---@class ImGuiViewportPtr
---@field get_ID fun(): integer READ-ONLY
---@field get_Flags fun(): ImGuiViewportFlags|integer|"None"|"IsPlatformWindow"|"IsPlatformMonitor"|"OwnedByApp"|"NoDecoration"|"NoTaskBarIcon"|"NoFocusOnAppearing"|"NoFocusOnClick"|"NoInputs"|"NoRendererClear"|"NoAutoMerge"|"TopMost"|"CanHostOtherWindows"|"IsMinimized"|"IsFocused" READ-ONLY
---@field get_Pos fun(): Vector2 READ-ONLY
---@field get_Size fun(): Vector2 READ-ONLY
---@field get_WorkPos fun(): Vector2 READ-ONLY
---@field get_WorkSize fun(): Vector2 READ-ONLY
---@field get_DpiScale fun(): number READ-ONLY
---@field get_ParentViewportId fun(): integer READ-ONLY
---@field get_DrawData fun(): ImDrawDataPtr READ-ONLY
---@field get_RendererUserData fun(): lightuserdata READ-ONLY
---@field set_RendererUserData fun(value: lightuserdata): nil READ-ONLY
---@field get_PlatformUserData fun(): lightuserdata READ-ONLY
---@field set_PlatformUserData fun(value: lightuserdata): nil READ-ONLY
---@field get_PlatformHandle fun(): lightuserdata READ-ONLY
---@field set_PlatformHandle fun(value: lightuserdata): nil READ-ONLY
---@field get_PlatformHandleRaw fun(): lightuserdata READ-ONLY
---@field set_PlatformHandleRaw fun(value: lightuserdata): nil READ-ONLY
---@field get_PlatformWindowCreated fun(): boolean READ-ONLY
---@field get_PlatformRequestMove fun(): boolean READ-ONLY
---@field get_PlatformRequestResize fun(): boolean READ-ONLY
---@field get_PlatformRequestClose fun(): boolean READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field GetCenter fun(): Vector2 READ-ONLY
---@field GetWorkCenter fun(): Vector2 READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field ID integer
---@field Flags ImGuiViewportFlags|integer|"None"|"IsPlatformWindow"|"IsPlatformMonitor"|"OwnedByApp"|"NoDecoration"|"NoTaskBarIcon"|"NoFocusOnAppearing"|"NoFocusOnClick"|"NoInputs"|"NoRendererClear"|"NoAutoMerge"|"TopMost"|"CanHostOtherWindows"|"IsMinimized"|"IsFocused"
---@field Pos Vector2
---@field Size Vector2
---@field WorkPos Vector2
---@field WorkSize Vector2
---@field DpiScale number
---@field ParentViewportId integer
---@field DrawData ImDrawDataPtr
---@field RendererUserData lightuserdata
---@field PlatformUserData lightuserdata
---@field PlatformHandle lightuserdata
---@field PlatformHandleRaw lightuserdata
---@field PlatformWindowCreated boolean
---@field PlatformRequestMove boolean
---@field PlatformRequestResize boolean
---@field PlatformRequestClose boolean

---@class ImGuiWindowClass
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field ClassId integer
---@field ParentViewportId integer
---@field FocusRouteParentWindowId integer
---@field ViewportFlagsOverrideSet ImGuiViewportFlags|integer|"None"|"IsPlatformWindow"|"IsPlatformMonitor"|"OwnedByApp"|"NoDecoration"|"NoTaskBarIcon"|"NoFocusOnAppearing"|"NoFocusOnClick"|"NoInputs"|"NoRendererClear"|"NoAutoMerge"|"TopMost"|"CanHostOtherWindows"|"IsMinimized"|"IsFocused"
---@field ViewportFlagsOverrideClear ImGuiViewportFlags|integer|"None"|"IsPlatformWindow"|"IsPlatformMonitor"|"OwnedByApp"|"NoDecoration"|"NoTaskBarIcon"|"NoFocusOnAppearing"|"NoFocusOnClick"|"NoInputs"|"NoRendererClear"|"NoAutoMerge"|"TopMost"|"CanHostOtherWindows"|"IsMinimized"|"IsFocused"
---@field TabItemFlagsOverrideSet ImGuiTabItemFlags|integer|"None"|"UnsavedDocument"|"SetSelected"|"NoCloseWithMiddleMouseButton"|"NoPushId"|"NoTooltip"|"NoReorder"|"Leading"|"Trailing"|"NoAssumedClosure"
---@field DockNodeFlagsOverrideSet ImGuiDockNodeFlags|integer|"None"|"KeepAliveOnly"|"NoDockingOverCentralNode"|"PassthruCentralNode"|"NoDockingSplit"|"NoResize"|"AutoHideTabBar"|"NoUndocking"
---@field DockingAlwaysTabBar integer
---@field DockingAllowUnclassed integer

---@class ImGuiWindowClassPtr
---@field get_ClassId fun(): integer READ-ONLY
---@field get_ParentViewportId fun(): integer READ-ONLY
---@field get_FocusRouteParentWindowId fun(): integer READ-ONLY
---@field get_ViewportFlagsOverrideSet fun(): ImGuiViewportFlags|integer|"None"|"IsPlatformWindow"|"IsPlatformMonitor"|"OwnedByApp"|"NoDecoration"|"NoTaskBarIcon"|"NoFocusOnAppearing"|"NoFocusOnClick"|"NoInputs"|"NoRendererClear"|"NoAutoMerge"|"TopMost"|"CanHostOtherWindows"|"IsMinimized"|"IsFocused" READ-ONLY
---@field get_ViewportFlagsOverrideClear fun(): ImGuiViewportFlags|integer|"None"|"IsPlatformWindow"|"IsPlatformMonitor"|"OwnedByApp"|"NoDecoration"|"NoTaskBarIcon"|"NoFocusOnAppearing"|"NoFocusOnClick"|"NoInputs"|"NoRendererClear"|"NoAutoMerge"|"TopMost"|"CanHostOtherWindows"|"IsMinimized"|"IsFocused" READ-ONLY
---@field get_TabItemFlagsOverrideSet fun(): ImGuiTabItemFlags|integer|"None"|"UnsavedDocument"|"SetSelected"|"NoCloseWithMiddleMouseButton"|"NoPushId"|"NoTooltip"|"NoReorder"|"Leading"|"Trailing"|"NoAssumedClosure" READ-ONLY
---@field get_DockNodeFlagsOverrideSet fun(): ImGuiDockNodeFlags|integer|"None"|"KeepAliveOnly"|"NoDockingOverCentralNode"|"PassthruCentralNode"|"NoDockingSplit"|"NoResize"|"AutoHideTabBar"|"NoUndocking" READ-ONLY
---@field get_DockingAlwaysTabBar fun(): boolean READ-ONLY
---@field get_DockingAllowUnclassed fun(): boolean READ-ONLY
---@field Destroy fun(): nil READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field ClassId integer
---@field ParentViewportId integer
---@field FocusRouteParentWindowId integer
---@field ViewportFlagsOverrideSet ImGuiViewportFlags|integer|"None"|"IsPlatformWindow"|"IsPlatformMonitor"|"OwnedByApp"|"NoDecoration"|"NoTaskBarIcon"|"NoFocusOnAppearing"|"NoFocusOnClick"|"NoInputs"|"NoRendererClear"|"NoAutoMerge"|"TopMost"|"CanHostOtherWindows"|"IsMinimized"|"IsFocused"
---@field ViewportFlagsOverrideClear ImGuiViewportFlags|integer|"None"|"IsPlatformWindow"|"IsPlatformMonitor"|"OwnedByApp"|"NoDecoration"|"NoTaskBarIcon"|"NoFocusOnAppearing"|"NoFocusOnClick"|"NoInputs"|"NoRendererClear"|"NoAutoMerge"|"TopMost"|"CanHostOtherWindows"|"IsMinimized"|"IsFocused"
---@field TabItemFlagsOverrideSet ImGuiTabItemFlags|integer|"None"|"UnsavedDocument"|"SetSelected"|"NoCloseWithMiddleMouseButton"|"NoPushId"|"NoTooltip"|"NoReorder"|"Leading"|"Trailing"|"NoAssumedClosure"
---@field DockNodeFlagsOverrideSet ImGuiDockNodeFlags|integer|"None"|"KeepAliveOnly"|"NoDockingOverCentralNode"|"PassthruCentralNode"|"NoDockingSplit"|"NoResize"|"AutoHideTabBar"|"NoUndocking"
---@field DockingAlwaysTabBar boolean
---@field DockingAllowUnclassed boolean

---@class ImPtrVector<T>
---@field get_Item fun(index: integer): `T` READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(vector: ImVector, stride: integer): nil READ-ONLY
---@field __new fun(size: integer, capacity: integer, data: lightuserdata, stride: integer): nil READ-ONLY
---@field Item `T`
---@field Size integer READ-ONLY
---@field Capacity integer READ-ONLY
---@field Data lightuserdata READ-ONLY

---@class ImVector
---@field Address fun(index: integer): lightuserdata READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(size: integer, capacity: integer, data: lightuserdata): nil READ-ONLY
---@field Size integer READ-ONLY
---@field Capacity integer READ-ONLY
---@field Data lightuserdata READ-ONLY

---@class ImVector<T>
---@field get_Item fun(index: integer): `T` READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(vector: ImVector): nil READ-ONLY
---@field __new fun(size: integer, capacity: integer, data: lightuserdata): nil READ-ONLY
---@field Item `T`
---@field Size integer READ-ONLY
---@field Capacity integer READ-ONLY
---@field Data lightuserdata READ-ONLY

---@class NullTerminatedString
---@field ToString fun(): string READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field GetType fun(): Type READ-ONLY

---@class RangeAccessorExtensions
---@field GetType fun(): Type READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY

---@class RangeAccessor<T>
---@field get_Item fun(index: integer): `T` READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(data: lightuserdata, count: integer): nil READ-ONLY
---@field Item `T`
---@field Count integer READ-ONLY

---@class RangePtrAccessor<T>
---@field get_Item fun(index: integer): `T` READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(data: lightuserdata, count: integer): nil READ-ONLY
---@field Item `T`
---@field Count integer READ-ONLY

---@class StbTexteditRow
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field x0 number
---@field x1 number
---@field baseline_y_delta number
---@field ymin number
---@field ymax number
---@field num_chars integer

---@class StbTexteditRowPtr
---@field get_x0 fun(): number READ-ONLY
---@field get_x1 fun(): number READ-ONLY
---@field get_baseline_y_delta fun(): number READ-ONLY
---@field get_ymin fun(): number READ-ONLY
---@field get_ymax fun(): number READ-ONLY
---@field get_num_chars fun(): integer READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field x0 number
---@field x1 number
---@field baseline_y_delta number
---@field ymin number
---@field ymax number
---@field num_chars integer

---@class StbUndoRecord
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field where integer
---@field insert_length integer
---@field delete_length integer
---@field char_storage integer

---@class StbUndoRecordPtr
---@field get_where fun(): integer READ-ONLY
---@field get_insert_length fun(): integer READ-ONLY
---@field get_delete_length fun(): integer READ-ONLY
---@field get_char_storage fun(): integer READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field where integer
---@field insert_length integer
---@field delete_length integer
---@field char_storage integer

---@class StbUndoState
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field undo_rec_0 StbUndoRecord
---@field undo_rec_1 StbUndoRecord
---@field undo_rec_2 StbUndoRecord
---@field undo_rec_3 StbUndoRecord
---@field undo_rec_4 StbUndoRecord
---@field undo_rec_5 StbUndoRecord
---@field undo_rec_6 StbUndoRecord
---@field undo_rec_7 StbUndoRecord
---@field undo_rec_8 StbUndoRecord
---@field undo_rec_9 StbUndoRecord
---@field undo_rec_10 StbUndoRecord
---@field undo_rec_11 StbUndoRecord
---@field undo_rec_12 StbUndoRecord
---@field undo_rec_13 StbUndoRecord
---@field undo_rec_14 StbUndoRecord
---@field undo_rec_15 StbUndoRecord
---@field undo_rec_16 StbUndoRecord
---@field undo_rec_17 StbUndoRecord
---@field undo_rec_18 StbUndoRecord
---@field undo_rec_19 StbUndoRecord
---@field undo_rec_20 StbUndoRecord
---@field undo_rec_21 StbUndoRecord
---@field undo_rec_22 StbUndoRecord
---@field undo_rec_23 StbUndoRecord
---@field undo_rec_24 StbUndoRecord
---@field undo_rec_25 StbUndoRecord
---@field undo_rec_26 StbUndoRecord
---@field undo_rec_27 StbUndoRecord
---@field undo_rec_28 StbUndoRecord
---@field undo_rec_29 StbUndoRecord
---@field undo_rec_30 StbUndoRecord
---@field undo_rec_31 StbUndoRecord
---@field undo_rec_32 StbUndoRecord
---@field undo_rec_33 StbUndoRecord
---@field undo_rec_34 StbUndoRecord
---@field undo_rec_35 StbUndoRecord
---@field undo_rec_36 StbUndoRecord
---@field undo_rec_37 StbUndoRecord
---@field undo_rec_38 StbUndoRecord
---@field undo_rec_39 StbUndoRecord
---@field undo_rec_40 StbUndoRecord
---@field undo_rec_41 StbUndoRecord
---@field undo_rec_42 StbUndoRecord
---@field undo_rec_43 StbUndoRecord
---@field undo_rec_44 StbUndoRecord
---@field undo_rec_45 StbUndoRecord
---@field undo_rec_46 StbUndoRecord
---@field undo_rec_47 StbUndoRecord
---@field undo_rec_48 StbUndoRecord
---@field undo_rec_49 StbUndoRecord
---@field undo_rec_50 StbUndoRecord
---@field undo_rec_51 StbUndoRecord
---@field undo_rec_52 StbUndoRecord
---@field undo_rec_53 StbUndoRecord
---@field undo_rec_54 StbUndoRecord
---@field undo_rec_55 StbUndoRecord
---@field undo_rec_56 StbUndoRecord
---@field undo_rec_57 StbUndoRecord
---@field undo_rec_58 StbUndoRecord
---@field undo_rec_59 StbUndoRecord
---@field undo_rec_60 StbUndoRecord
---@field undo_rec_61 StbUndoRecord
---@field undo_rec_62 StbUndoRecord
---@field undo_rec_63 StbUndoRecord
---@field undo_rec_64 StbUndoRecord
---@field undo_rec_65 StbUndoRecord
---@field undo_rec_66 StbUndoRecord
---@field undo_rec_67 StbUndoRecord
---@field undo_rec_68 StbUndoRecord
---@field undo_rec_69 StbUndoRecord
---@field undo_rec_70 StbUndoRecord
---@field undo_rec_71 StbUndoRecord
---@field undo_rec_72 StbUndoRecord
---@field undo_rec_73 StbUndoRecord
---@field undo_rec_74 StbUndoRecord
---@field undo_rec_75 StbUndoRecord
---@field undo_rec_76 StbUndoRecord
---@field undo_rec_77 StbUndoRecord
---@field undo_rec_78 StbUndoRecord
---@field undo_rec_79 StbUndoRecord
---@field undo_rec_80 StbUndoRecord
---@field undo_rec_81 StbUndoRecord
---@field undo_rec_82 StbUndoRecord
---@field undo_rec_83 StbUndoRecord
---@field undo_rec_84 StbUndoRecord
---@field undo_rec_85 StbUndoRecord
---@field undo_rec_86 StbUndoRecord
---@field undo_rec_87 StbUndoRecord
---@field undo_rec_88 StbUndoRecord
---@field undo_rec_89 StbUndoRecord
---@field undo_rec_90 StbUndoRecord
---@field undo_rec_91 StbUndoRecord
---@field undo_rec_92 StbUndoRecord
---@field undo_rec_93 StbUndoRecord
---@field undo_rec_94 StbUndoRecord
---@field undo_rec_95 StbUndoRecord
---@field undo_rec_96 StbUndoRecord
---@field undo_rec_97 StbUndoRecord
---@field undo_rec_98 StbUndoRecord
---@field undo_point integer
---@field redo_point integer
---@field undo_char_point integer
---@field redo_char_point integer

---@class StbUndoStatePtr
---@field get_undo_rec fun(): RangeAccessor<StbUndoRecord> READ-ONLY
---@field get_undo_char fun(): RangeAccessor<integer> READ-ONLY
---@field get_undo_point fun(): integer READ-ONLY
---@field get_redo_point fun(): integer READ-ONLY
---@field get_undo_char_point fun(): integer READ-ONLY
---@field get_redo_char_point fun(): integer READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field undo_rec RangeAccessor<StbUndoRecord>
---@field undo_char RangeAccessor<integer>
---@field undo_point integer
---@field redo_point integer
---@field undo_char_point integer
---@field redo_char_point integer

---@class STB_TexteditState
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field cursor integer
---@field select_start integer
---@field select_end integer
---@field insert_mode integer
---@field row_count_per_page integer
---@field cursor_at_end_of_line integer
---@field initialized integer
---@field has_preferred_x integer
---@field single_line integer
---@field padding1 integer
---@field padding2 integer
---@field padding3 integer
---@field preferred_x number
---@field undostate StbUndoState

---@class STB_TexteditStatePtr
---@field get_cursor fun(): integer READ-ONLY
---@field get_select_start fun(): integer READ-ONLY
---@field get_select_end fun(): integer READ-ONLY
---@field get_insert_mode fun(): integer READ-ONLY
---@field get_row_count_per_page fun(): integer READ-ONLY
---@field get_cursor_at_end_of_line fun(): integer READ-ONLY
---@field get_initialized fun(): integer READ-ONLY
---@field get_has_preferred_x fun(): integer READ-ONLY
---@field get_single_line fun(): integer READ-ONLY
---@field get_padding1 fun(): integer READ-ONLY
---@field get_padding2 fun(): integer READ-ONLY
---@field get_padding3 fun(): integer READ-ONLY
---@field get_preferred_x fun(): number READ-ONLY
---@field get_undostate fun(): StbUndoState READ-ONLY
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field __new fun(nativePtr: lightuserdata): nil READ-ONLY
---@field cursor integer
---@field select_start integer
---@field select_end integer
---@field insert_mode integer
---@field row_count_per_page integer
---@field cursor_at_end_of_line integer
---@field initialized integer
---@field has_preferred_x integer
---@field single_line integer
---@field padding1 integer
---@field padding2 integer
---@field padding3 integer
---@field preferred_x number
---@field undostate StbUndoState

---@class UnionValue
---@field Equals fun(obj: any): boolean READ-ONLY
---@field GetHashCode fun(): integer READ-ONLY
---@field ToString fun(): string READ-ONLY
---@field GetType fun(): Type READ-ONLY
---@field ValueI32 integer
---@field ValueF32 number
---@field ValuePtr lightuserdata
