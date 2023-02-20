#include <sourcemod>
#include <sdktools>
#include <cstrike>

public Plugin:myinfo =
{
	name = "Trails",
	author = "RSq | funtazzy",
	description = "Display T Trail",
	version = "1.0",
	url = "vk.com/funtazygg"
}

new g_Beam;
new Float:g_fLastPosition[MAXPLAYERS + 1][3];
new bool:g_bTrail[MAXPLAYERS + 1];

public void OnPluginStart()	{	HookEvent("player_spawn", OnPlayerSpawn);		}

public void OnMapStart()	{	g_Beam = PrecacheModel("materials/sprites/purplelaser1.vmt", true);		}

public Action:OnPlayerRunCmd(client, &buttons, &impulse, Float:vel[3], Float:angles[3], &weapon, &subtype, &cmdnum, &tickcount, &seed, mouse[2]) 	{
	decl Float:origin[3];
	GetClientAbsOrigin(client, origin);
	DrawPreStrafeBeam(client, origin);
	g_fLastPosition[client] = origin;	}

public void DrawPreStrafeBeam(client, Float:origin[3])	{
	if (!g_bTrail[client])
		return;
	if (GetClientTeam(client) == CS_TEAM_T)
		if (IsPlayerAlive(client)) {
	new Float:v1[3], Float:v2[3];
	v1[0] = origin[0];
	v1[1] = origin[1];
	v1[2] = origin[2];	
	v2[0] = g_fLastPosition[client][0];
	v2[1] = g_fLastPosition[client][1];
	v2[2] = g_fLastPosition[client][2];
	TE_SetupBeamPoints(v1, v2, g_Beam, 0, 0, 0, 2.5, 3.0, 3.0, 10, 0.0, {0, 255, 255, 255}, 0);
	TE_SendToAll();	}	}
 
public OnPlayerSpawn(Event event, const char[] sName, bool bDontBroadcast)	{
	int client = GetClientOfUserId(event.GetInt("userid"));
	if (GetClientTeam(client) == CS_TEAM_T)	{
		g_bTrail[client] = true;	}	}
