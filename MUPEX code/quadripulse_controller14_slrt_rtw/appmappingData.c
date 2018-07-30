#include "slrtappmapping.h"
#include "./maps/quadripulse_controller14.map"



const AppMapInfo appInfo[] = 
{
	{ /* Idx 0, <quadripulse_controller14> */
		{ /* SignalMapInfo */
			quadripulse_controller14_BIOMAP,
			quadripulse_controller14_LBLMAP,
			quadripulse_controller14_SIDMAP,
			quadripulse_controller14_SBIO,
			quadripulse_controller14_SLBL,
			{0,23904},
			178,
		},
		{ /* ParamMapInfo */
			quadripulse_controller14_PTIDSMAP,
			quadripulse_controller14_PTNAMESMAP,
			quadripulse_controller14_SPTMAP,
			{0,160},
			161,
		},
		"quadripulse_controller14",
		"",
		"quadripulse_controller14",
		7,
		quadripulse_controller14_dtmap,
	},
};
int getNumRef(void){
	 return(sizeof(appInfo) / sizeof(AppMapInfo));
}