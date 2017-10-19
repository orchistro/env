#!/usr/local/bin/bash
cp ${HOME}/env/itg_cfg/*.sql ${INTEGRATOR_HOME}
cp ${HOME}/env/itg_cfg/initdb.sh ${INTEGRATOR_HOME}
cp ${HOME}/env/itg_cfg/initfiles.sh ${INTEGRATOR_HOME}
cp ${HOME}/env/itg_cfg/insertdb.sh ${INTEGRATOR_HOME}
cp ${HOME}/env/itg_cfg/datastore.cfg.mine ${INTEGRATOR_HOME}/cfg
cp ${HOME}/env/itg_cfg/service.cfg.mine ${INTEGRATOR_HOME}/cfg
cp ${HOME}/env/itg_cfg/integrator.cfg ${INTEGRATOR_HOME}/cfg
