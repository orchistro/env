#!/usr/local/bin/bash
echo Removing itg1 and itg2 directories
rm -rf ${HOME}/work/mdw/integrator/test/itg1
rm -rf ${HOME}/work/mdw/integrator/test/itg2
cleancore
killitg
atfrun ${HOME}/work/mdw/integrator/test/Setup/0_1_IntegratorSetup.tc
