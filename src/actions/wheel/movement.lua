-- Partially taken from [kusa's 1msthing plugin](https://github.com/Illuminati-CRAZ/1msthing), with minor changes to integrate into this codebase. Credits go to them.
-- The function below retains the same license as the rest of plumoguSV.
function kusaGeneralMovement(noteTransform)
    local notes = state.SelectedHitObjects
    local result = {}

    if not truthy(notes) then
        print('e!', 'You are not selecting any notes.')
        return false
    end

    for _, note in pairs(notes) do
        table.insert(result, noteTransform(note))
    end

    actions.PerformBatch({
        utils.CreateEditorAction(action_type.RemoveHitObjectBatch, notes),
        utils.CreateEditorAction(action_type.PlaceHitObjectBatch, result),
    })
    actions.SetHitObjectSelection(result)
    return true
end

function kusaMovementUp()
    local success = kusaGeneralMovement(
        function(note)
            return utils.CreateHitObject(
                note.StartTime + 1,
                note.Lane,
                note.EndTime == 0 and 0 or note.EndTime + 1,
                note.HitSound,
                note.EditorLayer,
                note.Type
            )
        end
    )
    if success then print('s!', 'Moved selected notes up by 1ms.') end
end

function kusaMovementRight()
    local success = kusaGeneralMovement(
        function(note)
            return utils.CreateHitObject(
                note.StartTime,
                note.Lane % game.keyCount + 1,
                note.EndTime,
                note.HitSound,
                note.EditorLayer,
                note.Type
            )
        end
    )
    if success then print('s!', 'Shifted selected notes one lane to the right.') end
end

function kusaMovementDown()
    local success = kusaGeneralMovement(
        function(note)
            return utils.CreateHitObject(
                note.StartTime - 1,
                note.Lane,
                note.EndTime == 0 and 0 or note.EndTime - 1,
                note.HitSound,
                note.EditorLayer,
                note.Type
            )
        end
    )
    if success then print('s!', 'Moved selected notes down by 1ms.') end
end

function kusaMovementLeft()
    local success = kusaGeneralMovement(
        function(note)
            return utils.CreateHitObject(
                note.StartTime,
                (note.Lane - 2 + game.keyCount) % game.keyCount + 1,
                note.EndTime,
                note.HitSound,
                note.EditorLayer,
                note.Type
            )
        end
    )
    if success then print('s!', 'Shifted selected notes one lane to the left.') end
end
