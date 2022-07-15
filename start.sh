eval "$(conda shell.bash hook)"
cd esg-bert
conda activate ESG
python3 prediction.py ../inputs/corpus.txt
cd ../openie
python3 re_openie.py ../outputs/classification_output.csv
cd ../semantic-match
python3 match.py ../outputs/relation_output.csv ../inputs/relations.txt 25
cd ../ner-spacy
python3 ner.py ../outputs/matched_output.csv
cd ../MBEM
python3 mbem.py ../outputs/ner_output.csv ../inputs/props.txt
cp ../outputs/final_output.csv "/Users/akash/Library/Application Support/Neo4j Desktop/Application/relate-data/dbmss/dbms-0ba29859-9668-40e3-924f-538a987135c9/import"
cd ..
conda deactivate

cat neo1.cypher | cypher-shell -u socgen -p esg 
cat neo2.cypher | cypher-shell -u socgen -p esg 
cat neo3.cypher | cypher-shell -u socgen -p esg
cat neo4.cypher | cypher-shell -u socgen -p esg
cat neo5.cypher | cypher-shell -u socgen -p esg