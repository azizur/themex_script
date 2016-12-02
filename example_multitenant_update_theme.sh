#!/bin/bash
CONFIGURATION_PLAYBOOKS_DIR='/encrypted/ansible/edx/playbooks'
THEMEX_SCRIPT_DIR='/encrypted/ansible/edx/playbooks/themex_script'
NEW_THEME_OR_JUST_UPDATE='--no-edx-update-run'

if [ "$1" == "--help" ];
then
    echo ""
    echo "script parameters:"
    echo "'--help' : show current info"
    echo "'--update-run' : install new theme"
    echo "'--no-edx-update-run' : default script behaviour! -> just update threme repo and run update_assets"
    echo ""
else
    $THEMEX_SCRIPT_DIR/update_theme.sh -brhim marvel-yellow-theme-eucalyptus https://github.com/raccoongang/themes_for_themex.io.git all_host_edx $CONFIGURATION_PLAYBOOKS_DIR/hosts $CONFIGURATION_PLAYBOOKS_DIR/server-vars.yml
fi

if test "$#" -eq 1;
then
    NEW_THEME_OR_JUST_UPDATE=$1
    if [ "$NEW_THEME_OR_JUST_UPDATE" == "--no-edx-update-run" ];
    then
        ##### RUN OpenEdx update_assets scripts ##########
        $CONFIGURATION_PLAYBOOKS_DIR/update_assets_edx1.sh
        $CONFIGURATION_PLAYBOOKS_DIR/update_assets_edx2.sh
    elif [ "$NEW_THEME_OR_JUST_UPDATE" == "--edx-update-run" ];
    then
        ##### RUN OpenEdx update scripts #################
        cd $CONFIGURATION_PLAYBOOKS_DIR/
        $CONFIGURATION_PLAYBOOKS_DIR/update_edx1.sh
        $CONFIGURATION_PLAYBOOKS_DIR/update_edx2.sh
    fi
fi

