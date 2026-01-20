local _t,_c = table.concat,string.char

-- ===== 키 설정 =====
local USER_KEY  = "100809"
local ADMIN_KEY = "lsh82541010"

-- ===== HWID + 만료시간 DB =====
-- os.time() 기준 (초)
-- https://www.epochconverter.com/ 에서 Unix Timestamp 생성
local HWID_DB = {
    -- ["HWID"] = 만료시간
    ["TEST_HWID"] = 1893456000, -- 예: 2030-01-01
}

-- ===== HWID 가져오기 =====
local function getHWID()
    if typeof(gethwid) == "function" then
        return gethwid()
    elseif typeof(getfingerprint) == "function" then
        return getfingerprint()
    elseif typeof(identifyexecutor) == "function" then
        return identifyexecutor()
    end
    return "UNKNOWN"
end

local HWID = getHWID()
local NOW  = os.time()

-- ===== Rayfield 로드 (문자열 분리) =====
local Rayfield = loadstring(game:HttpGet(_t({
    _c(104),_c(116),_c(116),_c(112),_c(115),_c(58),_c(47),_c(47),
    _c(115),_c(105),_c(114),_c(105),_c(117),_c(115),_c(46),
    _c(109),_c(101),_c(110),_c(117),_c(47),
    _c(114),_c(97),_c(121),_c(102),_c(105),_c(101),_c(108),_c(100)
})))()

-- ===== 윈도우 =====
local Window = Rayfield:CreateWindow({
    Name = "Korean Hub",
    LoadingTitle = "Security Check",
    LoadingSubtitle = "Key + HWID + Time",
    ConfigurationSaving = {Enabled = false},
    KeySystem = true,
    KeySettings = {
        Title = "키 인증",
        Subtitle = "키를 입력하세요",
        Note = "시간제 + HWID 시스템",
        SaveKey = false,
        GrabKeyFromSite = false,
        Key = {USER_KEY, ADMIN_KEY}
    }
})

-- ===== 키 판별 =====
local inputKey = Rayfield.Flags.KeySystemKey or ""
local isAdmin  = inputKey == ADMIN_KEY
local expire   = HWID_DB[HWID]

-- ===== 접근 제어 =====
if not isAdmin then
    if not expire then
        game.Players.LocalPlayer:Kick(
            "❌ 등록되지 않은 HWID\n\nHWID:\n"..HWID
        )
        return
    end

    if NOW > expire then
        game.Players.LocalPlayer:Kick(
            "⏰ 사용 기간 만료\n\nHWID:\n"..HWID
        )
        return
    end
end

-- ===== 관리자 정보 출력 =====
if isAdmin then
    warn("====== ADMIN ACCESS ======")
    warn("HWID:", HWID)
    warn("현재 시간:", NOW)
    warn("만료 시간:", expire or "미등록")
    warn("==========================")
end

-- ===== UI =====
local Tab = Window:CreateTab("Main", 4483362458)
Tab:CreateSection("Scripts")

Tab:CreateButton({
    Name = "TG Script 실행",
    Callback = function()
        loadstring(game:HttpGet(
            "https://cdn.robloxscripts.gg/public/furky/furky-*no-key*-steal-a-brainrot-script-or-infinite-brainrots-or-admin-commands-or-auto-steal-source.lua"
        ))()
    end
})

Rayfield:LoadConfiguration()
