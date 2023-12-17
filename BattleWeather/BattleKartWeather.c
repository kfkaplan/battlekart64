#include "../Library/MainInclude.h"

void KWKumo_Alloc_Hook()
{
	if (HotSwapID > 0)
	{
		LoadCustomHeader(courseValue + gpCourseIndex);

		SetCloudType((char)OverKartHeader.SkyType);
		SetWeatherType((char)OverKartHeader.WeatherType);
		GlobalShortA = g_courseID;
		g_courseID = CloudCourseID;
		KWKumo_Alloc();
		g_courseID = GlobalShortA;
	}
	else
	{
		KWKumo_Alloc();
	}
}

void KWChart_Kumo_Hook(int screen_num)
{
	if (HotSwapID > 0)
	{
		GlobalShortA = g_courseID;
		g_courseID = CloudCourseID;
		KWChart_Kumo(screen_num);
		g_courseID = GlobalShortA;
	}
	else
	{
		KWChart_Kumo(screen_num);
	}

	if ((char)OverKartHeader.WeatherType == 0)
	{
		return;
	}

	AnmObject *cloud;
	int cloudcount = CloudCount1P;
	if (g_playerCount == 2)
	{
		cloudcount = CloudCount2P;
	}

	for (int i = 0; i < cloudcount; i++)
	{
		if (g_CloudAllocate[i] == 0)
		{
			return;
		}
		cloud = (AnmObject *)&g_DynamicObjects[g_CloudAllocate[i]];
		cloud->velocity[1] = -5.0f;
		cloud->scale = 0.4;
	}
}