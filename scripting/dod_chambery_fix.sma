/*
*	Based on DOD_Falaise_Fix by Vet(3TT3V)
*/

#include <amxmodx>
#include <fakemeta>

// From Ven's fakemeta_util include
#define fm_create_entity(%1) engfunc(EngFunc_CreateNamedEntity, engfunc(EngFunc_AllocString, %1))
#define fm_DispatchSpawn(%1) dllfunc(DLLFunc_Spawn, %1)
#define fm_entity_set_model(%1,%2) engfunc(EngFunc_SetModel, %1, %2)

public plugin_init()
{
	register_plugin("dod_chambery_fix", "1.1", "Fysiks/Vet(3TT3V)")

	new mapname[32]
	get_mapname(mapname, 31)
	if (!equali(mapname, "dod_chambery")) {
		return
	}
	new ent
	ent = fm_create_entity("func_wall")
	if( !pev_valid(ent) ) {
		log_amx("[AMXX] dod_chambery_fix - Entity could not be created")
		return
	}
	fm_set_kvd(ent, "origin", "4 0 0")
	fm_entity_set_model(ent, "*10")
	fm_set_kvd(ent, "renderamt", "0")
	fm_set_kvd(ent, "rendermode", "2")

	fm_DispatchSpawn(ent)
}

// From Ven's fakemeta_util include
// based on Basic-Master's set_keyvalue, upgraded version optionally accepts a classname
stock fm_set_kvd(entity, const key[], const value[], const classname[] = "")
{
	if (classname[0])
		set_kvd(0, KV_ClassName, classname)
	else {
		new class[32]
		pev(entity, pev_classname, class, 31)
		set_kvd(0, KV_ClassName, class)
	}
	set_kvd(0, KV_KeyName, key)
	set_kvd(0, KV_Value, value)
	set_kvd(0, KV_fHandled, 0)

	return dllfunc(DLLFunc_KeyValue, entity, 0)
}
