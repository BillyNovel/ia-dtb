/*
    Author: Alganthe
    This file is where all the enemies and objects are going to be defined (the ones from the missions / SM) at least.
    Please keep the format of the defines as is, if a define is an array keep it an array.
*/
#define ArsenalBoxes [Quartermaster,Quartermaster_1,Quartermaster_2,Quartermaster_3,Quartermaster_4,Quartermaster_5,Quartermaster_6] // Vars of the arsenal boxes


// Arsenal blacklist and gear limitations
#define ArsenalWeaponBlacklist [ \
    "srifle_DMR_01_SOS_F", \
    "srifle_EBR_SOS_F", \
    "srifle_GM6_SOS_F", \
    "srifle_GM6_LRPS_F", \
    "srifle_LRR_SOS_F", \
    "srifle_LRR_LRPS_F", \
    "arifle_Katiba_GL_Nstalker_pointer_F", \
    "arifle_MXC_SOS_point_snds_F", \
    "arifle_MXM_SOS_pointer_F", \
    "srifle_GM6_camo_SOS_F",  \
    "srifle_GM6_camo_LRPS_F", \
    "srifle_LRR_camo_SOS_F", \
    "srifle_LRR_camo_LRPS_F", \
    "srifle_DMR_02_SOS_F", \
    "srifle_DMR_03_SOS_F", \
    "srifle_DMR_04_SOS_F", \
    "srifle_DMR_04_NS_LP_F", \
    "srifle_DMR_05_SOS_F" \
]

#define ArsenalBlacklistedItems [ \
    "optic_Nightstalker", \
    "optic_tws", \
    "optic_tws_mg", \
    "O_UavTerminal", \
    "I_UavTerminal", \
	"C_UavTerminal", \
    "O_NVGoggles_ghex_F", \
    "O_NVGoggles_hex_F", \
    "O_NVGoggles_urb_F", \
    "NVGogglesB_blk_F", \
    "NVGogglesB_grn_F", \
    "NVGogglesB_gry_F" \
]

#define ArsenalBlacklistedUniforms [ \
    "U_O_CombatUniform_ocamo", \
    "U_O_CombatUniform_oucamo", \
    "U_O_OfficerUniform_ocamo", \
    "U_O_SpecopsUniform_ocamo", \
    "U_O_T_Soldier_F", \
    "U_B_GEN_Commander_F", \
    "U_B_GEN_Soldier_F", \
    "U_O_T_Officer_F", \
    "U_O_V_Soldier_Viper_F", \
    "U_O_V_Soldier_Viper_hex_F", \
    "U_I_C_Soldier_Camo_F", \
    "U_I_CombatUniform", \
    "U_I_CombatUniform_shortsleeve", \
    "U_I_OfficerUniform", \
    "U_O_PilotCoveralls", \
    "U_I_pilotCoveralls", \
    "U_I_HeliPilotCoveralls", \
 \
    "U_I_FullGhillie_sard", \
    "U_O_FullGhillie_sard", \
    "U_I_FullGhillie_ard", \
    "U_O_FullGhillie_ard", \
    "U_I_FullGhillie_lsh", \
    "U_O_FullGhillie_lsh", \
    "U_I_GhillieSuit", \
    "U_O_GhillieSuit", \
    "U_O_T_FullGhillie_tna_F", \
    "U_O_T_Sniper_F", \
 \
    "U_O_Wetsuit", \
    "U_I_Wetsuit", \
 \
    "U_C_Poloshirt_blue", \
    "U_C_Poloshirt_burgundy", \
    "U_C_Poloshirt_stripped", \
    "U_C_Poloshirt_tricolour", \
    "U_C_Poloshirt_salmon", \
    "U_C_Poloshirt_redwhite", \
    "U_C_Man_casual_2_F", \
    "U_C_Man_casual_3_F", \
    "U_C_Man_casual_1_F", \
    "U_C_man_sport_1_F", \
    "U_C_man_sport_3_F", \
    "U_C_man_sport_2_F", \
    "U_C_Man_casual_6_F", \
    "U_C_Man_casual_4_F", \
    "U_C_Man_casual_5_F", \
    "U_C_Driver_1_black", \
    "U_C_Driver_1_blue", \
    "U_C_Driver_2", \
    "U_C_Driver_1", \
    "U_C_Driver_1_green", \
    "U_C_Driver_1_orange", \
    "U_C_Driver_1_red", \
    "U_C_Driver_3", \
    "U_C_Driver_4", \
    "U_C_Driver_1_white", \
    "U_C_Driver_1_yellow", \
    "U_C_HunterBody_grn", \
    "U_OrestesBody", \
    "U_C_Journalist", \
    "U_Marshal", \
    "U_C_Scientist", \
    "U_C_WorkerCoveralls", \
    "U_C_Poor_1", \
    "U_Competitor", \
    "U_Rangemaster", \
    "U_B_Protagonist_VR", \
    "U_O_Protagonist_VR", \
    "U_I_Protagonist_VR", \
	"U_C_IDAP_Man_cargo_F", \
	"U_C_IDAP_Man_Jeans_F", \
	"U_C_IDAP_Man_casual_F", \
	"U_C_IDAP_Man_shorts_F", \
	"U_C_IDAP_Man_Tee_F", \
	"U_C_IDAP_Man_TeeShorts_F", \
	"U_C_ConstructionCoverall_Black_F", \
    "U_C_ConstructionCoverall_Blue_F", \
    "U_C_ConstructionCoverall_Red_F", \
	"U_C_ConstructionCoverall_Vrana_F" \
]

#define ArsenalBlacklistedHelmets [ \
    "H_HelmetSpecO_blk", \
    "H_HelmetO_ocamo", \
    "H_HelmetO_oucamo", \
    "H_HelmetSpecO_ocamo", \
    "H_HelmetLeaderO_ocamo", \
    "H_HelmetLeaderO_oucamo", \
    "H_HelmetIA", \
    "H_PilotHelmetFighter_O", \
    "H_PilotHelmetFighter_I", \
    "H_PilotHelmetHeli_O", \
    "H_PilotHelmetHeli_I", \
    "H_CrewHelmetHeli_O", \
    "H_CrewHelmetHeli_I", \
    "H_HelmetCrew_I", \
    "H_HelmetCrew_O", \
    "H_RacingHelmet_1_F", \
    "H_RacingHelmet_2_F", \
    "H_RacingHelmet_3_F", \
    "H_RacingHelmet_4_F", \
    "H_RacingHelmet_1_black_F", \
    "H_RacingHelmet_1_blue_F", \
    "H_RacingHelmet_1_green_F", \
    "H_RacingHelmet_1_red_F", \
    "H_RacingHelmet_1_white_F", \
    "H_RacingHelmet_1_yellow_F", \
    "H_RacingHelmet_1_orange_F", \
    "H_Cap_marshal", \
    "H_StrawHat", \
    "H_StrawHat_dark", \
    "H_Hat_blue", \
    "H_Hat_brown", \
    "H_Hat_camo", \
    "H_Hat_grey", \
    "H_Hat_checker", \
    "H_Hat_tan", \
    "H_Helmet_Skate", \
    "H_MilCap_ocamo", \
    "H_MilCap_dgtl", \
    "H_HelmetSpecO_ghex_F", \
    "H_Booniehat_dgtl", \
    "H_Cap_blk_Raven", \
    "H_Cap_brn_SPECOPS", \
    "H_HelmetCrew_O_ghex_F", \
    "H_HelmetLeaderO_ghex_F", \
    "H_MilCap_ghex_F", \
    "H_HelmetO_ghex_F", \
    "H_HelmetO_ViperSP_ghex_F", \
    "H_HelmetO_ViperSP_hex_F", \
	"H_Cap_Black_IDAP_F", \
    "H_Cap_Orange_IDAP_F", \
    "H_Cap_White_IDAP_F", \
    "H_Construction_basic_black_F", \
    "H_Construction_earprot_black_F", \
    "H_Construction_headset_black_F", \
	"H_Construction_basic_orange_F", \
    "H_Construction_earprot_orange_F", \
    "H_Construction_headset_orange_F", \
	"H_Construction_basic_red_F", \
    "H_Construction_earprot_red_F", \
    "H_Construction_headset_red_F", \
	"H_Construction_basic_vrana_F", \
    "H_Construction_earprot_vrana_F", \
    "H_Construction_headset_vrana_F", \
	"H_Construction_basic_white_F", \
    "H_Construction_earprot_white_F", \
    "H_Construction_headset_white_F", \
	"H_Construction_basic_yellow_F", \
    "H_Construction_earprot_yellow_F", \
    "H_Construction_headset_yellow_F", \
	"H_PASGT_basic_blue_press_F", \
    "H_PASGT_neckprot_blue_press_F" \
]

#define ArsenalBlacklistedBackpacks [ \
    "O_Mortar_01_weapon_F", \
    "O_Mortar_01_support_F", \
    "I_Mortar_01_weapon_F", \
    "I_Mortar_01_support_F", \
 \
    "B_GMG_01_A_weapon_F", \
    "B_GMG_01_high_F", \
    "B_GMG_01_high_weapon_F", \
    "B_GMG_01_weapon_F", \
    "O_GMG_01_A_weapon_F", \
    "O_GMG_01_high_F", \
    "O_GMG_01_high_weapon_F", \
    "O_GMG_01_weapon_F", \
    "I_GMG_01_A_weapon_F", \
    "I_GMG_01_high_F", \
    "I_GMG_01_high_weapon_F", \
    "I_GMG_01_weapon_F", \
 \
    "B_HMG_01_A_weapon_F", \
    "B_HMG_01_high_weapon_F", \
    "B_HMG_01_support_F", \
    "B_HMG_01_support_high_F", \
    "B_HMG_01_weapon_F", \
    "O_HMG_01_A_weapon_F", \
    "O_HMG_01_high_weapon_F", \
    "O_HMG_01_support_F", \
    "O_HMG_01_support_high_F", \
    "O_HMG_01_weapon_F", \
    "I_HMG_01_A_weapon_F", \
    "I_HMG_01_high_weapon_F", \
    "I_HMG_01_support_F", \
    "I_HMG_01_support_high_F", \
    "I_HMG_01_weapon_F", \
 \
    "B_AA_01_weapon_F", \
    "O_AA_01_weapon_F", \
    "I_AA_01_weapon_F", \
    "B_AT_01_weapon_F", \
    "O_AT_01_weapon_F", \
    "I_AT_01_weapon_F", \
 \
    "B_Respawn_Sleeping_bag_blue_F", \
    "B_Respawn_Sleeping_bag_brown_F", \
    "B_Respawn_Sleeping_bag_F", \
    "B_Respawn_TentA_F", \
    "B_Respawn_TentDome_F", \
    "B_Patrol_Respawn_bag_F",\
 \
    "O_Static_Designator_02_weapon_F", \
    "B_AssaultPack_dgtl", \
    "B_AssaultPack_ocamo", \
    "B_Carryall_ocamo", \
    "B_Carryall_oucamo", \
    "B_FieldPack_ocamo", \
    "B_FieldPack_oucamo", \
    "B_TacticalPack_ocamo", \
    "I_UAV_01_backpack_F", \
    "O_UAV_01_backpack_F", \
	"I_UAV_06_backpack_F", \
    "O_UAV_06_backpack_F", \
	"I_UAV_06_medical_backpack_F", \
    "O_UAV_06_medical_backpack_F", \
	"C_IDAP_UAV_01_backpack_F", \
    "C_IDAP_UAV_06_backpack_F", \
	"C_IDAP_UAV_06_medical_backpack_F", \
    "C_IDAP_UAV_06_antimine_backpack_F", \
	"C_UAV_06_backpack_F", \
    "C_UAV_06_medical_backpack_F", \
    "B_Carryall_ghex_F", \
    "B_FieldPack_ghex_F", \
    "B_ViperHarness_ghex_F", \
    "B_ViperHarness_hex_F", \
    "B_ViperLightHarness_ghex_F", \
    "B_ViperLightHarness_hex_F", \
	"B_Messenger_IDAP_F"\
]

#define ArsenalBlacklistedGlasses [ \
    "G_Goggles_VR", \
    "G_Lady_Blue", \
    "G_Spectacles", \
    "G_Spectacles_Tinted", \
    "G_I_Diving", \
    "G_O_Diving" \
]

#define ArsenalBlacklistedVests [ \
    "V_Press_F", \
    "V_HarnessO_brn", \
    "V_HarnessOGL_brn", \
    "V_HarnessO_gry", \
    "V_HarnessOGL_gry", \
    "V_HarnessOSpec_brn", \
    "V_HarnessOSpec_gry", \
    "V_RebreatherIR", \
    "V_RebreatherIA", \
    "V_PlateCarrierIAGL_dgtl", \
    "V_PlateCarrierIAGL_oli", \
    "V_PlateCarrierIA1_dgtl", \
    "V_PlateCarrierIA2_dgtl", \
    "V_TacVest_gen_F", \
    "V_HarnessOGL_ghex_F", \
    "V_HarnessO_ghex_F", \
    "V_BandollierB_ghex_F", \
	"v_i_g_resistanceLeader_f", \
	"V_DeckCrew_blue_F", \
    "V_DeckCrew_red_F", \
    "V_DeckCrew_violet_F", \
    "V_DeckCrew_white_F", \
	"V_DeckCrew_yellow_F", \
    "V_EOD_blue_F", \
    "V_EOD_IDAP_blue_F", \
    "V_Plain_crystal_F", \
	"V_Plain_medical_F", \
    "V_Safety_blue_F", \
    "V_Safety_orange_F", \
	"V_Safety_yellow_F", \
    "V_Press_F" \
]

#define GearLimitationMarksman [{_unit getUnitTrait 'derp_marksman'}, [ \
    "optic_SOS", "optic_SOS_khk_F", "optic_DMS", "optic_DMS_ghex_F", "optic_AMS", "optic_AMS_khk", "optic_AMS_snd", "optic_KHS_blk", "optic_KHS_hex", "optic_KHS_old", "optic_KHS_tan", \
 \
    "srifle_DMR_01_F", "srifle_DMR_01_ACO_F", "srifle_DMR_01_MRCO_F", "srifle_DMR_01_SOS_F", "srifle_DMR_01_DMS_F", "srifle_DMR_01_DMS_snds_F", "srifle_DMR_01_ARCO_F", "srifle_EBR_ACO_F", "srifle_EBR_MRCO_pointer_F", "srifle_EBR_ARCO_pointer_F", "srifle_EBR_SOS_F", "srifle_EBR_ARCO_pointer_snds_F", "srifle_EBR_DMS_F", "srifle_EBR_Hamr_pointer_F", "srifle_EBR_F", "srifle_EBR_DMS_pointer_snds_F", "srifle_DMR_01_DMS_BI_F", "srifle_DMR_01_DMS_snds_BI_F", "srifle_EBR_MRCO_LP_BI_F", "srifle_DMR_03_F", "srifle_DMR_03_khaki_F", "srifle_DMR_03_tan_F", "srifle_DMR_03_multicam_F", "srifle_DMR_03_woodland_F", "srifle_DMR_03_spotter_F", "srifle_DMR_03_ACO_F", "srifle_DMR_03_MRCO_F", "srifle_DMR_03_SOS_F", "srifle_DMR_03_DMS_F", "srifle_DMR_03_tan_AMS_LP_F", "srifle_DMR_03_DMS_snds_F", "srifle_DMR_03_ARCO_F", "srifle_DMR_03_AMS_F", "srifle_DMR_04_F", "srifle_DMR_04_Tan_F", "srifle_DMR_04_ACO_F", "srifle_DMR_04_MRCO_F", "srifle_DMR_04_SOS_F", "srifle_DMR_04_DMS_F", "srifle_DMR_04_ARCO_F", "srifle_DMR_04_NS_LP_F", "srifle_DMR_06_camo_F", "srifle_DMR_06_olive_F", "srifle_DMR_06_camo_khs_F", "srifle_DMR_02_F", "srifle_DMR_02_camo_F", "srifle_DMR_02_sniper_F", "srifle_DMR_02_ACO_F", "srifle_DMR_02_MRCO_F", "srifle_DMR_02_SOS_F", "srifle_DMR_02_DMS_F", "srifle_DMR_02_sniper_AMS_LP_S_F", "srifle_DMR_02_camo_AMS_LP_F", "srifle_DMR_02_ARCO_F", "srifle_DMR_05_blk_F", "srifle_DMR_05_hex_F", "srifle_DMR_05_tan_f", "srifle_DMR_05_ACO_F", "srifle_DMR_05_MRCO_F", "srifle_DMR_05_SOS_F", "srifle_DMR_05_DMS_F", "srifle_DMR_05_KHS_LP_F", "srifle_DMR_05_DMS_snds_F", "srifle_DMR_05_ARCO_F", "srifle_DMR_07_blk_DMS_F", "srifle_DMR_07_blk_DMS_Snds_F", "srifle_DMR_07_blk_F", "srifle_DMR_07_ghex_F", "srifle_DMR_07_hex_F", "arifle_MXM_Black_F", "arifle_MXM_DMS_F", "arifle_MXM_DMS_LP_BI_snds_F", "arifle_MXM_F", "arifle_MXM_Hamr_LP_BI_F", "arifle_MXM_Hamr_pointer_F", "arifle_MXM_khk_F", "arifle_MXM_khk_MOS_Pointer_Bipod_F", "arifle_MXM_RCO_pointer_snds_F", "arifle_MXM_SOS_pointer_F", "arifle_SPAR_03_blk_F", "arifle_SPAR_03_blk_MOS_Pointer_Bipod_F", "arifle_SPAR_03_khk_F", "arifle_SPAR_03_snd_F" \
], "Marksman"]

#define GearLimitationAT  [{_unit getUnitTrait 'derp_AT'}, [ \
    "launch_B_Titan_F", "launch_I_Titan_F", "launch_O_Titan_F", "launch_B_Titan_short_F", "launch_I_Titan_short_F", "launch_O_Titan_short_F", "launch_O_Titan_ghex_F", "launch_B_Titan_tna_F", "launch_O_Titan_short_ghex_F", "launch_B_Titan_short_tna_F" \
], "AT specialist"]

#define GearLimitationSniper [{_unit getUnitTrait 'derp_sniper'}, [ \
    "optic_LRPS", "optic_LRPS_ghex_F", "optic_LRPS_tna_F", \
 \
    "srifle_GM6_F", "srifle_GM6_SOS_F", "srifle_GM6_LRPS_F", "srifle_LRR_F", "srifle_LRR_SOS_F", "srifle_LRR_LRPS_F", "srifle_GM6_camo_F", "srifle_GM6_camo_SOS_F", "srifle_GM6_camo_LRPS_F", "srifle_LRR_camo_F", "srifle_LRR_camo_F", "srifle_LRR_camo_LRPS_F", "srifle_GM6_ghex_F", "srifle_GM6_ghex_LRPS_F", "srifle_LRR_tna_F", "srifle_LRR_tna_LRPS_F" \
], "Sniper"]

#define GearLimitationMMG [{_unit getUnitTrait 'derp_machinegunner'}, [ \
    "MMG_01_hex_F", "MMG_01_tan_F", "MMG_01_hex_ARCO_LP_F", "MMG_02_camo_F", "MMG_02_black_F", "MMG_02_sand_F", "MMG_02_sand_RCO_LP_F", "MMG_02_black_RCO_BI_F", "LMG_Mk200_F", "LMG_Mk200_BI_F", "LMG_Mk200_LP_BI_F", "LMG_Zafir_F", "LMG_Zafir_pointer_F", "LMG_Zafir_ARCO_F", "LMG_03_F", "arifle_MX_SW_Black_F", "arifle_MX_SW_Black_Hamr_pointer_F", "arifle_MX_SW_F", "arifle_MX_SW_Hamr_pointer_F", "arifle_MX_SW_khk_F", "arifle_MX_SW_khk_Pointer_F", "arifle_MX_SW_pointer_F", "arifle_SPAR_02_blk_F", "arifle_SPAR_02_blk_Pointer_F", "arifle_SPAR_02_khk_F", "arifle_SPAR_02_snd_F", "arifle_CTARS_ghex_F", "arifle_CTARS_hex_F", "arifle_CTARS_blk_F", "arifle_CTARS_blk_Pointer_F" \
], "Autorifleman"]

#define GearLimitationUAVOperator [{_unit getUnitTrait 'derp_uavOperator'}, ["B_UavTerminal"], "UAV operator"]

#define GearLimitationGrenadier [{_unit getUnitTrait 'derp_grenadier'}, [ \
    "arifle_Katiba_GL_F", "arifle_Katiba_GL_ACO_F", "arifle_Katiba_GL_ARCO_pointer_F", "arifle_Katiba_GL_ACO_pointer_F", "arifle_Katiba_GL_Nstalker_pointer_F", "arifle_Katiba_GL_ACO_pointer_snds_F", "arifle_Mk20_GL_F", "arifle_Mk20_GL_plain_F", "arifle_Mk20_GL_MRCO_pointer_F", "arifle_Mk20_GL_ACO_F", "arifle_MX_GL_F", "arifle_MX_GL_ACO_F", "arifle_MX_GL_ACO_pointer_F", "arifle_MX_GL_Hamr_pointer_F", "arifle_MX_GL_Holo_pointer_snds_F", "arifle_MX_GL_Black_F", "arifle_MX_GL_Black_Hamr_pointer_F", "arifle_TRG21_GL_F", "arifle_TRG21_GL_MRCO_F", "arifle_TRG21_GL_ACO_pointer_F", "arifle_AK12_GL_F", "arifle_CTAR_GL_blk_ACO_F", "arifle_CTAR_GL_blk_ACO_Pointer_Snds_F", "arifle_CTAR_GL_blk_F", "arifle_MX_GL_khk_ACO_F", "arifle_MX_GL_khk_F", "arifle_MX_GL_khk_Hamr_Pointer_F", "arifle_MX_GL_khk_Holo_Pointer_Snds_F", "arifle_SPAR_01_GL_blk_ACO_Pointer_F", "arifle_SPAR_01_GL_blk_F", "arifle_SPAR_01_GL_khk_F", "arifle_SPAR_01_GL_snd_F", "arifle_CTAR_GL_ghex_F", "arifle_CTAR_GL_hex_F" \
], "Grenadier"]

#define GearLimitationGhillie [{_unit getUnitTrait 'derp_Ghillie'}, [ \
	"U_B_FullGhillie_ard","U_B_T_FullGhillie_tna_F","U_B_FullGhillie_lsh","U_B_FullGhillie_sard","U_B_T_Sniper_F","U_B_GhillieSuit" \
], "Sniper"]
