# param_sfo_tools
Tools to inspect param.sfo from PS4

The SFO class will take a filestream and give a hash containing fields from param.sfo.

An example has been created (Usage):

ruby get_sfo_info.rb [URL|File]

E.G.

```
$ ruby get_sfo_info.rb http://gs2.ww.prod.dl.playstation.net/gs2/appkgo/prod/CUSA10481_00/1/f_23acca4fe09dca26e7e37e28803c3f188d47fd0fa6c8ba90d60eb6d87cf558d9/f/UP0700-CUSA10481_00-DBPROJECTZBETA13.pkg

APP_TYPE: 00000001
APP_VER: 01.00
ATTRIBUTE: {:display_location_flag=>0, :unknown_value_15=>0, :supports_HDR=>0, :unknown_value_14=>0, :unknown_value_13=>0, :requires_PSVR=>0, :unknown_value_12=>0, :unknown_value_11=>0, :support_NEO_mode_on_PRO=>1, :unknown_value_10=>0, :unknown_value_9=>0, :unknown_value_8=>0, :unknown_value_7=>0, :unknown_value_6=>0, :unknown_value_5=>0, :cpu_mode_7cpu=>0, :cpu_mode_6cpu=>0, :psvr_support=>0, :unknown_value_4=>0, :unknown_value_3=>0, :unknown_value_2=>0, :hdcp_disalbed_non_games=>0, :hdcp_enabled=>0, :suspend_on_output_resolution_change=>0, :unknown_value_1=>0, :share_button_overriden=>0, :common_dialog_accept_system_setting=>1, :suspend_on_lose_focus=>0, :stereoscopic_3d=>0, :ps_move=>0, :common_dialog_accept_is_cross=>0, :support_logout=>0}
ATTRIBUTE2: {:unknown_value_24=>0, :unknown_value_23=>0, :unknown_value_22=>0, :unknown_value_21=>0, :unknown_value_20=>0, :unknown_value_19=>0, :unknown_value_18=>0, :unknown_value_17=>0, :unknown_value_16=>0, :unknown_value_15=>0, :unknown_value_14=>0, :unknown_value_13=>0, :unknown_value_12=>0, :unknown_value_11=>0, :unknown_value_10=>0, :unknown_value_9=>0, :unknown_value_8=>0, :unknown_value_7=>0, :unknown_value_6=>0, :support_team_on_team_tournament_sdk4500=>0, :support_one_on_one_match_sdk3500=>0, :unknown_value_5=>1, :does_not_apply_dummy_psmove_tracking_to_cpu=>0, :support_broadcase_separate_mode=>0, :unknown_value_4=>0, :unknown_value_3=>0, :psvr_eye_setting_dynamic_config=>0, :psvr_personal_eye_setting_disabled=>0, :unknown_value_2=>0, :support_content_search=>0, :support_video_recording=>0, :unknown_value_1=>1}
CATEGORY: gd
CONTENT_ID: UP0700-CUSA10481_00-DBPROJECTZBETA13
DEV_FLAG: 00000000
DOWNLOAD_DATA_SIZE: 00000000
FORMAT: obs
PARENTAL_LEVEL: 00000005
PUBTOOLINFO: c_date=20171214,sdk_ver=04508000,st_type=digital50,img0_l0_size=2293,img0_l1_size=0,img0_sc_ksize=5632,img0_pc_ksize=2944
PUBTOOLVER: 03120000
SERVICE_ID_ADDCONT_ADD_1: UP0700-CUSA09072_00
SERVICE_ID_ADDCONT_ADD_2:
SERVICE_ID_ADDCONT_ADD_3:
SERVICE_ID_ADDCONT_ADD_4:
SERVICE_ID_ADDCONT_ADD_5:
SERVICE_ID_ADDCONT_ADD_6:
SERVICE_ID_ADDCONT_ADD_7:
SYSTEM_VER: 05010000
TITLE: DRAGON BALL FighterZ Open Beta
TITLE_ID: CUSA10481
USER_DEFINED_PARAM_1:
USER_DEFINED_PARAM_2:
USER_DEFINED_PARAM_3:
USER_DEFINED_PARAM_4:
VERSION: 01.00
```
