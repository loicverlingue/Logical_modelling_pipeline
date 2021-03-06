#!/usr/bin/bash

java -cp '../../../lib/BiNoM.jar' fr.curie.BiNoM.pathways.MaBoSS.MaBoSSBNDFile -c ./ginsimout.cfg -b ./ginsimout.bnd  -level 1

cd ginsimout_mutants_logics/
sed 's:../MaBoSS:../../../../lib/MaBoSS:;s:./ginsimout.cfg:../ginsimout.cfg:' run.sh > run2.sh
chmod 766 ./run2.sh
echo "running MaBoSS instances"
./run2.sh

cd ..

java -cp '../../../lib/BiNoM.jar:../../../lib/VDAOEngine.jar' fr.curie.BiNoM.pathways.MaBoSS.MaBoSSProbTrajFile -makelogicmutanttable -folder ./ginsimout_mutants_logics/ -prefix ginsimout -out ginsimout.xls -description ./ginsimout_mutants_logics/descriptions.txt

java -cp '../../../lib/BiNoM.jar:../../../lib/VDAOEngine.jar' fr.curie.BiNoM.pathways.MaBoSS.MaBoSSStatDistFile -folder ginsimout_mutants_logics/ -prefix ginsimout -maketable

cd ginsimout_mutants_logics
for f in *_dist_*; do
	mv $f ../
done
