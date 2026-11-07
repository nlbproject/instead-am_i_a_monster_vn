--$Name:Am I a Monster?$
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
require 'dice/modules/big_pig'
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
function update_action_count()
    _action_count_diff_prev = _action_count_diff;
    _action_count_diff = nlb:count_get(0);
    if _action_count_diff <= _action_count_diff_prev then
        return false;
    end
    return true;
end
function has_action()
    if _action_count_diff < _needs_action_count then
        return false;
    end
    nlb:count_reset();
    return true;
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
    _action_count_diff = 0;
    _action_count_diff_prev = 0;
    _needs_action_count = 3;
    _syscall_showmenubtn:act();
    format.quotes = false;
    if not prefs.achievements_max then
        prefs.achievements_max = {};
    end
    if not prefs.achievements_ids then
        prefs.achievements_ids = {};
    end
    if not prefs.achievements_ids['FOREST_LIFE'] then prefs.achievements_ids['FOREST_LIFE'] = {}; end;
    if not prefs.achievements_ids['FOREST_MEETING'] then prefs.achievements_ids['FOREST_MEETING'] = {}; end;
    if not prefs.achievements_ids['GUARD_NOT_A_PROBLEM'] then prefs.achievements_ids['GUARD_NOT_A_PROBLEM'] = {}; end;
    if not prefs.achievements_ids['HUMAN_AGAIN'] then prefs.achievements_ids['HUMAN_AGAIN'] = {}; end;
    if not prefs.achievements_ids['INFO_FOR_GUARD'] then prefs.achievements_ids['INFO_FOR_GUARD'] = {}; end;
    if not prefs.achievements_ids['INTERNET_SEARCH'] then prefs.achievements_ids['INTERNET_SEARCH'] = {}; end;
    if not prefs.achievements_ids['MAXIMUM_WOLFINESS'] then prefs.achievements_ids['MAXIMUM_WOLFINESS'] = {}; end;
    if not prefs.achievements_ids['PHILOSOPHER_CONVERSATION'] then prefs.achievements_ids['PHILOSOPHER_CONVERSATION'] = {}; end;
    if not prefs.achievements_ids['RIGHT_CHOICE'] then prefs.achievements_ids['RIGHT_CHOICE'] = {}; end;
    if not prefs.achievements_ids['THE_BAR'] then prefs.achievements_ids['THE_BAR'] = {}; end;
    if not prefs.achievements_ids['THE_HOSPITAL'] then prefs.achievements_ids['THE_HOSPITAL'] = {}; end;
    if not prefs.achievements_ids['THE_ZOO'] then prefs.achievements_ids['THE_ZOO'] = {}; end;
    if not prefs.achievements_ids['VILLAIN_DEFEATED'] then prefs.achievements_ids['VILLAIN_DEFEATED'] = {}; end;
    if not prefs.achievements_ids['VILLAIN_PUNISHED'] then prefs.achievements_ids['VILLAIN_PUNISHED'] = {}; end;
    if not prefs.achievements_ids['WRONG_CHOICE'] then prefs.achievements_ids['WRONG_CHOICE'] = {}; end;
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
    if _forestExit == nil then
        _forestExit = false;
    end
    if _guardDone == nil then
        _guardDone = false;
    end
    if _barExit == nil then
        _barExit = false;
    end
    if _wolfiness == nil then
        _wolfiness = 0;
    end
    if _hp == nil then
        _hp = 0;
    end
    if _room == nil then
        _room = false;
    end
    if _wolvesTalk == nil then
        _wolvesTalk = false;
    end
end

-- tagsObj
v_ccb8b2e6_f93d_4fc6_9e9e_544e8fe158b1 = nlbobj {
    var { tag = ''; container = function() return nil; end; },
    nlbid = 'ccb8b2e6-f93d-4fc6-9e9e-544e8fe158b1',
    deref = function(s) return stead.deref(v_ccb8b2e6_f93d_4fc6_9e9e_544e8fe158b1); end,
    nam = 'tagsObj',
    snd = function(s) 
    end,
    disp = function(s) return false; end,
    dscf = function(s) end,
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
_room = nlb:pop(_tagsArg.listnam);
if ((_wolfiness ~= nil) and (_wolfiness <= 1)) then
_room.tag = 'HUMAN';
else
_room.tag = 'WOLF';
end;
    end,
};

_tagsObj = v_ccb8b2e6_f93d_4fc6_9e9e_544e8fe158b1
-- infoObj
v_766dc293_6fcf_421e_8b99_ef09b92a98b2 = nlbstat {
    var { tag = ''; container = function() return nil; end; },
    nlbid = '766dc293-6fcf-421e-8b99-ef09b92a98b2',
    deref = function(s) return stead.deref(v_766dc293_6fcf_421e_8b99_ef09b92a98b2); end,
    nam = 'infoObj',
    snd = function(s) 
    end,
    disp = function(s) return "Wolfiness: "..tostring(_wolfiness).."    HP: "..tostring(_hp).."" end,
    dscf = function(s) end,
    dsc = function(s) p(s.dscf(s)); end,
    tak = function(s)
        s.act(s);
        return true;
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
    end,
};

_infoObj = v_766dc293_6fcf_421e_8b99_ef09b92a98b2
-- For Ludum Dare #33 \"You are the Monster\"
main, v_f7cb8bed_47a9_4ce2_b713_c9b53571c93f = room { nam = 'main', enter = function(s) nlb:nlbwalk(s, v_f7cb8bed_47a9_4ce2_b713_c9b53571c93f, true); end }, vnr {
    nam = 'Am I a Monster?',
    notes = 'For Ludum Dare #33 \"You are the Monster\"',
    bgimg = function(s)
        if (true) then
            return 'images/title.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
    end,
    walk_to = "v_f7cb8bed_47a9_4ce2_b713_c9b53571c93f_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_f7cb8bed_47a9_4ce2_b713_c9b53571c93f_snds');
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
nlb:snapshot();
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

v_f7cb8bed_47a9_4ce2_b713_c9b53571c93f_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if true then
                nlb:addf(nil, v_766dc293_6fcf_421e_8b99_ef09b92a98b2, false);
        nlb:nlbwalk(v_f7cb8bed_47a9_4ce2_b713_c9b53571c93f, v_f12432d9_dd8f_40fc_97bd_f9a15cc21ff6, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- ++
v_c28ae684_785a_4442_8756_8f5a7e9fb0c1 = vnr {
    nam = 'Am I a Monster?',
    notes = '++',
    bgimg = function(s)
        if (true) then
            return 'images/5.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("You were running down the night streets as fast as you could, and soon the many-storied buildings gave way to small private houses.");
pn();
pn(" You found a broken half-ruined shack and decided to wait there for dawn. You curled yourself up into a ball and fell asleep.");
pn();
pn(" The morning chill woke you up at the crack of dawn. You snuck into the neighboring courtyard and took a shirt and a pair of trousers off their clothesline.");
pn();
pn(" You quickly got dressed and headed towards the highway. You felt like yourself again, with the exception of feeling heavy remorse about the pathologist.");
pn();
pn(" But the most important question was what or who made you turn into a wolf. You was absolutely sure that no animal bit or even scratched you.");
pn();
pn(" You were confused. As ill luck would have it, there were no cars on the road when you badly needed to get home.");
pn();
pn(" Moreover, you were hungry again. You saw a bar for truck drivers behind the trees, and decided to go there.");
pn();
pn("");
pn();
    end,
    walk_to = "v_c28ae684_785a_4442_8756_8f5a7e9fb0c1_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_c28ae684_785a_4442_8756_8f5a7e9fb0c1_snds');
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
            set_music('sound/smiling_cynic_-_beat_me.ogg', 0);
    end,
    sndout = function(s) end,
};

v_c28ae684_785a_4442_8756_8f5a7e9fb0c1_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if true then
        nlb:nlbwalk(v_c28ae684_785a_4442_8756_8f5a7e9fb0c1, v_34e50ebc_ea2b_4714_81a1_ae8fca22c399, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- ++
v_ffa05a49_c979_4e9f_9b89_42936e21b81a = vnr {
    nam = 'Am I a Monster?',
    notes = '++',
    bgimg = function(s)
        if (true) then
            return 'images/1.6.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("You calmed down and looked over yourself one more time. You looked like an ordinary wolf, just a little larger.");
pn();
pn(" It\'s unlikely that your pursuers would tell the difference in the dark. You just hoped that you left no tracks by the enclosure, and that they wouldn\'t have hounds to sniff you out.");
pn();
pn("");
pn();
pn("Suddenly your attention was drawn to a cell phone hanging around your neck. You hastily tore it off and hid it in the grass. Just in time!");
pn();
pn("You heard voices in the alley. Flashlight beams were sliding over the roads, enclosures, and grass. Soon three men came up to the enclosure you were in.");
pn();
pn(" You recognized one of them. The old man was Olaf, the zoo watchman, and two armed policemen were with him.");
pn();
pn("");
pn();
pn("\"Are you sure that everything is normal, old man?\" harshly asked one of the cops. \"Are your animals all here?\" They lit the enclosure with the beams. It lit up the pack and you.");
pn();
pn("Olaf reluctantly looked inside the enclosure.");
pn();
pn("\"Yes, everything is fine. The animals would alert me if something was wrong. They are much smarter than you assholes.\"");
pn();
pn("The police officer just hemmed.");
pn();
pn("\"Fine, Swen, let\'s get out of here. It looks like everything is ok.\"");
pn();
pn("The officers turned around and went off. Olaf continued to look at the wolves for some time and then he also left.");
pn();
    end,
    walk_to = "v_ffa05a49_c979_4e9f_9b89_42936e21b81a_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_ffa05a49_c979_4e9f_9b89_42936e21b81a_snds');
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
            set_music('sound/in_limbo__rock_prog__-_reminiscences.ogg', 0);
    end,
    sndout = function(s) end,
};

v_ffa05a49_c979_4e9f_9b89_42936e21b81a_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if true then
        nlb:nlbwalk(v_ffa05a49_c979_4e9f_9b89_42936e21b81a, v_c28ae684_785a_4442_8756_8f5a7e9fb0c1, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- ++
v_a2b6a777_a95c_4518_8623_ec797a483c46 = vnr {
    nam = 'Am I a Monster?',
    notes = '++',
    bgimg = function(s)
        if (true) then
            return 'images/3.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("You bared your teeth and slowly began to rise up from the table. That was enough to make the pathologist rush out of the room, wildly screaming.");
pn();
pn(" You turned into the beast again. Acute hunger was torturing you and so you pounced on the corpse lying on the next table.");
pn();
pn(" After a quick bloody meal, you hurried to leave the building. Now your stomach was full, but the wound hurt a little bit.");
pn();
pn("");
pn();
    end,
    walk_to = "v_a2b6a777_a95c_4518_8623_ec797a483c46_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_a2b6a777_a95c_4518_8623_ec797a483c46_snds');
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
    end,
    sndout = function(s) end,
};

v_a2b6a777_a95c_4518_8623_ec797a483c46_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if true then
        nlb:nlbwalk(v_a2b6a777_a95c_4518_8623_ec797a483c46, v_c28ae684_785a_4442_8756_8f5a7e9fb0c1, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- ++
v_8c1fa8c6_8027_43c8_8d8b_0bf454d5e717 = vnr {
    nam = 'Am I a Monster?',
    notes = '++',
    bgimg = function(s)
        if (true) then
            return 'images/3.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("You woke up because of the bright light that was coming even through your closed eyelids.  You were lying on something hard and cold.");
pn();
pn(" When you partially opened your eyes, you saw a man wearing a medical mask. He tried to take the cell phone off your neck.");
pn();
pn(" When he noticed that you were looking at him, the pathologist shuddered and began to move back with his eyes bugged open.");
pn();
pn("");
pn();
    end,
    walk_to = "v_8c1fa8c6_8027_43c8_8d8b_0bf454d5e717_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_8c1fa8c6_8027_43c8_8d8b_0bf454d5e717_snds');
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
nlb:setAchievement(statsAPI, 'THE_HOSPITAL', '13728a8e-885d-40db-ad42-adf784325337');
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
    end,
    sndout = function(s) end,
};

v_8c1fa8c6_8027_43c8_8d8b_0bf454d5e717_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
        vn.skip_mode = false;
        vn:unlock_direct();
        put(v_ba3735f7_403c_429f_8934_af62231d8565);
        put(v_36d93e4f_19f9_489d_94a4_7fc5ba630d7a);
        s:initf();
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

v_ba3735f7_403c_429f_8934_af62231d8565 = menu {
    nam = "v_ba3735f7_403c_429f_8934_af62231d8565",
    dsc = function(s) return "{Eat the pathologist}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_8c1fa8c6_8027_43c8_8d8b_0bf454d5e717, v_d937c5c1_766c_4581_a03e_736560b0cc8f, false); 
    end
}

v_36d93e4f_19f9_489d_94a4_7fc5ba630d7a = menu {
    nam = "v_36d93e4f_19f9_489d_94a4_7fc5ba630d7a",
    dsc = function(s) return "{Eat the corpse}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_8c1fa8c6_8027_43c8_8d8b_0bf454d5e717, v_a2b6a777_a95c_4518_8623_ec797a483c46, false); 
    end
}

-- ++
v_d937c5c1_766c_4581_a03e_736560b0cc8f = vnr {
    nam = 'Am I a Monster?',
    notes = '++',
    bgimg = function(s)
        if (true) then
            return 'images/4.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("When you sensed a panicked terror coming from the pathologist, you felt blood raging in your veins and your stomach began to rumble.");
pn();
pn(" You suddenly burst into your beastly fur and muscle once again and caught the medical worker in the corridor.");
pn();
pn(" You attacked him from behind, pinning him down and biting through his throat in a blink of an eye. There wasn\'t much time.");
pn();
pn(" Half of the building must have heard his screams. After swallowing a few pieces of meat, you felt your strength quickly returning.");
pn();
pn(" On your way out, you scared a cleaning woman half to death, and finally left the building. Soon the pain abated. You was astonished to find out that your bullet wound had closed.");
pn();
pn("");
pn();
    end,
    walk_to = "v_d937c5c1_766c_4581_a03e_736560b0cc8f_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_d937c5c1_766c_4581_a03e_736560b0cc8f_snds');
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
_wolfiness = _wolfiness + 1;
_hp = _hp + 1;
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
    end,
    sndout = function(s) end,
};

v_d937c5c1_766c_4581_a03e_736560b0cc8f_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if true then
        nlb:nlbwalk(v_d937c5c1_766c_4581_a03e_736560b0cc8f, v_c28ae684_785a_4442_8756_8f5a7e9fb0c1, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- ++
v_f12432d9_dd8f_40fc_97bd_f9a15cc21ff6 = vnr {
    nam = 'Am I a Monster?',
    notes = '++',
    bgimg = function(s)
        if (true) then
            return 'images/1.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("You woke up lying on the pavement. The full moon had already shown up from behind the roof and was shining brightly in your face. Not a single soul was around.");
pn();
pn("\"Weird, how long have I been lying here? Nobody even called an ambulance,\" you thought to yourself, slowly walking along the street.");
pn();
pn(" In the distance you heard the sound of sirens. You turned round the corner and faced a group of people.");
pn();
pn("");
pn();
pn("\"Wolf! Wolf!\" someone screamed. People rushed in all directions. Saving yourself from the beast, you ran together with them.");
pn();
pn(" You looked back a couple of times, full of fright, expecting to see an open toothy mouth, but there was nothing behind you.");
pn();
pn(" Finally you decided to separate yourself from the mad group and turned into an alleyway and hid behind a garbage can.");
pn();
pn(" You carefully looked from behind the cover and saw two policemen. They were walking right towards you.");
pn();
pn("");
pn();
pn("\"The wolf really is here, then!\" you thought to yourself, growing cold with fear.  You nervously began to look around.");
pn();
pn(" Suddenly you saw something dark and hairy by the opposite wall. Your heart thumped loudly and your ears were ringing in fear.");
pn();
pn(" The next moment, in spite of the panic clutching at your chest, you made a frightening discovery: on the opposite wall you were looking into a mirror that someone had thrown away. The reflection in it was yours!");
pn();
pn("");
pn();
pn("\"I\'m a monster!\" you screamed with despair. But the police officers heard only a terrifying howling.");
pn();
pn(" It became clear that they were coming to kill you. You needed to run! But where? To the left and right there were houses. Behind them was a three meter concrete fence and a bunch of armed men in front of it.");
pn();
pn("");
pn();
    end,
    walk_to = "v_f12432d9_dd8f_40fc_97bd_f9a15cc21ff6_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_f12432d9_dd8f_40fc_97bd_f9a15cc21ff6_snds');
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
_hp = 3;
_wolfiness = 0;
_guardDone =  false ;
_forestExit =  false ;
_barExit =  false ;
_wolvesTalk =  false ;
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
            set_music('sound/in_limbo__rock_prog__-_reminiscences.ogg', 0);
    end,
    sndout = function(s) end,
};

v_f12432d9_dd8f_40fc_97bd_f9a15cc21ff6_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
        vn.skip_mode = false;
        vn:unlock_direct();
        put(v_dedde941_43c9_46c6_89f9_799e86c17e08);
        put(v_a9ba0ac9_1fcf_499c_a53c_6f41811649be);
        s:initf();
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

v_dedde941_43c9_46c6_89f9_799e86c17e08 = menu {
    nam = "v_dedde941_43c9_46c6_89f9_799e86c17e08",
    dsc = function(s) return "{Try to run through the police}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_f12432d9_dd8f_40fc_97bd_f9a15cc21ff6, v_b12a01be_cd61_4dba_b427_1ce3afc06fc6, false); 
    end
}

v_a9ba0ac9_1fcf_499c_a53c_6f41811649be = menu {
    nam = "v_a9ba0ac9_1fcf_499c_a53c_6f41811649be",
    dsc = function(s) return "{Jump over the fence}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_f12432d9_dd8f_40fc_97bd_f9a15cc21ff6, v_5b5d038f_ce4d_4cc8_8bee_81de8528b1a5, false); 
    end
}

-- ++
v_b12a01be_cd61_4dba_b427_1ce3afc06fc6 = vnr {
    nam = 'Am I a Monster?',
    notes = '++',
    bgimg = function(s)
        if (true) then
            return 'images/2.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("You decided to bet on the element of surprise and jumped out from the cover. You rushed away by long jumps.");
pn();
pn(" The police men held back because of the suddenness, but in a few seconds gunfire sounded. Suddenly, the moon disappeared behind the clouds.");
pn();
pn(" You were lucky that the street lights were out and pitch black darkness covered the neighborhood. You almost managed to reach a safe place, when suddenly one of the bullets hit you.  You squealed in agony, and after covering a few more yards, dropped on the spot.");
pn();
pn("");
pn();
pn("\"We need to check it out. Everybody, come with me,\" ordered one of the policemen. Moving extremely cautiously and holding their guns ready to shoot, the cops approached the place you fell.");
pn();
pn("\"It\'s clear, guys! There is some naked redneck here. Maybe we hit him while were shooting at the beast? Call an ambulance.\"");
pn();
pn("\"Where did he come from?\"");
pn();
pn("\"I bet he visited somebody\'s wife and her husband came home early. So he jumped off the balcony.\"");
pn();
pn("\"What\'s there on his neck?\"");
pn();
pn("\"Looks like a cell phone.\"");
pn();
pn("\"Poor devil. If I were in his shoes, I\'d have grabbed my shorts.\"");
pn();
pn("The ambulance arrived quite fast. The doctors verified the death of the victim, then took the body and drove it to the morgue.");
pn();
    end,
    walk_to = "v_b12a01be_cd61_4dba_b427_1ce3afc06fc6_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_b12a01be_cd61_4dba_b427_1ce3afc06fc6_snds');
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
_hp = _hp - 1;
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
    end,
    sndout = function(s) end,
};

v_b12a01be_cd61_4dba_b427_1ce3afc06fc6_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if true then
        nlb:nlbwalk(v_b12a01be_cd61_4dba_b427_1ce3afc06fc6, v_8c1fa8c6_8027_43c8_8d8b_0bf454d5e717, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- ++
v_85d2e46d_074a_4925_b54d_4a52299d9d93 = vnr {
    nam = 'Am I a Monster?',
    notes = '++',
    bgimg = function(s)
        if (true) then
            return 'images/1.3.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Only now, looking at this trembling man, you felt a wild hunger, like it was burning you from within.");
pn();
pn(" Slowly, looking at the mugger, you began to approach him. The guy\'s nerves wavered, he dropped his knife and the stolen bag, and he ran screaming loudly.");
pn();
pn(" But you were faster. By a single quick bound, you jumped up to him and bit into his throat. Your prey\'s scream died on his lips and you began the horrible feast…");
pn();
pn("");
pn();
    end,
    walk_to = "v_85d2e46d_074a_4925_b54d_4a52299d9d93_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_85d2e46d_074a_4925_b54d_4a52299d9d93_snds');
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
_wolfiness = _wolfiness + 1;
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
    end,
    sndout = function(s) end,
};

v_85d2e46d_074a_4925_b54d_4a52299d9d93_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if true then
        nlb:nlbwalk(v_85d2e46d_074a_4925_b54d_4a52299d9d93, v_5d3bc0dc_ad8f_48d9_ba6d_66a39afd9915, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- ++
v_5a8afdd9_5412_424e_b72e_1373d99795a2 = vnr {
    nam = 'Am I a Monster?',
    notes = '++',
    bgimg = function(s)
        if (true) then
            return 'images/1.2.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("You bared your teeth and loudly roared, pretending that you were about to attack the mugger. It was enough. He threw the knife and even the bag and ran down the street. Soon he disappeared from your sight.");
pn();
pn("You came closer to the bag and caught the scent of groceries.  Bread, cheese, some vegetables... raw meat!");
pn();
pn("Only now you realized how hungry you were. You shook out the contents of the bag and greedily dug in the meat like a wild beast. Actually, you were a wild beast!");
pn();
    end,
    walk_to = "v_5a8afdd9_5412_424e_b72e_1373d99795a2_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_5a8afdd9_5412_424e_b72e_1373d99795a2_snds');
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
    end,
    sndout = function(s) end,
};

v_5a8afdd9_5412_424e_b72e_1373d99795a2_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if true then
        nlb:nlbwalk(v_5a8afdd9_5412_424e_b72e_1373d99795a2, v_5d3bc0dc_ad8f_48d9_ba6d_66a39afd9915, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- ++
v_5b5d038f_ce4d_4cc8_8bee_81de8528b1a5 = vnr {
    nam = 'Am I a Monster?',
    notes = '++',
    bgimg = function(s)
        if (true) then
            return 'images/1.1.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("It was not the best idea to run towards the armed policemen. You turned your head back, and longingly looked at the fence. No man can jump that high.");
pn();
pn("But when you heard gunshots, your body began to move instinctually by itself. You took hard off the ground and rocketed into the air, landing on the other side of the fence.");
pn();
pn(" No time to waste before your pursuers would find a roundabout way, you ran through the narrow streets up hill and down dale, trying to get as far from there as possible.");
pn();
pn("");
pn();
pn("Like a hairy whirlwind you ran into a side street and nearly bumped into a struggling couple. It appeared that another crime was in progress.");
pn();
pn(" A muscular skinny fellow wearing a mask and a leather jacket was quietly trying to snatch a bag from a woman.");
pn();
pn(" She was trying to fend him off. The sight of your appearance struck them like lightning. The woman\'s eyes bugged out, she immediately released her bag, and she ran behind the corner, screaming.  The mugger stepped back to the wall, brandishing the knife in his fist.");
pn();
pn("");
pn();
    end,
    walk_to = "v_5b5d038f_ce4d_4cc8_8bee_81de8528b1a5_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_5b5d038f_ce4d_4cc8_8bee_81de8528b1a5_snds');
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
    end,
    sndout = function(s) end,
};

v_5b5d038f_ce4d_4cc8_8bee_81de8528b1a5_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
        vn.skip_mode = false;
        vn:unlock_direct();
        put(v_167bc539_44e2_41f0_83c9_78dee52b4602);
        put(v_69073172_bc58_4080_90a2_b011140925f4);
        s:initf();
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

v_167bc539_44e2_41f0_83c9_78dee52b4602 = menu {
    nam = "v_167bc539_44e2_41f0_83c9_78dee52b4602",
    dsc = function(s) return "{Eat the mugger}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_5b5d038f_ce4d_4cc8_8bee_81de8528b1a5, v_85d2e46d_074a_4925_b54d_4a52299d9d93, false); 
    end
}

v_69073172_bc58_4080_90a2_b011140925f4 = menu {
    nam = "v_69073172_bc58_4080_90a2_b011140925f4",
    dsc = function(s) return "{Scare the mugger off}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_5b5d038f_ce4d_4cc8_8bee_81de8528b1a5, v_5a8afdd9_5412_424e_b72e_1373d99795a2, false); 
    end
}

-- 
v_34e50ebc_ea2b_4714_81a1_ae8fca22c399 = vnr {
    nam = 'Am I a Monster?',
    notes = 'Бар для дальнобойщиков',
    bgimg = function(s)

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
    end,
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        if ((_barExit)) then         nlb:nlbwalk(v_34e50ebc_ea2b_4714_81a1_ae8fca22c399, v_5ce20904_0ac9_422b_b8c6_ad6dbc89d981, false); 

        return false;
 end;
        if (( not _barExit)) then         nlb:nlbwalk(v_34e50ebc_ea2b_4714_81a1_ae8fca22c399, v_4a4652ec_a6c1_4619_b82e_d469e6227589, true); 

        return false;
 end;
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_34e50ebc_ea2b_4714_81a1_ae8fca22c399_snds');
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
            set_music('sound/in_limbo__rock_prog__-_reminiscences.ogg', 0);
    end,
    sndout = function(s) end,
};

-- 6.
v_4a4652ec_a6c1_4619_b82e_d469e6227589 = vnr {
    nam = 'Am I a Monster?',
    notes = '6.',
    bgimg = function(s)
        if (true) then
            return 'images/6.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Усевшись за столик, вы с досадой вспомнили, что денег-то нету. Автоматически пошарив в карманах брюк, вы обнаружили скомканную, ещё влажную купюру.");
pn();
pn(" Этого должно было хватить на чашку чая. Нарушив ваше уединение, за столик подсел бородатый мужик в клетчатой рубахе.");
pn();
pn("");
pn();
    end,
    walk_to = "v_4a4652ec_a6c1_4619_b82e_d469e6227589_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_4a4652ec_a6c1_4619_b82e_d469e6227589_snds');
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
nlb:setAchievement(statsAPI, 'THE_BAR', '4f73756b-4755-4cad-ac48-7e32e0d1e39b');
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
    end,
    sndout = function(s) end,
};

v_4a4652ec_a6c1_4619_b82e_d469e6227589_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if ( not _barExit) then
        nlb:nlbwalk(v_4a4652ec_a6c1_4619_b82e_d469e6227589, v_2ff7b229_4eb9_4c30_8962_4d8ed95a490b, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 13.
v_a470c96a_d30d_4944_80b4_4623c297afe3 = vnr {
    nam = 'Am I a Monster?',
    notes = '13.',
    bgimg = function(s)
        if (true) then
            return 'images/13.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Когда вы покинули царство Морфея, уже стемнело. Жутко хотелось есть. Выбравшись из укрытия, вы заметили как из бара вышел утренний знакомец. Увидев его, вы поняли, что очень, очень голодны.");
pn();
    end,
    walk_to = "v_a470c96a_d30d_4944_80b4_4623c297afe3_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_a470c96a_d30d_4944_80b4_4623c297afe3_snds');
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
    end,
    sndout = function(s) end,
};

v_a470c96a_d30d_4944_80b4_4623c297afe3_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
        vn.skip_mode = false;
        vn:unlock_direct();
if ( not _barExit) then
        put(v_f39496db_aea7_4694_9937_b261503b7bdc);
end;
if ( not _barExit) then
        put(v_cb8d4efa_0386_4ceb_8e54_9b551048d9af);
end;
        s:initf();
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

v_f39496db_aea7_4694_9937_b261503b7bdc = menu {
    nam = "v_f39496db_aea7_4694_9937_b261503b7bdc",
    dsc = function(s) return "{Съесть философа}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_a470c96a_d30d_4944_80b4_4623c297afe3, v_46fc2603_670d_4e23_8ce1_618e20143ea2, false); 
    end
}

v_cb8d4efa_0386_4ceb_8e54_9b551048d9af = menu {
    nam = "v_cb8d4efa_0386_4ceb_8e54_9b551048d9af",
    dsc = function(s) return "{Украсть еду с кухни}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_a470c96a_d30d_4944_80b4_4623c297afe3, v_338bd8d1_fc55_42c0_8e67_65f58628a5c0, false); 
    end
}

-- 7.
v_2ff7b229_4eb9_4c30_8962_4d8ed95a490b = vnr {
    nam = 'Am I a Monster?',
    notes = '7.',
    bgimg = function(s)
        if (true) then
            return 'images/7.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("-- Доброго вам утречка! -- сказал мужик.");
pn();
    end,
    walk_to = "v_2ff7b229_4eb9_4c30_8962_4d8ed95a490b_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_2ff7b229_4eb9_4c30_8962_4d8ed95a490b_snds');
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
    end,
    sndout = function(s) end,
};

v_2ff7b229_4eb9_4c30_8962_4d8ed95a490b_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if (_wolfiness ~= nil) and (( not _barExit) and (_wolfiness <= 0)) then
        nlb:nlbwalk(v_2ff7b229_4eb9_4c30_8962_4d8ed95a490b, v_94e84eb0_0ba0_475f_b839_71da445fa595, false); 
    return;
end;
if (_wolfiness ~= nil) and (( not _barExit) and (_wolfiness > 0)) then
        nlb:nlbwalk(v_2ff7b229_4eb9_4c30_8962_4d8ed95a490b, v_b2f0838e_3068_4850_ad2f_4944075de38b, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 11.  +1ч
v_338bd8d1_fc55_42c0_8e67_65f58628a5c0 = vnr {
    nam = 'Am I a Monster?',
    notes = '11.  +1ч',
    bgimg = function(s)
        if (true) then
            return 'images/11.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Всё же вам удалось взять себя в руки. Презрительно отвернувшись, вы тенью промелькнули к помещению, откуда доносились ароматы съестного.");
pn();
pn(" Это оказалась кухня. На ваше счастье, там никого не было. Без труда запрыгнув в открытое окно, вы с удовольствием съели огромный кусок сырого мяса, которое повар оставил размораживаться.");
pn();
pn("");
pn();
    end,
    walk_to = "v_338bd8d1_fc55_42c0_8e67_65f58628a5c0_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_338bd8d1_fc55_42c0_8e67_65f58628a5c0_snds');
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
    end,
    sndout = function(s) end,
};

v_338bd8d1_fc55_42c0_8e67_65f58628a5c0_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if ( not _barExit) then
        nlb:nlbwalk(v_338bd8d1_fc55_42c0_8e67_65f58628a5c0, v_e40f707a_3934_43b4_b302_9ea6b4461531, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 9.  +1в
v_46fc2603_670d_4e23_8ce1_618e20143ea2 = vnr {
    nam = 'Am I a Monster?',
    notes = '9.  +1в',
    bgimg = function(s)
        if (true) then
            return 'images/9.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Бородач повернулся лицом к стене и застыл на месте, очевидно, справляя малую нужду.  Бесшумно подкравшись к нему, вы дождались, пока он повернётся, и, бросившись любителю чая на грудь, загрызли прежде, чем он успел пикнуть.");
pn();
    end,
    walk_to = "v_46fc2603_670d_4e23_8ce1_618e20143ea2_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_46fc2603_670d_4e23_8ce1_618e20143ea2_snds');
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
_wolfiness = _wolfiness + 1;
_hp = _hp + 1;
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
    end,
    sndout = function(s) end,
};

v_46fc2603_670d_4e23_8ce1_618e20143ea2_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if ( not _barExit) then
        nlb:nlbwalk(v_46fc2603_670d_4e23_8ce1_618e20143ea2, v_e40f707a_3934_43b4_b302_9ea6b4461531, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 12. Лезет в Интернет, узнаёт про средство
v_94e84eb0_0ba0_475f_b839_71da445fa595 = vnr {
    nam = 'Am I a Monster?',
    notes = '12. Лезет в Интернет, узнаёт про средство',
    bgimg = function(s)
        if (true) then
            return 'images/12.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("-- Здравствуйте, -- ответили вы.");
pn();
pn("-- У вас свободно?");
pn();
pn("-- Да, пожалуйста.");
pn();
pn("Свободных столиков было много, из чего вы сделали вывод, что мужик жаждал общения. Но вам требовалось уединение, чтобы как следует подумать о той ситуации, в которой вы оказались.");
pn();
pn(" Как раз в этот момент принесли чай. Выпив его почти залпом, вы поспешили встать из-за стола, так как вам в голову пришла отличная идея: почитать про оборотней в интернете.");
pn();
pn(" Выйдя на улицу, вы сняли с шеи телефон. Вот какую информацию вам удалось найти: \"Превратиться в волка можно не только после укуса.");
pn();
pn(" Если накинуть на плечи волчью шкуру и произнести заклинание, вы станете волколаком. Волколак -- очень сильный и хитрый.");
pn();
pn(" Лучшее средство победить его -- вонзить кол из боярышника\". Вы вспомнили, как несколько дней назад гостили у одного товарища в загородном доме.");
pn();
pn(" Там вы действительно примеряли волчью шкуру… Решив отдохнуть в ближайшей роще, а вечером отправиться в дом злодея, заколдовавшего вас, вы спрятались в густом кустарнике, где и заснули под мерное гудение пчёл.");
pn();
pn("");
pn();
    end,
    walk_to = "v_94e84eb0_0ba0_475f_b839_71da445fa595_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_94e84eb0_0ba0_475f_b839_71da445fa595_snds');
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
nlb:setAchievement(statsAPI, 'INTERNET_SEARCH', 'd899954b-f58d-405e-88df-09e87e1f72b6');
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
    end,
    sndout = function(s) end,
};

v_94e84eb0_0ba0_475f_b839_71da445fa595_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if ( not _barExit) then
        nlb:nlbwalk(v_94e84eb0_0ba0_475f_b839_71da445fa595, v_a470c96a_d30d_4944_80b4_4623c297afe3, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 10. Узнав про волчью шкуру, он понял, кто его превратил, и пошёл к нему домой. А путь его пролегал через лес.
v_e40f707a_3934_43b4_b302_9ea6b4461531 = vnr {
    nam = 'Am I a Monster?',
    notes = '10. Узнав про волчью шкуру, он понял, кто его превратил, и пошёл к нему домой. А путь его пролегал через лес.',
    bgimg = function(s)
        if (true) then
            return 'images/10.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Основательно подкрепившись, вы, стараясь держаться поближе к деревьям, рысцой отправились в дом врага.");
pn();
    end,
    walk_to = "v_e40f707a_3934_43b4_b302_9ea6b4461531_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_e40f707a_3934_43b4_b302_9ea6b4461531_snds');
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
_barExit = true;
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
    end,
    sndout = function(s) end,
};

v_e40f707a_3934_43b4_b302_9ea6b4461531_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if true then
        nlb:nlbwalk(v_e40f707a_3934_43b4_b302_9ea6b4461531, v_34e50ebc_ea2b_4714_81a1_ae8fca22c399, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 8.
v_b2f0838e_3068_4850_ad2f_4944075de38b = vnr {
    nam = 'Am I a Monster?',
    notes = '8.',
    bgimg = function(s)
        if (true) then
            return 'images/8.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Вам не хотелось общаться. С недовольной гримасой на лице, вы нехотя кивнули в ответ.");
pn();
pn("-- А я вижу, у вас день не задался? -- не отставал бородач.");
pn();
pn("-- Да уж, -- рявкнули вы.");
pn();
pn("-- Потрясающе! -- воскликнул мужик. -- Вы типичный волколак.");
pn();
pn("-- Чего? -- не поняли вы.");
pn();
pn("-- Видите ли, я не всегда работал дальнобойщиком. По профессии я кандидат философских наук. Но жить на зарплату преподавателя...");
pn();
pn(" -- он вздохнул. -- Так вот, увидев вас, я отчего-то сразу вспомнил это мифическое существо. Оборотня.");
pn();
pn("");
pn();
pn("-- Меня никто не кусал, -- зачем-то сказали вы.");
pn();
pn("-- Для превращения в волколака это и не требуется! -- радостно воскликнул мужик, счастливый от того, что нашёл собеседника.");
pn();
pn("Вот это уже было интересно. Вы весь превратились в слух.");
pn();
pn("-- Достаточно накинуть волчью шкуру, произнести заклинание и дело сделано.");
pn();
pn("В этот момент принесли чай, но вам было не до него. Вы вспомнили, как несколько дней назад гостили у одного товарища в загородном доме. Там вы действительно примеряли волчью шкуру…");
pn();
pn("-- Что самое интересное, -- продолжал философ, -- самый надёжный способ убить такого оборотня -- это вонзить в него кол из боярышника.");
pn();
pn(" Вы, я вижу, не хотите чай? Так я выпью, пока он не остыл. -- С этими словами мужик взял чашку и, прежде чем вы успели его остановить, сделал большой глоток.");
pn();
pn("");
pn();
pn("-- А-а, хорошо. Зря не стали чай, очень недурственно.");
pn();
pn("Побагровев от ярости, вы встали из-за стола и практически выбежали из бара, стараясь не слушать возгласы нового знакомого, раздававшиеся вслед.");
pn();
pn(" Решив отдохнуть в ближайшей роще, а вечером отправиться в дом злодея, заколдовавшего вас, вы спрятались в густом кустарнике, где и заснули под мерное гудение пчёл.");
pn();
pn("");
pn();
    end,
    walk_to = "v_b2f0838e_3068_4850_ad2f_4944075de38b_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_b2f0838e_3068_4850_ad2f_4944075de38b_snds');
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
nlb:setAchievement(statsAPI, 'PHILOSOPHER_CONVERSATION', '5459b066-6aab-485d-b3ce-ea89c5c3b096');
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
    end,
    sndout = function(s) end,
};

v_b2f0838e_3068_4850_ad2f_4944075de38b_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if ( not _barExit) then
        nlb:nlbwalk(v_b2f0838e_3068_4850_ad2f_4944075de38b, v_0f773e1b_130f_465d_a8e5_3cabc8bfc1d1, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 13.
v_0f773e1b_130f_465d_a8e5_3cabc8bfc1d1 = vnr {
    nam = 'Am I a Monster?',
    notes = '13.',
    bgimg = function(s)
        if (true) then
            return 'images/13.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Когда вы покинули царство Морфея, уже стемнело. Жутко хотелось есть. Выбравшись из укрытия, вы заметили как из бара вышел философ. Гнев захватил вас, словно водоворот.");
pn();
    end,
    walk_to = "v_0f773e1b_130f_465d_a8e5_3cabc8bfc1d1_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_0f773e1b_130f_465d_a8e5_3cabc8bfc1d1_snds');
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
    end,
    sndout = function(s) end,
};

v_0f773e1b_130f_465d_a8e5_3cabc8bfc1d1_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
        vn.skip_mode = false;
        vn:unlock_direct();
if ( not _barExit) then
        put(v_179d0a83_813c_461c_8ae4_257bedeea33a);
end;
if ( not _barExit) then
        put(v_fab7dbf7_e99d_44d0_80dc_a1ddc04088db);
end;
        s:initf();
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

v_179d0a83_813c_461c_8ae4_257bedeea33a = menu {
    nam = "v_179d0a83_813c_461c_8ae4_257bedeea33a",
    dsc = function(s) return "{Съесть философа}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_0f773e1b_130f_465d_a8e5_3cabc8bfc1d1, v_46fc2603_670d_4e23_8ce1_618e20143ea2, false); 
    end
}

v_fab7dbf7_e99d_44d0_80dc_a1ddc04088db = menu {
    nam = "v_fab7dbf7_e99d_44d0_80dc_a1ddc04088db",
    dsc = function(s) return "{Украсть еду с кухни}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_0f773e1b_130f_465d_a8e5_3cabc8bfc1d1, v_338bd8d1_fc55_42c0_8e67_65f58628a5c0, false); 
    end
}

-- ++
v_5d3bc0dc_ad8f_48d9_ba6d_66a39afd9915 = vnr {
    nam = 'Am I a Monster?',
    notes = '++',
    bgimg = function(s)
        if (true) then
            return 'images/1.4.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("You were running down the night streets and armed people loomed behind every corner. The wind in your ears seemed like bullets whizzing by.");
pn();
pn("But the most important question was what or who made you turn into a wolf. You was absolutely sure that no animal bit or even scratched you. You were confused.");
pn();
pn("Now there were fewer houses on the street. It looked like the edge of town. You clearly remembered that there were a zoo somewhere near with a wolf cage in it.");
pn();
pn(" Currently people were more dangerous to you than wolves, and a crazy idea came to your mind. What if you could lose your pursuers by hiding in the wolf pack at the zoo? At least you\'d survive the night. What would happen next you tried not to think of.");
pn();
pn("");
pn();
pn("It was easy to hop over the wolf enclosure fence, much easier than the concrete wall. The scared wolves huddled up, looking at you with their teeth bared.");
pn();
pn(" It appeared they felt that you were the wrong wolf to mess with, but seeing that you didn\'t intend to attack, eventually they calmed down and returned to their routine.");
pn();
pn("");
pn();
    end,
    walk_to = "v_5d3bc0dc_ad8f_48d9_ba6d_66a39afd9915_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_5d3bc0dc_ad8f_48d9_ba6d_66a39afd9915_snds');
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
nlb:setAchievement(statsAPI, 'THE_ZOO', 'd8d50e75-020f-42e9-943d-f2cedb21abff');
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
            set_music('sound/smiling_cynic_-_beat_me.ogg', 0);
    end,
    sndout = function(s) end,
};

v_5d3bc0dc_ad8f_48d9_ba6d_66a39afd9915_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if (_wolfiness ~= nil) and (_wolfiness > 0) then
        nlb:nlbwalk(v_5d3bc0dc_ad8f_48d9_ba6d_66a39afd9915, v_30f2da3a_76a3_40b2_84f0_41714eb48ae4, false); 
    return;
end;
if (_wolfiness ~= nil) and (_wolfiness <= 0) then
        nlb:nlbwalk(v_5d3bc0dc_ad8f_48d9_ba6d_66a39afd9915, v_ffa05a49_c979_4e9f_9b89_42936e21b81a, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 
v_5ce20904_0ac9_422b_b8c6_ad6dbc89d981 = vnr {
    nam = 'Am I a Monster?',
    notes = 'Лес',
    bgimg = function(s)

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
    end,
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        if ((_forestExit)) then         nlb:nlbwalk(v_5ce20904_0ac9_422b_b8c6_ad6dbc89d981, v_b45ff8f3_4052_467e_bffa_4a420b67a7b3, false); 

        return false;
 end;
        if (( not _forestExit)) then         nlb:nlbwalk(v_5ce20904_0ac9_422b_b8c6_ad6dbc89d981, v_8bee9a84_d4f6_4ccd_857e_873bd07eb922, true); 

        return false;
 end;
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_5ce20904_0ac9_422b_b8c6_ad6dbc89d981_snds');
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
            set_music('sound/cloudjumper_-_a_full_mind.ogg', 0);
    end,
    sndout = function(s) end,
};

-- 
v_8bee9a84_d4f6_4ccd_857e_873bd07eb922 = vnr {
    nam = 'Am I a Monster?',
    notes = '',
    bgimg = function(s)

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
    end,
    walk_to = "v_8bee9a84_d4f6_4ccd_857e_873bd07eb922_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        if (true) then         nlb:nlbwalk(v_8bee9a84_d4f6_4ccd_857e_873bd07eb922, v_05837065_8160_469f_8b29_e07d87549656, true); 

        return false;
 end;
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_8bee9a84_d4f6_4ccd_857e_873bd07eb922_snds');
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

v_8bee9a84_d4f6_4ccd_857e_873bd07eb922_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
        vn.skip_mode = false;
        vn:unlock_direct();
if ( not _forestExit) then
        put(v_93a2e5c6_177f_4c0d_8437_a6691403960b);
end;
if ( not _forestExit) then
        put(v_8c641e8f_9d6b_4d0d_8551_1092f4fe3808);
end;
        s:initf();
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

v_93a2e5c6_177f_4c0d_8437_a6691403960b = menu {
    nam = "v_93a2e5c6_177f_4c0d_8437_a6691403960b",
    dsc = function(s) return "{Налево}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_8bee9a84_d4f6_4ccd_857e_873bd07eb922, v_67573c54_0976_4a54_a3c9_f70696f5feae, false); 
    end
}

v_8c641e8f_9d6b_4d0d_8551_1092f4fe3808 = menu {
    nam = "v_8c641e8f_9d6b_4d0d_8551_1092f4fe3808",
    dsc = function(s) return "{Направо}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_8bee9a84_d4f6_4ccd_857e_873bd07eb922, v_f293bb53_86f5_4600_ac29_3b60e8da760e, false); 
    end
}

-- 15.
v_05837065_8160_469f_8b29_e07d87549656 = vnr {
    nam = 'Am I a Monster?',
    notes = '15.',
    bgimg = function(s)
        if (true) then
            return 'images/15.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Чтобы сократить путь, вы решили свернуть в лес. Вскоре вы заметили две тропинки. Бежать по дорожке было бы удобнее, но какую выбрать?");
pn();
    end,
    walk_to = "v_05837065_8160_469f_8b29_e07d87549656_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_05837065_8160_469f_8b29_e07d87549656_snds');
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
    end,
    sndout = function(s) end,
};

v_05837065_8160_469f_8b29_e07d87549656_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if (_wolfiness ~= nil) and (_wolfiness > 1) then
        nlb:nlbwalk(v_05837065_8160_469f_8b29_e07d87549656, v_3792ac23_4da9_4539_a393_95780a98771a, false); 
    return;
end;
if (_wolfiness ~= nil) and (_wolfiness <= 1) then
        nlb:nlbwalk(v_05837065_8160_469f_8b29_e07d87549656, v_58180cad_f8db_42f7_a04a_994e1c56f991, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 16. Запах так и манил направо
v_3792ac23_4da9_4539_a393_95780a98771a = vnr {
    nam = 'Am I a Monster?',
    notes = '16. Запах так и манил направо',
    bgimg = function(s)
        if (true) then
            return 'images/16.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Вы принюхались. Какой-то новый, но очень знакомый запах так и манил вас направо.");
pn();
    end,
    walk_to = "v_3792ac23_4da9_4539_a393_95780a98771a_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_3792ac23_4da9_4539_a393_95780a98771a_snds');
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
    end,
    sndout = function(s) end,
};

v_3792ac23_4da9_4539_a393_95780a98771a_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
        vn.skip_mode = false;
        vn:unlock_direct();
        put(v_3792ac23_4da9_4539_a393_95780a98771a_67573c54_0976_4a54_a3c9_f70696f5feae_93a2e5c6_177f_4c0d_8437_a6691403960b_Return);
        put(v_3792ac23_4da9_4539_a393_95780a98771a_f293bb53_86f5_4600_ac29_3b60e8da760e_8c641e8f_9d6b_4d0d_8551_1092f4fe3808_Return);
        s:initf();
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

v_3792ac23_4da9_4539_a393_95780a98771a_67573c54_0976_4a54_a3c9_f70696f5feae_93a2e5c6_177f_4c0d_8437_a6691403960b_Return = menu {
    nam = "v_3792ac23_4da9_4539_a393_95780a98771a_67573c54_0976_4a54_a3c9_f70696f5feae_93a2e5c6_177f_4c0d_8437_a6691403960b_Return",
    dsc = function(s) return "{Налево}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_3792ac23_4da9_4539_a393_95780a98771a, v_67573c54_0976_4a54_a3c9_f70696f5feae, false); 
    end
}

v_3792ac23_4da9_4539_a393_95780a98771a_f293bb53_86f5_4600_ac29_3b60e8da760e_8c641e8f_9d6b_4d0d_8551_1092f4fe3808_Return = menu {
    nam = "v_3792ac23_4da9_4539_a393_95780a98771a_f293bb53_86f5_4600_ac29_3b60e8da760e_8c641e8f_9d6b_4d0d_8551_1092f4fe3808_Return",
    dsc = function(s) return "{Направо}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_3792ac23_4da9_4539_a393_95780a98771a, v_f293bb53_86f5_4600_ac29_3b60e8da760e, false); 
    end
}

-- 17.
v_58180cad_f8db_42f7_a04a_994e1c56f991 = vnr {
    nam = 'Am I a Monster?',
    notes = '17.',
    bgimg = function(s)
        if (true) then
            return 'images/17.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Вы принюхались. В воздухе чувствовалась масса разнообразных запахов.");
pn();
    end,
    walk_to = "v_58180cad_f8db_42f7_a04a_994e1c56f991_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_58180cad_f8db_42f7_a04a_994e1c56f991_snds');
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
    end,
    sndout = function(s) end,
};

v_58180cad_f8db_42f7_a04a_994e1c56f991_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
        vn.skip_mode = false;
        vn:unlock_direct();
        put(v_58180cad_f8db_42f7_a04a_994e1c56f991_67573c54_0976_4a54_a3c9_f70696f5feae_93a2e5c6_177f_4c0d_8437_a6691403960b_Return);
        put(v_58180cad_f8db_42f7_a04a_994e1c56f991_f293bb53_86f5_4600_ac29_3b60e8da760e_8c641e8f_9d6b_4d0d_8551_1092f4fe3808_Return);
        s:initf();
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

v_58180cad_f8db_42f7_a04a_994e1c56f991_67573c54_0976_4a54_a3c9_f70696f5feae_93a2e5c6_177f_4c0d_8437_a6691403960b_Return = menu {
    nam = "v_58180cad_f8db_42f7_a04a_994e1c56f991_67573c54_0976_4a54_a3c9_f70696f5feae_93a2e5c6_177f_4c0d_8437_a6691403960b_Return",
    dsc = function(s) return "{Налево}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_58180cad_f8db_42f7_a04a_994e1c56f991, v_67573c54_0976_4a54_a3c9_f70696f5feae, false); 
    end
}

v_58180cad_f8db_42f7_a04a_994e1c56f991_f293bb53_86f5_4600_ac29_3b60e8da760e_8c641e8f_9d6b_4d0d_8551_1092f4fe3808_Return = menu {
    nam = "v_58180cad_f8db_42f7_a04a_994e1c56f991_f293bb53_86f5_4600_ac29_3b60e8da760e_8c641e8f_9d6b_4d0d_8551_1092f4fe3808_Return",
    dsc = function(s) return "{Направо}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_58180cad_f8db_42f7_a04a_994e1c56f991, v_f293bb53_86f5_4600_ac29_3b60e8da760e, false); 
    end
}

-- 22.
v_86893ac1_6506_4fdd_bbfc_8008d6ad6b31 = vnr {
    nam = 'Am I a Monster?',
    notes = '22.',
    bgimg = function(s)
        if (true) then
            return 'images/22.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Ваше животное чутьё подсказывало, что дом врага уже совсем близко. Вы ускорили бег.");
pn();
    end,
    walk_to = "v_86893ac1_6506_4fdd_bbfc_8008d6ad6b31_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_86893ac1_6506_4fdd_bbfc_8008d6ad6b31_snds');
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
_forestExit = true;
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
            set_music('sound/smiling_cynic_-_beat_me.ogg', 0);
    end,
    sndout = function(s) end,
};

v_86893ac1_6506_4fdd_bbfc_8008d6ad6b31_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if true then
        nlb:nlbwalk(v_86893ac1_6506_4fdd_bbfc_8008d6ad6b31, v_5ce20904_0ac9_422b_b8c6_ad6dbc89d981, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 19. Тут путник
v_f87e0749_c4b3_4a3f_878b_47964d1994ab = vnr {
    nam = 'Am I a Monster?',
    notes = '19. Тут путник',
    bgimg = function(s)
        if (true) then
            return 'images/19.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Вы выбрали левый поворот. Вдруг, вы услышали лёгкое шуршание. Кто-то двигался вам навстречу. Затаившись в кустах, вы увидели запоздалого путника. Он двигался по дорожке, испуганно озираясь.");
pn();
    end,
    walk_to = "v_f87e0749_c4b3_4a3f_878b_47964d1994ab_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_f87e0749_c4b3_4a3f_878b_47964d1994ab_snds');
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
    end,
    sndout = function(s) end,
};

v_f87e0749_c4b3_4a3f_878b_47964d1994ab_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
        vn.skip_mode = false;
        vn:unlock_direct();
if ( not _forestExit) then
        put(v_012bbd53_638b_4d2b_8021_95c1b0e5e1eb);
end;
if ( not _forestExit) then
        put(v_adf150b2_c8de_4dda_95ac_3ab56f281157);
end;
        s:initf();
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

v_012bbd53_638b_4d2b_8021_95c1b0e5e1eb = menu {
    nam = "v_012bbd53_638b_4d2b_8021_95c1b0e5e1eb",
    dsc = function(s) return "{Съесть путника}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_f87e0749_c4b3_4a3f_878b_47964d1994ab, v_0d9f5052_9f0a_4a5d_892b_05d8ac7f713f, false); 
    end
}

v_adf150b2_c8de_4dda_95ac_3ab56f281157 = menu {
    nam = "v_adf150b2_c8de_4dda_95ac_3ab56f281157",
    dsc = function(s) return "{Не есть путника}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_f87e0749_c4b3_4a3f_878b_47964d1994ab, v_db1bdcfc_0184_46ea_8194_d7cdbbf3b8fb, false); 
    end
}

-- 21.  +1ч
v_db1bdcfc_0184_46ea_8194_d7cdbbf3b8fb = vnr {
    nam = 'Am I a Monster?',
    notes = '21.  +1ч',
    bgimg = function(s)
        if (true) then
            return 'images/21.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Вам некогда было с ним возиться, поэтому, как только он прошёл, вы побежали дальше.");
pn();
    end,
    walk_to = "v_db1bdcfc_0184_46ea_8194_d7cdbbf3b8fb_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_db1bdcfc_0184_46ea_8194_d7cdbbf3b8fb_snds');
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
            set_music('sound/smiling_cynic_-_beat_me.ogg', 0);
    end,
    sndout = function(s) end,
};

v_db1bdcfc_0184_46ea_8194_d7cdbbf3b8fb_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if ( not _forestExit) then
        nlb:nlbwalk(v_db1bdcfc_0184_46ea_8194_d7cdbbf3b8fb, v_86893ac1_6506_4fdd_bbfc_8008d6ad6b31, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 18.
v_67573c54_0976_4a54_a3c9_f70696f5feae = vnr {
    nam = 'Am I a Monster?',
    notes = '18.',
    bgimg = function(s)
        if (true) then
            return 'images/18.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Вы повернули налево. Пробежав некоторое расстояние, вы снова оказались на развилке.");
pn();
    end,
    walk_to = "v_67573c54_0976_4a54_a3c9_f70696f5feae_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_67573c54_0976_4a54_a3c9_f70696f5feae_snds');
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
    end,
    sndout = function(s) end,
};

v_67573c54_0976_4a54_a3c9_f70696f5feae_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
        vn.skip_mode = false;
        vn:unlock_direct();
if ( not _forestExit) then
        put(v_97edec47_7e41_4e6d_886a_e3c29ddaaca4);
end;
if ( not _forestExit) then
        put(v_2fd1636c_29c5_42dc_bf75_bac572830904);
end;
        s:initf();
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

v_97edec47_7e41_4e6d_886a_e3c29ddaaca4 = menu {
    nam = "v_97edec47_7e41_4e6d_886a_e3c29ddaaca4",
    dsc = function(s) return "{Налево}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_67573c54_0976_4a54_a3c9_f70696f5feae, v_f87e0749_c4b3_4a3f_878b_47964d1994ab, false); 
    end
}

v_2fd1636c_29c5_42dc_bf75_bac572830904 = menu {
    nam = "v_2fd1636c_29c5_42dc_bf75_bac572830904",
    dsc = function(s) return "{Направо}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_67573c54_0976_4a54_a3c9_f70696f5feae, v_86893ac1_6506_4fdd_bbfc_8008d6ad6b31, false); 
    end
}

-- 20.  +1в
v_0d9f5052_9f0a_4a5d_892b_05d8ac7f713f = vnr {
    nam = 'Am I a Monster?',
    notes = '20.  +1в',
    bgimg = function(s)
        if (true) then
            return 'images/20.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Зверского аппетита вы не чувствовали, но упустить лёгкую добычу было бы глупо. Когда человек поравнялся с вашим укрытием, вы, молнией кинулись на него. Похоже, жертва даже не успела понять что происходит, как вы уже перегрызли ей горло.");
pn();
    end,
    walk_to = "v_0d9f5052_9f0a_4a5d_892b_05d8ac7f713f_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_0d9f5052_9f0a_4a5d_892b_05d8ac7f713f_snds');
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
_wolfiness = _wolfiness + 1;
_hp = _hp + 1;
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
    end,
    sndout = function(s) end,
};

v_0d9f5052_9f0a_4a5d_892b_05d8ac7f713f_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if ( not _forestExit) then
        nlb:nlbwalk(v_0d9f5052_9f0a_4a5d_892b_05d8ac7f713f, v_86893ac1_6506_4fdd_bbfc_8008d6ad6b31, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- Тут волки!
v_f293bb53_86f5_4600_ac29_3b60e8da760e = vnr {
    nam = 'Am I a Monster?',
    notes = 'Тут волки!',
    bgimg = function(s)

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
    end,
    walk_to = "v_f293bb53_86f5_4600_ac29_3b60e8da760e_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        if (true) then         nlb:nlbwalk(v_f293bb53_86f5_4600_ac29_3b60e8da760e, v_e10b657b_d06c_4b34_be66_a7322266755c, true); 

        return false;
 end;
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_f293bb53_86f5_4600_ac29_3b60e8da760e_snds');
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

v_f293bb53_86f5_4600_ac29_3b60e8da760e_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
        vn.skip_mode = false;
        vn:unlock_direct();
if ( not _forestExit) then
        put(v_cc1a2ff4_84e8_4357_bbce_5dd14271a658);
end;
if ( not _forestExit) then
        put(v_b9cfbc2f_51dd_4e99_8a84_190ef08eb1c0);
end;
        s:initf();
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

v_cc1a2ff4_84e8_4357_bbce_5dd14271a658 = menu {
    nam = "v_cc1a2ff4_84e8_4357_bbce_5dd14271a658",
    dsc = function(s) return "{Налево}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_f293bb53_86f5_4600_ac29_3b60e8da760e, v_f87e0749_c4b3_4a3f_878b_47964d1994ab, false); 
    end
}

v_b9cfbc2f_51dd_4e99_8a84_190ef08eb1c0 = menu {
    nam = "v_b9cfbc2f_51dd_4e99_8a84_190ef08eb1c0",
    dsc = function(s) return "{Направо}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_f293bb53_86f5_4600_ac29_3b60e8da760e, v_86893ac1_6506_4fdd_bbfc_8008d6ad6b31, false); 
    end
}

-- 23.
v_e10b657b_d06c_4b34_be66_a7322266755c = vnr {
    nam = 'Am I a Monster?',
    notes = '23.',
    bgimg = function(s)
        if (true) then
            return 'images/23.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Вы повернули направо. Казалось, лес стал гуще.");
pn();
    end,
    walk_to = "v_e10b657b_d06c_4b34_be66_a7322266755c_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_e10b657b_d06c_4b34_be66_a7322266755c_snds');
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
    end,
    sndout = function(s) end,
};

v_e10b657b_d06c_4b34_be66_a7322266755c_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if (_wolfiness ~= nil) and (_wolfiness > 1) then
        nlb:nlbwalk(v_e10b657b_d06c_4b34_be66_a7322266755c, v_4d0291af_49a6_42ab_ae94_4e039cb15072, false); 
    return;
end;
if (_wolfiness ~= nil) and (_wolfiness <= 1) then
        nlb:nlbwalk(v_e10b657b_d06c_4b34_be66_a7322266755c, v_a27840f3_04f2_4156_8854_1abf0061e0c9, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 24.
v_4d0291af_49a6_42ab_ae94_4e039cb15072 = vnr {
    nam = 'Am I a Monster?',
    notes = '24.',
    bgimg = function(s)
        if (true) then
            return 'images/24.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Привлекший вас запах усилился. В кустах то и дело раздавались какие-то шорохи. Вы остановились, словно чего-то ожидая. На тропинку, прямо перед вами, не спеша вышел волк. Точнее, волчица.");
pn();
pn("-- Кто ты? -- автоматически спросили вы.");
pn();
pn("-- Волколак, как и ты, -- ответила она. -- После превращения я спряталась здесь. Теперь мы живём тут все вместе.");
pn();
pn("-- Вас много?! -- удивились вы.");
pn();
pn("-- Нет, всего пятеро. Оставайся и ты с нами, -- предложила она.");
pn();
pn("Это звучало очень заманчиво. Но вы хотели понять, за что вас заколдовали и отомстить.");
pn();
pn("-- Мне нужно закончить одно дело, -- сказали вы. -- Но, возможно, я ещё вернусь.");
pn();
pn("С этими словами вы побежали прочь. Вскоре вы оказались на развилке.");
pn();
    end,
    walk_to = "v_4d0291af_49a6_42ab_ae94_4e039cb15072_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_4d0291af_49a6_42ab_ae94_4e039cb15072_snds');
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
nlb:setAchievement(statsAPI, 'FOREST_MEETING', '8cb06267-ef0c-4686-96ea-3f5333e9ceae');
_wolvesTalk = true;
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
    end,
    sndout = function(s) end,
};

v_4d0291af_49a6_42ab_ae94_4e039cb15072_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
        vn.skip_mode = false;
        vn:unlock_direct();
        put(v_4d0291af_49a6_42ab_ae94_4e039cb15072_f87e0749_c4b3_4a3f_878b_47964d1994ab_cc1a2ff4_84e8_4357_bbce_5dd14271a658_Return);
        put(v_4d0291af_49a6_42ab_ae94_4e039cb15072_86893ac1_6506_4fdd_bbfc_8008d6ad6b31_b9cfbc2f_51dd_4e99_8a84_190ef08eb1c0_Return);
        s:initf();
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

v_4d0291af_49a6_42ab_ae94_4e039cb15072_f87e0749_c4b3_4a3f_878b_47964d1994ab_cc1a2ff4_84e8_4357_bbce_5dd14271a658_Return = menu {
    nam = "v_4d0291af_49a6_42ab_ae94_4e039cb15072_f87e0749_c4b3_4a3f_878b_47964d1994ab_cc1a2ff4_84e8_4357_bbce_5dd14271a658_Return",
    dsc = function(s) return "{Налево}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_4d0291af_49a6_42ab_ae94_4e039cb15072, v_f87e0749_c4b3_4a3f_878b_47964d1994ab, false); 
    end
}

v_4d0291af_49a6_42ab_ae94_4e039cb15072_86893ac1_6506_4fdd_bbfc_8008d6ad6b31_b9cfbc2f_51dd_4e99_8a84_190ef08eb1c0_Return = menu {
    nam = "v_4d0291af_49a6_42ab_ae94_4e039cb15072_86893ac1_6506_4fdd_bbfc_8008d6ad6b31_b9cfbc2f_51dd_4e99_8a84_190ef08eb1c0_Return",
    dsc = function(s) return "{Направо}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_4d0291af_49a6_42ab_ae94_4e039cb15072, v_86893ac1_6506_4fdd_bbfc_8008d6ad6b31, false); 
    end
}

-- 25.
v_a27840f3_04f2_4156_8854_1abf0061e0c9 = vnr {
    nam = 'Am I a Monster?',
    notes = '25.',
    bgimg = function(s)
        if (true) then
            return 'images/25.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("В кустах то и дело раздавались какие-то шорохи. Вам стало казаться, будто за вами следят. Но вы продолжали упрямо двигаться к своей цели, стараясь ни на что не обращать внимания. Вскоре, вы оказались на развилке.");
pn();
    end,
    walk_to = "v_a27840f3_04f2_4156_8854_1abf0061e0c9_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_a27840f3_04f2_4156_8854_1abf0061e0c9_snds');
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
    end,
    sndout = function(s) end,
};

v_a27840f3_04f2_4156_8854_1abf0061e0c9_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
        vn.skip_mode = false;
        vn:unlock_direct();
        put(v_a27840f3_04f2_4156_8854_1abf0061e0c9_f87e0749_c4b3_4a3f_878b_47964d1994ab_cc1a2ff4_84e8_4357_bbce_5dd14271a658_Return);
        put(v_a27840f3_04f2_4156_8854_1abf0061e0c9_86893ac1_6506_4fdd_bbfc_8008d6ad6b31_b9cfbc2f_51dd_4e99_8a84_190ef08eb1c0_Return);
        s:initf();
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

v_a27840f3_04f2_4156_8854_1abf0061e0c9_f87e0749_c4b3_4a3f_878b_47964d1994ab_cc1a2ff4_84e8_4357_bbce_5dd14271a658_Return = menu {
    nam = "v_a27840f3_04f2_4156_8854_1abf0061e0c9_f87e0749_c4b3_4a3f_878b_47964d1994ab_cc1a2ff4_84e8_4357_bbce_5dd14271a658_Return",
    dsc = function(s) return "{Налево}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_a27840f3_04f2_4156_8854_1abf0061e0c9, v_f87e0749_c4b3_4a3f_878b_47964d1994ab, false); 
    end
}

v_a27840f3_04f2_4156_8854_1abf0061e0c9_86893ac1_6506_4fdd_bbfc_8008d6ad6b31_b9cfbc2f_51dd_4e99_8a84_190ef08eb1c0_Return = menu {
    nam = "v_a27840f3_04f2_4156_8854_1abf0061e0c9_86893ac1_6506_4fdd_bbfc_8008d6ad6b31_b9cfbc2f_51dd_4e99_8a84_190ef08eb1c0_Return",
    dsc = function(s) return "{Направо}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_a27840f3_04f2_4156_8854_1abf0061e0c9, v_86893ac1_6506_4fdd_bbfc_8008d6ad6b31, false); 
    end
}

-- 
v_b45ff8f3_4052_467e_bffa_4a420b67a7b3 = vnr {
    nam = 'Am I a Monster?',
    notes = 'Волк-охранник',
    bgimg = function(s)

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
    end,
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        if ((_guardDone)) then         nlb:nlbwalk(v_b45ff8f3_4052_467e_bffa_4a420b67a7b3, v_d5044b52_9786_43aa_b097_67a7b3220d6a, false); 

        return false;
 end;
        if (( not _guardDone)) then         nlb:nlbwalk(v_b45ff8f3_4052_467e_bffa_4a420b67a7b3, v_5848772f_134b_412e_9e5e_f9d2feedb3b0, true); 

        return false;
 end;
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_b45ff8f3_4052_467e_bffa_4a420b67a7b3_snds');
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

-- 1.7
v_5848772f_134b_412e_9e5e_f9d2feedb3b0 = vnr {
    nam = 'Am I a Monster?',
    notes = '1.7',
    bgimg = function(s)
        if (true) then
            return 'images/1.7.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Наконец вы приблизились к дому своего врага. Вы узнали приземистый, но большой особняк с заброшенным садом, плавно переходящим в лес, из которого вы пришли.");
pn();
pn(" Чугунная ограда вокруг особняка была густо увита растениями, а лесные деревья подступали к ней вплотную.");
pn();
pn("");
pn();
pn("");
pn();
pn("Вы медленно стали подбираться ко входу в здание.");
pn();
    end,
    walk_to = "v_5848772f_134b_412e_9e5e_f9d2feedb3b0_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_5848772f_134b_412e_9e5e_f9d2feedb3b0_snds');
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
            set_music('sound/in_limbo__rock_prog__-_reminiscences.ogg', 0);
    end,
    sndout = function(s) end,
};

v_5848772f_134b_412e_9e5e_f9d2feedb3b0_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if (_wolfiness ~= nil) and (( not _guardDone) and (_wolfiness > 1)) then
        nlb:nlbwalk(v_5848772f_134b_412e_9e5e_f9d2feedb3b0, v_0e3e04d8_03e7_459d_8136_e7c135100101, false); 
    return;
end;
if (_wolfiness ~= nil) and (( not _guardDone) and (_wolfiness <= 1)) then
        nlb:nlbwalk(v_5848772f_134b_412e_9e5e_f9d2feedb3b0, v_433426b4_2e3f_4461_ab7a_e87119808471, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 33. Драка, победа, -1 жизнь
v_bc738a80_9890_4416_bead_3bbc8f533412 = vnr {
    nam = 'Am I a Monster?',
    notes = '33. Драка, победа, -1 жизнь',
    bgimg = function(s)
        if (true) then
            return 'images/33.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Соорудив примитивное оружие, вы вернулись к особняку. Вас встретил мускулистый лохматый мужчина. По выражению его лица вы поняли, что он по-прежнему не собирается вас пропускать.");
pn();
pn(" Оборотень кинулся на вас. Вы резко выбросили из-за спины руку с зажатым в ней колом. Охранник, не успев остановиться, налетел грудью прямо на острую палку.");
pn();
pn("");
pn();
    end,
    walk_to = "v_bc738a80_9890_4416_bead_3bbc8f533412_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_bc738a80_9890_4416_bead_3bbc8f533412_snds');
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
_hp = _hp - 1;
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
    end,
    sndout = function(s) end,
};

v_bc738a80_9890_4416_bead_3bbc8f533412_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if ( not _guardDone) then
        nlb:nlbwalk(v_bc738a80_9890_4416_bead_3bbc8f533412, v_6e8c1c0f_abd8_4e5c_83a5_7e3e003c7f46, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 28. Драка
v_d45d6de2_e019_4a32_87f8_5f97ab2fcbf9 = vnr {
    nam = 'Am I a Monster?',
    notes = '28. Драка',
    bgimg = function(s)
        if (true) then
            return 'images/28.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("-- Ты пропустишь меня? -- осторожно спросили вы.");
pn();
pn("-- Да, -- твёрдо сказал он. -- Но тебе придётся драться со мной.");
pn();
pn("Не сразу поняв смысл его противоречивых слов, вы кинулись на противника. Он не оказал сопротивления, и вы за пару секунд перегрызли ему горло.");
pn();
    end,
    walk_to = "v_d45d6de2_e019_4a32_87f8_5f97ab2fcbf9_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_d45d6de2_e019_4a32_87f8_5f97ab2fcbf9_snds');
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
nlb:setAchievement(statsAPI, 'GUARD_NOT_A_PROBLEM', '578e7076-b474-486f-b99e-40e0d953b6a5');
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
    end,
    sndout = function(s) end,
};

v_d45d6de2_e019_4a32_87f8_5f97ab2fcbf9_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if ( not _guardDone) then
        nlb:nlbwalk(v_d45d6de2_e019_4a32_87f8_5f97ab2fcbf9, v_d6b53c8e_e4ae_492c_8489_89a67cf8d41e, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 26.
v_0e3e04d8_03e7_459d_8136_e7c135100101 = vnr {
    nam = 'Am I a Monster?',
    notes = '26.',
    bgimg = function(s)
        if (true) then
            return 'images/26.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Внезапно раздалось рычание, и перед вами возник волк с оскаленной мордой. Это был огромный зверь, крупнее вас.");
pn();
pn(" Вы приготовились к драке, но монстр не спешил нападать. Шумно втянув носом воздух, он заговорил с вами:");
pn();
pn("");
pn();
pn("-- Кто ты? Откуда здесь взялся?");
pn();
pn("-- Хозяин этого дома сделал меня оборотнем. Я пришёл, чтобы разделаться с ним, -- честно ответили вы.");
pn();
pn("-- Ты тоже надевал волчью шкуру? -- уже мягче спросил зверь.");
pn();
pn("-- Да.");
pn();
pn("-- Меня он превратил тем же способом. Теперь я у него что-то вроде сторожевого пса, -- с тоской сообщил оборотень. -- Человеком мне уже не стать. А у тебя ещё есть шанс?");
pn();
pn("-- Не знаю. Но очень надеюсь.");
pn();
    end,
    walk_to = "v_0e3e04d8_03e7_459d_8136_e7c135100101_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_0e3e04d8_03e7_459d_8136_e7c135100101_snds');
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
    end,
    sndout = function(s) end,
};

v_0e3e04d8_03e7_459d_8136_e7c135100101_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if (( not _guardDone) and (_wolvesTalk)) then
        nlb:nlbwalk(v_0e3e04d8_03e7_459d_8136_e7c135100101, v_2eb72ffe_865a_4e51_aa9c_60af1b055fc3, false); 
    return;
end;
if (( not _guardDone) and ( not _wolvesTalk)) then
        nlb:nlbwalk(v_0e3e04d8_03e7_459d_8136_e7c135100101, v_d45d6de2_e019_4a32_87f8_5f97ab2fcbf9, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 35b
v_6e8c1c0f_abd8_4e5c_83a5_7e3e003c7f46 = vnr {
    nam = 'Am I a Monster?',
    notes = '35b',
    bgimg = function(s)
        if (true) then
            return 'images/35b.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Путь был свободен.");
pn();
    end,
    walk_to = "v_6e8c1c0f_abd8_4e5c_83a5_7e3e003c7f46_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_6e8c1c0f_abd8_4e5c_83a5_7e3e003c7f46_snds');
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
nlb:setAchievement(statsAPI, 'RIGHT_CHOICE', '39a83d0c-c7dc-478d-86db-b0a8aae12d7c');
_guardDone = true;
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
    end,
    sndout = function(s) end,
};

v_6e8c1c0f_abd8_4e5c_83a5_7e3e003c7f46_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if true then
        nlb:nlbwalk(v_6e8c1c0f_abd8_4e5c_83a5_7e3e003c7f46, v_b45ff8f3_4052_467e_bffa_4a420b67a7b3, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 27. Волк убежал
v_2eb72ffe_865a_4e51_aa9c_60af1b055fc3 = vnr {
    nam = 'Am I a Monster?',
    notes = '27. Волк убежал',
    bgimg = function(s)
        if (true) then
            return 'images/27.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Вспомнив недавнюю встречу, вы воскликнули:");
pn();
pn("-- А почему ты не убежишь в лес?");
pn();
pn("-- Скитаться в одиночестве? Нет.");
pn();
pn("-- Ты можешь жить в стае волков, которых я только что видел, -- предложили вы.");
pn();
pn("-- Здесь есть другие оборотни?! -- удивился охранник.");
pn();
pn("-- Да!");
pn();
pn("Вы рассказали коллеге по несчастью, где найти оборотней, и он тут же убежал в лес.");
pn();
    end,
    walk_to = "v_2eb72ffe_865a_4e51_aa9c_60af1b055fc3_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_2eb72ffe_865a_4e51_aa9c_60af1b055fc3_snds');
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
nlb:setAchievement(statsAPI, 'INFO_FOR_GUARD', '1e54b198-4705-4c5b-94c1-a3847b4f19e2');
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
    end,
    sndout = function(s) end,
};

v_2eb72ffe_865a_4e51_aa9c_60af1b055fc3_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if ( not _guardDone) then
        nlb:nlbwalk(v_2eb72ffe_865a_4e51_aa9c_60af1b055fc3, v_d6b53c8e_e4ae_492c_8489_89a67cf8d41e, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 35a
v_d6b53c8e_e4ae_492c_8489_89a67cf8d41e = vnr {
    nam = 'Am I a Monster?',
    notes = '35a',
    bgimg = function(s)
        if (true) then
            return 'images/35a.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Путь был свободен.");
pn();
    end,
    walk_to = "v_d6b53c8e_e4ae_492c_8489_89a67cf8d41e_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_d6b53c8e_e4ae_492c_8489_89a67cf8d41e_snds');
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
_guardDone = true;
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
    end,
    sndout = function(s) end,
};

v_d6b53c8e_e4ae_492c_8489_89a67cf8d41e_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if true then
        nlb:nlbwalk(v_d6b53c8e_e4ae_492c_8489_89a67cf8d41e, v_b45ff8f3_4052_467e_bffa_4a420b67a7b3, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 1.8 Вырвался и убежал
v_433426b4_2e3f_4461_ab7a_e87119808471 = vnr {
    nam = 'Am I a Monster?',
    notes = '1.8 Вырвался и убежал',
    bgimg = function(s)
        if (true) then
            return 'images/1.8.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Внезапно раздалось рычание, и перед вами возник волк с оскаленной мордой. Это был огромный зверь, крупнее вас.");
pn();
pn(" Как заворожённый, вы смотрели ему в глаза. Это было поистине жуткое зрелище: человеческие глаза на звериной морде с оскаленной пастью.");
pn();
pn("");
pn();
pn("");
pn();
pn("Зверь бросился вперёд, а вы кинулись ему навстречу. Хищник ловко парировал атаки, и вскоре стало понятно, что он сильнее и опытнее.");
pn();
pn(" Если бы битва продолжалась, навряд ли удалось бы выбраться отсюда живым, не говоря уже о том, чтобы одержать победу.");
pn();
pn("");
pn();
pn("");
pn();
pn("Улучив момент, вы нырнули в ближайшие кусты и бросились прочь. Кажется, противник не стал вас преследовать. По крайней мере, когда вы обернулись, сзади уже никого не было.");
pn();
    end,
    walk_to = "v_433426b4_2e3f_4461_ab7a_e87119808471_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_433426b4_2e3f_4461_ab7a_e87119808471_snds');
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
            set_music('sound/lukhash_-_failure.ogg', 0);
    end,
    sndout = function(s) end,
};

v_433426b4_2e3f_4461_ab7a_e87119808471_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if ( not _guardDone) then
        nlb:nlbwalk(v_433426b4_2e3f_4461_ab7a_e87119808471, v_0848f12f_cff7_4d6d_b67a_b1b996eb6322, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 32. Вы взяли калину
v_7e4ded08_354b_4c76_b876_2e8ac335fdad = vnr {
    nam = 'Am I a Monster?',
    notes = '32. Вы взяли калину',
    bgimg = function(s)
        if (true) then
            return 'images/31.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Ваш взгляд упал на растущую неподалёку калину.");
pn();
    end,
    walk_to = "v_7e4ded08_354b_4c76_b876_2e8ac335fdad_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_7e4ded08_354b_4c76_b876_2e8ac335fdad_snds');
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
    end,
    sndout = function(s) end,
};

v_7e4ded08_354b_4c76_b876_2e8ac335fdad_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if ( not _guardDone) then
        nlb:nlbwalk(v_7e4ded08_354b_4c76_b876_2e8ac335fdad, v_9a78cd0b_cc2b_4c46_bf73_e807ed71189c, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 
v_0848f12f_cff7_4d6d_b67a_b1b996eb6322 = vnr {
    nam = 'Am I a Monster?',
    notes = '',
    bgimg = function(s)

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
    end,
    walk_to = "v_0848f12f_cff7_4d6d_b67a_b1b996eb6322_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        if (true) then         nlb:nlbwalk(v_0848f12f_cff7_4d6d_b67a_b1b996eb6322, v_8c0da93f_8301_442b_a9fd_60d68d9610d0, true); 

        return false;
 end;
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_0848f12f_cff7_4d6d_b67a_b1b996eb6322_snds');
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
            set_music('sound/in_limbo__rock_prog__-_reminiscences.ogg', 0);
    end,
    sndout = function(s) end,
};

v_0848f12f_cff7_4d6d_b67a_b1b996eb6322_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
        vn.skip_mode = false;
        vn:unlock_direct();
if (_wolfiness ~= nil) and (( not _guardDone) and (_wolfiness >= 1)) then
        put(v_c92edec5_e799_4393_bb58_bac32756f883);
end;
if ( not _guardDone) then
        put(v_3552ac04_1e42_4cfb_bfef_9d7777d3b6b9);
end;
if (_wolfiness ~= nil) and (( not _guardDone) and (_wolfiness >= 1)) then
        put(v_57bfa54c_a18e_4322_b9ad_2eb6559c4298);
end;
        s:initf();
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

v_c92edec5_e799_4393_bb58_bac32756f883 = menu {
    nam = "v_c92edec5_e799_4393_bb58_bac32756f883",
    dsc = function(s) return "{Выбрать рябину}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_0848f12f_cff7_4d6d_b67a_b1b996eb6322, v_b8eecad7_8e40_4397_87de_e794189f7bf5, false); 
    end
}

v_3552ac04_1e42_4cfb_bfef_9d7777d3b6b9 = menu {
    nam = "v_3552ac04_1e42_4cfb_bfef_9d7777d3b6b9",
    dsc = function(s) return "{Выбрать боярышник}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_0848f12f_cff7_4d6d_b67a_b1b996eb6322, v_bc738a80_9890_4416_bead_3bbc8f533412, false); 
    end
}

v_57bfa54c_a18e_4322_b9ad_2eb6559c4298 = menu {
    nam = "v_57bfa54c_a18e_4322_b9ad_2eb6559c4298",
    dsc = function(s) return "{Выбрать калину}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_0848f12f_cff7_4d6d_b67a_b1b996eb6322, v_7e4ded08_354b_4c76_b876_2e8ac335fdad, false); 
    end
}

-- 1.9
v_8c0da93f_8301_442b_a9fd_60d68d9610d0 = vnr {
    nam = 'Am I a Monster?',
    notes = '1.9',
    bgimg = function(s)
        if (true) then
            return 'images/1.9.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Дрожа, вы улеглись под кустом, зализывая раны. Вскоре забрезжил рассвет, и вы приготовились к очередной болезненной трансформации...");
pn();
pn("");
pn();
pn("Вы снова стали человеком, и вид у вас был неважный. Раны, нанесённые охранником вашего врага, болели и кровоточили.");
pn();
pn("\"Нужно как-то победить это чудовище\", -- подумали вы.");
pn();
    end,
    walk_to = "v_8c0da93f_8301_442b_a9fd_60d68d9610d0_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_8c0da93f_8301_442b_a9fd_60d68d9610d0_snds');
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
            set_music('sound/in_limbo__rock_prog__-_reminiscences.ogg', 0);
    end,
    sndout = function(s) end,
};

v_8c0da93f_8301_442b_a9fd_60d68d9610d0_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if (_wolfiness ~= nil) and (_wolfiness >= 1) then
        nlb:nlbwalk(v_8c0da93f_8301_442b_a9fd_60d68d9610d0, v_e307ea1f_9d44_45f0_aa58_15607482293b, false); 
    return;
end;
if (_wolfiness ~= nil) and (_wolfiness < 1) then
        nlb:nlbwalk(v_8c0da93f_8301_442b_a9fd_60d68d9610d0, v_e0d11a50_50d2_4521_be11_10267f8aab92, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 29.
v_e307ea1f_9d44_45f0_aa58_15607482293b = vnr {
    nam = 'Am I a Monster?',
    notes = '29.',
    bgimg = function(s)
        if (true) then
            return 'images/29.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("В мозгу всплыли смутные воспоминания о каком-то дереве с ягодами, заострённая ветка которого должна помочь одолеть волколака. Но какое именно дерево упоминалось, вы не помнили.");
pn();
    end,
    walk_to = "v_e307ea1f_9d44_45f0_aa58_15607482293b_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_e307ea1f_9d44_45f0_aa58_15607482293b_snds');
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
    end,
    sndout = function(s) end,
};

v_e307ea1f_9d44_45f0_aa58_15607482293b_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
        vn.skip_mode = false;
        vn:unlock_direct();
if (_wolfiness ~= nil) and (_wolfiness >= 1) then
        put(v_e307ea1f_9d44_45f0_aa58_15607482293b_b8eecad7_8e40_4397_87de_e794189f7bf5_c92edec5_e799_4393_bb58_bac32756f883_Return);
end;
        put(v_e307ea1f_9d44_45f0_aa58_15607482293b_bc738a80_9890_4416_bead_3bbc8f533412_3552ac04_1e42_4cfb_bfef_9d7777d3b6b9_Return);
if (_wolfiness ~= nil) and (_wolfiness >= 1) then
        put(v_e307ea1f_9d44_45f0_aa58_15607482293b_7e4ded08_354b_4c76_b876_2e8ac335fdad_57bfa54c_a18e_4322_b9ad_2eb6559c4298_Return);
end;
        s:initf();
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

v_e307ea1f_9d44_45f0_aa58_15607482293b_b8eecad7_8e40_4397_87de_e794189f7bf5_c92edec5_e799_4393_bb58_bac32756f883_Return = menu {
    nam = "v_e307ea1f_9d44_45f0_aa58_15607482293b_b8eecad7_8e40_4397_87de_e794189f7bf5_c92edec5_e799_4393_bb58_bac32756f883_Return",
    dsc = function(s) return "{Выбрать рябину}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_e307ea1f_9d44_45f0_aa58_15607482293b, v_b8eecad7_8e40_4397_87de_e794189f7bf5, false); 
    end
}

v_e307ea1f_9d44_45f0_aa58_15607482293b_bc738a80_9890_4416_bead_3bbc8f533412_3552ac04_1e42_4cfb_bfef_9d7777d3b6b9_Return = menu {
    nam = "v_e307ea1f_9d44_45f0_aa58_15607482293b_bc738a80_9890_4416_bead_3bbc8f533412_3552ac04_1e42_4cfb_bfef_9d7777d3b6b9_Return",
    dsc = function(s) return "{Выбрать боярышник}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_e307ea1f_9d44_45f0_aa58_15607482293b, v_bc738a80_9890_4416_bead_3bbc8f533412, false); 
    end
}

v_e307ea1f_9d44_45f0_aa58_15607482293b_7e4ded08_354b_4c76_b876_2e8ac335fdad_57bfa54c_a18e_4322_b9ad_2eb6559c4298_Return = menu {
    nam = "v_e307ea1f_9d44_45f0_aa58_15607482293b_7e4ded08_354b_4c76_b876_2e8ac335fdad_57bfa54c_a18e_4322_b9ad_2eb6559c4298_Return",
    dsc = function(s) return "{Выбрать калину}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_e307ea1f_9d44_45f0_aa58_15607482293b, v_7e4ded08_354b_4c76_b876_2e8ac335fdad, false); 
    end
}

-- 30.
v_e0d11a50_50d2_4521_be11_10267f8aab92 = vnr {
    nam = 'Am I a Monster?',
    notes = '30.',
    bgimg = function(s)
        if (true) then
            return 'images/30.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("В этот момент вы вспомнили, что кол из боярышника мог помочь в уничтожении волколака.");
pn();
    end,
    walk_to = "v_e0d11a50_50d2_4521_be11_10267f8aab92_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_e0d11a50_50d2_4521_be11_10267f8aab92_snds');
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
    end,
    sndout = function(s) end,
};

v_e0d11a50_50d2_4521_be11_10267f8aab92_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
        vn.skip_mode = false;
        vn:unlock_direct();
if (_wolfiness ~= nil) and (_wolfiness >= 1) then
        put(v_e0d11a50_50d2_4521_be11_10267f8aab92_b8eecad7_8e40_4397_87de_e794189f7bf5_c92edec5_e799_4393_bb58_bac32756f883_Return);
end;
        put(v_e0d11a50_50d2_4521_be11_10267f8aab92_bc738a80_9890_4416_bead_3bbc8f533412_3552ac04_1e42_4cfb_bfef_9d7777d3b6b9_Return);
if (_wolfiness ~= nil) and (_wolfiness >= 1) then
        put(v_e0d11a50_50d2_4521_be11_10267f8aab92_7e4ded08_354b_4c76_b876_2e8ac335fdad_57bfa54c_a18e_4322_b9ad_2eb6559c4298_Return);
end;
        s:initf();
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

v_e0d11a50_50d2_4521_be11_10267f8aab92_b8eecad7_8e40_4397_87de_e794189f7bf5_c92edec5_e799_4393_bb58_bac32756f883_Return = menu {
    nam = "v_e0d11a50_50d2_4521_be11_10267f8aab92_b8eecad7_8e40_4397_87de_e794189f7bf5_c92edec5_e799_4393_bb58_bac32756f883_Return",
    dsc = function(s) return "{Выбрать рябину}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_e0d11a50_50d2_4521_be11_10267f8aab92, v_b8eecad7_8e40_4397_87de_e794189f7bf5, false); 
    end
}

v_e0d11a50_50d2_4521_be11_10267f8aab92_bc738a80_9890_4416_bead_3bbc8f533412_3552ac04_1e42_4cfb_bfef_9d7777d3b6b9_Return = menu {
    nam = "v_e0d11a50_50d2_4521_be11_10267f8aab92_bc738a80_9890_4416_bead_3bbc8f533412_3552ac04_1e42_4cfb_bfef_9d7777d3b6b9_Return",
    dsc = function(s) return "{Выбрать боярышник}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_e0d11a50_50d2_4521_be11_10267f8aab92, v_bc738a80_9890_4416_bead_3bbc8f533412, false); 
    end
}

v_e0d11a50_50d2_4521_be11_10267f8aab92_7e4ded08_354b_4c76_b876_2e8ac335fdad_57bfa54c_a18e_4322_b9ad_2eb6559c4298_Return = menu {
    nam = "v_e0d11a50_50d2_4521_be11_10267f8aab92_7e4ded08_354b_4c76_b876_2e8ac335fdad_57bfa54c_a18e_4322_b9ad_2eb6559c4298_Return",
    dsc = function(s) return "{Выбрать калину}^^" end, 
    act = function(s) 
        nlb:nlbwalk(v_e0d11a50_50d2_4521_be11_10267f8aab92, v_7e4ded08_354b_4c76_b876_2e8ac335fdad, false); 
    end
}

-- 31. Вы взяли рябину
v_b8eecad7_8e40_4397_87de_e794189f7bf5 = vnr {
    nam = 'Am I a Monster?',
    notes = '31. Вы взяли рябину',
    bgimg = function(s)
        if (true) then
            return 'images/31.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("На глаза вам попалась раскидистая рябина.");
pn();
    end,
    walk_to = "v_b8eecad7_8e40_4397_87de_e794189f7bf5_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_b8eecad7_8e40_4397_87de_e794189f7bf5_snds');
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
    end,
    sndout = function(s) end,
};

v_b8eecad7_8e40_4397_87de_e794189f7bf5_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if ( not _guardDone) then
        nlb:nlbwalk(v_b8eecad7_8e40_4397_87de_e794189f7bf5, v_9a78cd0b_cc2b_4c46_bf73_e807ed71189c, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 34. Драка, конец
v_9a78cd0b_cc2b_4c46_bf73_e807ed71189c = vnr {
    nam = 'Am I a Monster?',
    notes = '34. Драка, конец',
    bgimg = function(s)
        if (true) then
            return 'images/34.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("На ней вы и остановили свой выбор. Вам удалось сломать толстую ветку под острым углом.  Соорудив примитивное оружие, вы вернулись к особняку.");
pn();
pn(" Вас встретил мускулистый лохматый мужчина. По выражению его лица вы поняли, что он по-прежнему не собирается вас пропускать.");
pn();
pn(" Оборотень кинулся на вас. Вы резко выбросили из-за спины руку с зажатым в ней колом. Охранник, не успев остановиться, налетел грудью прямо на острую палку. Он заревел от боли и бросился на вас. Из его смертельных объятий вам уже не суждено было выбраться.");
pn();
pn("");
pn();
    end,
    walk_to = "v_9a78cd0b_cc2b_4c46_bf73_e807ed71189c_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_9a78cd0b_cc2b_4c46_bf73_e807ed71189c_snds');
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
nlb:setAchievement(statsAPI, 'WRONG_CHOICE', '82a5f73c-a804-46ce-8240-86b95c99f529');
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
            set_music('sound/lukhash_-_failure.ogg', 0);
    end,
    sndout = function(s) end,
};

v_9a78cd0b_cc2b_4c46_bf73_e807ed71189c_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    dsc = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
        vn.skip_mode = false;
        vn:unlock_direct();
        put(_try_again);
        s:initf();
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_end('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 
v_d5044b52_9786_43aa_b097_67a7b3220d6a = vnr {
    nam = 'Am I a Monster?',
    notes = 'Злодей',
    bgimg = function(s)

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
    end,
    walk_to = "v_d5044b52_9786_43aa_b097_67a7b3220d6a_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        if (true) then         nlb:nlbwalk(v_d5044b52_9786_43aa_b097_67a7b3220d6a, v_0aa69b7f_274b_42ee_a758_4d3c2f98e3aa, true); 

        return false;
 end;
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_d5044b52_9786_43aa_b097_67a7b3220d6a_snds');
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

-- 36. Препятствия больше не было, и вы проникли в дом
v_0aa69b7f_274b_42ee_a758_4d3c2f98e3aa = vnr {
    nam = 'Am I a Monster?',
    notes = '36. Препятствия больше не было, и вы проникли в дом',
    bgimg = function(s)
        if (s.tag == 'HUMAN') then
            return 'images/36.jpg';
        elseif (s.tag == 'WOLF') then
            return 'images/36b.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Других препятствий вы не встретили. С замиранием сердца вы проникли в дом.");
pn();
    end,
    walk_to = "v_0aa69b7f_274b_42ee_a758_4d3c2f98e3aa_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_0aa69b7f_274b_42ee_a758_4d3c2f98e3aa_snds');
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
        if not _tagsArg then
            stead.add_var { _tagsArg = nlb:clonelst(listobj, "_tagsArg"); }
        end;
        nlb:push(_tagsArg.listnam, s);
nlb:acta(v_ccb8b2e6_f93d_4fc6_9e9e_544e8fe158b1);
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
            set_music('sound/in_limbo__rock_prog__-_reminiscences.ogg', 0);
    end,
    sndout = function(s) end,
};

v_0aa69b7f_274b_42ee_a758_4d3c2f98e3aa_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if (_wolfiness ~= nil) and (_wolfiness == 3) then
        nlb:nlbwalk(v_0aa69b7f_274b_42ee_a758_4d3c2f98e3aa, v_61f37b28_518b_4025_8913_5c278ba14bdb, false); 
    return;
end;
if (_wolfiness ~= nil) and (_wolfiness == 2) then
        nlb:nlbwalk(v_0aa69b7f_274b_42ee_a758_4d3c2f98e3aa, v_c195f996_3411_4120_a03d_1cbc25d871c7, false); 
    return;
end;
if (_wolfiness ~= nil) and (_wolfiness == 1) then
        nlb:nlbwalk(v_0aa69b7f_274b_42ee_a758_4d3c2f98e3aa, v_8a8ee4b3_7744_4fe5_a3e0_6a5a5eb91f82, false); 
    return;
end;
if (_wolfiness ~= nil) and (_wolfiness < 1) then
        nlb:nlbwalk(v_0aa69b7f_274b_42ee_a758_4d3c2f98e3aa, v_b5aa3b43_a7be_44b3_82d1_95925a213cd7, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 38. Здесь волк. Кусает врага и убегает, т.к. захотел остаться волком.
v_c195f996_3411_4120_a03d_1cbc25d871c7 = vnr {
    nam = 'Am I a Monster?',
    notes = '38. Здесь волк. Кусает врага и убегает, т.к. захотел остаться волком.',
    bgimg = function(s)
        if (true) then
            return 'images/38.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Здесь повсюду чувствовался запах врага. Ваш чуткий животный слух уловил какие-то звуки, доносившиеся из комнаты на втором этаже.");
pn();
pn(" Бесшумно взлетев по лестнице, вы заглянули в приоткрытую дверь. Это был он. Виновник ваших злоключений.");
pn();
pn(" Вы мгновенно почувствовали прилив ярости. Вам захотелось убить его. Неожиданно из открытого окна донёсся запах леса.");
pn();
pn(" Вы вспомнили то ощущение свободы и силы, которое познали за эти дни в образе волка. Вы поняли, что не хотите полностью становиться человеком.");
pn();
pn(" Но вам всё же хотелось отомстить. Вы ворвались в комнату. Насладившись видом пришедшего в ужас врага, вы повалили его на пол.");
pn();
pn(" Прокусив руку противника, вы убежали в лес. Пусть на своей шкуре испытает то, что вы пережили по его вине. Это было справедливо.");
pn();
pn("");
pn();
    end,
    walk_to = "v_c195f996_3411_4120_a03d_1cbc25d871c7_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_c195f996_3411_4120_a03d_1cbc25d871c7_snds');
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
nlb:setAchievement(statsAPI, 'FOREST_LIFE', '9750b3a4-2545-4840-868c-43fa5b21bcc3');
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
            set_music('sound/lukhash_-_failure.ogg', 0);
    end,
    sndout = function(s) end,
};

v_c195f996_3411_4120_a03d_1cbc25d871c7_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    dsc = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
        vn.skip_mode = false;
        vn:unlock_direct();
        put(_try_again);
        s:initf();
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_end('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 40. Здесь человек. Разговаривает с врагом, узнаёт, за что он его превратил. Просит расколдовать.
v_b5aa3b43_a7be_44b3_82d1_95925a213cd7 = vnr {
    nam = 'Am I a Monster?',
    notes = '40. Здесь человек. Разговаривает с врагом, узнаёт, за что он его превратил. Просит расколдовать.',
    bgimg = function(s)
        if (true) then
            return 'images/40.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Было темно. Только на втором этаже в одной из комнат горел свет. Вы неслышно приблизились к двери. Она оказалась не заперта. Вы решительно вошли в комнату.");
pn();
pn("-- О, не ожидал тебя здесь увидеть, -- сказал наглец, -- не думал, что ты догадаешься.");
pn();
pn("-- За что ты заколдовал меня? -- сурово спросили вы.");
pn();
pn("-- Если честно, ни за что. Просто узнал новое интересное заклинание, надо было его на ком-то испробовать. А тут ты, сам напялил волчью шкуру. Как не воспользоваться моментом!");
pn();
pn("Вас поразила бессердечность этого человека и бессмысленность происходящего.");
pn();
pn("-- Расколдуй меня, -- наконец сказали вы.");
pn();
pn("-- Нет, -- безразличным голосом произнёс он.");
pn();
pn("Вас словно стегнули кнутом.");
pn();
    end,
    walk_to = "v_b5aa3b43_a7be_44b3_82d1_95925a213cd7_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_b5aa3b43_a7be_44b3_82d1_95925a213cd7_snds');
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
    end,
    sndout = function(s) end,
};

v_b5aa3b43_a7be_44b3_82d1_95925a213cd7_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if (_hp ~= nil) and (_hp > 1) then
        nlb:nlbwalk(v_b5aa3b43_a7be_44b3_82d1_95925a213cd7, v_c81126f6_4646_42b3_af03_aae3d6a9a0c2, false); 
    return;
end;
if (_hp ~= nil) and (_hp <= 1) then
        nlb:nlbwalk(v_b5aa3b43_a7be_44b3_82d1_95925a213cd7, v_eaa4f345_6237_416d_9764_f6f503028864, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 41. Т.к. ГГ слаб, злодей нападает на него. ГГ убивает его в драке.
v_eaa4f345_6237_416d_9764_f6f503028864 = vnr {
    nam = 'Am I a Monster?',
    notes = '41. Т.к. ГГ слаб, злодей нападает на него. ГГ убивает его в драке.',
    bgimg = function(s)
        if (true) then
            return 'images/41.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Вы бросились на врага и, сдавив ему горло, пригрозили:");
pn();
pn("-- Если не снимешь это чёртово заклятье, я убью тебя!");
pn();
pn("Поначалу, злодей пытался разжать ваши руки, а потом ударил в раненый бок. Вы согнулись от боли. А негодяй пнул вас по больной ноге.");
pn();
pn(" Вы упали на пол. На ковре валялись какие-то вещи. Среди них вы заметили нож для бумаг. Сделав вид, что пытаетесь выползти из комнаты, вы незаметно взяли его. Негодяй преградил вам путь и, наклонившись к самому лицу, произнёс:");
pn();
pn("");
pn();
pn("-- Это я убью тебя!");
pn();
pn("В этот момент вы вонзили в него нож. Одержав победу, раненый и усталый, вы покинули страшный дом.");
pn();
pn("С трепетом вы ожидали ночи. Но ваши страхи оказались напрасны. В волка вы больше не превращались.");
pn();
    end,
    walk_to = "v_eaa4f345_6237_416d_9764_f6f503028864_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_eaa4f345_6237_416d_9764_f6f503028864_snds');
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
nlb:setAchievement(statsAPI, 'VILLAIN_DEFEATED', 'b0c85000-8a76-432c-bbf5-b781a83f7102');
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
            set_music('sound/lukhash_-_failure.ogg', 0);
    end,
    sndout = function(s) end,
};

v_eaa4f345_6237_416d_9764_f6f503028864_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    dsc = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
        vn.skip_mode = false;
        vn:unlock_direct();
        put(_try_again);
        s:initf();
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_end('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 39. Здесь человек. Спросил, за что превратил, просит расколдовать, тот отказывается.
v_8a8ee4b3_7744_4fe5_a3e0_6a5a5eb91f82 = vnr {
    nam = 'Am I a Monster?',
    notes = '39. Здесь человек. Спросил, за что превратил, просит расколдовать, тот отказывается.',
    bgimg = function(s)
        if (true) then
            return 'images/39.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Было темно. Только на втором этаже в одной из комнат горел свет. Вы неслышно приблизились к двери. Она оказалась не заперта. Вы решительно вошли в комнату.");
pn();
pn("-- О, не ожидал тебя здесь увидеть, -- сказал наглец, -- не думал, что ты догадаешься.");
pn();
pn("-- За что ты заколдовал меня? -- сурово спросили вы.");
pn();
pn("-- Если честно, ни за что. Просто узнал новое интересное заклинание, надо было его на ком-то испробовать. А тут ты, сам напялил волчью шкуру. Как не воспользоваться моментом!");
pn();
pn("Вас поразила бессердечность этого человека и бессмысленность происходящего.");
pn();
pn("-- Расколдуй меня, -- наконец сказали вы.");
pn();
pn("-- Нет, -- безразличным голосом произнёс он.");
pn();
pn("Вас словно стегнули кнутом. Резко бросившись на врага, вы прокусили ему руку.");
pn();
pn("-- Что ты наделал?! -- отчаянно воскликнул он.");
pn();
pn("-- Расколдуй меня, -- повторили вы, -- тогда и ты исцелишься.");
pn();
pn("Трясущимися руками он открыл старую книгу, и отыскав нужное заклинание, быстро прочитал его. Презрительно взглянув на жалкого человечишку, вы удалились.");
pn();
pn(" Ваша жизнь вернулась в прежнее русло, а те несколько дней в шкуре волка вы постарались забыть как страшный сон.");
pn();
pn("");
pn();
    end,
    walk_to = "v_8a8ee4b3_7744_4fe5_a3e0_6a5a5eb91f82_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_8a8ee4b3_7744_4fe5_a3e0_6a5a5eb91f82_snds');
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
nlb:setAchievement(statsAPI, 'HUMAN_AGAIN', '3e87dae1-e991-4aed-8787-411e91ca8311');
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
            set_music('sound/lukhash_-_failure.ogg', 0);
    end,
    sndout = function(s) end,
};

v_8a8ee4b3_7744_4fe5_a3e0_6a5a5eb91f82_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    dsc = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
        vn.skip_mode = false;
        vn:unlock_direct();
        put(_try_again);
        s:initf();
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_end('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 42.  и что-то ещё
v_c81126f6_4646_42b3_af03_aae3d6a9a0c2 = vnr {
    nam = 'Am I a Monster?',
    notes = '42.  и что-то ещё',
    bgimg = function(s)
        if (true) then
            return 'images/42.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Вы бросились на врага и, сдавив ему горло, пригрозили:");
pn();
pn("-- Если не снимешь это чёртово заклятье, я убью тебя!");
pn();
pn("Негодяй беспомощно барахтался, выпучив глаза. Его лицо уже начало синеть, когда вы ослабили хватку.");
pn();
pn("-- Согласен, -- прохрипел он.");
pn();
pn("Вы отпустили его. Трясущимися руками он открыл старую книгу, и отыскав нужное заклинание, быстро прочитал его. Презрительно взглянув на жалкого человечишку, вы удалились.");
pn();
pn("Добравшись до города, вы сразу позвонили в полицию, заявив, что знаете адрес человека, бегавшего по городу в облике волка.");
pn();
pn(" Вы знали, что охота на этих животных запрещена, а в его доме хранилось несколько, добытых им лично, волчьих шкур.");
pn();
pn("");
pn();
pn("Вскоре ваша жизнь вернулась в прежнее русло, а те несколько дней в шкуре волка вы постарались забыть как страшный сон.");
pn();
    end,
    walk_to = "v_c81126f6_4646_42b3_af03_aae3d6a9a0c2_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_c81126f6_4646_42b3_af03_aae3d6a9a0c2_snds');
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
nlb:setAchievement(statsAPI, 'VILLAIN_PUNISHED', 'ec437b19-13ab-4f4a-b851-185849a51249');
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
            set_music('sound/lukhash_-_failure.ogg', 0);
    end,
    sndout = function(s) end,
};

v_c81126f6_4646_42b3_af03_aae3d6a9a0c2_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    dsc = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
        vn.skip_mode = false;
        vn:unlock_direct();
        put(_try_again);
        s:initf();
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_end('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- 37. Здесь волк. Убил врага, но человеком не стал
v_61f37b28_518b_4025_8913_5c278ba14bdb = vnr {
    nam = 'Am I a Monster?',
    notes = '37. Здесь волк. Убил врага, но человеком не стал',
    bgimg = function(s)
        if (true) then
            return 'images/37.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("Здесь повсюду чувствовался запах врага. Ваш чуткий животный слух уловил какие-то звуки, доносившиеся из комнаты на втором этаже.");
pn();
pn(" Бесшумно взлетев по лестнице, вы заглянули в приоткрытую дверь. Это был он! Виновник ваших злоключений.");
pn();
pn(" Вы мгновенно ощутили прилив ярости. Глаза налились кровью и будто покрылись пеленой. Не в силах сдерживаться, вы с громким рычанием ворвались в комнату.");
pn();
pn(" Насладившись видом пришедшего в ужас врага, вы повалили его на пол. Он ещё успел издать душераздирающий вопль, прежде чем вы перегрызли ему горло.");
pn();
pn("");
pn();
pn("Дождавшись утра, вы нашли в доме штаны, рубашку, ботинки и, одевшись, отправились домой. К сожалению, на следующую ночь вы вновь превратились в волка.");
pn();
    end,
    walk_to = "v_61f37b28_518b_4025_8913_5c278ba14bdb_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_61f37b28_518b_4025_8913_5c278ba14bdb_snds');
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
nlb:setAchievement(statsAPI, 'MAXIMUM_WOLFINESS', 'a0b1f017-c7a3-4f32-a55c-25ab02f9ec39');
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
            set_music('sound/lukhash_-_failure.ogg', 0);
    end,
    sndout = function(s) end,
};

v_61f37b28_518b_4025_8913_5c278ba14bdb_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    dsc = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
        vn.skip_mode = false;
        vn:unlock_direct();
        put(_try_again);
        s:initf();
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_end('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

-- ++
v_30f2da3a_76a3_40b2_84f0_41714eb48ae4 = vnr {
    nam = 'Am I a Monster?',
    notes = '++',
    bgimg = function(s)
        if (true) then
            return 'images/1.5.jpg';
        end

    end,
    var { time = 0; wastext = false; lasttext = nil; tag = ''; autowired = false; },
    dsc = function(s)
pn("You noticed that wolves lost interest in you and preferred not to come close, so you stopped showing your teeth and made yourself comfortable on the grass.");
pn();
pn("After some time you heard voices in the alley. Flashlight beams were sliding over the roads, enclosures, and grass.");
pn();
pn(" Soon three men came up to the enclosure you were in. Two of them definitely were cops. You bared your teeth again.");
pn();
pn("");
pn();
pn("\"Are you sure that everything is normal, old man?\" harshly asked one of the cops. \"Are your animals all here?\" They lit the enclosure with the beams. It lit up the pack and you.");
pn();
pn("\"Hey, light up this one again!\"");
pn();
pn("The beam returned. You froze, your muscles strained.");
pn();
pn("\"This one doesn\'t look like mine... What does it have on its neck? Is that a cell phone?\"");
pn();
pn("You decided not to find out what was on your neck, but instead made another jump over the fence and rushed off down the road.");
pn();
pn(" The policemen obviously weren\'t as fast as you were and were slow to react, but then they grabbed their guns and opened fire at you.");
pn();
pn(" You shuddered and shrieked when one of the bullets hit you. Trying ignore the pain, you hurried to run as far as possible. Luckily you met no more cops on your way.");
pn();
pn("");
pn();
    end,
    walk_to = "v_30f2da3a_76a3_40b2_84f0_41714eb48ae4_choices",
    autos = function(s)
        update_action_count();
        nlb:revive();
        nlb:ways_chk(s);
        return true;
    end,
    nextsnd = function(s)
        local sndfile = nlb:pop('v_30f2da3a_76a3_40b2_84f0_41714eb48ae4_snds');
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
_hp = _hp - 1;
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
            set_music('sound/in_limbo__rock_prog__-_reminiscences.ogg', 0);
    end,
    sndout = function(s) end,
};

v_30f2da3a_76a3_40b2_84f0_41714eb48ae4_choices = vn_choices {
    nam = "Am I a Monster?",
    disp = true,
    textbg = true,
    ignore_preserved_gobjs = true,
    var { paginator_state = false; },
    enter = function(s) 
        s.paginator_state = paginator.on;
        objs():zap();
        paginator:turnoff();
if true then
        nlb:nlbwalk(v_30f2da3a_76a3_40b2_84f0_41714eb48ae4, v_c28ae684_785a_4442_8756_8f5a7e9fb0c1, false); 
    return;
end;
    end,
    theme_file = function(s) return "theme_vn.lua"; end,
    initf = function(s) 
        return vn:auto_geom_choices('dissolve');
    end,
    exit = function(s) 
        if s.paginator_state then paginator:turnon(); end;
    end
}

