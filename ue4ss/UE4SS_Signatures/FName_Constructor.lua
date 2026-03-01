-- FName::FName(wchar_t const *, enum EFindName) for UE 5.7
-- Direct scan of function prologue + wchar_t processing entry
function Register()
    return "48 89 5C 24 08 57 48 83 EC 30 48 8B D9 48 89 54 24 20 33 C9 41 8B F8 4C 8B D2 44 8B C9 48 85 D2"
end

function OnMatchFound(MatchAddress)
    return MatchAddress
end
