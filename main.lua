--$Name:Am I a Monster?$
--$Name(ru):Я -- монстр?$
--$Version:1.04$
--$Author:NLB project$
instead_version '2.3.0'

--package.cpath = './?.so'
require 'luapassing'

require 'prefs'
require 'xact'
require 'nouse'
require 'hideinv'
--require 'para'
require 'dash'
require 'snapshots'
require 'theme'
require 'timer'
require 'modules/nlb'
require 'modules/fonts'
require 'modules/paginator'
require 'modules/vn'
require 'modules/gobj'
game.codepage='UTF-8';
stead.scene_delim = '^';

game.act = function() nlb:curloc().lasttext = 'Nothing happens.'; p(nlb:curloc().lasttext); nlb:curloc().wastext = true; end;
game.inv = function() nlb:curloc().lasttext = 'Hm... This is strange thing...'; p(nlb:curloc().lasttext); nlb:curloc().wastext = true; end;
game.nouse = function() nlb:curloc().lasttext = 'Does not work...'; p(nlb:curloc().lasttext); nlb:curloc().wastext = true; end;
game.forcedsc = false;
paginator.delim = '\n[ \t]*\n'
function exec(s)
    p('$'..s:gsub('\n', '^')..'$^^')
end
function init()
    statsAPI.init();
    if dice then
        paginator:set_onproceed(function()
            dice:hide(true);
            -- Use code below if you want smooth rollout animation and text change on next step
            --if dice:hide() then
            --    return
            --end
        end);
    end
    vn:scene(nil);
    nlbticks = stead.ticks();
    _export_lang = 'en';
    _syscall_showmenubtn:act();
    format.quotes = false;
    if not prefs.achievements_max then
        prefs.achievements_max = {};
    end
    if not prefs.achievements_ids then
        prefs.achievements_ids = {};
    end
    if not prefs.achievements_ids['MAIN_MENU'] then prefs.achievements_ids['MAIN_MENU'] = {}; end;
    prefs:store();
    nlb:resendAchievements(statsAPI);
    initializeVariables();
end

_version_obj = gobj {
    nam = 'version_obj',
    system_type = true,
    pic = 'gfx/version.png',
    txtfn = function(s) return { [1] = {['text'] = '1.04', ['color'] = 'white' } }; end,
    eff = 'left-top@0,0',
    iarm = {[0] = {0, 16}}

}

-- In INSTEAD, when using the snapshots module, you will run into unpredictable behaviour if the variable is not initialized yet.
-- More specifically, if the value is nil, it won't be included in the snapshot & therefore will not be overwritten when the snapshot is loaded.
-- So, for example, if the flag was initially nil, then you make snapshot, then you walked into location which sets this flag to true,
-- than when loading the snapshot the value of the flag will NOT change back to nil.
-- That's why we should initialize all nil variables on start (so that they equal false or 0 or '', but not nil).
function initializeVariables()
    if _version_holder_obj == nil then
        _version_holder_obj = false;
    end
    if _seen_main_menu == nil then
        _seen_main_menu = 0;
    end
    if _back2menu == nil then
        _back2menu = false;
    end
    if _credits == nil then
        _credits = false;
    end
    if _intro == nil then
        _intro = false;
    end
    if _our_games == nil then
        _our_games = false;
    end
end

-- optionsOutObj
v_5943beec_862b_406c_b4fc_ae4a8f03a21e = gobj {
    var { tag = ''; container = function() return v_61e7589b_f548_44d5_b3f3_fe1c7136c3c8; end; },
    nlbid = '5943beec-862b-406c-b4fc-ae4a8f03a21e',
    deref = function(s) return stead.deref(v_5943beec_862b_406c_b4fc_ae4a8f03a21e); end,
    nam = 'optionsOutObj',
    eff = 'middle-middle@231,110',
    morphover = function(s) return v_92f6f6a4_04f6_4aa7_a75c_59a1acdea2da:deref(); end,
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) end,
    dsc = function(s) return s.dscf(s); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
    end,
    pic = function(s)
        if (true) then
            return 'images/options.png';

        end
end,
    imgv = function(s) return img(s.pic(s)); end,
};

_optionsOutObj = v_5943beec_862b_406c_b4fc_ae4a8f03a21e
-- nlblogo_in
v_d4b18a63_4da0_4b5b_ab8a_3da3f6dc16bf = gobj {
    var { tag = ''; container = function() return v_da36b7de_b2fd_46c9_a9cf_5e253cc445dc; end; },
    nlbid = 'd4b18a63-4da0-4b5b-ab8a-3da3f6dc16bf',
    deref = function(s) return stead.deref(v_d4b18a63_4da0_4b5b_ab8a_3da3f6dc16bf); end,
    nam = 'nlblogo_in',
    eff = 'fadein-middle-middle@0,0',
    maxStep = 68,
    startFrame = 0,
    curStep = 0,
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) end,
    dsc = function(s) return s.dscf(s); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
    end,
    pic = function(s)
        if (true) then
            return 'images/nlblogo.png';

        end
end,
    imgv = function(s) return img(s.pic(s)); end,
};

_nlblogo_in = v_d4b18a63_4da0_4b5b_ab8a_3da3f6dc16bf
-- back2menuObj
v_bb4991ef_0c52_45a7_92f9_10ade18afaef = nlbmenu {
    var { tag = ''; container = function() return nil; end; },
    nlbid = 'bb4991ef-0c52-45a7-92f9-10ade18afaef',
    deref = function(s) return stead.deref(v_bb4991ef_0c52_45a7_92f9_10ade18afaef); end,
    nam = 'back2menuObj',
    snd = function(s) 
    end,
    disp = function(s) return "Back" end,
    dscf = function(s) end,
    dsc = function(s) p(s.dscf(s)); end,
    tak = function(s)
        s.act(s);
        return true;
    end,
    menu = function(s)
        return s.act(s);
    end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
    end,
    actt = function(s)
        return "Back";
    end,
    actp = function(s)
        nlb:curloc().lasttext = s.actt(s); p(nlb:curloc().lasttext); nlb:curloc().wastext = true;
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
_back2menu =  true ;
    end,
};

_back2menuObj = v_bb4991ef_0c52_45a7_92f9_10ade18afaef
-- russianOutObj
v_da368deb_0207_479b_96ba_87b1c1ae4159 = gobj {
    var { tag = ''; container = function() return v_61e7589b_f548_44d5_b3f3_fe1c7136c3c8; end; },
    nlbid = 'da368deb-0207-479b-96ba-87b1c1ae4159',
    deref = function(s) return stead.deref(v_da368deb_0207_479b_96ba_87b1c1ae4159); end,
    nam = 'russianOutObj',
    eff = 'middle-middle@462,-290',
    morphover = function(s) return v_f3c09bc0_96f8_424a_9f3c_e7621f1dde98:deref(); end,
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) end,
    dsc = function(s) return s.dscf(s); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
    end,
    pic = function(s)
        if (true) then
            return 'images/russian.png';

        end
end,
    imgv = function(s) return img(s.pic(s)); end,
};

_russianOutObj = v_da368deb_0207_479b_96ba_87b1c1ae4159
-- loadGameOverObj
v_4965a77e_89c1_489d_ac34_00fd06266729 = gobj {
    var { tag = ''; container = function() return nil; end; },
    nlbid = '4965a77e-89c1-489d-ac34-00fd06266729',
    deref = function(s) return stead.deref(v_4965a77e_89c1_489d_ac34_00fd06266729); end,
    nam = 'loadGameOverObj',
    eff = 'middle-middle@305,-158',
    morphout = function(s) return v_26baf5c3_7f9d_4b4d_b956_5cd3774c114c:deref(); end,
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) end,
    dsc = function(s) return s.dscf(s); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
nlb:actf(_syscall_menu_load);
    end,
    pic = function(s)
        if (true) then
            return 'images/load_game_over.png';

        end
end,
    imgv = function(s) return img(s.pic(s)); end,
};

_loadGameOverObj = v_4965a77e_89c1_489d_ac34_00fd06266729
-- 
v_1ad8b242_09f7_416d_87c6_10db7318648e = nlbobj {
    var { tag = ''; container = function() return v_b097ad4f_f32d_41d7_acb9_b69632ce070c; end; },
    nlbid = '1ad8b242-09f7-416d-87c6-10db7318648e',
    deref = function(s) return stead.deref(v_1ad8b242_09f7_416d_87c6_10db7318648e); end,
    nam = 'v_1ad8b242_09f7_416d_87c6_10db7318648e',
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) return "^"..
"^"..
"== Software ==^"..
"INSTEAD^"..
"Simple Text Adventure, The Interpreter^"..
"For Unix and Windows^"..
"{http://instead.syscall.ru}"; end,
    dsc = function(s) p(s.dscf(s)); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
statsAPI.openURL("http://instead.syscall.ru");
    end,
};

-- englishOverObj
v_ca290951_f649_459c_bd23_d04a26667e5b = gobj {
    var { tag = ''; container = function() return nil; end; },
    nlbid = 'ca290951-f649-459c-bd23-d04a26667e5b',
    deref = function(s) return stead.deref(v_ca290951_f649_459c_bd23_d04a26667e5b); end,
    nam = 'englishOverObj',
    eff = 'middle-middle@468,-426',
    morphout = function(s) return v_248ae96e_a969_4583_b4e6_16215496a13e:deref(); end,
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) end,
    dsc = function(s) return s.dscf(s); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
nlb:actf(_syscall_starten);
    end,
    pic = function(s)
        if (true) then
            return 'images/english_over.png';

        end
end,
    imgv = function(s) return img(s.pic(s)); end,
};

_englishOverObj = v_ca290951_f649_459c_bd23_d04a26667e5b
-- 
v_b9ed2c0a_31f4_4241_bc2c_740ae1206fce = nlbobj {
    var { tag = ''; container = function() return v_6104baf7_01b3_4e7b_9eba_1377f12009a7; end; },
    nlbid = 'b9ed2c0a-31f4-4241-bc2c-740ae1206fce',
    deref = function(s) return stead.deref(v_b9ed2c0a_31f4_4241_bc2c_740ae1206fce); end,
    nam = 'v_b9ed2c0a_31f4_4241_bc2c_740ae1206fce',
    snd = function(s) 
    end,
    disp = function(s) return s.imgv(s).."" end,
    dscf = function(s) return "^"..
"{"..s.imgv(s).."    The Adventurous Four}^"..
"It is the sequel to the visual novel \"Wild Island Quest\". You will have to go on a journey full of dangers and adventures, where the main characters are young people connected by their solid friendship."; end,
    dsc = function(s) p(s.dscf(s)); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
    end,
    actt = function(s)
        return "The Adventurous Four";
    end,
    actp = function(s)
        nlb:curloc().lasttext = s.actt(s); p(nlb:curloc().lasttext); nlb:curloc().wastext = true;
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
statsAPI.openURL("https://store.steampowered.com/app/815070/The_Adventurous_Four/");
    end,
    pic = function(s)
        if (true) then
            return 'images/advfour.jpg';

        end
end,
    imgv = function(s) return img(s.pic(s)); end,
};

-- loadGameOutObj
v_26baf5c3_7f9d_4b4d_b956_5cd3774c114c = gobj {
    var { tag = ''; container = function() return v_61e7589b_f548_44d5_b3f3_fe1c7136c3c8; end; },
    nlbid = '26baf5c3-7f9d-4b4d-b956-5cd3774c114c',
    deref = function(s) return stead.deref(v_26baf5c3_7f9d_4b4d_b956_5cd3774c114c); end,
    nam = 'loadGameOutObj',
    eff = 'middle-middle@305,-158',
    morphover = function(s) return v_4965a77e_89c1_489d_ac34_00fd06266729:deref(); end,
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) end,
    dsc = function(s) return s.dscf(s); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
    end,
    pic = function(s)
        if (true) then
            return 'images/load_game.png';

        end
end,
    imgv = function(s) return img(s.pic(s)); end,
};

_loadGameOutObj = v_26baf5c3_7f9d_4b4d_b956_5cd3774c114c
-- creditsOutObj
v_b476964e_29f8_4a1f_af08_73765a6b92d3 = gobj {
    var { tag = ''; container = function() return v_61e7589b_f548_44d5_b3f3_fe1c7136c3c8; end; },
    nlbid = 'b476964e-29f8-4a1f-af08-73765a6b92d3',
    deref = function(s) return stead.deref(v_b476964e_29f8_4a1f_af08_73765a6b92d3); end,
    nam = 'creditsOutObj',
    eff = 'middle-middle@239,-26',
    morphover = function(s) return v_a109d8ab_90cf_46cd_9a4d_18c7f908b704:deref(); end,
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) end,
    dsc = function(s) return s.dscf(s); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
    end,
    pic = function(s)
        if (true) then
            return 'images/credits.png';

        end
end,
    imgv = function(s) return img(s.pic(s)); end,
};

_creditsOutObj = v_b476964e_29f8_4a1f_af08_73765a6b92d3
-- 
v_d9cc21f5_f95b_4300_8971_1733183e1ab9 = nlbobj {
    var { tag = ''; container = function() return v_6104baf7_01b3_4e7b_9eba_1377f12009a7; end; },
    nlbid = 'd9cc21f5-f95b-4300-8971-1733183e1ab9',
    deref = function(s) return stead.deref(v_d9cc21f5_f95b_4300_8971_1733183e1ab9); end,
    nam = 'v_d9cc21f5_f95b_4300_8971_1733183e1ab9',
    snd = function(s) 
    end,
    disp = function(s) return s.imgv(s).."" end,
    dscf = function(s) return "^^"..
"{"..s.imgv(s).."    Return of Red Riding Hood Enhanced Edition}^"..
"It is a visual novel with elements of a text adventure quest. The main characters keep getting into funny situations, and how they\'re going to find their way out depends on you."; end,
    dsc = function(s) p(s.dscf(s)); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
    end,
    actt = function(s)
        return "Return of Red Riding Hood Enhanced Edition";
    end,
    actp = function(s)
        nlb:curloc().lasttext = s.actt(s); p(nlb:curloc().lasttext); nlb:curloc().wastext = true;
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
statsAPI.openURL("http://store.steampowered.com/app/594320/Return_of_Red_Riding_Hood_Enhanced_Edition/");
    end,
    pic = function(s)
        if (true) then
            return 'images/red_hood.jpg';

        end
end,
    imgv = function(s) return img(s.pic(s)); end,
};

-- 
v_cc5ebee8_54ee_438a_8468_3811c4e57291 = nlbobj {
    var { tag = ''; container = function() return v_b097ad4f_f32d_41d7_acb9_b69632ce070c; end; },
    nlbid = 'cc5ebee8-54ee-438a-8468-3811c4e57291',
    deref = function(s) return stead.deref(v_cc5ebee8_54ee_438a_8468_3811c4e57291); end,
    nam = 'v_cc5ebee8_54ee_438a_8468_3811c4e57291',
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) return "== Text ==^"..
"NLB project team.^"..
"Special thanks for English translation proofreading: Christine Ewert."; end,
    dsc = function(s) p(s.dscf(s)); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
    end,
};

-- ourGamesOutObj
v_ec014653_9193_4399_8185_eea017b96b35 = gobj {
    var { tag = ''; container = function() return v_61e7589b_f548_44d5_b3f3_fe1c7136c3c8; end; },
    nlbid = 'ec014653-9193-4399-8185-eea017b96b35',
    deref = function(s) return stead.deref(v_ec014653_9193_4399_8185_eea017b96b35); end,
    nam = 'ourGamesOutObj',
    eff = 'left-top@1500,630',
    morphover = function(s) return v_55c9b789_a33a_47df_8d37_5b7dcca7f989:deref(); end,
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) end,
    dsc = function(s) return s.dscf(s); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
    end,
    pic = function(s)
        if (true) then
            return 'images/our_games.png';

        end
end,
    imgv = function(s) return img(s.pic(s)); end,
};

_ourGamesOutObj = v_ec014653_9193_4399_8185_eea017b96b35
-- 
v_7d6ef07f_a9e9_4f34_88f3_d26ac88dde55 = nlbobj {
    var { tag = ''; container = function() return v_b097ad4f_f32d_41d7_acb9_b69632ce070c; end; },
    nlbid = '7d6ef07f-a9e9-4f34-88f3-d26ac88dde55',
    deref = function(s) return stead.deref(v_7d6ef07f_a9e9_4f34_88f3_d26ac88dde55); end,
    nam = 'v_7d6ef07f_a9e9_4f34_88f3_d26ac88dde55',
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) return "^"..
"^"..
"GIMP^"..
"GNU Image Manipulation Program^"..
"{https://www.gimp.org/}"; end,
    dsc = function(s) p(s.dscf(s)); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
statsAPI.openURL("https://www.gimp.org/");
    end,
};

-- version_holder_obj
v_43243a00_7e14_49eb_a1b7_afbad9eb6df2 = gobj {
    var { tag = ''; container = function() return v_61e7589b_f548_44d5_b3f3_fe1c7136c3c8; end; },
    nlbid = '43243a00-7e14-49eb-a1b7-afbad9eb6df2',
    deref = function(s) return stead.deref(v_43243a00_7e14_49eb_a1b7_afbad9eb6df2); end,
    nam = 'version_holder_obj',
    eff = 'left-bottom@0,0',
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) end,
    dsc = function(s) return s.dscf(s); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
    end,
    pic = function(s)
        if (true) then
            return 'images/version_holder.png';

        end
end,
    imgv = function(s) return img(s.pic(s)); end,
};

_version_holder_obj = v_43243a00_7e14_49eb_a1b7_afbad9eb6df2
-- presents_out
v_3978214c_072b_44e9_92e9_a9749927b2c0 = gobj {
    var { tag = ''; container = function() return v_a135a9ec_65be_4774_b2c5_14e06026385c; end; },
    nlbid = '3978214c-072b-44e9-92e9-a9749927b2c0',
    deref = function(s) return stead.deref(v_3978214c_072b_44e9_92e9_a9749927b2c0); end,
    nam = 'presents_out',
    eff = 'fadeout-middle-middle@0,0',
    maxStep = 68,
    startFrame = 0,
    curStep = 0,
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) end,
    dsc = function(s) return s.dscf(s); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
    end,
    pic = function(s)
        if (true) then
            return 'images/presents.png';

        end
end,
    imgv = function(s) return img(s.pic(s)); end,
};

_presents_out = v_3978214c_072b_44e9_92e9_a9749927b2c0
-- 
v_4acb3d44_760b_47a3_bbde_a3624251f799 = nlbobj {
    var { tag = ''; container = function() return v_b097ad4f_f32d_41d7_acb9_b69632ce070c; end; },
    nlbid = '4acb3d44-760b-47a3-bbde-a3624251f799',
    deref = function(s) return stead.deref(v_4acb3d44_760b_47a3_bbde_a3624251f799); end,
    nam = 'v_4acb3d44_760b_47a3_bbde_a3624251f799',
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) return "^"..
"^"..
"== Font ==^"..
"Steinem Unicode^"..
"© 2001 Apostrophic Labs. All rights reserved.^"..
"Free for commercial use.^"..
"{http://www.1001fonts.com/steinem-font.html}"; end,
    dsc = function(s) p(s.dscf(s)); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
statsAPI.openURL("http://www.1001fonts.com/steinem-font.html");
    end,
};

-- nlblogo_out
v_60e27336_12ef_4702_b1cb_d9b822a36fcc = gobj {
    var { tag = ''; container = function() return v_5bd37bb6_9454_4388_b33d_291d4ccd20ce; end; },
    nlbid = '60e27336-12ef-4702-b1cb-d9b822a36fcc',
    deref = function(s) return stead.deref(v_60e27336_12ef_4702_b1cb_d9b822a36fcc); end,
    nam = 'nlblogo_out',
    eff = 'fadeout-middle-middle@0,0',
    maxStep = 68,
    startFrame = 0,
    curStep = 0,
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) end,
    dsc = function(s) return s.dscf(s); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
    end,
    pic = function(s)
        if (true) then
            return 'images/nlblogo.png';

        end
end,
    imgv = function(s) return img(s.pic(s)); end,
};

_nlblogo_out = v_60e27336_12ef_4702_b1cb_d9b822a36fcc
-- 
v_66edebcb_50ca_4edb_89e3_bdd513cfcfd0 = nlbobj {
    var { tag = ''; container = function() return v_6104baf7_01b3_4e7b_9eba_1377f12009a7; end; },
    nlbid = '66edebcb-50ca-4edb-89e3-bdd513cfcfd0',
    deref = function(s) return stead.deref(v_66edebcb_50ca_4edb_89e3_bdd513cfcfd0); end,
    nam = 'v_66edebcb_50ca_4edb_89e3_bdd513cfcfd0',
    snd = function(s) 
    end,
    disp = function(s) return s.imgv(s).."" end,
    dscf = function(s) return "^^"..
"{"..s.imgv(s).."    Wild Island Quest}^"..
"It is visual novel about traveling teenagers on a dangerous flying island."; end,
    dsc = function(s) p(s.dscf(s)); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
    end,
    actt = function(s)
        return "Wild Island Quest";
    end,
    actp = function(s)
        nlb:curloc().lasttext = s.actt(s); p(nlb:curloc().lasttext); nlb:curloc().wastext = true;
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
statsAPI.openURL("http://store.steampowered.com/app/392820/Wild_Island_Quest/");
    end,
    pic = function(s)
        if (true) then
            return 'images/wild_island_quest.jpg';

        end
end,
    imgv = function(s) return img(s.pic(s)); end,
};

-- ourGamesOverObj
v_55c9b789_a33a_47df_8d37_5b7dcca7f989 = gobj {
    var { tag = ''; container = function() return nil; end; },
    nlbid = '55c9b789-a33a-47df-8d37-5b7dcca7f989',
    deref = function(s) return stead.deref(v_55c9b789_a33a_47df_8d37_5b7dcca7f989); end,
    nam = 'ourGamesOverObj',
    eff = 'left-top@1500,630',
    morphout = function(s) return v_ec014653_9193_4399_8185_eea017b96b35:deref(); end,
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) end,
    dsc = function(s) return s.dscf(s); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
_our_games = true;
    end,
    pic = function(s)
        if (true) then
            return 'images/our_games_over.png';

        end
end,
    imgv = function(s) return img(s.pic(s)); end,
};

_ourGamesOverObj = v_55c9b789_a33a_47df_8d37_5b7dcca7f989
-- exitOutObj
v_aaa5f6c7_a75d_4599_a519_00ee5977ba7d = gobj {
    var { tag = ''; container = function() return v_61e7589b_f548_44d5_b3f3_fe1c7136c3c8; end; },
    nlbid = 'aaa5f6c7-a75d-4599-a519-00ee5977ba7d',
    deref = function(s) return stead.deref(v_aaa5f6c7_a75d_4599_a519_00ee5977ba7d); end,
    nam = 'exitOutObj',
    eff = 'middle-middle@144,244',
    morphover = function(s) return v_7069e536_c763_4098_ad91_8f25c74280c9:deref(); end,
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) end,
    dsc = function(s) return s.dscf(s); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
    end,
    pic = function(s)
        if (true) then
            return 'images/exit.png';

        end
end,
    imgv = function(s) return img(s.pic(s)); end,
};

_exitOutObj = v_aaa5f6c7_a75d_4599_a519_00ee5977ba7d
-- exitOverObj
v_7069e536_c763_4098_ad91_8f25c74280c9 = gobj {
collapsable = true,
    var { tag = ''; container = function() return nil; end; },
    nlbid = '7069e536-c763-4098-ad91-8f25c74280c9',
    deref = function(s) return stead.deref(v_7069e536_c763_4098_ad91_8f25c74280c9); end,
    nam = 'exitOverObj',
    eff = 'middle-middle@144,244',
    morphout = function(s) return v_aaa5f6c7_a75d_4599_a519_00ee5977ba7d:deref(); end,
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) end,
    dsc = function(s) return s.dscf(s); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
nlb:actf(_syscall_menu_exit);
        local v = vn:glookup(stead.deref(s));
        if s.is_paused then
            vn:vpause(v, false);
        else
            vn:set_step(v, nil, not v.forward);
        end
        vn:start();
    end,
    pic = function(s)
        if (true) then
            return 'images/exit_over.png';

        end
end,
    imgv = function(s) return img(s.pic(s)); end,
};

_exitOverObj = v_7069e536_c763_4098_ad91_8f25c74280c9
-- 
v_84ae1bd1_458c_405a_bba8_f7bdd996b682 = nlbobj {
    var { tag = ''; container = function() return v_b097ad4f_f32d_41d7_acb9_b69632ce070c; end; },
    nlbid = '84ae1bd1-458c-405a-bba8-f7bdd996b682',
    deref = function(s) return stead.deref(v_84ae1bd1_458c_405a_bba8_f7bdd996b682); end,
    nam = 'v_84ae1bd1_458c_405a_bba8_f7bdd996b682',
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) return "^"..
"^"..
"== Music ==^"..
"CLOUDJUMPER: A full mind ({https://www.jamendo.com/album/136651/a-full-mind})"; end,
    dsc = function(s) p(s.dscf(s)); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
statsAPI.openURL("https://www.jamendo.com/album/136651/a-full-mind");
    end,
};

-- 
v_107b0bce_dc04_4bf4_bd03_7c046cbe71e9 = nlbobj {
    var { tag = ''; container = function() return v_b097ad4f_f32d_41d7_acb9_b69632ce070c; end; },
    nlbid = '107b0bce-dc04-4bf4-bd03-7c046cbe71e9',
    deref = function(s) return stead.deref(v_107b0bce_dc04_4bf4_bd03_7c046cbe71e9); end,
    nam = 'v_107b0bce_dc04_4bf4_bd03_7c046cbe71e9',
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) return "^"..
"^"..
"Audacity^"..
"free, open source, cross-platform audio software^"..
"for multi-track recording and editing.^"..
"{https://www.audacityteam.org/}"; end,
    dsc = function(s) p(s.dscf(s)); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
statsAPI.openURL("https://www.audacityteam.org/");
    end,
};

-- russianOverObj
v_f3c09bc0_96f8_424a_9f3c_e7621f1dde98 = gobj {
    var { tag = ''; container = function() return nil; end; },
    nlbid = 'f3c09bc0-96f8-424a-9f3c-e7621f1dde98',
    deref = function(s) return stead.deref(v_f3c09bc0_96f8_424a_9f3c_e7621f1dde98); end,
    nam = 'russianOverObj',
    eff = 'middle-middle@462,-290',
    morphout = function(s) return v_da368deb_0207_479b_96ba_87b1c1ae4159:deref(); end,
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) end,
    dsc = function(s) return s.dscf(s); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
nlb:actf(_syscall_startru);
    end,
    pic = function(s)
        if (true) then
            return 'images/russian_over.png';

        end
end,
    imgv = function(s) return img(s.pic(s)); end,
};

_russianOverObj = v_f3c09bc0_96f8_424a_9f3c_e7621f1dde98
-- 
v_30075339_496a_4485_b7f9_7ec28907472d = nlbobj {
    var { tag = ''; container = function() return v_b097ad4f_f32d_41d7_acb9_b69632ce070c; end; },
    nlbid = '30075339-496a-4485-b7f9-7ec28907472d',
    deref = function(s) return stead.deref(v_30075339_496a_4485_b7f9_7ec28907472d); end,
    nam = 'v_30075339_496a_4485_b7f9_7ec28907472d',
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) return "^"..
"SMILING CYNIC: Beat me ({https://www.jamendo.com/track/1098237/beat-me})"; end,
    dsc = function(s) p(s.dscf(s)); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
statsAPI.openURL("https://www.jamendo.com/track/1098237/beat-me");
    end,
};

-- skipObj
v_04d2f69b_7b46_45ab_854d_dbb230454344 = gobj {
preserved = true,
    var { tag = ''; container = function() return v_da36b7de_b2fd_46c9_a9cf_5e253cc445dc; end; },
    nlbid = '04d2f69b-7b46-45ab-854d-dbb230454344',
    actonkey = function(s, down, key)
        if down then
            s:actf();
        end
        return down;
    end,
    deref = function(s) return stead.deref(v_04d2f69b_7b46_45ab_854d_dbb230454344); end,
    nam = 'skipObj',
    eff = 'right-top@0',
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) end,
    dsc = function(s) return s.dscf(s); end,
    alive = function(s)
        return (_intro) and s:cont_alive();
    end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
_intro =  false ;
nlb:nlbwalk(nil, v_61e7589b_f548_44d5_b3f3_fe1c7136c3c8);
    end,
    pic = function(s)
        if (true) then
            return 'images/skip.png';

        end
end,
    imgv = function(s) return img(s.pic(s)); end,
};

lifeon('v_04d2f69b_7b46_45ab_854d_dbb230454344');
_skipObj = v_04d2f69b_7b46_45ab_854d_dbb230454344
-- 
v_930585ec_bbe5_473b_acd4_ed6f3a2605d7 = nlbobj {
    var { tag = ''; container = function() return v_b097ad4f_f32d_41d7_acb9_b69632ce070c; end; },
    nlbid = '930585ec-bbe5-473b-acd4-ed6f3a2605d7',
    deref = function(s) return stead.deref(v_930585ec_bbe5_473b_acd4_ed6f3a2605d7); end,
    nam = 'v_930585ec_bbe5_473b_acd4_ed6f3a2605d7',
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) return "^"..
"^"..
"Non-Linear Book Builder^"..
"Open Source tool for making interactive stories^"..
"{https://nlbproject.com/soft.html}"; end,
    dsc = function(s) p(s.dscf(s)); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
statsAPI.openURL("https://nlbproject.com/soft.html");
    end,
};

-- 
v_fdc08234_89c5_4dd2_a57b_026bc07e86f0 = nlbobj {
    var { tag = ''; container = function() return v_b097ad4f_f32d_41d7_acb9_b69632ce070c; end; },
    nlbid = 'fdc08234-89c5-4dd2-a57b-026bc07e86f0',
    deref = function(s) return stead.deref(v_fdc08234_89c5_4dd2_a57b_026bc07e86f0); end,
    nam = 'v_fdc08234_89c5_4dd2_a57b_026bc07e86f0',
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) return "^"..
"^"..
"MakeHuman^"..
"Open Source tool for making 3D characters^"..
"{http://www.makehuman.org/}"; end,
    dsc = function(s) p(s.dscf(s)); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
statsAPI.openURL("http://www.makehuman.org/");
    end,
};

-- 
v_ea3ebcd0_9c6e_405b_baee_53e8eb790c52 = nlbobj {
    var { tag = ''; container = function() return v_b097ad4f_f32d_41d7_acb9_b69632ce070c; end; },
    nlbid = 'ea3ebcd0-9c6e-405b-baee-53e8eb790c52',
    deref = function(s) return stead.deref(v_ea3ebcd0_9c6e_405b_baee_53e8eb790c52); end,
    nam = 'v_ea3ebcd0_9c6e_405b_baee_53e8eb790c52',
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) return "^"..
"LUKHASH: Failure ({https://www.jamendo.com/track/434107/failure-lukhash-com})"; end,
    dsc = function(s) p(s.dscf(s)); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
statsAPI.openURL("https://www.jamendo.com/track/434107/failure-lukhash-com");
    end,
};

-- 
v_bc8d220d_d651_4995_998f_2ec6e5f09552 = nlbobj {
    var { tag = ''; container = function() return v_b097ad4f_f32d_41d7_acb9_b69632ce070c; end; },
    nlbid = 'bc8d220d-d651-4995-998f-2ec6e5f09552',
    deref = function(s) return stead.deref(v_bc8d220d_d651_4995_998f_2ec6e5f09552); end,
    nam = 'v_bc8d220d_d651_4995_998f_2ec6e5f09552',
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) return "^"..
"IN LIMBO \91ROCK PROG\93: Reminiscences ({https://www.jamendo.com/track/1080505/reminiscences})"; end,
    dsc = function(s) p(s.dscf(s)); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
statsAPI.openURL("https://www.jamendo.com/track/1080505/reminiscences");
    end,
};

-- 
v_eb58dab3_3e56_427d_ae99_787b986dfe72 = nlbobj {
    var { tag = ''; container = function() return v_6104baf7_01b3_4e7b_9eba_1377f12009a7; end; },
    nlbid = 'eb58dab3-3e56-427d-ae99-787b986dfe72',
    deref = function(s) return stead.deref(v_eb58dab3_3e56_427d_ae99_787b986dfe72); end,
    nam = 'v_eb58dab3_3e56_427d_ae99_787b986dfe72',
    snd = function(s) 
    end,
    disp = function(s) return s.imgv(s).."" end,
    dscf = function(s) return "^^"..
"{"..s.imgv(s).."    The Barbarian and the Subterranean Caves}^"..
"It is an adventure themed visual novel, where you\'ll have to make lots of choices and follow many different branching paths to know the full story and unmask the evildoer."; end,
    dsc = function(s) p(s.dscf(s)); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
    end,
    actt = function(s)
        return "The Barbarian and the Subterranean Caves";
    end,
    actp = function(s)
        nlb:curloc().lasttext = s.actt(s); p(nlb:curloc().lasttext); nlb:curloc().wastext = true;
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
statsAPI.openURL("http://store.steampowered.com/app/490690/The_Barbarian_and_the_Subterranean_Caves/");
    end,
    pic = function(s)
        if (true) then
            return 'images/the_barbarian.jpg';

        end
end,
    imgv = function(s) return img(s.pic(s)); end,
};

-- presents_in
v_0b66da23_7a3d_4bd9_a9a6_b3bfd8e0c58b = gobj {
    var { tag = ''; container = function() return v_fbf46ec7_9f51_49a7_8d60_d351d70a2ac1; end; },
    nlbid = '0b66da23-7a3d-4bd9-a9a6-b3bfd8e0c58b',
    deref = function(s) return stead.deref(v_0b66da23_7a3d_4bd9_a9a6_b3bfd8e0c58b); end,
    nam = 'presents_in',
    eff = 'fadein-middle-middle@0,0',
    maxStep = 68,
    startFrame = 0,
    curStep = 0,
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) end,
    dsc = function(s) return s.dscf(s); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
    end,
    pic = function(s)
        if (true) then
            return 'images/presents.png';

        end
end,
    imgv = function(s) return img(s.pic(s)); end,
};

_presents_in = v_0b66da23_7a3d_4bd9_a9a6_b3bfd8e0c58b
-- optionsOverObj
v_92f6f6a4_04f6_4aa7_a75c_59a1acdea2da = gobj {
    var { tag = ''; container = function() return nil; end; },
    nlbid = '92f6f6a4-04f6-4aa7-a75c-59a1acdea2da',
    deref = function(s) return stead.deref(v_92f6f6a4_04f6_4aa7_a75c_59a1acdea2da); end,
    nam = 'optionsOverObj',
    eff = 'middle-middle@231,110',
    morphout = function(s) return v_5943beec_862b_406c_b4fc_ae4a8f03a21e:deref(); end,
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) end,
    dsc = function(s) return s.dscf(s); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
nlb:actf(_syscall_menu);
    end,
    pic = function(s)
        if (true) then
            return 'images/options_over.png';

        end
end,
    imgv = function(s) return img(s.pic(s)); end,
};

_optionsOverObj = v_92f6f6a4_04f6_4aa7_a75c_59a1acdea2da
-- creditsOverObj
v_a109d8ab_90cf_46cd_9a4d_18c7f908b704 = gobj {
    var { tag = ''; container = function() return nil; end; },
    nlbid = 'a109d8ab-90cf-46cd-9a4d-18c7f908b704',
    deref = function(s) return stead.deref(v_a109d8ab_90cf_46cd_9a4d_18c7f908b704); end,
    nam = 'creditsOverObj',
    eff = 'middle-middle@239,-26',
    morphout = function(s) return v_b476964e_29f8_4a1f_af08_73765a6b92d3:deref(); end,
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) end,
    dsc = function(s) return s.dscf(s); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
_credits = true;
    end,
    pic = function(s)
        if (true) then
            return 'images/credits_over.png';

        end
end,
    imgv = function(s) return img(s.pic(s)); end,
};

_creditsOverObj = v_a109d8ab_90cf_46cd_9a4d_18c7f908b704
-- 
v_5080431d_08f0_4f38_b293_4d0ed9736e16 = nlbobj {
    var { tag = ''; container = function() return v_b097ad4f_f32d_41d7_acb9_b69632ce070c; end; },
    nlbid = '5080431d-08f0-4f38-b293-4d0ed9736e16',
    deref = function(s) return stead.deref(v_5080431d_08f0_4f38_b293_4d0ed9736e16); end,
    nam = 'v_5080431d_08f0_4f38_b293_4d0ed9736e16',
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) return "^"..
"^"..
"Blender^"..
"Free & Open Source 3D Creation Suite^"..
"{https://www.blender.org/}"; end,
    dsc = function(s) p(s.dscf(s)); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
statsAPI.openURL("https://www.blender.org/");
    end,
};

-- 
v_e9e4cf1b_911f_48a2_9ee5_8e880e9fc926 = nlbobj {
    var { tag = ''; container = function() return v_b097ad4f_f32d_41d7_acb9_b69632ce070c; end; },
    nlbid = 'e9e4cf1b-911f-48a2-9ee5-8e880e9fc926',
    deref = function(s) return stead.deref(v_e9e4cf1b_911f_48a2_9ee5_8e880e9fc926); end,
    nam = 'v_e9e4cf1b_911f_48a2_9ee5_8e880e9fc926',
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) return "^"..
"^"..
"== 3D graphics ==^"..
"\"Jukebox\" by olesk^"..
"Released under Creative Commons Zero (Public Domain)^"..
"Downloaded from {http://www.blendswap.com/blends/view/61319}"; end,
    dsc = function(s) p(s.dscf(s)); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
statsAPI.openURL("http://www.blendswap.com/blends/view/61319");
    end,
};

-- 
v_11acd3a9_3989_4c01_b9de_c927f15f09ea = nlbobj {
    var { tag = ''; container = function() return v_b097ad4f_f32d_41d7_acb9_b69632ce070c; end; },
    nlbid = '11acd3a9-3989-4c01-b9de-c927f15f09ea',
    deref = function(s) return stead.deref(v_11acd3a9_3989_4c01_b9de_c927f15f09ea); end,
    nam = 'v_11acd3a9_3989_4c01_b9de_c927f15f09ea',
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) return "^"..
"^"..
"Musescore^"..
"World\'s most popular notation software^"..
"{https://musescore.org/}"; end,
    dsc = function(s) p(s.dscf(s)); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
statsAPI.openURL("https://musescore.org/");
    end,
};

-- englishOutObj
v_248ae96e_a969_4583_b4e6_16215496a13e = gobj {
    var { tag = ''; container = function() return v_61e7589b_f548_44d5_b3f3_fe1c7136c3c8; end; },
    nlbid = '248ae96e-a969-4583-b4e6-16215496a13e',
    deref = function(s) return stead.deref(v_248ae96e_a969_4583_b4e6_16215496a13e); end,
    nam = 'englishOutObj',
    eff = 'middle-middle@468,-426',
    morphover = function(s) return v_ca290951_f649_459c_bd23_d04a26667e5b:deref(); end,
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) end,
    dsc = function(s) return s.dscf(s); end,
    used = function(s, w)
    end,
    act = function(s)
        s:acta();
        return true;
    end,
    actt = function(s)
        return "";
    end,
    actp = function(s)
    end,
    acta = function(s)
        s:actp();
        s:actf();
    end,
    actf = function(s)
    end,
    pic = function(s)
        if (true) then
            return 'images/english.png';

        end
end,
    imgv = function(s) return img(s.pic(s)); end,
};

_englishOutObj = v_248ae96e_a969_4583_b4e6_16215496a13e
-- 
main, v_489e8c3a_519a_4587_bedd_1d291036b82a = room { nam = 'main', enter = function(s) nlb:nlbwalk(s, v_489e8c3a_519a_4587_bedd_1d291036b82a); end }, room {
    nam = 'Am I a Monster?',
    nosave = true,
    notes = '',
    bgimg = function(s)
return nlb:std_bg();
    end,
    pic = function(s)
    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = true,
    way = {
    },
    xdsc = function(s)
        p(nlb:alts_txt(s));
    end,
    wcns = {
    },
    alts = {
    },
    autos = function(s)
        nlb:revive();
        nlb:ways_chk(s);
        if ((_seen_main_menu ~= nil) and (_seen_main_menu <= 0)) then         nlb:nlbwalk(v_489e8c3a_519a_4587_bedd_1d291036b82a, v_da36b7de_b2fd_46c9_a9cf_5e253cc445dc); 
        return false;
 end;
        if ((_seen_main_menu ~= nil) and (_seen_main_menu > 0)) then         nlb:nlbwalk(v_489e8c3a_519a_4587_bedd_1d291036b82a, v_61e7589b_f548_44d5_b3f3_fe1c7136c3c8); 
        return false;
 end;
        vn:standard_renew();
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_489e8c3a_519a_4587_bedd_1d291036b82a_snds');
        if sndfile ~= nil then
            s.sndout(s);
            add_sound(sndfile);
        end;
    end,
    theme_file = function(s)
        return 'theme_standard.lua';
    end,
    enter = function(s, f)
        nlb:theme_switch(s:theme_file());
        s.lasttext = nil;
        s.wastext = false;
        if not (f.autowired) then
            nlb:addf(v_43243a00_7e14_49eb_a1b7_afbad9eb6df2, _version_obj, false);
_seen_main_menu = nlb:getAchievement(statsAPI, 'MAIN_MENU');
        end;
        s:initf();
    end,
    initf = function(s)
        s.snd(s);
        local bg_img = s.bgimg(s);
        nlb:revive();
        nlb:ways_chk(s);
        vn:scene(bg_img);
        local geomFuncNeedToCall = true;
        if geomFuncNeedToCall then
            vn:auto_geom('dissolve', function() s.autos(s); end);
        end;
        return vn:get_win_coords();
    end,
    exit = function(s, t)
        s.sndout(s);
        s.wastext = false;
        s.lasttext = nil;
    end,
    life = function(s)
        if vn.stopped then s.autos(s); end;
    end,
    snd = function(s) 
            set_music('sound/cloudjumper_-_a_full_mind.ogg', 0);
        s.nextsnd(s);
    end,
    sndout = function(s) end,
    obj = { 
        xdsc()
    },
};

-- 
v_61e7589b_f548_44d5_b3f3_fe1c7136c3c8 = vnr {
    nam = 'Am I a Monster?',
    nosave = true,
    notes = '',
    bgimg = function(s)
        if (true) then
            return 'images/menu.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
    end,
    autos = function(s)
        nlb:revive();
        nlb:ways_chk(s);
        if ((_credits)) then     _credits =  false ;
    nlb:actf(_syscall_hud_dark_sparse);
                nlb:addf(nil, v_bb4991ef_0c52_45a7_92f9_10ade18afaef, false);
        nlb:nlbwalk(v_61e7589b_f548_44d5_b3f3_fe1c7136c3c8, v_b097ad4f_f32d_41d7_acb9_b69632ce070c); 

        return false;
 end;
        if ((_intro)) then         nlb:nlbwalk(v_61e7589b_f548_44d5_b3f3_fe1c7136c3c8, v_da36b7de_b2fd_46c9_a9cf_5e253cc445dc); 

        return false;
 end;
        if ((_our_games)) then     _our_games =  false ;
    nlb:actf(_syscall_hud_dark_sparse);
                nlb:addf(nil, v_bb4991ef_0c52_45a7_92f9_10ade18afaef, false);
        nlb:nlbwalk(v_61e7589b_f548_44d5_b3f3_fe1c7136c3c8, v_6104baf7_01b3_4e7b_9eba_1377f12009a7); 

        return false;
 end;
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_61e7589b_f548_44d5_b3f3_fe1c7136c3c8_snds');
        if sndfile ~= nil then
            s.sndout(s);
            add_sound(sndfile);
        end;
    end,
    theme_file = function(s)
        return 'theme_vn.lua';
    end,
    enter = function(s, f)
        nlb:theme_switch(s:theme_file());
        s.lasttext = nil;
        s.wastext = false;
        if not (f.autowired) then
_credits =  false ;
_back2menu =  false ;
_intro =  false ;
_our_games =  false ;
nlb:setAchievement(statsAPI, 'MAIN_MENU', '29ee9abf-405d-4735-bf3b-be69a7c80289');
        end;
        s:initf();
    end,
    initf = function(s)
        s.snd(s);
        vn:request_full_clear();
        vn:lock_direct();
        local bg_img = s.bgimg(s);
        nlb:revive();
        nlb:ways_chk(s);
        vn:scene(bg_img);
        local geomFuncNeedToCall = true;
        if v_43243a00_7e14_49eb_a1b7_afbad9eb6df2.preload then
            geomFuncNeedToCall = false;
            v_43243a00_7e14_49eb_a1b7_afbad9eb6df2:preload(s);
        else
            vn:gshow(v_43243a00_7e14_49eb_a1b7_afbad9eb6df2);
        end
        if v_da368deb_0207_479b_96ba_87b1c1ae4159.preload then
            geomFuncNeedToCall = false;
            v_da368deb_0207_479b_96ba_87b1c1ae4159:preload(s);
        else
            vn:gshow(v_da368deb_0207_479b_96ba_87b1c1ae4159);
        end
        if v_b476964e_29f8_4a1f_af08_73765a6b92d3.preload then
            geomFuncNeedToCall = false;
            v_b476964e_29f8_4a1f_af08_73765a6b92d3:preload(s);
        else
            vn:gshow(v_b476964e_29f8_4a1f_af08_73765a6b92d3);
        end
        if v_5943beec_862b_406c_b4fc_ae4a8f03a21e.preload then
            geomFuncNeedToCall = false;
            v_5943beec_862b_406c_b4fc_ae4a8f03a21e:preload(s);
        else
            vn:gshow(v_5943beec_862b_406c_b4fc_ae4a8f03a21e);
        end
        if v_248ae96e_a969_4583_b4e6_16215496a13e.preload then
            geomFuncNeedToCall = false;
            v_248ae96e_a969_4583_b4e6_16215496a13e:preload(s);
        else
            vn:gshow(v_248ae96e_a969_4583_b4e6_16215496a13e);
        end
        if v_aaa5f6c7_a75d_4599_a519_00ee5977ba7d.preload then
            geomFuncNeedToCall = false;
            v_aaa5f6c7_a75d_4599_a519_00ee5977ba7d:preload(s);
        else
            vn:gshow(v_aaa5f6c7_a75d_4599_a519_00ee5977ba7d);
        end
        if v_26baf5c3_7f9d_4b4d_b956_5cd3774c114c.preload then
            geomFuncNeedToCall = false;
            v_26baf5c3_7f9d_4b4d_b956_5cd3774c114c:preload(s);
        else
            vn:gshow(v_26baf5c3_7f9d_4b4d_b956_5cd3774c114c);
        end
        if v_ec014653_9193_4399_8185_eea017b96b35.preload then
            geomFuncNeedToCall = false;
            v_ec014653_9193_4399_8185_eea017b96b35:preload(s);
        else
            vn:gshow(v_ec014653_9193_4399_8185_eea017b96b35);
        end
        if geomFuncNeedToCall then
            vn:auto_geom('dissolve', function() s.autos(s); end);
        end;
        return 0, 0, vn.scr_w, vn.scr_h;
    end,
    exit = function(s, t)
        s.sndout(s);
        s.wastext = false;
        s.lasttext = nil;
        vn:request_full_clear();
        vn:unlock_direct();
    end,
    life = function(s)
        if vn.stopped then s.autos(s); end;
    end,
    snd = function(s) 
    end,
    sndout = function(s) end,
};

-- Credits
v_b097ad4f_f32d_41d7_acb9_b69632ce070c = room {
    nam = "Credits",
    nosave = true,
    notes = 'Credits',
    bgimg = function(s)
        if (true) then
            return 'images/15.jpg';
        end
return nlb:std_bg();
    end,
    pic = function(s)
    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = true,
    way = {
    },
    xdsc = function(s)
        p "^";
        p(nlb:alts_txt(s));
    end,
    wcns = {
    },
    alts = {
    },
    autos = function(s)
        nlb:revive();
        nlb:ways_chk(s);
        if ((_back2menu)) then     _back2menu =  false ;
    nlb:actf(_syscall_hud_default);
                if have(stead.deref(_back2menuObj)) then remove(stead.deref(_back2menuObj), inv()); end;
        nlb:nlbwalk(v_b097ad4f_f32d_41d7_acb9_b69632ce070c, v_61e7589b_f548_44d5_b3f3_fe1c7136c3c8); 
        return false;
 end;
        vn:standard_renew();
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_b097ad4f_f32d_41d7_acb9_b69632ce070c_snds');
        if sndfile ~= nil then
            s.sndout(s);
            add_sound(sndfile);
        end;
    end,
    theme_file = function(s)
        return 'theme_standard.lua';
    end,
    enter = function(s, f)
        nlb:theme_switch(s:theme_file());
        s.lasttext = nil;
        s.wastext = false;
        if not (f.autowired) then
        end;
        s:initf();
    end,
    initf = function(s)
theme.win.geom(68, 70, 1704, 901);
theme.win.color('white', '#00FF00', 'gold');
theme.inv.color('white', '#00FF00', 'gold');

        s.snd(s);
        local bg_img = s.bgimg(s);
        nlb:revive();
        nlb:ways_chk(s);
        vn:scene(bg_img);
        local geomFuncNeedToCall = true;
        if geomFuncNeedToCall then
            vn:auto_geom('dissolve', function() s.autos(s); end);
        end;
        return vn:get_win_coords();
    end,
    exit = function(s, t)
        s.sndout(s);
        s.wastext = false;
        s.lasttext = nil;
    end,
    life = function(s)
        if vn.stopped then s.autos(s); end;
    end,
    snd = function(s) 
        s.nextsnd(s);
    end,
    sndout = function(s) end,
    obj = { 
        'v_cc5ebee8_54ee_438a_8468_3811c4e57291',
        'v_e9e4cf1b_911f_48a2_9ee5_8e880e9fc926',
        'v_84ae1bd1_458c_405a_bba8_f7bdd996b682',
        'v_bc8d220d_d651_4995_998f_2ec6e5f09552',
        'v_ea3ebcd0_9c6e_405b_baee_53e8eb790c52',
        'v_30075339_496a_4485_b7f9_7ec28907472d',
        'v_1ad8b242_09f7_416d_87c6_10db7318648e',
        'v_7d6ef07f_a9e9_4f34_88f3_d26ac88dde55',
        'v_107b0bce_dc04_4bf4_bd03_7c046cbe71e9',
        'v_11acd3a9_3989_4c01_b9de_c927f15f09ea',
        'v_5080431d_08f0_4f38_b293_4d0ed9736e16',
        'v_fdc08234_89c5_4dd2_a57b_026bc07e86f0',
        'v_930585ec_bbe5_473b_acd4_ed6f3a2605d7',
        'v_4acb3d44_760b_47a3_bbde_a3624251f799',
        xdsc()
    },
};

-- 
v_5bd37bb6_9454_4388_b33d_291d4ccd20ce = vnr {
    nam = 'Am I a Monster?',
    nosave = true,
    notes = '',
    bgimg = function(s)

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
    end,
    autos = function(s)
        nlb:revive();
        nlb:ways_chk(s);
        if (true) then         nlb:nlbwalk(v_5bd37bb6_9454_4388_b33d_291d4ccd20ce, v_fbf46ec7_9f51_49a7_8d60_d351d70a2ac1); 

        return false;
 end;
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_5bd37bb6_9454_4388_b33d_291d4ccd20ce_snds');
        if sndfile ~= nil then
            s.sndout(s);
            add_sound(sndfile);
        end;
    end,
    theme_file = function(s)
        return 'theme_vn.lua';
    end,
    enter = function(s, f)
        nlb:theme_switch(s:theme_file());
        s.lasttext = nil;
        s.wastext = false;
        if not (f.autowired) then
        end;
        s:initf();
    end,
    initf = function(s)
        s.snd(s);
        vn:request_full_clear();
        vn:lock_direct();
        local bg_img = s.bgimg(s);
        nlb:revive();
        nlb:ways_chk(s);
        vn:scene(bg_img);
        local geomFuncNeedToCall = true;
        if v_60e27336_12ef_4702_b1cb_d9b822a36fcc.preload then
            geomFuncNeedToCall = false;
            v_60e27336_12ef_4702_b1cb_d9b822a36fcc:preload(s);
        else
            vn:gshow(v_60e27336_12ef_4702_b1cb_d9b822a36fcc);
        end
        if geomFuncNeedToCall then
            vn:auto_geom('dissolve', function() s.autos(s); end);
        end;
        return 0, 0, vn.scr_w, vn.scr_h;
    end,
    exit = function(s, t)
        s.sndout(s);
        s.wastext = false;
        s.lasttext = nil;
        vn:request_full_clear();
        vn:unlock_direct();
    end,
    life = function(s)
        if vn.stopped then s.autos(s); end;
    end,
    snd = function(s) 
    end,
    sndout = function(s) end,
};

-- Other games by NLB project
v_6104baf7_01b3_4e7b_9eba_1377f12009a7 = room {
    nam = "Other games by NLB project",
    nosave = true,
    notes = 'Other games by NLB project',
    bgimg = function(s)
        if (true) then
            return 'images/ourgamesbg.jpg';
        end
return nlb:std_bg();
    end,
    pic = function(s)
    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
        p("Thanks for playing this game!^"..
"If you liked this game, then probably you\'ll like our other games.");
    end,
    way = {
    },
    xdsc = function(s)
        p "^";
        p(nlb:alts_txt(s));
    end,
    wcns = {
    },
    alts = {
    },
    autos = function(s)
        nlb:revive();
        nlb:ways_chk(s);
        if ((_back2menu)) then     _back2menu =  false ;
    nlb:actf(_syscall_hud_default);
                if have(stead.deref(_back2menuObj)) then remove(stead.deref(_back2menuObj), inv()); end;
        nlb:nlbwalk(v_6104baf7_01b3_4e7b_9eba_1377f12009a7, v_61e7589b_f548_44d5_b3f3_fe1c7136c3c8); 
        return false;
 end;
        vn:standard_renew();
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_6104baf7_01b3_4e7b_9eba_1377f12009a7_snds');
        if sndfile ~= nil then
            s.sndout(s);
            add_sound(sndfile);
        end;
    end,
    theme_file = function(s)
        return 'theme_standard.lua';
    end,
    enter = function(s, f)
        nlb:theme_switch(s:theme_file());
        s.lasttext = nil;
        s.wastext = false;
        if not (f.autowired) then
        end;
        s:initf();
    end,
    initf = function(s)
theme.win.geom(68, 70, 1704, 901);
theme.win.color('black', 'black', 'darkgreen');
theme.inv.color('black', 'black', 'darkgreen');

        s.snd(s);
        local bg_img = s.bgimg(s);
        nlb:revive();
        nlb:ways_chk(s);
        vn:scene(bg_img);
        local geomFuncNeedToCall = true;
        if geomFuncNeedToCall then
            vn:auto_geom('dissolve', function() s.autos(s); end);
        end;
        return vn:get_win_coords();
    end,
    exit = function(s, t)
        s.sndout(s);
        s.wastext = false;
        s.lasttext = nil;
    end,
    life = function(s)
        if vn.stopped then s.autos(s); end;
    end,
    snd = function(s) 
        s.nextsnd(s);
    end,
    sndout = function(s) end,
    obj = { 
        'v_b9ed2c0a_31f4_4241_bc2c_740ae1206fce',
        'v_d9cc21f5_f95b_4300_8971_1733183e1ab9',
        'v_eb58dab3_3e56_427d_ae99_787b986dfe72',
        'v_66edebcb_50ca_4edb_89e3_bdd513cfcfd0',
        xdsc()
    },
};

-- 
v_a135a9ec_65be_4774_b2c5_14e06026385c = vnr {
    nam = 'Am I a Monster?',
    nosave = true,
    notes = '',
    bgimg = function(s)

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
    end,
    autos = function(s)
        nlb:revive();
        nlb:ways_chk(s);
        if (true) then     _intro =  false ;
        nlb:nlbwalk(v_a135a9ec_65be_4774_b2c5_14e06026385c, v_61e7589b_f548_44d5_b3f3_fe1c7136c3c8); 

        return false;
 end;
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_a135a9ec_65be_4774_b2c5_14e06026385c_snds');
        if sndfile ~= nil then
            s.sndout(s);
            add_sound(sndfile);
        end;
    end,
    theme_file = function(s)
        return 'theme_vn.lua';
    end,
    enter = function(s, f)
        nlb:theme_switch(s:theme_file());
        s.lasttext = nil;
        s.wastext = false;
        if not (f.autowired) then
        end;
        s:initf();
    end,
    initf = function(s)
        s.snd(s);
        vn:request_full_clear();
        vn:lock_direct();
        local bg_img = s.bgimg(s);
        nlb:revive();
        nlb:ways_chk(s);
        vn:scene(bg_img);
        local geomFuncNeedToCall = true;
        if v_3978214c_072b_44e9_92e9_a9749927b2c0.preload then
            geomFuncNeedToCall = false;
            v_3978214c_072b_44e9_92e9_a9749927b2c0:preload(s);
        else
            vn:gshow(v_3978214c_072b_44e9_92e9_a9749927b2c0);
        end
        if geomFuncNeedToCall then
            vn:auto_geom('dissolve', function() s.autos(s); end);
        end;
        return 0, 0, vn.scr_w, vn.scr_h;
    end,
    exit = function(s, t)
        s.sndout(s);
        s.wastext = false;
        s.lasttext = nil;
        vn:request_full_clear();
        vn:unlock_direct();
    end,
    life = function(s)
        if vn.stopped then s.autos(s); end;
    end,
    snd = function(s) 
    end,
    sndout = function(s) end,
};

-- 
v_fbf46ec7_9f51_49a7_8d60_d351d70a2ac1 = vnr {
    nam = 'Am I a Monster?',
    nosave = true,
    notes = '',
    bgimg = function(s)

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
    end,
    autos = function(s)
        nlb:revive();
        nlb:ways_chk(s);
        if (true) then         nlb:nlbwalk(v_fbf46ec7_9f51_49a7_8d60_d351d70a2ac1, v_a135a9ec_65be_4774_b2c5_14e06026385c); 

        return false;
 end;
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_fbf46ec7_9f51_49a7_8d60_d351d70a2ac1_snds');
        if sndfile ~= nil then
            s.sndout(s);
            add_sound(sndfile);
        end;
    end,
    theme_file = function(s)
        return 'theme_vn.lua';
    end,
    enter = function(s, f)
        nlb:theme_switch(s:theme_file());
        s.lasttext = nil;
        s.wastext = false;
        if not (f.autowired) then
        end;
        s:initf();
    end,
    initf = function(s)
        s.snd(s);
        vn:request_full_clear();
        vn:lock_direct();
        local bg_img = s.bgimg(s);
        nlb:revive();
        nlb:ways_chk(s);
        vn:scene(bg_img);
        local geomFuncNeedToCall = true;
        if v_0b66da23_7a3d_4bd9_a9a6_b3bfd8e0c58b.preload then
            geomFuncNeedToCall = false;
            v_0b66da23_7a3d_4bd9_a9a6_b3bfd8e0c58b:preload(s);
        else
            vn:gshow(v_0b66da23_7a3d_4bd9_a9a6_b3bfd8e0c58b);
        end
        if geomFuncNeedToCall then
            vn:auto_geom('dissolve', function() s.autos(s); end);
        end;
        return 0, 0, vn.scr_w, vn.scr_h;
    end,
    exit = function(s, t)
        s.sndout(s);
        s.wastext = false;
        s.lasttext = nil;
        vn:request_full_clear();
        vn:unlock_direct();
    end,
    life = function(s)
        if vn.stopped then s.autos(s); end;
    end,
    snd = function(s) 
    end,
    sndout = function(s) end,
};

-- 
v_da36b7de_b2fd_46c9_a9cf_5e253cc445dc = vnr {
    nam = 'Am I a Monster?',
    nosave = true,
    notes = '',
    bgimg = function(s)

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
    end,
    autos = function(s)
        nlb:revive();
        nlb:ways_chk(s);
        if (true) then         nlb:nlbwalk(v_da36b7de_b2fd_46c9_a9cf_5e253cc445dc, v_5bd37bb6_9454_4388_b33d_291d4ccd20ce); 

        return false;
 end;
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_da36b7de_b2fd_46c9_a9cf_5e253cc445dc_snds');
        if sndfile ~= nil then
            s.sndout(s);
            add_sound(sndfile);
        end;
    end,
    theme_file = function(s)
        return 'theme_vn.lua';
    end,
    enter = function(s, f)
        nlb:theme_switch(s:theme_file());
        s.lasttext = nil;
        s.wastext = false;
        if not (f.autowired) then
_intro =  true ;
nlb:actf(_syscall_hidemenubtn);
        end;
        s:initf();
    end,
    initf = function(s)
        s.snd(s);
        vn:request_full_clear();
        vn:lock_direct();
        local bg_img = s.bgimg(s);
        nlb:revive();
        nlb:ways_chk(s);
        vn:scene(bg_img);
        local geomFuncNeedToCall = true;
        if v_d4b18a63_4da0_4b5b_ab8a_3da3f6dc16bf.preload then
            geomFuncNeedToCall = false;
            v_d4b18a63_4da0_4b5b_ab8a_3da3f6dc16bf:preload(s);
        else
            vn:gshow(v_d4b18a63_4da0_4b5b_ab8a_3da3f6dc16bf);
        end
        if v_04d2f69b_7b46_45ab_854d_dbb230454344.preload then
            geomFuncNeedToCall = false;
            v_04d2f69b_7b46_45ab_854d_dbb230454344:preload(s);
        else
            vn:gshow(v_04d2f69b_7b46_45ab_854d_dbb230454344);
        end
        if geomFuncNeedToCall then
            vn:auto_geom('dissolve', function() s.autos(s); end);
        end;
        return 0, 0, vn.scr_w, vn.scr_h;
    end,
    exit = function(s, t)
        s.sndout(s);
        s.wastext = false;
        s.lasttext = nil;
        vn:request_full_clear();
        vn:unlock_direct();
    end,
    life = function(s)
        if vn.stopped then s.autos(s); end;
    end,
    snd = function(s) 
    end,
    sndout = function(s) end,
};

